<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="Task1.Account" EnableViewStateMac="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:LoginName ID="LoginName1" runat="server" />
            <asp:HyperLink ID="lnkadmin" runat="server" Text="admin" NavigateUrl="~/admin/create.aspx" Visible='<%#Roles.IsUserInRole("admin")%>'></asp:HyperLink>
            <asp:HyperLink ID="LinkButton8" runat="server" Text="admission" NavigateUrl="~/admission" Visible='<%#Roles.IsUserInRole("admission")%>'></asp:HyperLink>
            <asp:HyperLink ID="LinkButton9" runat="server" Text="laboratory" NavigateUrl="~/lab" Visible='<%#Roles.IsUserInRole("lab")%>'></asp:HyperLink>
            <asp:HyperLink ID="LinkButton10" runat="server" Text="doctor" NavigateUrl="~/doc" Visible='<%#Roles.IsUserInRole("doc")%>'></asp:HyperLink>
            <asp:HyperLink ID="LinkButton11" runat="server" Text="patient" NavigateUrl="~/pat" Visible='<%#Roles.IsUserInRole("pat")%>'></asp:HyperLink>
            <asp:HyperLink ID="LinkButton12" runat="server" Text="nurse" NavigateUrl="~/nurse" Visible='<%#Roles.IsUserInRole("nurse")%>'></asp:HyperLink>
            <asp:LoginStatus ID="LoginStatus1" runat="server" />
        </div>
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:ChangePassword ID="ChangePassword1" runat="server" BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" CancelDestinationPageUrl="/" ContinueDestinationPageUrl="/" Font-Names="Verdana" Font-Size="0.8em">
                        <CancelButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                        <ChangePasswordButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                        <ContinueButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                        <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                        <PasswordHintStyle Font-Italic="True" ForeColor="#888888" />
                        <TextBoxStyle Font-Size="0.8em" />
                        <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                    </asp:ChangePassword>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
