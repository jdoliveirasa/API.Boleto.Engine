using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BoletoNetCore;
using Microsoft.AspNetCore.WebSockets.Internal;
using Models = UI.WebApplication.Models;

namespace UI.WebApplication.Engine
{
    public class BradescoEngine
    {
        private Models.DataContext db = new Models.DataContext();

        public BradescoEngine()
        {
            var cedente = (from c in db.Cedente
                              join b in db.Banco on c.IdBanco equals b.IdBanco
                              where c.IdCedente == Common.Constants.Cedente.IBAY
                              select new
                              {                                  
                                  c.IdCedente,
                                  c.IdBanco,
                                  c.Codigo,
                                  c.Documento,
                                  c.Identificacao,
                                  c.NomeCedente,
                                  c.Endereco,
                                  c.Cidade,
                                  c.UF,
                                  c.PathCedenteLogo,
                                  c.Agencia,
                                  c.AgenciaDv,
                                  c.ContaCorrente,
                                  c.ContaCorrenteDv,
                                  c.ConvenioFormato,
                                  c.Convenio,
                                  c.ContratoAcordo,
                                  c.Carteira,
                                  c.CarteiraVariacao,
                                  c.CarteiraDescricao,
                                  c.CodigoCiente,
                                  Banco_IdBanco = b.IdBanco, 
                                  Banco_Descricao = b.Descricao, 
                                  Banco_Codigo = b.Codigo
                              }).FirstOrDefault();

            Boletos boletos = null;
            boletos = new Boletos();

            //Cabeçalho
            boletos.Banco = Banco.Instancia(Int32.Parse(cedente.Banco_Codigo));
            boletos.Banco.Cedente = new Cedente
            {
                CPFCNPJ = cedente.Documento,
                Nome = cedente.Conta.Titular,
                Observacoes = string.Empty,
                ContaBancaria = new ContaBancaria
                {
                    Agencia = this.Conta.Agencia,
                    DigitoAgencia = this.Conta.AgenciaDigito,
                    OperacaoConta = string.Empty,
                    Conta = this.Conta.Numero,
                    DigitoConta = this.Conta.NumeroDigito,
                    CarteiraPadrao = this.Conta.CarteiraBoleto,
                    VariacaoCarteiraPadrao = this.Conta.VariacaoCarteira,
                    TipoCarteiraPadrao = TipoCarteira.CarteiraCobrancaSimples,
                    TipoFormaCadastramento = TipoFormaCadastramento.ComRegistro,
                    TipoImpressaoBoleto = this.Conta.Emissor == EmissaoBoleto.Banco ? TipoImpressaoBoleto.Banco : TipoImpressaoBoleto.Empresa,
                    TipoDocumento = TipoDocumento.Tradicional
                },
                Codigo = this.Conta.CedenteNumero,
                CodigoDV = this.Conta.CedenteDigito.ToString(),
                CodigoTransmissao = string.Empty,
                Endereco = new Boleto2Net.Endereco
                {
                    LogradouroEndereco = Globals.DadosEmpresa.Endereco.Logradouro,
                    LogradouroNumero = Globals.DadosEmpresa.Endereco.Numero,
                    LogradouroComplemento = Globals.DadosEmpresa.Endereco.Complemento,
                    Bairro = Globals.DadosEmpresa.Endereco.Bairro,
                    Cidade = Globals.DadosEmpresa.Endereco.Cidade.Nome,
                    UF = Globals.DadosEmpresa.Endereco.Cidade.Uf.ToString(),
                    CEP = Globals.DadosEmpresa.Endereco.Cep
                }
            };
            boletos.Banco.FormataCedente();

            //Títulos
            foreach (var cr in crs)
            {
                var boleto = new Boleto(boletos.Banco);
                boleto.Sacado = new Sacado
                {
                    CPFCNPJ = cr.Cliente.Cnpj,
                    Nome = cr.Cliente.Razao,
                    Observacoes = string.Empty,
                    Endereco = new Boleto2Net.Endereco
                    {
                        LogradouroEndereco = cr.Cliente.Endereco.Logradouro,
                        LogradouroNumero = cr.Cliente.Endereco.Numero,
                        LogradouroComplemento = cr.Cliente.Endereco.Complemento,
                        Bairro = cr.Cliente.Endereco.Bairro,
                        Cidade = cr.Cliente.Endereco.Cidade.Nome,
                        UF = cr.Cliente.Endereco.Cidade.Uf.ToString(),
                        CEP = cr.Cliente.Endereco.Cep
                    }
                };

                boleto.CodigoOcorrencia = "01"; //Registrar remessa
                boleto.DescricaoOcorrencia = "Remessa Registrar";

                boleto.NumeroDocumento = cr.Codigo.ToString();
                boleto.NumeroControleParticipante = cr.Codigo.ToString();
                boleto.NossoNumero = cr.Codigo.ToString();

                boleto.DataEmissao = cr.Lancamento;
                boleto.DataVencimento = cr.Vencimento;
                boleto.ValorTitulo = cr.ValorAberto;
                boleto.Aceite = "N";
                boleto.EspecieDocumento = TipoEspecieDocumento.DM;

                //boleto.DataDesconto = DateTime.Today;
                //boleto.ValorDesconto = 0;
                if (this.Conta.PercentualMulta > 0)
                {
                    boleto.DataMulta = cr.Vencimento.AddDays(1);
                    boleto.PercentualMulta = this.Conta.PercentualMulta;
                    boleto.ValorMulta = boleto.ValorTitulo * boleto.PercentualMulta / 100;

                    boleto.MensagemInstrucoesCaixa = $"Cobrar Multa de {boleto.ValorMulta.FormatoMoeda()} após o vencimento.";
                }

                if (this.Conta.PercentualMora > 0)
                {
                    boleto.DataJuros = cr.Vencimento.AddDays(1);
                    boleto.PercentualJurosDia = (this.Conta.PercentualMora / 30);
                    boleto.ValorJurosDia = boleto.ValorTitulo * boleto.PercentualJurosDia / 100;

                    string instrucao = $"Cobrar juros de {boleto.PercentualJurosDia.FormatoPorcentagem()} por dia de atraso";
                    if (string.IsNullOrEmpty(boleto.MensagemInstrucoesCaixa))
                        boleto.MensagemInstrucoesCaixa = instrucao;
                    else
                        boleto.MensagemInstrucoesCaixa += Environment.NewLine + instrucao;
                }

                /*
                boleto.CodigoInstrucao1 = string.Empty;
                boleto.ComplementoInstrucao1 = string.Empty;

                boleto.CodigoInstrucao2 = string.Empty;
                boleto.ComplementoInstrucao2 = string.Empty;

                boleto.CodigoInstrucao3 = string.Empty;
                boleto.ComplementoInstrucao3 = string.Empty;                
                */

                boleto.CodigoProtesto = this.Conta.DiasProtesto == 0 ? TipoCodigoProtesto.NaoProtestar : TipoCodigoProtesto.ProtestarDiasuteis;
                boleto.DiasProtesto = this.Conta.DiasProtesto;

                boleto.CodigoBaixaDevolucao = TipoCodigoBaixaDevolucao.NaoBaixarNaoDevolver;
                boleto.DiasBaixaDevolucao = 0;

                boleto.ValidarDados();
                boletos.Add(boleto);
            }
            #endregion Daddos do título

            //Gerar Remessa
            var stream = new MemoryStream();
            var remessa = new ArquivoRemessa(boletos.Banco, this.Conta.LayoutRemessa == LayoutRemessa.Cnab240 ? TipoArquivo.CNAB240 : TipoArquivo.CNAB400, this.Conta.SequencialRemessa);
            remessa.GerarArquivoRemessa(boletos, stream);


            //Gerar boletos - aqui eu gravo os arquivos um a um porque mando via e-mail.
            foreach (var boleto in boletos)
            {
                var boletoBancario = new BoletoBancario() { Boleto = boleto };
                var pdf = boletoBancario.MontaBytesPDF(false);
                var pathPDF = GArquivos.CombinarDiretorio(PathRemessa, $"{boleto.NumeroControleParticipante}.pdf");
                File.WriteAllBytes(pathPDF, pdf);
            }
        }


    }
}
