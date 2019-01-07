using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace UI.WebApplication.Models
{
    public class Cedente
    {

        [Key]
        public int IdCedente { get; set; }

        public int IdBanco { get; set; }

        public string Codigo { get; set; }

        public string Documento { get; set; }

        public string Identificacao { get; set; }

        public string NomeCedente { get; set; }

        public string Endereco { get; set; }

        public string Cidade { get; set; }

        public string UF { get; set; }

        public string PathCedenteLogo { get; set; }

        public string Agencia { get; set; }

        public int AgenciaDv { get; set; }

        public string ContaCorrente { get; set; }

        public int ContaCorrenteDv { get; set; }

        public int ConvenioFormato { get; set; }

        public string Convenio { get; set; }

        public string ContratoAcordo { get; set; }

        public string Carteira { get; set; }

        public string CarteiraVariacao { get; set; }

        public string CarteiraDescricao { get; set; }

        public string CodigoCiente { get; set; }

    }
}
