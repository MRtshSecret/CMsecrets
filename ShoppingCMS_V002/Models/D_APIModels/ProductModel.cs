using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.D_APIModels
{
    public class ProductModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Discription { get; set; }
        public List<Id_ValueModel> Tags { get; set; }
        public string Type { get; set; }
        public string MainCat { get; set; }
        public string SubCat { get; set; }
        public List<string> Pictures { get; set; }
        public List<TreeModel> MPC_Options { get; set; }
        public List<OptionModel> Options { get; set; }
        public List<ProductCommentModel> Comments { get; set; }
        public string Price { get; set; }
        public string PriceOff { get; set; }


    }
}