using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task1.Admin
{
    public partial class manage : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            ViewStateUserKey = Session.SessionID;
            /*if (Session.SessionID != Request.Cookies["ASP.NET_SessionId"].Value) Response.Redirect(Page.Request.Url.ToString());
            Response.AddHeader("nw", Session.IsNewSession.ToString() + " " + Session.SessionID + " " + Request.Cookies["ASP.NET_SessionId"].Value);*/
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Lnkpat.DataBind();
        }

        protected void btndl_Click(object sender, EventArgs e)
        {
            if (drpdl.SelectedValue != System.Web.Security.Membership.GetUser().UserName)
            {
                System.Web.Security.Membership.DeleteUser(drpdl.SelectedValue);
                drpdl.DataBind();
            }
        }
    }
}