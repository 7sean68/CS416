<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Task1._default" EnableViewStateMac="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #Text1 {
            width: 95px;
        }

        #Text2 {
            width: 95px;
        }

        #Text3 {
            width: 95px;
        }

        #form1 {
            direction: ltr;
            height: 92px;
        }

        .userName{
            top : 0 ;  
            right: 0 ; 
        }
    </style>
</head>
<body style="width: 520px; height: 104px; margin-left:auto; margin-right:auto;margin-top:auto;margin-bottom:auto;margin:auto; background-image:url('background.jpg'); background-size:100%">
    
    <form id="form1" name="frminsert" runat="server" method="post" >
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:LoginName CssClass="userName" ID="LoginName1" runat="server" Font-Names="Freestyle Script" Font-Size="XX-Large" Font-Bold="False"/>
        &nbsp;&nbsp;&nbsp; <asp:LinkButton ID="LinkButton6" runat="server" Text="Account" OnClick="LinkButton5_Click" PostBackUrl="~/Account.aspx"></asp:LinkButton>
        &nbsp;&nbsp; <asp:LoginStatus runat="server" ID="LoginStatus1"></asp:LoginStatus>

        &nbsp;<br />

        <asp:HyperLink ID="lnkadmin" runat="server" Text="admin" NavigateUrl="~/admin/create.aspx" Visible='<%# Roles.IsUserInRole("admin") %>' ToolTip="Welcome Boss !!"></asp:HyperLink>

        &nbsp;<asp:HyperLink ID="LinkButton8" runat="server" Text="admission" NavigateUrl="~/admission" Visible='<%# Roles.IsUserInRole("admission") %>' ToolTip="New one to register, huh "></asp:HyperLink>
        
        &nbsp;<asp:HyperLink ID="LinkButton9" runat="server" Text="laboratory" NavigateUrl="~/lab" Visible='<%#Roles.IsUserInRole("lab")%>'></asp:HyperLink>
        
        &nbsp;<asp:HyperLink ID="LinkButton10" runat="server" Text="doctor" NavigateUrl="~/doc" Visible='<%# Roles.IsUserInRole("doc") %>' ToolTip="Welcome Doc , new life to save "></asp:HyperLink>
        
        &nbsp;<asp:HyperLink ID="LinkButton11" runat="server" Text="patient" NavigateUrl="~/pat" Visible='<%# Roles.IsUserInRole("pat") %>' ToolTip="You are strong ,Get well soon"></asp:HyperLink>
        
        &nbsp;<asp:HyperLink ID="LinkButton12" runat="server" Text="nurse" NavigateUrl="~/nurse" Visible='<%# Roles.IsUserInRole("nurse") %>' ToolTip="With your help we go on "></asp:HyperLink>

    </form>
      
</body>
</html>

