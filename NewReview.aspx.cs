using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class New_Review : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
        }
        protected void DropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            //foreach(ListItem listItem in list.Items)
            //{
            //    if(listItem.Selected)
            //    {
            //        Test.Enabled = true;
            //    }
            //}
            //foreach (ListItem listItem in DropDownList.Items)
            //{
            //    if (listItem.Selected)
            //    {
            //        Test.Enabled = true;
            //    }
            //}


            if (list.SelectedValue != "--Select--" || DropDownList.SelectedValue != "--Select--")
            {

                Test.Enabled = true;

            }
            else
            {
                Test.Enabled = false;

            }
        }
    }
}