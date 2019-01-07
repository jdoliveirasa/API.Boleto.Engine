using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace UI.WebApplication.Models
{
    public class StatusBoleto
    {

        [Key]
        public int IdStatusBoleto { get; set; }

        public string Descricao { get; set; }

    }
}
