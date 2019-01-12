using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using BoletoNetCore;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using UI.WebApplication.Engine;
//using UI.WebApplication.Models;

namespace UI.WebApplication.Controllers
{
    [Route("GerarBoleto")]
    public class GerarBoletoController : Controller
    {
        //private DataContext db = new DataContext();

        [Route("")]
        [Route("Index")]
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        [Route("Bradesco")]
        public IActionResult Bradesco()
        {
            BradescoEngine be = new BradescoEngine();
            return View();
            //return View("Bradesco", new Product());
        }

        [HttpGet]
        [Route("Santander")]
        public IActionResult Santander()
        {
            return View();
        }

        [HttpGet]
        [Route("Itau")]
        public IActionResult Itau()
        {
            return View();
        }


        //[HttpPost]
        //[Route("Add")]
        //public IActionResult Add(Product product, IFormFile photo)
        //{
        //    // Upload File
        //    if (photo == null || photo.Length == 0)
        //    {
        //        product.Photo = "no-image.png";
        //    }
        //    else
        //    {
        //        var path = Path.Combine(Directory.GetCurrentDirectory(), 
        //            "wwwroot/images", photo.FileName);
        //        var stream = new FileStream(path, FileMode.Create);
        //        product.Photo = photo.FileName;
        //    }
        //    db.Product.Add(product);
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

        //[HttpGet]
        //[Route("Delete/{id}")]
        //public IActionResult Delete(int id)
        //{
        //    db.Product.Remove(db.Product.Find(id));
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}

        //[HttpGet]
        //[Route("Edit/{id}")]
        //public IActionResult Edit(int id)
        //{
        //    return View("Edit", db.Product.Find(id));
        //}

        //[HttpPost]
        //[Route("Edit/{id?}")]
        //public IActionResult Edit(int id, Product product, IFormFile photo)
        //{
        //    // Upload File
        //    if (photo == null || photo.Length == 0)
        //    {
        //        product.Photo = db.Product.Find(product.Id).Photo;
        //    }
        //    else
        //    {
        //        var path = Path.Combine(Directory.GetCurrentDirectory(),
        //            "wwwroot/images", photo.FileName);
        //        var stream = new FileStream(path, FileMode.Create);
        //        product.Photo = photo.FileName;
        //    }

        //    Product ProductUpdate = db.Product.Find(product.Id);            
        //    ProductUpdate.Name = product.Name;
        //    ProductUpdate.Photo = product.Photo;
        //    ProductUpdate.Price = product.Price;
        //    ProductUpdate.Quantity = product.Quantity;
        //    ProductUpdate.Status = product.Status;

        //    db.Entry(ProductUpdate).State = Microsoft.EntityFrameworkCore.EntityState.Modified;
        //    db.SaveChanges();
        //    return RedirectToAction("Index");
        //}
    }
}