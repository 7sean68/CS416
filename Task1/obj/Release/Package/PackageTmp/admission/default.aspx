<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Task1.admission._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:LoginName ID="LoginName1" runat="server" />
            <asp:HyperLink ID="LinkButton11" runat="server" Text="patient" NavigateUrl="~/pat" Visible='<%#Roles.IsUserInRole("pat")%>'></asp:HyperLink>
            <asp:LinkButton ID="LinkButton6" runat="server" PostBackUrl="~/Account.aspx" Text="Account"></asp:LinkButton>
            <asp:LoginStatus ID="LoginStatus1" runat="server" />
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <br />
        <asp:Label ID="Label4" runat="server" height="22px" Text="ssn" width="128px"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label5" runat="server" height="22px" Text="name" width="128px"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label6" runat="server" height="22px" Text="user name" width="128px"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label7" runat="server" height="22px" Text="tel. no." width="128px"></asp:Label>
&nbsp;
        <asp:Label ID="Label8" runat="server" height="22px" Text="email" width="128px"></asp:Label>
&nbsp;<asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div>
                    <asp:TextBox ID="txtssn" runat="server" ToolTip="ssid" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvssn" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtssn"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtname" runat="server" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvname" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtname"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtuname" runat="server" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvuname" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtuname"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txttelno" runat="server" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvtelno" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txttelno"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtml" runat="server" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rtfml" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtml"></asp:RequiredFieldValidator>
                    <br />
                    &nbsp;
                    <asp:Button ID="btnnsrt" runat="server" Text="insert" OnClick="btnnsrt_Click"></asp:Button>
                    <br />
                    <asp:RegularExpressionValidator ID="revml" runat="server" ControlToValidate="txtml" ErrorMessage="not a valid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" BorderStyle="None" ForeColor="Red"></asp:RegularExpressionValidator>
                    <br />
                    <asp:Label ID="lblstatus" runat="server"></asp:Label>
                </div>
                <div style="direction: ltr">
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="sqldpt" DataTextField="dname" DataValueField="dname">
                </asp:DropDownList>
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="rid" DataSourceID="Sqlrm" ForeColor="#333333" GridLines="None" Height="50px" style="margin-right: 4px" Width="125px" OnPageIndexChanging="DetailsView1_PageIndexChanging" AllowPaging="True">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
                    <EditRowStyle BackColor="#999999" />
                    <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
                    <Fields>
                        <asp:BoundField DataField="rid" HeaderText="rid" InsertVisible="False" ReadOnly="True" SortExpression="rid" />
                        <asp:BoundField DataField="dname" HeaderText="dname" ReadOnly="True" SortExpression="dname" />
                        <asp:TemplateField HeaderText="pid" SortExpression="pid">
                            <EditItemTemplate>
                                <asp:DropDownList ID="TextBox1" runat="server" DataSourceID="sqlp" DataTextField="puname" DataValueField="pid" OnSelectedIndexChanged="TextBox1_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("pid") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="textBox1" runat="server" Text='<%# Bind("pid") %>'></asp:TextBox>

                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="label1" runat="server" Text='<%# Bind("pid") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="drid" SortExpression="drid">
                            <EditItemTemplate>
                                <asp:DropDownList ID="TextBox2" runat="server" DataSourceID="sqldrn" DataTextField="Column1" DataValueField="drid"></asp:DropDownList>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("drid") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="textBox2" runat="server" Text='<%# Bind("drid") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="label2" runat="server" Text='<%# Bind("drid") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="nid" SortExpression="nid">
                            <EditItemTemplate>
                                <asp:DropDownList ID="TextBox3" runat="server" DataSourceID="sqldrn" DataTextField="Column2" DataValueField="nid"></asp:DropDownList>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("nid") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="textBox3" runat="server" Text='<%# Bind("nid") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="label3" runat="server" Text='<%# Bind("nid") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" OnClick="LinkButton1_Click" Text="Update"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Fields>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                </asp:DetailsView>
                    </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    <asp:SqlDataSource ID="Sqlrm" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Rooms] WHERE [rid] = @original_rid" InsertCommand="INSERT INTO [Rooms] ([dname], [pid], [drid], [nid]) VALUES (@dname, @pid, @drid, @nid)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Rooms] WHERE (([pid] IS NULL) AND ([dname] = @dname))" UpdateCommand="UPDATE [Rooms] SET  [pid] = @pid, [drid] = @drid, [nid] = @nid WHERE [rid] = @original_rid;
INSERT INTO [visits] ( [vpid], [vdrid], [vnid], [vsts]) VALUES ( @pid, @drid, @nid, 'under observation');">
        <DeleteParameters>
            <asp:Parameter Name="original_rid" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="dname" Type="String" />
            <asp:Parameter Name="pid" Type="Int32" />
            <asp:Parameter Name="drid" Type="Int32" />
            <asp:Parameter Name="nid" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="dname" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="pid" Type="Int32" />
            <asp:Parameter Name="drid" Type="Int32" />
            <asp:Parameter Name="nid" Type="Int32" />
            <asp:Parameter Name="original_rid" Type="Int32" />
        </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqldpt" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [departments]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqldrn" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="select a.drid, CAST(a.drid AS VARCHAR(10)) + ' ' + a.drname, b.nid, CAST(b.nid AS VARCHAR(10)) + ' ' + b.nname from doctors a, nurses b
where a.drdname = @dn and b.ndname = @dn;">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" DefaultValue="a" Name="dn" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlpatient" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO [patients] ([pssn], [pname], [puname], [ptelno]) VALUES (@ssn, @name, @uname, @telno)">
        <InsertParameters>
                <asp:ControlParameter ControlID="txtssn" DefaultValue="" Name="ssn" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtname" DefaultValue="" Name="name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtuname" DefaultValue="" Name="uname" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txttelno" DefaultValue="" Name="telno" PropertyName="Text" Type="String" />
            </InsertParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlp" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT pid, puname FROM patients a where pid not in (select pid from rooms where pid is not null) ;"></asp:SqlDataSource>
    </form>
    </body>
</html>
