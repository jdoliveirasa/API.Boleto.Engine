using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using UI.WebApplication.Models;

namespace UI.WebApplication.Controllers
{
    [Route("product")]
    public class ProductController : Controller
    {
        private DataContext db = new DataContext();

        [Route("")]
        [Route("index")]
        [Route("~/")]
        public IActionResult Index()
        {
            ViewBag.products = db.Product.ToList();
            return View();
        }

        [HttpGet]
        [Route("Add")]
        public IActionResult Add()
        {
            return View("Add", new Product());
        }

        [HttpPost]
        [Route("Add")]
        public IActionResult Add(Product product, IFormFile photo)
        {
            // Upload File
            if (photo != null || photo.Length != 0)
            {
            }
            return View("Add", new Product());
        }
    }
}