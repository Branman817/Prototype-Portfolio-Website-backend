﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LoginAPI.Models
{
    public class Response
    {
        public string Status { set; get; }
        public string Message { set; get; }
        public bool isManager { set; get; }
    }
}