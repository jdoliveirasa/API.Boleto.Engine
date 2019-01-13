//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Threading.Tasks;
//using BoletoNetCore;
//using Microsoft.AspNetCore.WebSockets.Internal;
//using UI.WebApplication.ClassMap;
//using Models = UI.WebApplication.Models;

//namespace UI.WebApplication.Engine
//{
//    public class BradescoEngine
//    {
//        private Models.DataContext db = new Models.DataContext();

//        public BradescoEngine()
//        {
//            //SELECT NO BANCO
//            //var cedente = (from c in db.Cedente
//            //               join b in db.Banco on c.IdBanco equals b.IdBanco
//            //               where c.IdCedente == Common.Constants.Cedente.IBAY
//            //               select new
//            //               {
//            //                   c.IdCedente,
//            //                   c.IdBanco,
//            //                   c.Codigo,
//            //                   c.Documento,
//            //                   c.Identificacao,
//            //                   c.NomeCedente,
//            //                   c.Endereco,
//            //                   c.Cidade,
//            //                   c.UF,
//            //                   c.PathCedenteLogo,
//            //                   c.Agencia,
//            //                   c.AgenciaDv,
//            //                   c.ContaCorrente,
//            //                   c.ContaCorrenteDv,
//            //                   c.ConvenioFormato,
//            //                   c.Convenio,
//            //                   c.ContratoAcordo,
//            //                   c.Carteira,
//            //                   c.CarteiraVariacao,
//            //                   c.CarteiraDescricao,
//            //                   c.CodigoCiente,
//            //                   Banco_IdBanco = b.IdBanco,
//            //                   Banco_Descricao = b.Descricao,
//            //                   Banco_Codigo = b.Codigo
//            //               }).FirstOrDefault();
//            //SELECT NO BANCO


//            //Dados do Cedente
//            Boletos boletos = null;
//            boletos = new Boletos();

//            Conta conta = new Conta();
//            conta.BancoNumero = "237";
//            conta.Titular = "FULANO DE TAL DA SILVA";
//            conta.Agencia = "1234";
//            conta.AgenciaDigito = "X";
//            conta.Numero = "123456";
//            conta.NumeroDigito = "X";
//            conta.CarteiraBoleto = "09";
//            conta.VariacaoCarteira = "666"; //M
//            conta.Emissor = "666"; //M
//            conta.CedenteNumero = "6666"; //M
//            conta.CedenteDigito = "6"; //M

//            EmissaoBoleto emissaoBoleto = new EmissaoBoleto();
//            emissaoBoleto.Banco = "Banco Bradesco S.A."; //M

//            GlobalsDadosEmpresa globalsDadosEmpresa = new GlobalsDadosEmpresa();
//            globalsDadosEmpresa.Cnpj = "97969747000194";
//            globalsDadosEmpresa.Logradouro = "RUA DAS ESTRELAS";
//            globalsDadosEmpresa.Numero = "666";
//            globalsDadosEmpresa.Complemento = "SL 13";
//            globalsDadosEmpresa.Bairro = "CAMANDORA";
//            globalsDadosEmpresa.CidadeNome = "CAMPINAS";
//            globalsDadosEmpresa.CidadeUf = "SP";
//            globalsDadosEmpresa.Cep = "34188130";

//            //Dados do Cliente            
//            Cliente cliente = new Cliente();
//            cliente.Cnpj = "10048848000144";
//            cliente.Razao = "ADAPTUP TI";
//            cliente.Logradouro = "RUA DOS PLANETAS";
//            cliente.Numero = "8541";
//            cliente.Complemento = "4 AND";
//            cliente.Bairro = "SERRA";
//            cliente.CidadeNome = "VITÓRIA";
//            cliente.Uf = "ES";
//            cliente.Cep = "23596478";


//            //Cabeçalho
//            boletos.Banco = Banco.Instancia(Int32.Parse(conta.BancoNumero));
//            boletos.Banco.Cedente = new Cedente
//            {
//                CPFCNPJ = globalsDadosEmpresa.Cnpj,
//                Nome = conta.Titular,
//                Observacoes = string.Empty,
//                ContaBancaria = new ContaBancaria
//                {
//                    Agencia = conta.Agencia,
//                    DigitoAgencia = conta.AgenciaDigito,
//                    OperacaoConta = string.Empty,
//                    Conta = conta.Numero,
//                    DigitoConta = conta.NumeroDigito,
//                    CarteiraPadrao = conta.CarteiraBoleto,
//                    //VariacaoCarteiraPadrao = conta.VariacaoCarteira,
//                    TipoCarteiraPadrao = TipoCarteira.CarteiraCobrancaSimples,
//                    TipoFormaCadastramento = TipoFormaCadastramento.ComRegistro,
//                    TipoImpressaoBoleto = conta.Emissor == emissaoBoleto.Banco ? TipoImpressaoBoleto.Banco : TipoImpressaoBoleto.Empresa,
//                    TipoDocumento = TipoDocumento.Tradicional
//                },
//                Codigo = conta.CedenteNumero,
//                CodigoDV = conta.CedenteDigito.ToString(),
//                CodigoTransmissao = string.Empty,
//                //Endereco = new Boleto2Net.Endereco
//                Endereco = new Endereco
//                {
//                    LogradouroEndereco = globalsDadosEmpresa.Logradouro,
//                    LogradouroNumero = globalsDadosEmpresa.Numero,
//                    LogradouroComplemento = globalsDadosEmpresa.Complemento,
//                    Bairro = globalsDadosEmpresa.Bairro,
//                    Cidade = globalsDadosEmpresa.CidadeNome,
//                    UF = globalsDadosEmpresa.CidadeUf,
//                    CEP = globalsDadosEmpresa.Cep
//                }
//            };
//            boletos.Banco.FormataCedente();

//            //Títulos
//            foreach (var cr in crs)
//            {
//                var boleto = new Boleto(boletos.Banco);
//                boleto.Sacado = new Sacado
//                {
//                    CPFCNPJ = cr.Cliente.Cnpj,
//                    Nome = cr.Cliente.Razao,
//                    Observacoes = string.Empty,
//                    Endereco = new Boleto2Net.Endereco
//                    {
//                        LogradouroEndereco = cr.Cliente.Endereco.Logradouro,
//                        LogradouroNumero = cr.Cliente.Endereco.Numero,
//                        LogradouroComplemento = cr.Cliente.Endereco.Complemento,
//                        Bairro = cr.Cliente.Endereco.Bairro,
//                        Cidade = cr.Cliente.Endereco.Cidade.Nome,
//                        UF = cr.Cliente.Endereco.Cidade.Uf.ToString(),
//                        CEP = cr.Cliente.Endereco.Cep
//                    }
//                };

//                boleto.CodigoOcorrencia = "01"; //Registrar remessa
//                boleto.DescricaoOcorrencia = "Remessa Registrar";

//                boleto.NumeroDocumento = cr.Codigo.ToString();
//                boleto.NumeroControleParticipante = cr.Codigo.ToString();
//                boleto.NossoNumero = cr.Codigo.ToString();

//                boleto.DataEmissao = cr.Lancamento;
//                boleto.DataVencimento = cr.Vencimento;
//                boleto.ValorTitulo = cr.ValorAberto;
//                boleto.Aceite = "N";
//                boleto.EspecieDocumento = TipoEspecieDocumento.DM;

//                //boleto.DataDesconto = DateTime.Today;
//                //boleto.ValorDesconto = 0;
//                if (this.Conta.PercentualMulta > 0)
//                {
//                    boleto.DataMulta = cr.Vencimento.AddDays(1);
//                    boleto.PercentualMulta = this.Conta.PercentualMulta;
//                    boleto.ValorMulta = boleto.ValorTitulo * boleto.PercentualMulta / 100;

//                    boleto.MensagemInstrucoesCaixa = $"Cobrar Multa de {boleto.ValorMulta.FormatoMoeda()} após o vencimento.";
//                }

//                if (this.Conta.PercentualMora > 0)
//                {
//                    boleto.DataJuros = cr.Vencimento.AddDays(1);
//                    boleto.PercentualJurosDia = (this.Conta.PercentualMora / 30);
//                    boleto.ValorJurosDia = boleto.ValorTitulo * boleto.PercentualJurosDia / 100;

//                    string instrucao = $"Cobrar juros de {boleto.PercentualJurosDia.FormatoPorcentagem()} por dia de atraso";
//                    if (string.IsNullOrEmpty(boleto.MensagemInstrucoesCaixa))
//                        boleto.MensagemInstrucoesCaixa = instrucao;
//                    else
//                        boleto.MensagemInstrucoesCaixa += Environment.NewLine + instrucao;
//                }

//                /*
//                boleto.CodigoInstrucao1 = string.Empty;
//                boleto.ComplementoInstrucao1 = string.Empty;

//                boleto.CodigoInstrucao2 = string.Empty;
//                boleto.ComplementoInstrucao2 = string.Empty;

//                boleto.CodigoInstrucao3 = string.Empty;
//                boleto.ComplementoInstrucao3 = string.Empty;                
                



//            /*

//                boleto.CodigoProtesto = this.Conta.DiasProtesto == 0 ? TipoCodigoProtesto.NaoProtestar : TipoCodigoProtesto.ProtestarDiasuteis;
//                boleto.DiasProtesto = this.Conta.DiasProtesto;

//                boleto.CodigoBaixaDevolucao = TipoCodigoBaixaDevolucao.NaoBaixarNaoDevolver;
//                boleto.DiasBaixaDevolucao = 0;

//                boleto.ValidarDados();
//                boletos.Add(boleto);
//            }
//#endregion Daddos do título

//            //Gerar Remessa
//            var stream = new MemoryStream();
//            var remessa = new ArquivoRemessa(boletos.Banco, this.Conta.LayoutRemessa == LayoutRemessa.Cnab240 ? TipoArquivo.CNAB240 : TipoArquivo.CNAB400, this.Conta.SequencialRemessa);
//            remessa.GerarArquivoRemessa(boletos, stream);


//            //Gerar boletos - aqui eu gravo os arquivos um a um porque mando via e-mail.
//            foreach (var boleto in boletos)
//            {
//                var boletoBancario = new BoletoBancario() { Boleto = boleto };
//                var pdf = boletoBancario.MontaBytesPDF(false);
//                var pathPDF = GArquivos.CombinarDiretorio(PathRemessa, $"{boleto.NumeroControleParticipante}.pdf");
//                File.WriteAllBytes(pathPDF, pdf);
//            }

//        */

//            }
//        }
//    }
