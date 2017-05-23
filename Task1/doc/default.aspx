<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Task1.doc._default1" EnableViewStateMac="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-image:url('../background.jpg'); background-size:100%; height: 1234px; width: 1052px; margin-left:auto;margin-right:auto">
    <form id="form1" runat="server">
                <asp:LoginName ID="LoginName1" runat="server" />
                <asp:HyperLink ID="LinkButton11" runat="server" Text="patient" NavigateUrl="~/pat" Visible='<%#Roles.IsUserInRole("pat")%>'></asp:HyperLink>
                <asp:LinkButton ID="LinkButton6" runat="server" PostBackUrl="~/Account.aspx" Text="Account"></asp:LinkButton>
                <asp:LoginStatus ID="LoginStatus1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
            
    </asp:ScriptManager>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" DataKeyNames="vid" Width="541px">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="vid" HeaderText="vid" SortExpression="vid" InsertVisible="False" ReadOnly="True" />
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
                <asp:LinkButton ID="LinkButton7" runat="server" OnClick="LinkButton7_Click" Text="history"></asp:LinkButton>
                <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
                <asp:DetailsView ID="DetailsView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" Height="50px" Width="511px" AutoGenerateRows="False" DataKeyNames="vId" DataSourceID="SqlDataSource2">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                    <EditRowStyle BackColor="#999999" />
                    <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                    <Fields>
                        <asp:BoundField DataField="vId" HeaderText="vId" InsertVisible="False" ReadOnly="True" SortExpression="vId" />
                        <asp:TemplateField HeaderText="patient id" SortExpression="patient id">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("[patient id]") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("[patient id]") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("[patient id]") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="patient name" HeaderText="patient name" SortExpression="patient name" ReadOnly="True" />
                        <asp:BoundField DataField="nurse id" HeaderText="nurse id" SortExpression="nurse id" ReadOnly="True" />
                        <asp:BoundField DataField="nurse name" HeaderText="nurse name" SortExpression="nurse name" ReadOnly="True" />
                        <asp:TemplateField HeaderText="disease" SortExpression="disease">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource3" DataTextField="dsname" DataValueField="dsname" ></asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("disease") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("disease") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="status" SortExpression="status">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource5" DataTextField="sts" DataValueField="sts" ></asp:DropDownList>
                                
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("status") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="medicine" SortExpression="medicine">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource4" DataTextField="mdname" DataValueField="mdname"></asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("medicine") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("medicine") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="doctor comment" SortExpression="doctorcomment">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("doctorcomment") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("doctorcomment") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("doctorcomment") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" />
                    </Fields>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                </asp:DetailsView>
                
                <asp:DetailsView ID="DetailsView2" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="vId" DataSourceID="SqlDataSource6" ForeColor="#333333" GridLines="None" Height="50px" Width="513px" AllowPaging="True" Visible="False">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                    <EditRowStyle BackColor="#999999" />
                    <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                    <Fields>
                        <asp:BoundField DataField="vId" HeaderText="vId" InsertVisible="False" ReadOnly="True" SortExpression="vId" />
                        <asp:BoundField DataField="patient id" HeaderText="patient id" SortExpression="patient id" />
                        <asp:BoundField DataField="patient name" HeaderText="patient name" SortExpression="patient name" />
                        <asp:BoundField DataField="nurse id" HeaderText="nurse id" SortExpression="nurse id" />
                        <asp:BoundField DataField="nurse name" HeaderText="nurse name" SortExpression="nurse name" />
                        <asp:BoundField DataField="disease" HeaderText="disease" SortExpression="disease" />
                        <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                        <asp:BoundField DataField="medicine" HeaderText="medicine" SortExpression="medicine" />
                        <asp:BoundField DataField="doctorcomment" HeaderText="doctorcomment" SortExpression="doctorcomment" />
                    </Fields>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                </asp:DetailsView>
                
            </ContentTemplate>

        </asp:UpdatePanel>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [vid] FROM [visits] where [vdrid] in (select drid from doctors where druname = @pu) and vsts != 'cured';">
        <SelectParameters>
            <asp:ControlParameter ControlID="Label1" Name="pu" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT a.[vId], a.[vpid] 'patient id', b.[pname] 'patient name', a.[vnid] 'nurse id', c.[nname] 'nurse name', a.[vdsid] disease, a.[vsts] status, a.[mdc] medicine, a.[comment] doctorcomment 
FROM [visits] a, patients b, nurses c
WHERE ([vId] = @vId) and a.vpid = b.pid and a.vnid = c.nid and a.vsts != 'cured';" UpdateCommand="update visits set vdsid = @disease, mdc = @medicine, vsts = @status, comment = @doctorcomment where vid = @vId" OnSelecting="SqlDataSource2_Selecting" OnUpdated="SqlDataSource2_Updated" OnUpdating="SqlDataSource2_Updating">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="vId" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="DetailsView1$DropDownList1" Name="disease" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DetailsView1$DropDownList2" Name="status" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DetailsView1$DropDownList3" Name="medicine" PropertyName="SelectedValue" />
            <asp:Parameter Name="doctorcomment" />
            <asp:Parameter Name="vid" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [diseases]" UpdateCommand="update rooms set pid = NULL, drid = NULL, nid = NULL where pid = @pid">
        <UpdateParameters>
            <asp:ControlParameter ControlID="DetailsView1$Label1" Name="pid" PropertyName="Text"/>
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [medicines]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [statuses]"></asp:SqlDataSource>
    
                <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT a.[vId], a.[vpid] 'patient id', b.[pname] 'patient name', a.[vnid] 'nurse id', c.[nname] 'nurse name', a.[vdsid] disease, a.[vsts] status, a.[mdc] medicine, a.[comment] doctorcomment 
FROM [visits] a, patients b, nurses c
WHERE vpid in (select distinct vpid from visits where vid = @vId) and a.vpid = b.pid and a.vnid = c.nid">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="vId" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
    </form>
        
    </body>
</html>
