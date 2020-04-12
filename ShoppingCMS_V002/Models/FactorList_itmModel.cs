using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models
{
    public class FactorList_itmModel
    {
        public int Id { get; set; }
        public string CustomerName { get; set; }
        public int ItmNumbers { get; set; }
        public long totality { get; set; }
        public long deposit { get; set; }
        public string priceQuantity { get; set; }
        public string Date { get; set; }
        public string status { get; set; }
    }
}