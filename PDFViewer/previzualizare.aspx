<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="previzualizare.aspx.cs" Inherits="PDFViewer.previzualizare" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Previzualizare PDF</title>
    <link rel="shortcut icon" href="#" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.10.377/pdf_viewer.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.10.111/pdf.js"></script>

    <style>

        /* Chrome, Safari, Edge, Opera */
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
          -webkit-appearance: none;
          margin: 0;
        }

        /* Firefox */
        input[type=number] {
          -moz-appearance: textfield;
        }

        body{
            margin: 0;
        }

        #toolbar {
            background-color: black;
            height: 50px;
            width: 100%;
            position: fixed;
            z-index:2;
            display: flex;
            justify-content: space-between;
            align-items: center;
            /*padding: 10px;*/
        }

        .left-buttons {
            flex: 1;
            text-align: left;
            margin-left: 10px;
        }

        .center-buttons {
            flex: 1;
            text-align: center;
        }

        .right-buttons {
            flex: 1;
            text-align: right;
            margin-right: 10px;
        }

        #pdfContainer {
            background-color: lightgrey;
            padding-top:50px;
        }

        #pageNumber{
            width: 30px;
            background-color: black;
            outline-style: auto;
            outline-color: grey;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="mainContainer">
            <div id="toolbar">
                <div class="left-buttons">
                    <button type="button" id="PrevPage" onclick="goToPrevPage()">Prev</button>
                    <input type="number" id="pageNumber" value="1" min="1" onkeydown="return event.key !== 'Enter';"/>
                    <button type="button" id="NextPage" onclick="goToNextPage()">Next</button>
                </div>
                <div class="center-buttons">
                    <button type="button" id="zoomIn" onclick="zoomInFile()">Zoom In</button>
                    <button type="button" id="zoomOut" onclick="zoomOutFile()">Zoom Out</button>
                </div>
                <div class="right-buttons">
                    <asp:Button type="button" ID="downloadFile" runat="server" Text="Download" OnClick="downloadPdf" />
                </div>
            </div>
            <div id="pdfContainer"></div>
        </div>
    </form>
    <script>
        pdfjsLib.GlobalWorkerOptions.workerSrc = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.10.111/pdf.worker.min.js";

        var scale = 1.333333;
        var container = document.getElementById('pdfContainer');
        var pageNum = 0;
        var pageHeight = 0;
        var numberOfPages = 0;
        var scrollPosition = 0;

        function getUrlParameter(name) {
            var url = new URL(window.location.href);
            return url.searchParams.get(name);
        }

        function goToNextPage() {
            if (pageNum + 1 < numberOfPages) {
                pageNum++;
                window.scrollTo(0, pageNum * pageHeight);
                setPageCounter(pageNum);
            }
        }

        function goToPrevPage() {
            if (pageNum - 1 >= 0) {
                pageNum--;
                window.scrollTo(0, pageNum * pageHeight);
                setPageCounter(pageNum);
            }
        }

        function zoomInFile() {
            scale += 0.3;
            document.getElementById('pdfContainer').innerHTML = ""
            loadPdf();
        }

        function zoomOutFile() {
            scale -= 0.3;
            document.getElementById('pdfContainer').innerHTML = ""
            loadPdf();
        }

        function setPageCounter(pageNum) {
            var pageNumber = document.getElementById('pageNumber');
            pageNumber.value = pageNum + 1;
        }

        document.getElementById("pageNumber").addEventListener("input", function (event) {
            window.scrollTo(0, document.getElementById("pageNumber").value * pageHeight);
            event.preventDefault();
        });


        document.getElementById('pdfContainer')
            .addEventListener('wheel', (e) => {
                if (window.scrollY > (pageNum + 1) * pageHeight) {
                    pageNum++;
                    setPageCounter(pageNum);
                }
                else if (window.scrollY < pageNum * pageHeight) {
                    pageNum--;
                    setPageCounter(pageNum);
                }
                
                if (e.ctrlKey) {
                    e.preventDefault();
                }
                
            });
  
        function loadPage(pdf, pageNumber) {
            pdf.getPage(pageNumber).then(function (page) {
                var viewport = page.getViewport({ scale: scale });

                var div = document.createElement('div');
                div.setAttribute("id", "page-" + (page._pageIndex + 1));
                div.setAttribute("style", "position: relative; display: flex; justify-content: center;");

                container.appendChild(div);

                var canvas = document.createElement('canvas');
                canvas.setAttribute("style", "margin-top: 10px")
                var context = canvas.getContext('2d');
                canvas.height = viewport.height;
                canvas.width = viewport.width;

                pageHeight = canvas.height + 10;

                div.appendChild(canvas);

                var renderContext = {
                    canvasContext: context,
                    viewport: viewport
                };
                var renderTask = page.render(renderContext);

                renderTask.promise.then(function () {
                    return page.getTextContent();
                }).then(function (textContent) {

                    var textLayer = document.createElement("div");
                    textLayer.setAttribute("class", "textLayer");
                    textLayer.setAttribute("style", `--scale-factor: ${viewport.scale}`);
                    textLayer.style.left = canvas.offsetLeft + 'px';
                    textLayer.style.top = canvas.offsetTop + 'px';
                    textLayer.style.height = canvas.offsetHeight + 'px';
                    textLayer.style.width = canvas.offsetWidth + 'px';

                    div.appendChild(textLayer);

                    pdfjsLib.renderTextLayer({
                        textContentSource: textContent,
                        container: textLayer,
                        viewport: viewport,
                        textDivs: []
                    });
                });
            });
        }

        function loadPdf() {
            var pdfPath = decodeURIComponent(getUrlParameter('pdf'));

            pdfjsLib.getDocument(pdfPath).promise.then(function (pdf) {
                numberOfPages = pdf.numPages;
                document.getElementById('pageNumber').max = numberOfPages;
                for (var pageNumber = 1; pageNumber <= pdf.numPages; pageNumber++) {
                    loadPage(pdf, pageNumber);
                }
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            loadPdf();
        });

    </script>
</body>
</html>


