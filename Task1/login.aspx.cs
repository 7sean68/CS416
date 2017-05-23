using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task1
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            try { ViewStateUserKey = Session.SessionID; }
            catch { Response.Redirect(Page.Request.Url.ToString()); }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated) Response.Redirect("/");
            DataBind();
        }
    }
}