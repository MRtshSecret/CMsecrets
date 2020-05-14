using ShoppingCMS_V002.Models.D_APIModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.ModelViews.D_APIModelViews
{
    public class AboutUsModelView
    {
        public List<Company_Customers_Model> CompanyCustomers { get; set; }

        public List<tbl_BLOG_TeamMembers> TeamMembers { get; set; }

    }
}