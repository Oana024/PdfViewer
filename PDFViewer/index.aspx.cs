﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PDFViewer
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnOpenPdf_Click(object sender, EventArgs e)
        {
            string pdfPath = "file.aspx";
            string url = "previzualizare.aspx?pdf=" + Server.UrlEncode(pdfPath);
            string script = string.Format("window.open('{0}', '_blank');", url);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenPDF", script, true);
        }
    }
}