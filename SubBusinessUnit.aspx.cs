using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesReportingWebsite
{
    public partial class SubBusinessUnit : PageBase
    {
        public int memberships;
        protected void Page_Load(object sender, EventArgs e)
        {

            VBFunctions.ADFunctions obj = new VBFunctions.ADFunctions();
            string userID = obj.GetUserName();
            // string dirEntry = obj.GetDirectoryEntry();
            memberships = obj.VerifyGroupMemberships("LDAP://192.168.100.3/ou=Cooper Network Users,dc=coopersurgical1,dc=com", "webapps", "Yankees#1", userID);

            if (!Page.IsPostBack)

            {
                if (memberships == 1 || memberships == 2 || memberships == 3)
                {
                    SubBusinessUnitReportingChild li = new SubBusinessUnitReportingChild();

                    DataTable table = new DataTable();

                    ddlSubBusinessUnitName.DataSource = li.SubBusinessUnitNameList().Tables[0];
                    ddlSubBusinessUnitName.DataTextField = "SubBusinessUnitName";
                    ddlSubBusinessUnitName.DataBind();

                    ddlSubBusinessUnitManagerName.DataSource = li.SubBusinessUnitManagerNameList().Tables[0];
                    ddlSubBusinessUnitManagerName.DataTextField = "SubBusinessUnitManagerName";
                    ddlSubBusinessUnitManagerName.DataBind();

                    ddlBusinessUnitName.DataSource = li.BusinessUnitNameist().Tables[0];
                    ddlBusinessUnitName.DataTextField = "BusinessUnitName";
                    ddlBusinessUnitName.DataBind();

                    ddlCompanyName.DataSource = li.CompanyNameList().Tables[0];
                    ddlCompanyName.DataTextField = "CompanyName";
                    ddlCompanyName.DataBind();

                    newCompanyName.DataSource = li.CompanyNameList().Tables[0];
                    newCompanyName.DataTextField = "CompanyName";
                    newCompanyName.DataBind();

                    newBusinessUnitName.DataSource = li.BusinessUnitNameist().Tables[0];
                    newBusinessUnitName.DataTextField = "BusinessUnitName";
                    newBusinessUnitName.DataBind();

                    newSubSegmentName.DataSource = li.SubSegmentNameList().Tables[0];
                    newSubSegmentName.DataTextField = "SubSegmentName";
                    newSubSegmentName.DataBind();

                    newSubBusinessUnitManagerName.DataSource = li.SubBusinessUnitManagerNameList().Tables[0];
                    newSubBusinessUnitManagerName.DataTextField = "SubBusinessUnitManagerName";
                    newSubBusinessUnitManagerName.DataBind();

                    BindGridView();
                }
                else
                {
                    string display = "You must be a member of 'Consolidated Sales Reporting – Admin' or 'Consolidated Sales Reporting – Finance' or 'Consolidated Sales Reporting – Commission' groups to View the page.";
                    ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + display + "');", true);
                }
            }
        }
        
        #region EventHandling
              
        protected void SubBusinessUnit_RowEditing(object sender, GridViewEditEventArgs e)
        {
            SubBusinessUnitGridView.EditIndex = e.NewEditIndex;
            int index = e.NewEditIndex;
            GridViewRow row = SubBusinessUnitGridView.Rows[e.NewEditIndex];

            BindGridView();
        }
        
        protected void SubBusinessUnit_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            SubBusinessUnitGridView.EditIndex = -1;
            BindGridView();
        }


        protected void SubBusinessUnit_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (Page.IsValid)
            {
                SubBusinessUnitReportingChild li = new SubBusinessUnitReportingChild();
                GridViewRow row = SubBusinessUnitGridView.Rows[e.RowIndex];
                string display = "";
                bool isFormFilled = true;
                try
                {
                    li.SubBusinessUnitID = Convert.ToInt32(SubBusinessUnitGridView.DataKeys[e.RowIndex].Values[0]);

                    if (((TextBox)row.FindControl("SubBusinessUnitCode")).Text != string.Empty)
                    {
                        li.SubBusinessUnitCode = Convert.ToInt32(((TextBox)row.FindControl("SubBusinessUnitCode")).Text);
                    }
                    else
                    {
                        display = "Sub Business Unit Code cannot be empty";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (((TextBox)row.FindControl("SubBusinessUnitName")).Text != string.Empty)
                    {
                        li.SubBusinessUnitName = Convert.ToString(((TextBox)row.FindControl("SubBusinessUnitName")).Text);
                    }
                    else
                    {
                        display = "Sub Business Unit Name cannot be empty";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (((DropDownList)row.FindControl("SubBusinessUnitManagerName")).SelectedValue != "Select One")
                    {
                        li.SubBusinessUnitManagerName = ((DropDownList)row.FindControl("SubBusinessUnitManagerName")).SelectedValue;
                    }
                    //else
                    //{
                    //    display = "Select Sub Business Unit Manager Name from dropdown";
                    //    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                    //    isFormFilled = false;
                    //}


                    if (((DropDownList)row.FindControl("BusinessUnitName")).SelectedValue != "Select One")
                    {
                        li.BusinessUnitName = ((DropDownList)row.FindControl("BusinessUnitName")).SelectedValue;
                    }
                    else
                    {
                        display = "Select Business Unit Name from dropdown";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }


                    if (((DropDownList)row.FindControl("CompanyName")).SelectedValue != "Select One")
                    {
                        li.CompanyName = ((DropDownList)row.FindControl("CompanyName")).SelectedValue;
                    }
                    else
                    {
                        display = "Select Company Name from dropdown";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (!String.IsNullOrEmpty(Convert.ToString((Request.Form[row.FindControl("EffectiveDate").UniqueID]))))
                    {
                        li.EffectiveDate = Convert.ToDateTime((Request.Form[row.FindControl("EffectiveDate").UniqueID]));
                    }
                    else
                    {
                        display = "Effective Date cannot be empty";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }
                    if (!String.IsNullOrEmpty(Convert.ToString((Request.Form[row.FindControl("ExpirationDate").UniqueID]))))
                    {
                        li.ExpirationDate = Convert.ToDateTime((Request.Form[row.FindControl("ExpirationDate").UniqueID]));
                    }
                    //else
                    //{
                    //    display = "Expiration Date cannot be empty";
                    //    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                    //    isFormFilled = false;
                    //}
                    if (li.ExpirationDate != DateTime.MinValue)
                    {
                        if (li.ExpirationDate < li.EffectiveDate)
                        {
                            display = "Expiration Date must be after Effective date";
                            ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                            isFormFilled = false;
                        }
                    }


                    if (isFormFilled)
                    {
                        if (memberships == 1 || memberships == 2)
                        {
                            DataSet result = li.UpdateSKPickingBoard(li, memberships);

                            string res = Convert.ToString(result.Tables[0].Rows[0].ItemArray[0]);

                            if (res.Equals("Duplicate SubBusinessUnitCode"))
                            {
                                display = "Sub Business Unit Code already exists in the database";
                                ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                            }
                            else if (res.Equals("Duplicate SubBusinessUnitName"))
                            {
                                display = "Sub Business Unit Name already exists in the database";
                                ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                            }
                            else if (res.Equals("Success"))
                            {
                            }
                        }
                        else
                        {
                            display = "You must be a member of Consolidated Sales Reporting – Admin or Consolidated Sales Reporting – Finance  groups to make changes.";
                            ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + display + "');", true);
                        }
                    }
                    

                }
                catch (Exception ex)
                {
                    throw ex;
                }

                SubBusinessUnitGridView.EditIndex = -1;
                BindGridView();
            }
        }

        protected void SubBusinessUnit_SortData(object sender, GridViewSortEventArgs e)
        {
            if (SubBusinessUnitGridView.EditIndex >= -1)
            {
                SubBusinessUnitGridView.EditIndex = -1;
            }
            BindGridView();
            SortGrid(sender, e);
        }

        protected void SubBusinessUnit_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && SubBusinessUnitGridView.EditIndex == e.Row.RowIndex)
            {
                SubBusinessUnitReportingChild li = new SubBusinessUnitReportingChild();

                //Find the DropDownList in the Row
                DropDownList ddlSubBusinessUnitManagerNameList = (e.Row.FindControl("SubBusinessUnitManagerName") as DropDownList);
                ddlSubBusinessUnitManagerNameList.DataSource = li.SubBusinessUnitManagerNameList().Tables[0];
                ddlSubBusinessUnitManagerNameList.DataTextField = "SubBusinessUnitManagerName";
                ddlSubBusinessUnitManagerNameList.DataValueField = "SubBusinessUnitManagerName";
                ddlSubBusinessUnitManagerNameList.DataBind();

                //Add Default Item in the DropDownList
                ddlSubBusinessUnitManagerNameList.Items.Insert(0, new ListItem("Select One"));

                //Select the Country of Customer in DropDownList
                string subBusinessUnitManagerNames = (e.Row.FindControl("lblSubBusinessUnitManagerName") as Label).Text;
                ListItem item = ddlSubBusinessUnitManagerNameList.Items.FindByValue(subBusinessUnitManagerNames);
                if (item != null)
                {
                    ddlSubBusinessUnitManagerNameList.SelectedValue = subBusinessUnitManagerNames;

                }


                //Find the DropDownList in the Row
                DropDownList ddlBusinessUnitNameList = (e.Row.FindControl("BusinessUnitName") as DropDownList);
                ddlBusinessUnitNameList.DataSource = li.BusinessUnitNameist().Tables[0];
                ddlBusinessUnitNameList.DataTextField = "BusinessUnitName";
                ddlBusinessUnitNameList.DataValueField = "BusinessUnitName";
                ddlBusinessUnitNameList.DataBind();

                //Add Default Item in the DropDownList
                ddlBusinessUnitNameList.Items.Insert(0, new ListItem("Select One"));

                //Select the Country of Customer in DropDownList
                string businessUnitNames = (e.Row.FindControl("lblBusinessUnitName") as Label).Text;
                ddlBusinessUnitNameList.Items.FindByValue(businessUnitNames).Selected = true;



                //Find the DropDownList in the Row
                DropDownList ddlCompanyNameList = (e.Row.FindControl("CompanyName") as DropDownList);
                ddlCompanyNameList.DataSource = li.CompanyNameList().Tables[0];
                ddlCompanyNameList.DataTextField = "CompanyName";
                ddlCompanyNameList.DataValueField = "CompanyName";
                ddlCompanyNameList.DataBind();

                //Add Default Item in the DropDownList
                ddlCompanyNameList.Items.Insert(0, new ListItem("Select One"));

                //Select the Country of Customer in DropDownList
                string companyNames = (e.Row.FindControl("lblCompanyName") as Label).Text;
                ddlCompanyNameList.Items.FindByValue(companyNames).Selected = true;


            }
        }

        protected void SubBusinessUnit_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (SubBusinessUnitGridView.EditIndex >= -1)
            {
                SubBusinessUnitGridView.EditIndex = -1;
            }
            BindGridView();
            PageGrid(sender, e);
        }
        
        protected void chkBoxResetCheckedChanged(object sender, EventArgs e)
        {
            if (SubBusinessUnitGridView.EditIndex >= -1)
            {
                SubBusinessUnitGridView.EditIndex = -1;
            }
            ddlBusinessUnitName.SelectedIndex = 0;
            ddlSubBusinessUnitManagerName.SelectedIndex = 0;
            ddlSubBusinessUnitName.SelectedIndex = 0;
            ddlCompanyName.SelectedIndex = 0;
            BindGridView();
        }

        #endregion
  protected void btnSaveNewSubBusinessUnit_Click(object sender, EventArgs e)
        {
            bool isFormFilled = true;
            string display = "";
            SubBusinessUnitReportingChild li = new SubBusinessUnitReportingChild();
            string subBusinessUnitCode = newSubBusinessUnitCode.Text;
            string subBusinessUnitName = newSubBusinessUnitName.Text;
            string subBusinessUnitManagerName = newSubBusinessUnitManagerName.Text;
            string businessUnitName = newBusinessUnitName.Text;
            string companyName = newCompanyName.Text;
            string subSegmentName = newSubSegmentName.Text;
            string effectiveDate = Request.Form[newEffectiveDate.UniqueID];
            
          
            if (String.IsNullOrEmpty(effectiveDate) || String.IsNullOrEmpty(subBusinessUnitCode) 
                || String.IsNullOrEmpty(subBusinessUnitName) || String.IsNullOrEmpty(subBusinessUnitManagerName) 
                || String.IsNullOrEmpty(businessUnitName) || String.IsNullOrEmpty(companyName))
            {
                display = "Please select all the mandatory fields ";
                ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                isFormFilled = false;
            }


            if (isFormFilled)
            {
                if (memberships == 1 || memberships == 2)
                {
                    DataSet result = li.AddNewSubBusinessUnit(subBusinessUnitCode, subBusinessUnitName, subSegmentName,subBusinessUnitManagerName, businessUnitName, companyName, effectiveDate);

                    string res = Convert.ToString(result.Tables[0].Rows[0].ItemArray[0]);

                    if (res.Equals("Duplicate SubBusinessUnitCode"))
                    {
                        display = "Sub Business Unit Code already exists in the database";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }
                    else if (res.Equals("Duplicate SubBusinessUnitName"))
                    {
                        display = "Sub Business Unit Name already exists in the database";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }
                    else if (res.Equals("Success"))
                    {
                        display = "A new SubSegment is successfully added in the database";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = true;
                    }
                    if (isFormFilled)
                    {
                        newSubBusinessUnitCode.Text = "";
                        newSubBusinessUnitName.Text = "";

                        ddlSubBusinessUnitManagerName.DataSource = li.SubBusinessUnitManagerNameList().Tables[0];
                        ddlSubBusinessUnitManagerName.DataTextField = "SubBusinessUnitManagerName";
                        ddlSubBusinessUnitManagerName.DataBind();

                        ddlBusinessUnitName.DataSource = li.BusinessUnitNameist().Tables[0];
                        ddlBusinessUnitName.DataTextField = "BusinessUnitName";
                        ddlBusinessUnitName.DataBind();

                        ddlCompanyName.DataSource = li.CompanyNameList().Tables[0];
                        ddlCompanyName.DataTextField = "CompanyName";
                        ddlCompanyName.DataBind();
                        BindGridView();
                    }
                }
                else
                {
                    display = "You must be a member of Consolidated Sales Reporting – Admin or Consolidated Sales Reporting – Finance  groups to Add new SubBusinessUnit.";
                    ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + display + "');", true);
                }
            }
        }

        protected void btnAddNewSubBusinessUnit_Click(object sender, EventArgs e)
        {
            ModalPopupExtender1.Show();
        }

        protected void ddl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (SubBusinessUnitGridView.EditIndex >= -1)
            {
                SubBusinessUnitGridView.EditIndex = -1;
            }
            BindGridView();
        }

        private void BindGridView()
        {
            int count;
            SubBusinessUnitReportingChild obj = new SubBusinessUnitReportingChild();
           
            string subBusinessUnitName = ddlSubBusinessUnitName.SelectedValue.ToString();
            string subBusinessUnitManagerName = ddlSubBusinessUnitManagerName.SelectedValue.ToString();
            string businessUnitName = ddlBusinessUnitName.SelectedValue.ToString();
            string companyName = ddlCompanyName.SelectedValue.ToString();
            DataSet ds = obj.GetSKPickingBoard2(subBusinessUnitName,  businessUnitName, companyName, subBusinessUnitManagerName);//, companyName);// fromDate, toDate, period, fromQuantity, toQuantity, fromAmount, toAmount, adjustmentType, countryName, subBusinessUnitName, companyName, subSegmentName, accountSubTypeName, subCategoryName, rblMeasurementSystemText);
            SubBusinessUnitGridView.DataSource = ds.Tables[0];
            SubBusinessUnitGridView.DataBind();
            count = ds.Tables[0].Rows.Count;
            if (count > 1)
            {
                lblRecordCount.Text = "Record Count: " + count;
            }
            else
            {
                lblRecordCount.Text = "Record Count: " + count;
            }
            
        }
                
        protected void btnExportToExcel_Click(object sender, EventArgs e)
        {

            ModalPopupExtender2.Show();
           
        }

        protected void btnexcelDownloadAll_Click(object sender, EventArgs e)
        {
            ModalPopupExtender2.Hide();
            SubBusinessUnitReportingChild obj = new SubBusinessUnitReportingChild();
            DataSet ds = obj.GetSKPickingBoard2("Select One", "Select One", "Select One", "Select One");
            WorkbookEngine we = new WorkbookEngine();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                if (dr.IsNull("ExpirationDate"))
                {
                    dr.Delete();
                }
                //DateTime expirationDate = Convert.ToDateTime(dr["ExpirationDate"].ToString());
            }
            we.ExportDataSetToExcel(ds.Tables[0], "SubBusinessUnit Reporting");
        }

        protected void btnexcelDownload_Click(object sender, EventArgs e)
        {
            ModalPopupExtender2.Hide();
            SubBusinessUnitReportingChild obj = new SubBusinessUnitReportingChild();
            DataSet ds = obj.GetSKPickingBoard2("Select One", "Select One", "Select One", "Select One");
            WorkbookEngine we = new WorkbookEngine();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                if (!dr.IsNull("ExpirationDate"))
                {
                    dr.Delete();
                }
                //DateTime expirationDate = Convert.ToDateTime(dr["ExpirationDate"].ToString());
            }
            we.ExportDataSetToExcel(ds.Tables[0], "SubBusinessUnit Reporting");
        }
    }
}