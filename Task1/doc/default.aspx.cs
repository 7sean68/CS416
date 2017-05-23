using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task1.doc
{
    public partial class _default1 : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            ViewStateUserKey = Session.SessionID;
            /*if (Session.SessionID != Request.Cookies["ASP.NET_SessionId"].Value) Response.Redirect(Page.Request.Url.ToString());
            Response.AddHeader("nw", Session.IsNewSession.ToString() + " " + Session.SessionID + " " + Request.Cookies["ASP.NET_SessionId"].Value);*/
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = System.Web.Security.Membership.GetUser().UserName;
            LinkButton11.DataBind();
        }

        protected void LinkButton7_Click(object sender, EventArgs e)
        {
            LinkButton7.Text = (LinkButton7.Text == "history" ? "current" : "history");
            DetailsView1.Visible = !DetailsView1.Visible;
            DetailsView2.Visible = !DetailsView2.Visible;
        }

        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            
        }

        protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (((string)e.Command.Parameters[1].Value) == "cured")
            {
                SqlDataSource3.Update();
            }
        }

        protected void SqlDataSource2_Updating(object sender, SqlDataSourceCommandEventArgs e)
        {
            
        }
    }
}