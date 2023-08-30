<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="PDFViewer.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>test</title>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf.js"></script>--%>
<%--<script>
    function loadPDF() {
        var pdfPath = 'PDFs/test1.pdf'; // Calea către fișierul PDF
        var pdfContainer = document.getElementById('pdfContainer');

        pdfjsLib.getDocument(pdfPath).promise.then(function (pdf) {
            for (var pageNumber = 1; pageNumber <= pdf.numPages; pageNumber++) {
                pdf.getPage(pageNumber).then(function (page) {
                    var canvas = document.createElement('canvas');
                    var context = canvas.getContext('2d');
                    var viewport = page.getViewport({ scale: 1 });

                    canvas.width = viewport.width;
                    canvas.height = viewport.height;

                    pdfContainer.appendChild(canvas);

                    page.render({ canvasContext: context, viewport: viewport });
                });
            }
        });
    }
    document.addEventListener('DOMContentLoaded', function () {
        loadPDF();
    });
</script>--%>


</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="btnOpenPdf" runat="server" Text="Deschide PDF" OnClick="btnOpenPdf_Click" />
        </div>
        <%--<div id="pdfContainer"></div>--%>
    </form>
</body>
</html>
