<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Task1.nurse._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="margin-left: auto; margin-right: auto; background-image: url('../background.jpg'); background-size: 100%; height: 819px; width: 886px">

    <form id="form1" runat="server">
        <div>
            <asp:LoginName ID="LoginName1" runat="server" />
            <asp:HyperLink ID="LinkButton11" runat="server" Text="patient" NavigateUrl="~/pat" Visible='<%#Roles.IsUserInRole("pat")%>'></asp:HyperLink>
            <asp:LinkButton ID="LinkButton6" runat="server" PostBackUrl="~/Account.aspx" Text="Account"></asp:LinkButton>
            <asp:LoginStatus ID="LoginStatus1" runat="server" />
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>

                <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="vId" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="366px">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="vId" HeaderText="vId" InsertVisible="False" ReadOnly="True" SortExpression="vId" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <asp:DetailsView ID="DetailsView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Height="50px" Width="366px" AutoGenerateRows="False" DataKeyNames="vId" DataSourceID="SqlDataSource2" AllowPaging="True">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                    <EditRowStyle BackColor="#999999" />
                    <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                    <Fields>
                        <asp:BoundField DataField="vId" HeaderText="vId" InsertVisible="False" ReadOnly="True" SortExpression="vId" />
                        <asp:BoundField DataField="patient id" HeaderText="patient id" SortExpression="patient id" />
                        <asp:BoundField DataField="patient name" HeaderText="patient name" SortExpression="patient name" />
                        <asp:BoundField DataField="dr id" HeaderText="dr id" SortExpression="dr id" />
                        <asp:BoundField DataField="dr name" HeaderText="dr name" SortExpression="dr name" />
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
                <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
            </ContentTemplate>

        </asp:UpdatePanel>
    </form>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT [vId] FROM [visits] where [vnid] in (select nid from nurses where nuname = @nu);">
        <SelectParameters>
            <asp:ControlParameter ControlID="Label1" Name="nu" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT a.[vId], a.[vpid] 'patient id', c.pname 'patient name', a.vdrid 'dr id', b.[drname] 'dr name', a.[vdsid] disease, a.[vsts] status, a.[mdc]medicine, a.[comment] 'dr comment' 
FROM [visits] a, doctors b, patients c
WHERE ([vId] = @vId) and a.vdrid = b.drid and a.vpid = c.pid and a.vsts != 'cured';">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="vId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</body>
</html>
