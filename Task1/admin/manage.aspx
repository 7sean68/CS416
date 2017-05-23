<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manage.aspx.cs" Inherits="Task1.Admin.manage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:LoginName ID="LoginName1" runat="server" />
        <asp:HyperLink ID="Lnkpat" runat="server" Text="Patient" NavigateUrl="~/pat" Visible='<%#Roles.IsUserInRole("pat")%>'></asp:HyperLink>
        <asp:HyperLink ID="LinkButton8" runat="server" Text="create accounts" NavigateUrl="./create.aspx"></asp:HyperLink>
        <asp:LinkButton ID="LinkButton6" runat="server" Text="Account" PostBackUrl="~/Account.aspx"></asp:LinkButton>
        <asp:LoginStatus runat="server" ID="LoginStatus1"></asp:LoginStatus>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div>
                    delete user <asp:DropDownList ID="drpdl" runat="server" DataSourceID="sqlusr" DataTextField="UserName" DataValueField="UserName"></asp:DropDownList>
                    <asp:Button ID="btndl" runat="server" Text="delete" OnClick="btndl_Click" />
                </div>
            </ContentTemplate>

        </asp:UpdatePanel>
    </form>
    <asp:SqlDataSource ID="sqlusr" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [UserName] FROM [Users]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlrl" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [RoleName] FROM [Roles] where [RoleName] != 'patient'"></asp:SqlDataSource>
</body>
</html>