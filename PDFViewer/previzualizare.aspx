<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="previzualizare.aspx.cs" Inherits="PDFViewer.previzualizare" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Previzualizare PDF</title>
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf_viewer.css"/>--%>
    <link type="text/css" href="PDFjs/text_layer_builder.css" rel="stylesheet"/>
    <script type="text/javascript" src="PDFjs/text_layer_builder.js"></script>
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
                var container = document.getElementById('pdfContainer');
                for (var pageNumber = 1; pageNumber <= pdf.numPages; pageNumber++) {
                    pdf.getPage(pageNumber).then(async function (page) {
                        console.log(page);
                        var scale = 1.5;
                        var viewport = page.getViewport({ scale });
                        var div = document.createElement('div');
                        console.log(page._pageIndex);
                        div.setAttribute("id", "page-" + (page._pageIndex + 1));

                        // This will keep positions of child elements as per our needs
                        div.setAttribute("style", "position: relative");
                        //div.setAttribute("style", "height: 500px");
                        //div.setAttribute("style", "width: 250px");

                        // Append div within div#container
                        container.appendChild(div);

                        var canvas = document.createElement("canvas");

                        // Append Canvas within div#page-#{pdf_page_number}
                        div.appendChild(canvas);

                        var context = canvas.getContext('2d');
                        canvas.height = viewport.height;
                        canvas.width = viewport.width;

                        var renderContext = {
                            canvasContext: context,
                            viewport: viewport
                        };
                        let textContent = await page.getTextContent();
                        console.log(textContent);

                    //    // Render PDF page
                        page.render(renderContext)
                            .then(function () {
                                console.log("222222");
                            // Get text-fragments
                            return page.getTextContent().promise;
                        })
                            .then(function (textContent) {
                                // Create div which will hold text-fragments
                                var textLayerDiv = document.createElement("div");

                                // Set it's class to textLayer which have required CSS styles
                                textLayerDiv.setAttribute("class", "textLayer");

                                // Append newly created div in `div#page-#{pdf_page_number}`
                                div.appendChild(textLayerDiv);

                                // Create new instance of TextLayerBuilder class
                                var textLayer = new TextLayerBuilder({
                                    textLayerDiv: textLayerDiv,
                                    pageIndex: page.pageIndex,
                                    viewport: viewport
                                });

                                // Set text-fragments
                                textLayer.setTextContent(textContent);

                                // Render text-fragments
                                textLayer.render();
                            });



                        //var canvas = document.createElement('canvas');
                        //var context = canvas.getContext('2d');
                        //var viewport = page.getViewport({ scale: 2 });

                        //canvas.width = viewport.width;
                        //canvas.height = viewport.height;

                        //pdfContainer.appendChild(canvas);

                        //page.render({ canvasContext: context, viewport: viewport });
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
        <%--<div style="display: flex; justify-content: center; background-color:grey;">--%>
            <div id='pdfContainer' style="background-color: aliceblue;"></div>
            <%--<canvas id="the-canvas"></canvas>--%>
            <%--<div id="the-canvas" style="height: 500px"/>--%>
            <%--<canvas id="the-canvas" style="border:1px solid black;"></canvas>--%>
            <%--<iframe src='PDFs/test1.pdf' style="width: 100%;height: 100%;border: none;"></iframe>--%>
        <%--</div>--%>
    </form>
</body>
</html>


