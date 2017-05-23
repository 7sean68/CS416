using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Task1
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            ViewStateUserKey = Session.SessionID;
            /*if (Session.SessionID != Request.Cookies["ASP.NET_SessionId"].Value) Response.Redirect(Page.Request.Url.ToString());
            Response.AddHeader("nw", Session.IsNewSession.ToString() + " " + Session.SessionID + " " + Request.Cookies["ASP.NET_SessionId"].Value);*/
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            //System.Web.Security.Roles.AddUserToRole
            //System.Web.Security.Membership.GetUser("7sea").GetPassword();
            DataBind();
        }
        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            /*if (e.CommandName == "Insert" && Page.IsValid)
            {
                SqlDataSource1.InsertParameters.Clear();
                SqlDataSource1.InsertParameters.Add("pssn", ((TextBox)GridView1.FooterRow.FindControl("TextBox5")).Text);
                SqlDataSource1.InsertParameters.Add("pname", ((TextBox)GridView1.FooterRow.FindControl("TextBox6")).Text);
                SqlDataSource1.InsertParameters.Add("paddress", ((TextBox)GridView1.FooterRow.FindControl("TextBox7")).Text);
                SqlDataSource1.InsertParameters.Add("ptelno", ((TextBox)GridView1.FooterRow.FindControl("TextBox8")).Text);
                SqlDataSource1.Insert();
            }*/
        }

        protected void GridView1_SelectedIndexChanged2(object sender, EventArgs e)
        {
            
        }

        protected void TextBox8_TextChanged(object sender, EventArgs e)
        {
            /*SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("pssn", ((TextBox)GridView1.FooterRow.FindControl("TextBox5")).Text + "%");
            SqlDataSource1.SelectParameters.Add("pname", ((TextBox)GridView1.FooterRow.FindControl("TextBox6")).Text + "%");
            SqlDataSource1.SelectParameters.Add("paddress", ((TextBox)GridView1.FooterRow.FindControl("TextBox7")).Text + "%");
            SqlDataSource1.SelectParameters.Add("ptelno", ((TextBox)GridView1.FooterRow.FindControl("TextBox8")).Text + "%");
            if (GridView1.Rows.Count == 0) { SqlDataSource1.SelectParameters.Clear(); }*/
        }

        protected void GridView1_Load(object sender, EventArgs e)
        {
            
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            
            /*SqlDataSource1.InsertParameters.Clear();
            SqlDataSource1.InsertParameters.Add("pssn", txtpssn.Text);
            SqlDataSource1.InsertParameters.Add("pname", txtpname.Text);
            SqlDataSource1.InsertParameters.Add("paddress", txtpaddress.Text);
            SqlDataSource1.InsertParameters.Add("ptelno", txtptelno.Text);*/


            
        }

        protected void LinkButton5_Click(object sender, EventArgs e)
        {
            
        }

        protected void SqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            

        }

        protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            //DetailsView1.Visible = true;
        }

        protected void GridView1_SelectedIndexChanged2(object sender, GridViewSelectEventArgs e)
        {
            /*Label2.Text = ((Label)GridView1.SelectedRow.FindControl("id")).Text;
            DetailsView1.Visible = true;*/
        }

        protected void SqlDataSource2_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {
            
        }
    }
}