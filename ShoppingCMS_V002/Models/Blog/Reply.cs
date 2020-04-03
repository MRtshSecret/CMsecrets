﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.Blog
{
    public class Reply
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string Message { get; set; }
        public string ImagePath { get; set; }
        public string ImageValue { get; set; }
        public string Date { get; set; }

    }
}