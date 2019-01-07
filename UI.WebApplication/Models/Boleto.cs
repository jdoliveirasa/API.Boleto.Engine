using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace UI.WebApplication.Models
{
    public class Boleto
    {

        [Key]
        public long IdBoleto { get; set; }

        public long IdStatusBoleto { get; set; }

        public long IdBanco { get; set; }

        public long IdCliente { get; set; }

        public decimal ValorTitulo { get; set; }

        public string NossoNumero { get; set; }

        public string NumeroDocumento { get; set; }

        public string DigitoVerificador { get; set; }

        public string NossoNumeroFormatado { get; set; }

        public string CodigoDeBarras { get; set; }

        public string LinhaDigitavel { get; set; }

        public int Ano { get; set; }

        public int Mes { get; set; }

        public int Dia { get; set; }

        public DateTime DataVencimento { get; set; }

        public DateTime DataPagamento { get; set; }

        public DateTime DataRegistro { get; set; }

        public DateTime DataModifiacao { get; set; }

    }
}
