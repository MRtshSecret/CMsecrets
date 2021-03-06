﻿using PagedList;
using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.D_APIModels;
using ShoppingCMS_V002.ModelViews.D_APIModelViews;
using ShoppingCMS_V002.OtherClasses;
using ShoppingCMS_V002.OtherClasses.Blog;
using ShoppingCMS_V002.OtherClasses.D_APIOtherClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using Newtonsoft.Json;
using ShoppingCMS_V002.OtherClasses.MasterChi_Fu;
using ShoppingCMS_V002.Models.Blog;

namespace ShoppingCMS_V002.Controllers
{
    public class D_APIController : Controller
    {
      
        public ActionResult Index()
        {
            Blog_ModelFiller BMF = new Blog_ModelFiller(3);
            var model = new BlogPostsModel()
            {
                Posts = BMF.UserPostModels("همه", 1, 0, "")
            };
            return View(model);
        }

        public ActionResult AboutUs()
        {
            
            D_APIModelFiller DMF = new D_APIModelFiller();
            var model = new AboutUsModelView()
            {
                CompanyCustomers=DMF.CompanyCustomers(),
                TeamMembers=DMF.TeamMembers()
            };
            return View(model);
        }

        public ActionResult Terms()
        {

            return View();
        }

        public ActionResult ContactUs()
        {
            
            return View();
        }

        public ActionResult ShoppingCartPopup(int factorId)
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            return View(DMF.shoppingCart(factorId));
        }
        public ActionResult ShoppingCart(int factorId)
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            var model = new ShoppingCartModelView()
            {
                FactorModel= DMF.shoppingCart(factorId),
                Ostan=DMF.Ostanha()
            };
            return View(model);
        }

        public ActionResult Product_Detail(int Id)
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }

            D_APIModelFiller DMF = new D_APIModelFiller();
            var model = new ProductDetail_ModelView()
            {
                ProductModel = DMF.SingleProduct(Id, "Ago"),
                Company = DMF.CompanyCustomers()
            };
            model.RelatedProducts = DMF.ProductList(15, "گروه اصلی", model.ProductModel.SubCatId, 1,"","Ago");
            return View(model);
        }

        public ActionResult Product_List(string Type,int Id=0,int Page=1,string Search="",int CustomerId=0)
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }
            D_APIModelFiller DMF = new D_APIModelFiller(4);
            D_APIModelFiller DMF2 = new D_APIModelFiller();
            var model = new D_ProductList_ModelView()
            {
                Cateqories = DMF.CategoriesAsTree_OneSub("MainCat", 1),
                NewProducts = DMF.ChosenProducts("New", 3, "Ago"),
                Sale_Products = DMF.ChosenProducts("Sale", 3, "Ago"),
                ProductsG3 = DMF.ChosenProducts("MainTag", 3, "Ago", 1),
                thisPage=Page,
                Cat=Type,
                Search=Search,
                CatId=Id
            };
            
            if (Type== "پرفروش ها")
            {
                model.Products = DMF.ChosenProducts("Sale", 15, "Ago");
                model.Pages = 1;
            }
            else if(Type=="جدیدترین")
            {
                model.Products = DMF.ChosenProducts("New", 15, "Ago");
                model.Pages = 1;
            }
            else if(Type=="فروش ویژه")
            {
                model.Products = DMF.ChosenProducts("MainTag", 15, "Ago",1);
                model.Pages = 1;
            }else if(Type== "علاقه مندی ها")
            {
                model.Products = DMF2.FavoriteProducts(15, Type, Id, Page, Search, "Date",CustomerId);
                model.Pages = DMF2.ProList_Pages(Type, 15, Id, Search,CustomerId);
            }
            else
            {
                model.Products = DMF2.ProductList(15, Type, Id, Page, Search, "Date");
                model.Pages = DMF2.ProList_Pages(Type, 15, Id, Search);
            }
           



            if(Type== "گروه اصلی")
            {
                model.tags = DMF2.ProductTags("Sub", Id);
            }
            else
            {
                model.tags = DMF2.ProductTags("min", 0);
            }
            return View(model);
        }

        [HttpGet]
        public ActionResult MyAccount()
        {
            HttpCookie reqCookies = Request.Cookies["Cookies"];

            string C_Mobile, C_Password;

            if (reqCookies != null)

            {
                C_Mobile = reqCookies["C_Mobile"].ToString();
                C_Password = reqCookies["C_Password"].ToString();

                PDBC dbo = new PDBC("PandaMarketCMS", true);
                string query;
                query = "SELECT [id_Customer],[C_Mobile],[C_Password]FROM[PandaMarketCMS].[dbo].[tbl_Customer_Main]";
                query += $" where[C_Mobile] = N'{C_Mobile}' AND [C_Password] = N'{C_Password}'";
                dbo.Connect();
                using (DataTable dt = dbo.Select(query))
                {
                    if (dt.Rows.Count > 0)
                    {
                        tbl_Customer_Main data = new tbl_Customer_Main()
                        {
                            id_Customer = dt.Rows[0]["id_Customer"].ToString()
                        };



                        Session["d1"] = data;
                        return Redirect("???????");
                    }


                }
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult login2(string MobileNum,string pass)
        {
            Encryption ENC = new Encryption();
            
                PDBC dbo = new PDBC("PandaMarketCMS", true);
                string query;
                query = "SELECT [id_Customer],[C_Mobile],[C_Password]FROM[PandaMarketCMS].[dbo].[tbl_Customer_Main]";
                query += $" where[C_Mobile] = N'"+MobileNum+"' AND [C_Password] = N'"+ENC.MD5Hash(pass)+"'";
                dbo.Connect();
                using (DataTable dt = dbo.Select(query))
                {
                    if (dt.Rows.Count > 0)
                    {

                        return RedirectToAction("EncryptOMD", "API_Functions",new { Token= dt.Rows[0]["id_Customer"].ToString() });
                    }
                    else
                    {
                     
                        return Content("Wrong value");

                    }
                }
            
            

        }
        /// /////////////////////{ end : login }////////////////////////

        ////////////////////////{ start : blog }////////////////////////5
        ///مثال 
        ////url = MS/blog?NamePage=post&page=1
        ////url = MS/blog?NamePage=Categories&Valuepage=اخبار پاندایی&page=1
        public ActionResult Blog(string Cat = "همه", int Page = 1, int Id = 0, string search = "")
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            string SearchNAmeHeader = "تمامی مطالب";
            int num = 1;
            db.Connect();
            if (Cat == "همه")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post]  where Is_Deleted=0 AND Is_Disabled=0").Rows[0][0]);
                db.DC();
            }
            else if (Cat == "دسته بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND Cat_Id=" + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Categories] WHERE [Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "گروه بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND [GroupId] = " + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Groups] WHERE [G_Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "برچسب")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_BLOG_TagConnector] as A inner join [tbl_BLOG_Post] as B on A.Post_Id=B.Id where Is_Deleted=0 AND Is_Disabled=0 AND Tag_Id=" + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Tags] WHERE [Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "جست و جو")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where (Is_Deleted=0 AND Is_Disabled=0) AND (Title Like N'%" + search + "%' OR Text_min Like N'%" + search + "%' OR [Text] Like N'%" + search + "%') ").Rows[0][0]);
                db.DC();
            }

            if (num % 15 == 0)
            {
                num = (num / 15);
            }
            else
            {
                num = (num / 15) + 1;
            }




            Blog_ModelFiller BMF = new Blog_ModelFiller();
            var model = new BlogPostsModel()
            {
                Categories = BMF.BCategory_Filler(),
                Tags = BMF.B_AllTags_Filler(),
                Posts = BMF.UserPostModels(Cat, Page, Id, search),
                GroupsList = BMF.C_AllTags_Filler(),
                Pages = num,
                Page = Page,
                Cat = Cat,
                Id = Id,
                SearchNAmeHeaderH1 = SearchNAmeHeader
            };

            return View(model);
        }

        /// /////////////////////{ end : blog }////////////////////////
        /// 
        ////////////////////////{ start : blog_post }////////////////////////6
        ////مثال
        ////url = MS/blog_post?IdPage=1
        public ActionResult Blog_Post(int Id)
        {
            Blog_ModelFiller BMF = new Blog_ModelFiller(3);
            var model = new SinglePostModel()
            {
                PostModel = BMF.UserPostModels("همه", 1, 0, ""),
                SPPD = BMF.SinglePostFiller(Id),
                BlogPicSlider = BMF.GetAllBlogPostPics(Id)
            };
            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult comment_post(tbl_BLOG tbl)
        {

            string query_new;
            string res = " ";


            PDBC db = new PDBC("PandaMarketCMS", true);


            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            query_new = "INSERT INTO [dbo].[tbl_BLOG_Comment]([Email],[message],[Name],[PostId])VALUES(@Email ,@message ,@Name ,@PostId)";

            parameters = new ExcParameters()
            {
                _KEY = "@Email",
                _VALUE = tbl.Email
            };
            paramss.Add(parameters);
            parameters = new ExcParameters()
            {
                _KEY = "@message",
                _VALUE = tbl.message
            };
            paramss.Add(parameters);
            parameters = new ExcParameters()
            {
                _KEY = "@Name",
                _VALUE = tbl.name
            };
            paramss.Add(parameters);
            parameters = new ExcParameters()
            {
                _KEY = "@PostId",
                _VALUE = tbl.Id
            };
            paramss.Add(parameters);
            db.Connect();
            res = db.Script(query_new, paramss);
            db.DC();


            return Redirect("blog_post?IdPage=" + tbl.Id);
        }


        public ActionResult AfraMaterPostsTypes()
        {

            Blog_ModelFiller BMF = new Blog_ModelFiller();
            BlogPostsModel bpm = new BlogPostsModel()
            {
                GroupsList = BMF.Groups_Filler()
            };
            return View(bpm);
        }
        /// /////////////////////{ end : blog_post }////////////////////////
        public ActionResult BlogMainPageSectionofPost()
        {

            Blog_ModelFiller BMF = new Blog_ModelFiller();
            var model = new BlogPostsModel()
            {
                Posts = BMF.UserPostModels("همه", 1, 7, "")

            };

            return View(model);
        }

        public ActionResult LoginAndRegister()
        {


            return View();
        }







    }
}