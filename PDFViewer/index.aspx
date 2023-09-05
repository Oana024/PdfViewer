<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="PDFViewer.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>test</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="btnOpenPdf" runat="server" Text="Deschide PDF" OnClick="btnOpenPdf_Click" />
        </div>
    </form>
</body>
</html>
