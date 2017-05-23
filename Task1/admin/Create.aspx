<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="Task1.Admin.Create" %>

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
        &nbsp;<asp:HyperLink ID="Lnkdlt" runat="server" Text="manage accounts" NavigateUrl="./manage.aspx"></asp:HyperLink>

        &nbsp;<asp:HyperLink ID="LinkButton6" runat="server" Text="Account" NavigateUrl="~/Account.aspx"></asp:HyperLink>
        &nbsp;<asp:LoginStatus runat="server" ID="LoginStatus1"></asp:LoginStatus>
        <br />
        <br />
&nbsp;
        &nbsp;
        &nbsp;
        &nbsp;&nbsp;
        &nbsp;<asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div>
                    <asp:Label ID="Label4" runat="server" height="22px" Text="ssn" width="128px"></asp:Label>
                    &nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Label5" runat="server" height="22px" Text="name" width="128px"></asp:Label>
                    &nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Label6" runat="server" height="22px" Text="user name" width="128px"></asp:Label>
                    &nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Label7" runat="server" height="22px" Text="tel. no." width="128px"></asp:Label>
                    &nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Label8" runat="server" height="22px" Text="email" width="128px"></asp:Label>
                    <br />
                    <asp:TextBox ID="txtssn" runat="server" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvssn" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtssn"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtname" runat="server" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvname" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtname"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtuname" runat="server" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvuname" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtuname"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txttelno" runat="server" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvtelno" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txttelno"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="txtml" runat="server" Width="128px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rtfml" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txtml"></asp:RequiredFieldValidator>
                    <asp:DropDownList ID="drprl" runat="server" DataSourceID="sqlrole" DataTextField="RoleName" DataValueField="RoleName" AutoPostBack="True" OnSelectedIndexChanged="drprl_SelectedIndexChanged"></asp:DropDownList>
                    <asp:DropDownList ID="drpdpt" runat="server" DataSourceID="sqldpt" DataTextField="dname" DataValueField="dname" Visible="False"></asp:DropDownList>
                    <br />
                    <asp:CheckBox ID="chkptnt" runat="server" Text="is patient" />
                    &nbsp;
                    <asp:Button ID="btnnsrt" runat="server" Text="insert" OnClick="btnnsrt_Click"></asp:Button>
                    <br />
                    <asp:RegularExpressionValidator ID="revml" runat="server" ControlToValidate="txtml" ErrorMessage="not a valid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" BorderStyle="None" ForeColor="Red"></asp:RegularExpressionValidator>
                    <br />
                    <asp:Label ID="lblstatus" runat="server"></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <asp:SqlDataSource ID="sqladmin" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO [admins] ([adssn], [adname], [aduname], [adtelno]) VALUES (@ssn, @name, @uname, @telno)">
        <InsertParameters>
                <asp:ControlParameter ControlID="txtssn" DefaultValue="" Name="ssn" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtname" DefaultValue="" Name="name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtuname" DefaultValue="" Name="uname" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txttelno" DefaultValue="" Name="telno" PropertyName="Text" Type="String" />
            </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlpatient" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO [patients] ([pssn], [pname], [puname], [ptelno]) VALUES (@ssn, @name, @uname, @telno)">
        <InsertParameters>
                <asp:ControlParameter ControlID="txtssn" DefaultValue="" Name="ssn" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtname" DefaultValue="" Name="name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtuname" DefaultValue="" Name="uname" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txttelno" DefaultValue="" Name="telno" PropertyName="Text" Type="String" />
            </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqldoctor" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO [doctors] ([drssn], [drname], [druname], [drtelno], [drdname]) VALUES (@ssn, @name, @uname, @telno, @dname)">
        <InsertParameters>
                <asp:ControlParameter ControlID="txtssn" DefaultValue="" Name="ssn" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtname" DefaultValue="" Name="name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtuname" DefaultValue="" Name="uname" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txttelno" DefaultValue="" Name="telno" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="drpdpt" DefaultValue="" Name="dname" PropertyName="SelectedValue" Type="String" />
            </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqllab" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO [labs] ([lbssn], [lbname], [lbuname], [lbtelno]) VALUES (@ssn, @name, @uname, @telno)">
        <InsertParameters>
                <asp:ControlParameter ControlID="txtssn" DefaultValue="" Name="ssn" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtname" DefaultValue="" Name="name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtuname" DefaultValue="" Name="uname" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txttelno" DefaultValue="" Name="telno" PropertyName="Text" Type="String" />
            </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqladmission" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO [admissions] ([dmssn], [dmname], [dmuname], [dmtelno]) VALUES (@ssn, @name, @uname, @telno)">
        <InsertParameters>
                <asp:ControlParameter ControlID="txtssn" DefaultValue="" Name="ssn" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtname" DefaultValue="" Name="name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtuname" DefaultValue="" Name="uname" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txttelno" DefaultValue="" Name="telno" PropertyName="Text" Type="String" />
            </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlnurse" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO [nurses] ([nssn], [nname], [nuname], [ntelno], [ndname]) VALUES (@ssn, @name, @uname, @telno, @dname)">
        <InsertParameters>
                <asp:ControlParameter ControlID="txtssn" DefaultValue="" Name="ssn" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtname" DefaultValue="" Name="name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txtuname" DefaultValue="" Name="uname" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="txttelno" DefaultValue="" Name="telno" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="drpdpt" DefaultValue="" Name="dname" PropertyName="SelectedValue" Type="String" />
            </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlrole" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [RoleName] FROM [Roles] where [RoleName] != 'pat'"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqldpt" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [dname] FROM [departments]"></asp:SqlDataSource>
</body>
</html>
