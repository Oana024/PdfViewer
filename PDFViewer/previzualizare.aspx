<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="previzualizare.aspx.cs" Inherits="PDFViewer.previzualizare" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
   <title>Previzualizare PDF</title>
    <style type="text/css">
        body{
        margin: 0; /* Remove default margin */
    }
    iframe{      
        display: block;  /* iframes are inline by default */   
        height: 100vh;  /* Set height to 100% of the viewport height */   
        width: 100vw;  /* Set width to 100% of the viewport width */     
        border: none; /* Remove default border */
        background: lightyellow; /* Just for styling */
    }
        }
    </style>
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf_viewer.css"/>--%>
    <link type="text/css" href="PDFjs/text_layer_builder.css" rel="stylesheet"/>
    <%--<script type="text/javascript" src="PDFjs/text_layer.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.10.111/pdf.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <%--<iframe src="PDFs/test1.pdf"></iframe>--%>
       <div id="pdfContainer"></div>
        <%--<div class="textLayer"></div>--%>
    </form>


    <script>

        //var pdfDoc = null,
        //    pageNum = 1,
        //    //pageRendering = false,
        //    pageNumPending = null,
        //    //scale = 0.8,
        //    scale = 1.5

        function getUrlParameter(name) {
            var url = new URL(window.location.href);
            return url.searchParams.get(name);
        }

        function loadPdf() {
            console.log()
            var pdfPath = decodeURIComponent(getUrlParameter('pdf'));
            console.log(pdfPath)
            //var pdfContainer = document.getElementById('pdfContainer');

            pdfjsLib.GlobalWorkerOptions.workerSrc =
                "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.10.111/pdf.worker.min.js";

            pdfjsLib.getDocument(pdfPath).promise.then(function (pdf) {
                var container = document.getElementById('pdfContainer');
                for (var pageNumber = 1; pageNumber <= pdf.numPages; pageNumber++) {
                    console.log(pageNumber);
                    var num = pageNumber;
                    pdf.getPage(num).then(function (page) {
                        var scale = 1.6666666666666665;
                        var viewport = page.getViewport({ scale: scale });

                        var div = document.createElement('div');
                        div.setAttribute("id", "page-" + (page._pageIndex + 1));
                        div.setAttribute("style", "position: relative");
                        container.appendChild(div);

                        var canvas = document.createElement('canvas');
                        var context = canvas.getContext('2d');
                        canvas.height = viewport.height;
                        canvas.width = viewport.width;

                        div.appendChild(canvas);

                        // Render PDF page into canvas context
                        var renderContext = {
                            canvasContext: context,
                            viewport: viewport
                        };
                        var renderTask = page.render(renderContext);

                        // Wait for rendering to finish
                        renderTask.promise.then(function () {
                            // Returns a promise, on resolving it will return text contents of the page
                            return page.getTextContent();
                        }).then(function (textContent) {
                            console.log(textContent)

                            var textLayer = document.createElement("div");
                            div.setAttribute("class", "textLayer");
                            //textLayer.setAttribute("style", `--scale-factor: ${viewport.scale}`);

                            console.log(`canvas offset: ${canvas.offsetHeight}`)

                            textLayer.style.color = "blue";

                            //textLayer.style.marginRight= "8000px";
                            //textLayer.style.top = canvas.offsetTop + 'px';
                            //textLayer.style.height = canvas.offsetHeight + 'px';
                            //textLayer.style.width = canvas.offsetWidth + 'px';

                            div.appendChild(textLayer);

                            // Pass the data to the method for rendering of text over the pdf canvas.
                            pdfjsLib.renderTextLayer({
                                textContentSource: textContent,
                                container: textLayer,
                                viewport: viewport,
                                textDivs: []
                            });
                        });
                    });
                }
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            loadPdf();
        });

    </script>
</body>
</html>


