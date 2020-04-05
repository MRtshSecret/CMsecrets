using ShoppingCMS_V002.ModelViews;
using ShoppingCMS_V002.OtherClasses;
using ShoppingCMS_V002.OtherClasses.Blog;
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

        public ActionResult NewBlogPost(string ActToDo = "New", int Post_id = 0)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                //ControllerContext.ParentActionViewContext.ViewBag.PageTitle = "";
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                var Model = new Blog_Post_insert_Model()
                {
                    Action_ToDo = ActToDo,
                    Category = BMF.BCategory_Filler(),
                    Groups = BMF.Groups_Filler()
                };

                if (ActToDo.Equals("Edit"))
                {
                    Model.PostData = BMF.EditModelFiller(Post_id);
                }


                return View(Model);
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        [HttpPost]
        public ActionResult Add_Edit_Post(string ActTodo, int WrittenBy_AdminId, string Title, string Text_min, string Text, int weight, int Cat_Id, int IsImportant, int GroupId, string Pictures, string Blog_Tags, int id_pr = 0)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();

                return Content(BMF.Post_Action(ActTodo, WrittenBy_AdminId, Title, Text_min, Text, weight, Cat_Id, IsImportant, GroupId, Pictures, Blog_Tags, id_pr));
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        [HttpPost]
        public ActionResult TagFiller(int CatId)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                var model = BMF.B_Tags_Filler(CatId);
                return Json(model);
                //return Content("hello");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }


    }
}