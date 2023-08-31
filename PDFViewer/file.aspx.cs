﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PDFViewer
{
    public partial class file : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var id = Request.QueryString["id"];
            if(id == "10")
            {
                Response.Clear();
                Response.WriteFile(@"C:\Users\ioana.mocanu\Downloads\test.pdf");
                Response.ContentType = "application/octet-stream";
                var contentDisposition = "attachment; filename=file.pdf";
                Response.Headers["Content-Disposition"] = contentDisposition;
                Response.End();
            }
        }
    }
}