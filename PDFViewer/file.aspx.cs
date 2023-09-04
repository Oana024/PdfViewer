using System;

namespace PDFViewer
{
    public partial class file : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                Response.Clear();
                Response.WriteFile(
                    @"C:/Users/Oana/Downloads/compressed.tracemonkey-pldi-09.pdf");
                Response.ContentType = "application/pdf";
            var contentDisposition = "attachment; filename=file.pdf";
            Response.Headers["Content-Disposition"] = contentDisposition;
            Response.End();
        }
    }
}