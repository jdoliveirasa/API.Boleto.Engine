using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace UI.WebApplication.Models
{
    public class Cliente
    {

        [Key]
        public int IdCliente { get; set; }

        public string Email { get; set; }

        public string Nome { get; set; }

        public DateTime DataNascimento { get; set; }

        public string Genero { get; set; }

        public string Cpf { get; set; }

        public string Telefone { get; set; }

    }
}
