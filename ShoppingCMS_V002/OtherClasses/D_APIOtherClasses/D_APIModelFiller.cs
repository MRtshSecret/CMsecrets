using MD.PersianDateTime;
using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.D_APIModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace ShoppingCMS_V002.OtherClasses.D_APIOtherClasses
{
    public class D_APIModelFiller
    {
        public string AppendServername(string url)
        {
            return "https://" + HttpContext.Current.Request.Url.Authority + "/" + url;
        }

        /// <summary>
        ///  زمان را به صورت رشته دریافت میکند و به صورت های مختلف تاریخ شمسی تبدیل میکند
        /// </summary>
        /// <param name="date_">زمان به صورت رشته</param>
        /// <param name="DateType">
        /// Date : تاریخ 
        /// Time : زمان
        /// DateTime : تاریخ و زمان به طور کامل
        /// Ago : چند دقیقه ، ساعت یا روز پیش
        /// </param>
        /// <returns>تاریخ تبدیل شده به صورت رشته</returns>
        public string DateReturner(string date_, string DateType)
        {
            DateTime date = Convert.ToDateTime(date_);
            PersianDateTime persianDateTime = new PersianDateTime(date);

            if (DateType == "Date")
            {
                return persianDateTime.ToLongDateString();
            }
            else if (DateType == "Time")
            {
                return persianDateTime.ToLongTimeString();
            }
            else if (DateType == "DateTime")
            {
                return persianDateTime.ToLongDateTimeString();
            }
            else if (DateType == "Ago")
            {
                string LastSeen = "";
                PersianDateTime PerNow = new PersianDateTime(DateTime.Now);
                var dateTest = PerNow.Subtract(persianDateTime);
                if (dateTest.Days < 1)
                {
                    if (dateTest.Hours < 1)
                    {
                        LastSeen = dateTest.Minutes + " دقیقه ی پیش";

                    }
                    else
                    {
                        LastSeen = dateTest.Hours + "ساعت پیش";
                    }
                }
                else
                {
                    LastSeen = dateTest.Days + "روز پیش";
                }
                return LastSeen;

            }
            else
            {
                return "";
            }
        }
        /// <summary>
        /// زمان را به صورت تاریخ وزمان دریافت میکند و به صورت های مختلف تاریخ شمسی تبدیل میکند
        /// </summary>
        /// <param name="date_">زمان</param>
        /// <param name="DateType">
        /// Date : تاریخ 
        /// Time : زمان
        /// DateTime : تاریخ و زمان به طور کامل
        /// Ago : چند دقیقه ، ساعت یا روز پیش
        /// </param>
        /// <returns>تاریخ تبدیل شده به صورت رشته</returns>
        public string DateReturner(DateTime date_, string DateType)
        {
            
            PersianDateTime persianDateTime = new PersianDateTime(date_);

            if (DateType == "Date")
            {
                return persianDateTime.ToLongDateString();
            }
            else if (DateType == "Time")
            {
                return persianDateTime.ToLongTimeString();
            }
            else if (DateType == "DateTime")
            {
                return persianDateTime.ToLongDateTimeString();
            }
            else if (DateType == "Ago")
            {
                string LastSeen = "";
                PersianDateTime PerNow = new PersianDateTime(DateTime.Now);
                var dateTest = PerNow.Subtract(persianDateTime);
                if (dateTest.Days < 1)
                {
                    if (dateTest.Hours < 1)
                    {
                        LastSeen = dateTest.Minutes + " دقیقه ی پیش";

                    }
                    else
                    {
                        LastSeen = dateTest.Hours + "ساعت پیش";
                    }
                }
                else
                {
                    LastSeen = dateTest.Days + "روز پیش";
                }
                return LastSeen;

            }
            else
            {
                return "";
            }
        }

        public List<Id_ValueModel> ProductTags(string type,int id)
        {
            var res = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            string query = "";

            if(type=="min")
            {
                query = "SELECT top 10 A.[id_TE],A.[TE_name] FROM [tbl_Product_TagEnums] as A inner join [tbl_Product_SubCategory] as B on A.SubCatId=B.id_SC  where B.ISDelete=0 AND B.ISDESABLED=0 order by (SELECT Count(*) FROM [tbl_Product_tagConnector] where id_TE=A.id_TE)DESC";
            }else
            {
                if(id==0)
                {
                    query = "SELECT [id_TE],[TE_name] FROM [tbl_Product_TagEnums] as A inner join [tbl_Product_SubCategory] as B on A.SubCatId=B.id_SC where B.ISDelete=0 AND B.ISDESABLED=0";
                }
                else
                {
                    query = "SELECT top 10 A.[id_TE],A.[TE_name] FROM [tbl_Product_TagEnums] as A inner join [tbl_Product_SubCategory] as B on A.SubCatId=B.id_SC  where B.ISDelete=0 AND B.ISDESABLED=0 AND A.SubCatId=" + id;
                }
            }


            DataTable dt = db.Select(query);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id=Convert.ToInt32(dt.Rows[i]["id_TE"]),
                    Value= dt.Rows[i]["TE_name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> Categories(string CatName, int id = 0)
        {
            string query = "";
            if (CatName == "Type")
            {
                query = "SELECT [id_PT] as id ,[PTname] as [name] FROM [tbl_Product_Type] WHERE ISDelete=0 AND ISDESABLED=0";

            }
            else if (CatName == "MainCat")
            {
                if (id != 0)
                {
                    query = "SELECT [id_MC] as id,[MCName] as [name] FROM[tbl_Product_MainCategory] WHERE ISDelete=0 AND ISDESABLED=0 AND id_PT=" + id;
                }
            }
            else if (CatName == "SubCat")
            {
                if (id != 0)
                {
                    query = "SELECT [id_SC] as id,[SCName] as [name] FROM [tbl_Product_SubCategory]WHERE ISDelete=0 AND ISDESABLED =0 AND id_MC=" + id;
                }
            }
            else if (CatName == "SubCat_Key")
            {
                if (id != 0)
                {
                    query = "SELECT [id_SCOK] as id,[SCOKName] as [name] FROM[tbl_Product_SubCategoryOptionKey]WHERE ISDelete=0 AND [ISDESABLED]=0 AND [id_SC]=" + id;
                }
            }
            else if (CatName == "SubCat_Value")
            {
                if (id != 0)
                {
                    query = "SELECT [id_SCOV] as id,[SCOVValueName] as [name] FROM[tbl_Product_SubCategoryOptionValue]WHERE[id_SCOK] = " + id;
                }
            }
            List<Id_ValueModel> result = new List<Id_ValueModel>();
            if (!query.Equals(""))
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();

                DataTable dt = db.Select(query);



                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    var maodel = new Id_ValueModel()
                    {
                        Id = Convert.ToInt32(dt.Rows[i]["id"]),
                        Value = dt.Rows[i]["name"].ToString()
                    };
                    result.Add(maodel);
                }
            }

            return result;
        }

        public List<TreeModel> CategoriesAsTree_OneSub(string CatName, int id = 0)
        {
            var res = new List<TreeModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            string query1 = "";
            string query2 = "";
            if(CatName == "Type")
            {
                query1 = "SELECT [id_PT] as Id,[PTname] as [Name] FROM [tbl_Product_Type] where ISDelete=0 AND ISDESABLED=0";
                query2 = "SELECT [id_MC] as Id,[MCName] as [Name] FROM [tbl_Product_MainCategory] where ISDelete=0 AND ISDESABLED=0 AND id_PT=";
            }
            else if (CatName == "MainCat")
            {
                query1 = "SELECT [id_MC] as Id,[MCName] as [Name] FROM [tbl_Product_MainCategory] where ISDelete=0 AND ISDESABLED=0 AND id_PT="+id;
                query2 = "SELECT [id_SC] as Id,[SCName] as [Name] FROM [tbl_Product_SubCategory]  where ISDelete=0 AND ISDESABLED=0 AND id_MC=";
            }
            else if (CatName == "SubCat")
            {
                query1 = "SELECT [id_SC] as Id,[SCName] as [Name] FROM [tbl_Product_SubCategory]  where ISDelete=0 AND ISDESABLED=0 AND id_MC="+id;
                query2 = "SELECT [id_SCOK] as Id,[SCOKName] as [Name] FROM [tbl_Product_SubCategoryOptionKey] where ISDelete=0 AND ISDESABLED=0 AND id_SC=";
            }

            DataTable dt = db.Select(query1);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var SupModel = new TreeModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    NameSub = dt.Rows[i]["Name"].ToString()
                };
                DataTable dt2 = db.Select(query2 + SupModel.Id);
                var Subs = new List<TreeModel>();
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    var SubModel = new TreeModel()
                    {
                        Id = Convert.ToInt32(dt.Rows[j]["Id"]),
                        NameSub = dt.Rows[j]["Name"].ToString()
                    };
                    Subs.Add(SubModel);
                }
                SupModel.Subs = Subs;
                res.Add(SupModel);
            }


                return res;
        }

        public List<TreeModel> CategoriesAsTree_All()
        {
            var result = new List<TreeModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable Type = db.Select("SELECT [id_PT],[PTname],[ISDESABLED]FROM[tbl_Product_Type] where ISDelete=0");

            for (int i = 0; i < Type.Rows.Count; i++)
            {
                var MainCat = new List<TreeModel>();
                DataTable Mains = db.Select("SELECT [id_MC],[MCName],[ISDESABLED]FROM [tbl_Product_MainCategory] WHERE ISDelete=0 AND id_PT=" + Type.Rows[i]["id_PT"]);
                for (int j = 0; j < Mains.Rows.Count; j++)
                {
                    var SubCat = new List<TreeModel>();
                    DataTable Subs = db.Select("SELECT [id_SC],[SCName],[ISDESABLED] FROM [tbl_Product_SubCategory] WHERE ISDelete=0 AND id_MC=" + Mains.Rows[j]["id_MC"]);
                    for (int k = 0; k < Subs.Rows.Count; k++)
                    {
                        var SubCatKey = new List<TreeModel>();
                        DataTable SubsK = db.Select("SELECT [id_SCOK],[SCOKName],[ISDESABLED] FROM [tbl_Product_SubCategoryOptionKey] where ISDelete=0 AND id_SC=" + Subs.Rows[k]["id_SC"]);
                        for (int k1 = 0; k1 < SubsK.Rows.Count; k1++)
                        {
                            var SubCatKeyVal = new List<TreeModel>();
                            DataTable SubsKV = db.Select("SELECT [id_SCOV],[SCOVValueName] FROM [tbl_Product_SubCategoryOptionValue] where id_SCOK=" + SubsK.Rows[k1]["id_SCOK"]);
                            for (int k2 = 0; k2 < SubsKV.Rows.Count; k2++)
                            {
                                var M5 = new TreeModel()
                                {
                                    Id = Convert.ToInt32(SubsKV.Rows[k2]["id_SCOV"]),
                                    NameSub = SubsKV.Rows[k2]["SCOVValueName"].ToString(),
                                    IsActive = true
                                };
                                SubCatKeyVal.Add(M5);
                            }
                            var M4 = new TreeModel()
                            {
                                Id = Convert.ToInt32(SubsK.Rows[k1]["id_SCOK"]),
                                NameSub = SubsK.Rows[k1]["SCOKName"].ToString(),
                                Subs = SubCatKeyVal
                            };
                            if (SubsK.Rows[k1]["ISDESABLED"].ToString() == "1")
                            {
                                M4.IsActive = false;
                            }
                            else
                            {
                                M4.IsActive = true;
                            }
                            SubCatKey.Add(M4);
                        }
                        var M3 = new TreeModel()
                        {
                            Id = Convert.ToInt32(Subs.Rows[k]["id_SC"]),
                            NameSub = Subs.Rows[k]["SCName"].ToString(),
                            Subs = SubCatKey
                        };
                        if (Subs.Rows[k]["ISDESABLED"].ToString() == "1")
                        {
                            M3.IsActive = false;
                        }
                        else
                        {
                            M3.IsActive = true;
                        }
                        SubCat.Add(M3);

                    }
                    var M2 = new TreeModel()
                    {
                        Id = Convert.ToInt32(Mains.Rows[j]["id_MC"]),
                        NameSub = Mains.Rows[j]["MCName"].ToString(),
                        Subs = SubCat
                    };
                    if (Mains.Rows[j]["ISDESABLED"].ToString() == "1")
                    {
                        M2.IsActive = false;
                    }
                    else
                    {
                        M2.IsActive = true;
                    }
                    MainCat.Add(M2);

                }
                var M1 = new TreeModel()
                {
                    Id = Convert.ToInt32(Type.Rows[i]["id_PT"]),
                    NameSub = Type.Rows[i]["PTname"].ToString(),
                    Subs = MainCat
                };
                if (Type.Rows[i]["ISDESABLED"].ToString() == "1")
                {
                    M1.IsActive = false;
                }
                else
                {
                    M1.IsActive = true;
                }
                result.Add(M1);
            }

            return result;
        }

        public List<MiniProductModel> ChosenProducts(string Type,int numbers,string DateType)
        {
            var res = new List<MiniProductModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            string query = "";

            if (Type == "Sale")
            {
                query = "SELECT top "+numbers+ " main.[id_MProduct],[Description],[Title],main.DateCreated,(SELECT top 1 [PicAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] as A inner join [tbl_Product_PicConnector] as B on A.PicID=B.PicID where B.id_MProduct=main.id_MProduct) as pic ,(SELECT top 1 [PriceXquantity] FROM [tlb_Product_MainProductConnector] where id_MProduct= main.id_MProduct) as [PriceXquantity],(SELECT top 1 [PriceOff] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [PriceOff],(SELECT top 1 [OffType] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [OffType]FROM [tbl_Product] as main where main.IS_AVAILABEL=1 AND main.ISDELETE=0 order by(SELECT Sum([number]) as sale FROM[tbl_FACTOR_Items] as A1 inner join [tlb_Product_MainProductConnector] as B1 on A1.Pro_Id=B1.id_MPC where B1.id_MProduct=main.id_MProduct)DESC ";
            }else if(Type=="New")
            {
                query = "SELECT top "+numbers+ " main.[id_MProduct],[Description],[Title],main.DateCreated,(SELECT top 1 [PicAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] as A inner join [tbl_Product_PicConnector] as B on A.PicID=B.PicID where B.id_MProduct=main.id_MProduct) as pic ,(SELECT top 1 [PriceXquantity] FROM [tlb_Product_MainProductConnector] where id_MProduct= main.id_MProduct) as [PriceXquantity],(SELECT top 1 [PriceOff] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [PriceOff],(SELECT top 1 [OffType] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [OffType]FROM [tbl_Product] as main where main.IS_AVAILABEL=1 AND main.ISDELETE=0 order by(DateCreated)DESC ";
            }

            DataTable dt = db.Select(query);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DateTime date = Convert.ToDateTime(dt.Rows[i]["DateCreatedDateCreated"]);
                PersianDateTime persianDateTime = new PersianDateTime(date);
                var model = new MiniProductModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_MProduct"]),
                    Title = dt.Rows[i]["Title"].ToString(),
                    Discription = dt.Rows[i]["Description"].ToString(),
                    PicPath = dt.Rows[i]["pic"].ToString(),
                    OffPrice = dt.Rows[i]["PriceOff"].ToString(),
                    date=DateReturner(dt.Rows[i]["DateCreatedDateCreated"].ToString(),DateType)
                };

                if(dt.Rows[i]["PriceOff"].ToString()=="1")
                {
                    model.Price = "";
                }else
                {
                    model.Price = dt.Rows[i]["PriceXquantity"].ToString();
                }

                res.Add(model);

            }


            return res;
        }

        public List<Company_Customers_Model> CompanyCustomers()
        {
            var res = new List<Company_Customers_Model>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [Id],[name],[Job],[message],[star],[ImagePath]FROM [tbl_BLOG_CustomersMessge]");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Company_Customers_Model()
                {
                    Id= Convert.ToInt32(dt.Rows[i]["Id"]),
                    Name= dt.Rows[i]["name"].ToString(),
                    Job = dt.Rows[i]["Job"].ToString(),
                    Message = dt.Rows[i]["message"].ToString(),
                    ImagePath = AppendServername(dt.Rows[i]["ImagePath"].ToString()),
                    stars = Convert.ToInt32(dt.Rows[i]["star"])
                };
            }

            return res;
        }

        public List<MiniProductModel> ProductList(int ProductsInAPage, string Type, int Id,int page,string search,string DateType)
        {
            var res = new List<MiniProductModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select(ProList_QueryMaker(Type, ProductsInAPage, Id, search, page));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new MiniProductModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_MProduct"]),
                    Title = dt.Rows[i]["Title"].ToString(),
                    Discription = dt.Rows[i]["Description"].ToString(),
                    PicPath = dt.Rows[i]["pic"].ToString(),
                    OffPrice = dt.Rows[i]["PriceOff"].ToString(),
                    date = DateReturner(dt.Rows[i]["DateCreatedDateCreated"].ToString(), DateType)
                };

                if (dt.Rows[i]["PriceOff"].ToString() == "1")
                {
                    model.Price = "";
                }
                else
                {
                    model.Price = dt.Rows[i]["PriceXquantity"].ToString();
                }

                res.Add(model);


            }
            return res;

        }

        public string ProList_QueryMaker(string Type,int ProductsInAPage,int Id,string search,int page)
        {
            StringBuilder query = new StringBuilder();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            int num = 1;
            if (Type == "همه")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0").Rows[0][0]);
            }
            else if (Type == "سردسته")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0 AND id_Type=" + Id).Rows[0][0]);
            }
            else if (Type == "دسته بندی اصلی")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0 AND id_MainCategory=" + Id).Rows[0][0]);
            }
            else if (Type == "گروه اصلی")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0 AND id_SubCategory=" + Id).Rows[0][0]);
            }
            else if (Type == "برچسب")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0 AND id_MProduct IN(SELECT distinct B.id_MProduct FROM [tbl_Product_tagConnector] as A inner join [tlb_Product_MainProductConnector] as B on A.id_MPC=B.id_MPC where A.id_TE=" + Id+ ")").Rows[0][0]);
            }
            else if (Type == "جست و جو")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0 AND Title LIKE N'%" + search + "%' OR [Description] LIKE N'%" +search+"%'").Rows[0][0]);
            }
            

            if (num % ProductsInAPage == 0)
            {
                num = (num / ProductsInAPage);
            }
            else
            {
                num = (num / ProductsInAPage) + 1;
            }

            query.Append("select * from(SELECT NTILE(");
            query.Append(num);
            query.Append(")over(order by(main.DateCreated)DESC)as tile,main.Search_Gravity,main.[id_MProduct],[Description],[Title],main.DateCreated,(SELECT top 1 [PicAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] as A inner join [tbl_Product_PicConnector] as B on A.PicID=B.PicID where B.id_MProduct=main.id_MProduct) as pic ,(SELECT top 1 [PriceXquantity] FROM [tlb_Product_MainProductConnector] where id_MProduct= main.id_MProduct) as [PriceXquantity],(SELECT top 1 [PriceOff] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [PriceOff],(SELECT top 1 [OffType] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [OffType]FROM [tbl_Product] as main where main.IS_AVAILABEL=1 AND main.ISDELETE=0 ");
            if (Type == "همه")
            {
                query.Append(")b where b.tile=");
                query.Append(page);
            }
            else if (Type == "سردسته")
            {
                query.Append("AND main.id_Type=");
                query.Append(Id);
                query.Append(" )b where b.tile=");
                query.Append(page);
            }
            else if (Type == "دسته بندی اصلی")
            {
                query.Append("AND main.id_MainCategory=");
                query.Append(Id);
                query.Append(" )b where b.tile=");
                query.Append(page);
            }
            else if (Type == "گروه اصلی")
            {
                query.Append("AND main.id_SubCategory=");
                query.Append(Id);
                query.Append(" )b where b.tile=");
                query.Append(page);
            }
            else if (Type == "برچسب")
            {
              query.Append(" AND id_MProduct IN(SELECT distinct B.id_MProduct FROM [tbl_Product_tagConnector] as A inner join [tlb_Product_MainProductConnector] as B on A.id_MPC=B.id_MPC where A.id_TE=");
                query.Append(Id);
                query.Append("))b where b.tile=");
                query.Append(page);
            }
            else if (Type == "جست و جو")
            {
                query.Append(" AND Title LIKE N'%");
                query.Append(search);
                query.Append("%' OR [Description] LIKE N'%");
                query.Append(search);
                query.Append("%' )b where b.tile=");
                query.Append(page);
                query.Append("order by (b.Search_Gravity)DESC");
            }

            return query.ToString();
        }

       
    }
}