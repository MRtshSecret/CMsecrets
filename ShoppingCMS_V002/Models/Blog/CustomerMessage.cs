﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.Blog
{
    public class CustomerMessage
    {
        public string Name { get; set; }
        public string Job { get; set; }
        public string Message { get; set; }
        public int Stars { get; set; }
        public string ImagePath { get; set; }
        public string ImageValue { get; set; }
    }
}