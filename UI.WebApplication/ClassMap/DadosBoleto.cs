using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UI.WebApplication.ClassMap
{
    public class DadosBoleto
    {
        public string CodigoOcorrencia { get; set; }

        public string DescricaoOcorrencia { get; set; }

        public string Codigo { get; set; }

        public DateTime Lancamento { get; set; }

        public DateTime Vencimento { get; set; }

        public decimal ValorAberto { get; set; }

        public string Aceite { get; set; }

    }
}
