using System;
using System.Collections.Generic;
using System.IO;
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
            if (photo == null || photo.Length == 0)
            {
                product.Photo = "no-image.png";
            }
            else
            {
                var path = Path.Combine(Directory.GetCurrentDirectory(), 
                    "wwwroot/images", photo.FileName);
                var stream = new FileStream(path, FileMode.Create);
                product.Photo = photo.FileName;
            }
            db.Product.Add(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [HttpGet]
        [Route("Delete/{id}")]
        public IActionResult Delete(int id)
        {
            db.Product.Remove(db.Product.Find(id));
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [HttpGet]
        [Route("Edit/{id}")]
        public IActionResult Edit(int id)
        {
            return View("Edit", db.Product.Find(id));
        }

        [HttpPost]
        [Route("Edit/{id?}")]
        public IActionResult Edit(int id, Product product, IFormFile photo)
        {
            // Upload File
            if (photo == null || photo.Length == 0)
            {
                product.Photo = db.Product.Find(product.Id).Photo;
            }
            else
            {
                var path = Path.Combine(Directory.GetCurrentDirectory(),
                    "wwwroot/images", photo.FileName);
                var stream = new FileStream(path, FileMode.Create);
                product.Photo = photo.FileName;
            }

            Product ProductUpdate = db.Product.Find(product.Id);            
            ProductUpdate.Name = product.Name;
            ProductUpdate.Photo = product.Photo;
            ProductUpdate.Price = product.Price;
            ProductUpdate.Quantity = product.Quantity;
            ProductUpdate.Status = product.Status;

            db.Entry(ProductUpdate).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}