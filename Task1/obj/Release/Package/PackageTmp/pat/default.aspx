<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Task1.pat._default" EnableViewStateMac="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
            <asp:LoginName ID="LoginName1" runat="server" />
            <asp:HyperLink ID="lnkadmin" runat="server" Text="admin" NavigateUrl="~/admin/create.aspx" Visible='<%#Roles.IsUserInRole("admin")%>'></asp:HyperLink>
            <asp:HyperLink ID="LinkButton8" runat="server" Text="admission" NavigateUrl="~/admission" Visible='<%#Roles.IsUserInRole("admission")%>'></asp:HyperLink>
            <asp:HyperLink ID="LinkButton9" runat="server" Text="laboratory" NavigateUrl="~/lab" Visible='<%#Roles.IsUserInRole("lab")%>'></asp:HyperLink>
            <asp:HyperLink ID="LinkButton10" runat="server" Text="doctor" NavigateUrl="~/doc" Visible='<%#Roles.IsUserInRole("doc")%>'></asp:HyperLink>
            <asp:HyperLink ID="LinkButton12" runat="server" Text="nurse" NavigateUrl="~/nurse" Visible='<%#Roles.IsUserInRole("nurse")%>'></asp:HyperLink>
            <asp:LinkButton ID="LinkButton6" runat="server" PostBackUrl="~/Account.aspx" Text="Account"></asp:LinkButton>
            <asp:LoginStatus ID="LoginStatus1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
            
    </asp:ScriptManager>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="vId" DataSourceID="SqlDataSource1">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="vId" HeaderText="vId" InsertVisible="False" ReadOnly="True" SortExpression="vId" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
                <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
                <asp:DetailsView ID="DetailsView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Height="50px" Width="125px" AutoGenerateRows="False" DataKeyNames="vId" DataSourceID="SqlDataSource2" AllowPaging="True">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                    <EditRowStyle BackColor="#999999" />
                    <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                    <Fields>
                        <asp:BoundField DataField="vId" HeaderText="vId" InsertVisible="False" ReadOnly="True" SortExpression="vId" />
                        <asp:BoundField DataField="doctor" HeaderText="doctor" SortExpression="doctor" />
                        <asp:BoundField DataField="nurse" HeaderText="nurse" SortExpression="nurse" />
                        <asp:BoundField DataField="disease" HeaderText="disease" SortExpression="disease" />
                        <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                        <asp:BoundField DataField="medicine" HeaderText="medicine" SortExpression="medicine" />
                        <asp:BoundField DataField="dr comment" HeaderText="dr comment" SortExpression="dr comment" />
                    </Fields>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                </asp:DetailsView>
            </ContentTemplate>

        </asp:UpdatePanel>
    </form>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT [vId] FROM [visits] where [vpid] in (select pid from patients where puname = @pu);">
        <SelectParameters>
            <asp:ControlParameter ControlID="Label1" Name="pu" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT a.[vId], b.[drname] doctor, c.[nname] nurse, a.[vdsid] disease, a.[vsts] status, a.[mdc]medicine, a.[comment] 'dr comment' 
FROM [visits] a, doctors b, nurses c
WHERE ([vId] = @vId) and a.vdrid = b.drid and a.vnid = c.nid;">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="vId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</body>
</html>
