using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShoppingCMS_V002.Controllers
{
    public class BlogMainController : Controller
    {
        // GET: BlogMain
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult NewBlogPost()
        {
            //ControllerContext.ParentActionViewContext.ViewBag.PageTitle = "";
            return View();
        }

    }
}