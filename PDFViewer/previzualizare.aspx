<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="previzualizare.aspx.cs" Inherits="PDFViewer.previzualizare" %>

<%--<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Previzualizare PDF</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf_viewer.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="viewerContainer">
                <iframe src="https://mozilla.github.io/pdf.js/web/viewer.html?file=<%= Server.UrlEncode(Request.QueryString["pdf"]) %>" width="100%" height="100%"></iframe>
                <iframe src="https://media.geeksforgeeks.org/wp-content/cdn-uploads/20210101201653/PDF.pdf" width="100%" height="100%"></iframe>
            </div>
        </div>
    </form>
</body>
</html>--%>








<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Previzualizare PDF</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf_viewer.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.10.111/pdf.js"></script>
    <script>
        function getUrlParameter(name) {
            var url = new URL(window.location.href);
            return url.searchParams.get(name);
        }

        function loadPdf() {
            var pdfPath = decodeURIComponent(getUrlParameter('pdf'));
            var pdfContainer = document.getElementById('pdfContainer');

            pdfjsLib.GlobalWorkerOptions.workerSrc =
                "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.10.111/pdf.worker.min.js";

            pdfjsLib.getDocument(pdfPath).promise.then(function (pdf) {
                for (var pageNumber = 1; pageNumber <= pdf.numPages; pageNumber++) {
                    pdf.getPage(pageNumber).then(function (page) {
                        var canvas = document.createElement('canvas');
                        var context = canvas.getContext('2d');
                        var viewport = page.getViewport({ scale: 2 });

                        canvas.width = viewport.width;
                        canvas.height = viewport.height;

                        pdfContainer.appendChild(canvas);

                        page.render({ canvasContext: context, viewport: viewport });
                    });
                }
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            loadPdf();
        });
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="display: flex; justify-content: center; background-color:grey;">
            <div id="pdfContainer""/>
            <%--<canvas id="the-canvas" style="border:1px solid black;"/>--%>
        </div>
    </form>
</body>
</html>
