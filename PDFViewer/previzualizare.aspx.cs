using System;
using System.Web.UI;

namespace PDFViewer
{
    public partial class previzualizare : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void downloadPdf(object sender, EventArgs e)
        {
            Response.Clear();
            Response.WriteFile(@"C:/Users/ioana.mocanu/Downloads/compressed.tracemonkey-pldi-09.pdf");
            Response.ContentType = "application/pdf";
            var contentDisposition = "attachment; filename=file.pdf";
            Response.Headers["Content-Disposition"] = contentDisposition;
            Response.End();
        }
    }
}