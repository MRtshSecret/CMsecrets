﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.D_APIModels
{
    public class ShoppingCart_item
    {
        public int Num { get; set; }
        public int Id { get; set; }
        public int number { get; set; }
        public string Title { get; set; }
        public string ImagePath { get; set; }
        public long total { get; set; }
        public string property { get; set; }
        public int Quantity { get; set; }
        public long PricePerQ { get; set; }
        public long PriceXQ { get; set; }
        public long PriceOff { get; set; }

    }
}