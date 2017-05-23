using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task1.admission
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            ViewStateUserKey = Session.SessionID;
            /*if (Session.SessionID != Request.Cookies["ASP.NET_SessionId"].Value) Response.Redirect(Page.Request.Url.ToString());
            Response.AddHeader("nw", Session.IsNewSession.ToString() + " " + Session.SessionID + " " + Request.Cookies["ASP.NET_SessionId"].Value);*/
            lblstatus.Visible = false;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            LinkButton11.DataBind();
        }

        protected void DetailsView1_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            ((Label)DetailsView1.FindControl("Label1")).Text = ((DropDownList)DetailsView1.FindControl("TextBox1")).SelectedValue;
            ((Label)DetailsView1.FindControl("Label2")).Text = ((DropDownList)DetailsView1.FindControl("TextBox2")).SelectedValue;
            ((Label)DetailsView1.FindControl("Label3")).Text = ((DropDownList)DetailsView1.FindControl("TextBox3")).SelectedValue;
            Sqlrm.DataBind();
        }

        protected void TextBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
        protected void btnnsrt_Click(object sender, EventArgs e)
        {
            string s = System.Web.Security.Membership.GeneratePassword(6, 0);
            if (System.Web.Security.Membership.FindUsersByEmail(txtml.Text).Count == 0 && System.Web.Security.Membership.FindUsersByName(txtuname.Text).Count == 0)
            {
                System.Web.Security.Membership.CreateUser(txtuname.Text, s, txtml.Text);
                System.Web.Security.Roles.AddUserToRole(txtuname.Text, "pat");
                lblstatus.Text = s;
                try
                {
                    sqlpatient.Insert();
                }
                catch
                {
                    lblstatus.Text = "Failed ";
                    System.Web.Security.Membership.DeleteUser(txtuname.Text);
                }
            }
            else
            {
                lblstatus.Text = "user creation error";
            }
            lblstatus.Visible = true;
        }

        protected void txtssn_TextChanged(object sender, EventArgs e)
        {

        }
    }
}