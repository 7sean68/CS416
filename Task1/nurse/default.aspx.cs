using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task1.nurse
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            ViewStateUserKey = Session.SessionID;
            /*if (Session.SessionID != Request.Cookies["ASP.NET_SessionId"].Value) Response.Redirect(Page.Request.Url.ToString());
            Response.AddHeader("nw", Session.IsNewSession.ToString() + " " + Session.SessionID + " " + Request.Cookies["ASP.NET_SessionId"].Value);*/
            
        }
        //iisexpress.exe /path:C:\Windows\Microsoft.NET\Framework\v4.0.30319\ASP.NETWebAdminFiles /vpath:"/ASP.NETWebAdminFiles" /port:8082 /clr:4.0 /ntlm
        //http://localhost:8082/asp.netwebadminfiles/default.aspx?applicationPhysicalPath=E:\HUSSIEN_WEB\study\Task1\task1&applicationUrl=/
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = System.Web.Security.Membership.GetUser().UserName;
            LinkButton11.DataBind();
        }

        protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            //LinkButton6.Text = e.Command.Parameters["drid"].ToString();
        }

        protected void LinkButton7_Click(object sender, EventArgs e)
        {

        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}