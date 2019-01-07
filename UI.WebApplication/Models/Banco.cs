using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace UI.WebApplication.Models
{
    public class Banco
    {

        [Key]
        public int IdBanco { get; set; }

        public string Descricao { get; set; }

        public string Codigo { get; set; }

    }
}
