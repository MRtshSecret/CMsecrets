using MD.PersianDateTime;
using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.Blog;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace ShoppingCMS_V002.OtherClasses.Blog
{
    public class Blog_ModelFiller
    {
        public List<Id_ValueModel> Groups_Filler()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [G_Id],[name] FROM [tbl_BLOG_Groups] WHERE Is_Disabled=0 AND Is_Deleted=0");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["G_Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> BCategory_Filler()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [Id],[name] FROM [tbl_BLOG_Categories] WHERE [Is_Disabled]=0 AND [Is_Deleted]=0");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> B_Tags_Filler(int CatId)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [Id],[name] FROM [tbl_BLOG_Tags] WHERE [Is_Disabled]=0 AND [Is_Deleted]=0 AND [CtegoryId]="+CatId);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public string Post_Action(string Action, int WrittenBy_AdminId, string Title, string Text_min, string Text, int weight, int Cat_Id, int IsImportant,int GroupId, string Pictures,string Blog_Tags, int id_pr = 0)
        {
            List<ExcParameters> paramss = new List<ExcParameters>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var parameters = new ExcParameters()
            {
                _KEY = "@Title",
                _VALUE = Title
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@Text_min",
                _VALUE = Text_min
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@Text",
                _VALUE = Text
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@WrittenBy_AdminId",
                _VALUE = WrittenBy_AdminId
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@weight",
                _VALUE = weight
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@IsImportant",
                _VALUE = IsImportant
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@Cat_Id",
                _VALUE = Cat_Id
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@GroupId",
                _VALUE = GroupId
            };
            paramss.Add(parameters);

            string query = "";

            if (Action.Equals("insert"))
            {
                query = "INSERT INTO [tbl_BLOG_Post] output inserted.Id VALUES(@Title, @Text_min ,@Text, @WrittenBy_AdminId, GETDATE(), @weight, @IsImportant, 0, 1, @Cat_Id, @GroupId)";
            }
            else if (Action == "update")
            {
                query = "UPDATE [tbl_BLOG_Post] SET [Title] = @Title ,[Text_min] = @Text_min ,[Text] = @Text ,[weight] = @weight ,[IsImportant] = @IsImportant ,[Cat_Id] = @Cat_Id ,[GroupId] = @GroupId WHERE Id=" + id_pr;
            }

            string id = "0";

            if (query != "")
            {
                id= db.Script(query, paramss);
            }

            if(id!="0" && Action.Equals("insert"))
            {
                var Post_picturse = Pictures.Split(',');
                for (int i = 0; i < Post_picturse.Length; i++)
                {
                    db.Script("INSERT INTO [tbl_BLOG_Pic_Connector]VALUES("+id+","+Post_picturse[i]+")");
                }

                var Tags = Blog_Tags.Split(',');
                for (int j = 0; j < Tags.Length; j++)
                {
                    db.Script("INSERT INTO [tbl_BLOG_TagConnector] VALUES(" + id + "," + Tags[j] + ")");
                }
            }else if(Action == "update")
            {
                db.Script("DELETE FROM [tbl_BLOG_Pic_Connector] WHERE PostId=" + id_pr);
                var Post_picturse = Pictures.Split(',');
                for (int i = 0; i < Post_picturse.Length; i++)
                {
                    db.Script("INSERT INTO [tbl_BLOG_Pic_Connector]VALUES(" + id_pr + "," + Post_picturse[i] + ")");
                }

                db.Script("DELETE FROM [tbl_BLOG_TagConnector] WHERE Post_Id=" + id_pr);//delete 
                var Tags = Blog_Tags.Split(',');
                for (int j = 0; j < Tags.Length; j++)
                {
                    db.Script("INSERT INTO [tbl_BLOG_TagConnector] VALUES(" + id_pr + "," + Tags[j] + ")");
                }
            }
            

            return "Success";
        }

        public PostModel EditModelFiller(int id)
        {
            var res = new PostModel();




            return res;
        }

        public string Add_Update_Category(string Action,string Name,int id=0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            if(Action=="insert")
            {
                db.Script("INSERT INTO [tbl_BLOG_Categories] VALUES (N'"+Name+"',0,0)");
            }else if(Action=="Update")
            {
                db.Script("UPDATE [tbl_BLOG_Categories] SET [name] =N'"+Name+"' WHERE Id=" + id);
            }

            return "Success";
        }

        public string Add_Update_Group(string Action, string Name, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_BLOG_Groups] VALUES (N'" + Name + "',0,0)");
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_BLOG_Groups] SET [name] =N'" + Name + "' WHERE G_Id=" + id);
            }

            return "Success";
        }

        public string Add_Update_Tag(string Action, string Name,int CatId, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_BLOG_Tags] VALUES (N'" + Name + "',"+CatId+",0,0)");
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_BLOG_Tags] SET [Name] = N'"+Name+"',[CtegoryId] = "+CatId+" WHERE Id="+id);
            }

            return "Success";
        }

        public List<CategoryModel> Blog_CategoryTable()
        {
            var res = new List<CategoryModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [Id],[name],[Is_Disabled],[Is_Deleted]FROM [tbl_BLOG_Categories]");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new CategoryModel()
                {
                    Num = i + 1,
                    Id=Convert.ToInt32(dt.Rows[i]["Id"]),
                    Name= dt.Rows[i]["name"].ToString(),
                    Deleted= Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    Disabled= Convert.ToInt32(dt.Rows[i]["Is_Disabled"])
                };
                res.Add(model);
            }


            return res;
        }

        public List<CategoryModel> Blog_GroupTable()
        {
            var res = new List<CategoryModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [G_Id],[name],[Is_Disabled],[Is_Deleted]FROM [tbl_BLOG_Groups]");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new CategoryModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["G_Id"]),
                    Name = dt.Rows[i]["name"].ToString(),
                    Deleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    Disabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"])
                };
                res.Add(model);
            }


            return res;
        }

        public List<CategoryModel> Blog_TagTable()
        {
            var res = new List<CategoryModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT A.[Id],A.[Name],A.[CtegoryId],A.[Is_Disabled],A.[Is_Deleted],B.[Name] as CatName FROM [tbl_BLOG_Tags] as A inner join [tbl_BLOG_Categories] as B on A.CtegoryId=B.Id");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new CategoryModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Name = dt.Rows[i]["Name"].ToString(),
                    Deleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    Disabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                    CatId = Convert.ToInt32(dt.Rows[i]["CtegoryId"]),
                    Category = dt.Rows[i]["CatName"].ToString()
                };
                res.Add(model);
            }


            return res;
        }
    }

}