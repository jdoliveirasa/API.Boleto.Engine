using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using BoletoNetCore;
using Microsoft.AspNetCore.WebSockets.Internal;
using UI.WebApplication.ClassMap;
using static UI.WebApplication.Common.Constants;
using Models = UI.WebApplication.Models;

namespace UI.WebApplication.Engine
{
    public class BradescoEngine
    {
        public BradescoEngine()
        {

        }

        public string GerarBoleto()
        {
            //Dados do Cedente
            Boletos boletos = null;
            boletos = new Boletos();

            Conta conta = new Conta();
            conta.BancoNumero = "237";
            conta.Titular = "FULANO DE TAL DA SILVA";
            conta.Agencia = "1234";
            conta.AgenciaDigito = "X";
            conta.Numero = "123456";
            conta.NumeroDigito = "X";
            conta.CarteiraBoleto = "09";
            conta.VariacaoCarteira = "666"; //M
            conta.Emissor = "666"; //M
            conta.CedenteNumero = "6666"; //M
            conta.CedenteDigito = "6"; //M
            conta.PercentualMulta = 1;
            conta.PercentualMora = 2;
            conta.DiasProtesto = 5;
            conta.LayoutRemessa = 0;
            conta.SequencialRemessa = 1000;

            EmissaoBoleto emissaoBoleto = new EmissaoBoleto();
            emissaoBoleto.Banco = "Banco Bradesco S.A."; //M

            GlobalsDadosEmpresa globalsDadosEmpresa = new GlobalsDadosEmpresa();
            globalsDadosEmpresa.Cnpj = "97969747000194";
            globalsDadosEmpresa.Logradouro = "RUA DAS ESTRELAS";
            globalsDadosEmpresa.Numero = "666";
            globalsDadosEmpresa.Complemento = "SL 13";
            globalsDadosEmpresa.Bairro = "CAMANDORA";
            globalsDadosEmpresa.CidadeNome = "CAMPINAS";
            globalsDadosEmpresa.CidadeUf = "SP";
            globalsDadosEmpresa.Cep = "34188130";

            //Dados do Cliente            
            Cliente cliente = new Cliente();
            cliente.Cnpj = "10048848000144";
            cliente.Razao = "ADAPTUP TI";
            cliente.Logradouro = "RUA DOS PLANETAS";
            cliente.Numero = "8541";
            cliente.Complemento = "4 AND";
            cliente.Bairro = "SERRA";
            cliente.CidadeNome = "VITÓRIA";
            cliente.Uf = "ES";
            cliente.Cep = "23596478";

            //Dados do Boleto
            DadosBoleto dadosBoleto = new DadosBoleto();
            dadosBoleto.CodigoOcorrencia = "01"; //Registrar remessa
            dadosBoleto.DescricaoOcorrencia = "Remessa Registrar";
            dadosBoleto.Codigo = "99999";
            dadosBoleto.Lancamento = DateTime.Today;
            dadosBoleto.Vencimento = new DateTime(2019, 1, 23);
            dadosBoleto.ValorAberto = 4600.00M;
            dadosBoleto.Aceite = "N";

            //Cabeçalho
            boletos.Banco = Banco.Instancia(Int32.Parse(conta.BancoNumero));
            boletos.Banco.Cedente = new Cedente
            {
                CPFCNPJ = globalsDadosEmpresa.Cnpj,
                Nome = conta.Titular,
                Observacoes = string.Empty,
                ContaBancaria = new ContaBancaria
                {
                    Agencia = conta.Agencia,
                    DigitoAgencia = conta.AgenciaDigito,
                    OperacaoConta = string.Empty,
                    Conta = conta.Numero,
                    DigitoConta = conta.NumeroDigito,
                    CarteiraPadrao = conta.CarteiraBoleto,
                    //VariacaoCarteiraPadrao = conta.VariacaoCarteira,
                    TipoCarteiraPadrao = TipoCarteira.CarteiraCobrancaSimples,
                    TipoFormaCadastramento = TipoFormaCadastramento.ComRegistro,
                    TipoImpressaoBoleto = conta.Emissor == emissaoBoleto.Banco ? TipoImpressaoBoleto.Banco : TipoImpressaoBoleto.Empresa,
                    TipoDocumento = TipoDocumento.Tradicional
                },
                Codigo = conta.CedenteNumero,
                CodigoDV = conta.CedenteDigito.ToString(),
                CodigoTransmissao = string.Empty,
                //Endereco = new Boleto2Net.Endereco
                Endereco = new Endereco
                {
                    LogradouroEndereco = globalsDadosEmpresa.Logradouro,
                    LogradouroNumero = globalsDadosEmpresa.Numero,
                    LogradouroComplemento = globalsDadosEmpresa.Complemento,
                    Bairro = globalsDadosEmpresa.Bairro,
                    Cidade = globalsDadosEmpresa.CidadeNome,
                    UF = globalsDadosEmpresa.CidadeUf,
                    CEP = globalsDadosEmpresa.Cep
                }
            };
            boletos.Banco.FormataCedente();

            //Título (FOREACH INIT)
            var boleto = new Boleto(boletos.Banco);
            boleto.Sacado = new Sacado
            {
                CPFCNPJ = cliente.Cnpj,
                Nome = cliente.Razao,
                Observacoes = string.Empty,
                Endereco = new Endereco
                {
                    LogradouroEndereco = cliente.Logradouro,
                    LogradouroNumero = cliente.Numero,
                    LogradouroComplemento = cliente.Complemento,
                    Bairro = cliente.Bairro,
                    Cidade = cliente.CidadeNome,
                    UF = cliente.Uf.ToString(),
                    CEP = cliente.Cep
                }
            };

            boleto.CodigoOcorrencia = dadosBoleto.CodigoOcorrencia; //Registrar remessa
            boleto.DescricaoOcorrencia = dadosBoleto.DescricaoOcorrencia;
            boleto.NumeroDocumento = dadosBoleto.Codigo.ToString();
            boleto.NumeroControleParticipante = dadosBoleto.Codigo.ToString();
            boleto.NossoNumero = dadosBoleto.Codigo.ToString();
            boleto.DataEmissao = dadosBoleto.Lancamento;
            boleto.DataVencimento = dadosBoleto.Vencimento;
            boleto.ValorTitulo = dadosBoleto.ValorAberto;
            boleto.Aceite = dadosBoleto.Aceite;
            boleto.EspecieDocumento = TipoEspecieDocumento.DM;

            //boleto.DataDesconto = DateTime.Today;
            //boleto.ValorDesconto = 0;
            if (conta.PercentualMulta > 0)
            {
                boleto.DataMulta = dadosBoleto.Vencimento.AddDays(1);
                boleto.PercentualMulta = conta.PercentualMulta;
                boleto.ValorMulta = boleto.ValorTitulo * boleto.PercentualMulta / 100;

                //boleto.MensagemInstrucoesCaixa = $"Cobrar Multa de {boleto.ValorMulta.FormatoMoeda()} após o vencimento.";
                boleto.MensagemInstrucoesCaixa = $"Cobrar Multa de {boleto.ValorMulta} .FormatoMoeda() após o vencimento.";
            }

            if (conta.PercentualMora > 0)
            {
                boleto.DataJuros = dadosBoleto.Vencimento.AddDays(1);
                boleto.PercentualJurosDia = (conta.PercentualMora / 30);
                boleto.ValorJurosDia = boleto.ValorTitulo * boleto.PercentualJurosDia / 100;

                //string instrucao = $"Cobrar juros de {boleto.PercentualJurosDia.FormatoPorcentagem()} por dia de atraso";
                string instrucao = $"Cobrar juros de {boleto.PercentualJurosDia} .FormatoPorcentagem() por dia de atraso";
                if (string.IsNullOrEmpty(boleto.MensagemInstrucoesCaixa))
                    boleto.MensagemInstrucoesCaixa = instrucao;
                else
                    boleto.MensagemInstrucoesCaixa += Environment.NewLine + instrucao;
            }

            boleto.CodigoInstrucao1 = string.Empty;
            boleto.ComplementoInstrucao1 = string.Empty;

            boleto.CodigoInstrucao2 = string.Empty;
            boleto.ComplementoInstrucao2 = string.Empty;

            boleto.CodigoInstrucao3 = string.Empty;
            boleto.ComplementoInstrucao3 = string.Empty;

            boleto.CodigoProtesto = conta.DiasProtesto == 0 ? TipoCodigoProtesto.NaoProtestar : TipoCodigoProtesto.ProtestarDiasUteis;
            boleto.DiasProtesto = conta.DiasProtesto;

            boleto.CodigoBaixaDevolucao = TipoCodigoBaixaDevolucao.NaoBaixarNaoDevolver;
            boleto.DiasBaixaDevolucao = 0;

            boleto.ValidarDados();
            boletos.Add(boleto);

            //(FOREACH END)

            //Gerar Remessa
            var stream = new MemoryStream();
            var remessa = new ArquivoRemessa(boletos.Banco, conta.LayoutRemessa == LayoutRemessa.Cnab240
                ? TipoArquivo.CNAB240 : TipoArquivo.CNAB400, conta.SequencialRemessa);
            remessa.GerarArquivoRemessa(boletos, stream);

            var boletoBancario = new BoletoBancario() { Boleto = boletos[0] };
            var html = boletoBancario.MontaHtml();
            return html;

            //var pdf = boletoBancario.MontaBytesPDF(false);
            //var pathPDF = GArquivos.CombinarDiretorio(PathRemessa, $"{boleto.NumeroControleParticipante}.pdf");
            //var pathPDF = @"C:\boletos\" + $"{boleto.NumeroControleParticipante}.pdf";
            //File.WriteAllBytes(pathPDF, pdf);
        }

    }
}
