using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task1.pat
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            ViewStateUserKey = Session.SessionID;
            /*if (Session.SessionID != Request.Cookies["ASP.NET_SessionId"].Value) Response.Redirect(Page.Request.Url.ToString());
            Response.AddHeader("nw", Session.IsNewSession.ToString() + " " + Session.SessionID + " " + Request.Cookies["ASP.NET_SessionId"].Value);*/
            Label1.Text = System.Web.Security.Membership.GetUser().UserName;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            LinkButton8.DataBind();
            LinkButton9.DataBind();
            LinkButton10.DataBind();
            LinkButton12.DataBind();
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
    }
}