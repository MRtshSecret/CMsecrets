﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.D_APIModels
{
    public class tbl_BLOG_TeamMembers
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Job { get; set; }
        public string Tozihat { get; set; }
        public string github { get; set; }
        public string Linkedin { get; set; }
        public string Instagram { get; set; }
        public string ImagePath { get; set; }
        public string ImageValue { get; set; }
    }
}