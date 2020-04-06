using ShoppingCMS_V002.DBConnect;
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
        public ActionResult Add_Update_Category(string ActToDo,string Cat_Name,int id=0)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
               // var model = BMF.B_Tags_Filler(CatId);
                return Content(BMF.Add_Update_Category(ActToDo,Cat_Name,id));
                //return Content("hello");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Blog_Category()
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                return View();
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Update_Group(string ActToDo, string G_Name, int id = 0)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                // var model = BMF.B_Tags_Filler(CatId);
                return Content(BMF.Add_Update_Group(ActToDo, G_Name, id));
                //return Content("hello");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Blog_Group()
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                return View();
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Update_Tags(string ActToDo, string T_Name,int CatId, int id = 0)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                // var model = BMF.B_Tags_Filler(CatId);
                return Content(BMF.Add_Update_Tag(ActToDo, T_Name, CatId, id));
                //return Content("hello");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Blog_Tags()
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.BCategory_Filler());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Blog_catTable()
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.Blog_CategoryTable());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult BlogCat_Actions(string ActToDo, int id)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                    db.Script("UPDATE [tbl_BLOG_Categories] SET [Is_Deleted] = 1 WHERE Id=" + id);
                    db.Script("UPDATE [tbl_BLOG_Tags] SET [Is_Deleted] = 1 WHERE CtegoryId=" + id);
                }
                else if (ActToDo == "Active")
                {
                    db.Script("UPDATE [tbl_BLOG_Categories] SET[Is_Disabled] = 0 WHERE Id=" + id);
                    db.Script("UPDATE [tbl_BLOG_Tags] SET [Is_Disabled] = 0 WHERE CtegoryId=" + id);
                }
                else if (ActToDo == "DeActive")
                {
                    db.Script("UPDATE [tbl_BLOG_Categories] SET[Is_Disabled] = 1 WHERE Id=" + id);
                    db.Script("UPDATE [tbl_BLOG_Tags] SET [Is_Disabled] = 1 WHERE CtegoryId=" + id);
                }
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Blog_GroupTable()
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.Blog_GroupTable());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult BlogGroup_Actions(string ActToDo, int id)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                    db.Script("UPDATE [tbl_BLOG_Groups] SET [Is_Deleted] = 1 WHERE G_Id=" + id);
                }
                else if (ActToDo == "Active")
                {
                    db.Script("UPDATE [tbl_BLOG_Groups] SET[Is_Disabled] = 0 WHERE G_Id=" + id);
                }
                else if (ActToDo == "DeActive")
                {
                    db.Script("UPDATE [tbl_BLOG_Groups] SET[Is_Disabled] = 1 WHERE G_Id=" + id);
                }
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Blog_TagTable()
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.Blog_TagTable());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult BlogTag_Actions(string ActToDo, int id)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                    db.Script("UPDATE [tbl_BLOG_Tags] SET [Is_Deleted] = 1 WHERE Id=" + id);
                }
                else if (ActToDo == "Active")
                {
                    db.Script("UPDATE [tbl_BLOG_Tags] SET[Is_Disabled] = 0 WHERE Id=" + id);
                }
                else if (ActToDo == "DeActive")
                {
                    db.Script("UPDATE [tbl_BLOG_Tags] SET[Is_Disabled] = 1 WHERE Id=" + id);
                }
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult PostTable()
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.Posttable());
            }
            else
                return RedirectToAction("NotAccess", "MS");
             
           
        }

        public ActionResult Post_Actions(string ActToDo, int id)
        {
            string SSSession = ""; CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                    db.Script("UPDATE [tbl_BLOG_Post] SET [Is_Deleted] = 1 WHERE Id=" + id);
                }
                else if (ActToDo == "Active")
                {
                    db.Script("UPDATE [tbl_BLOG_Post] SET[Is_Disabled] = 0 WHERE Id=" + id);
                }
                else if (ActToDo == "DeActive")
                {
                    db.Script("UPDATE [tbl_BLOG_Post] SET[Is_Disabled] = 1 WHERE Id=" + id);
                }
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

    }
}