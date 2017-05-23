using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task1.Admin
{
    
    public partial class Create : System.Web.UI.Page
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
            // DataBind();
        }//l^Mmpl jO&*JD W3drWV z(uc6R RwrX}Z FCRGLa

        protected void btnnsrt_Click(object sender, EventArgs e)
        {
            string s = System.Web.Security.Membership.GeneratePassword(6,0);
            if (System.Web.Security.Membership.FindUsersByEmail(txtml.Text).Count == 0 && System.Web.Security.Membership.FindUsersByName(txtuname.Text).Count == 0)
            {
                System.Web.Security.Membership.CreateUser(txtuname.Text, s, txtml.Text);
                System.Web.Security.Roles.AddUserToRole(txtuname.Text, drprl.SelectedValue);
                try
                {
                    ((SqlDataSource)FindControl("sql" + drprl.SelectedValue)).Insert();

                    lblstatus.Text = "Success\npassword is\t" + s;
                }
                catch
                {
                    System.Web.Security.Membership.DeleteUser(txtuname.Text);
                    lblstatus.Text = "Failed";
                    lblstatus.Visible = true;
                    return;
                }
                try
                {
                    if (chkptnt.Checked) sqlpatient.Insert();
                }
                catch
                {
                    lblstatus.Text = "User added primary and assigned to " + drprl.SelectedValue + " ,but a patient already exists with same ssn";
                }
            }else
            {
                lblstatus.Text = "user creation error";
            }
            lblstatus.Visible = true;
        }

        protected void drprl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (drprl.SelectedValue == "doc" || drprl.SelectedValue == "nurse") drpdpt.Visible = true;
            else drpdpt.Visible = false;
            lblstatus.Visible = false;
        }
    }
}