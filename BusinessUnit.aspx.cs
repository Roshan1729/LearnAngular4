using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesReportingWebsite
{
    public partial class BusinessUnit : PageBase
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
                    BusinessUnitReportingChild li = new BusinessUnitReportingChild();

                    DataTable table = new DataTable();

                    ddlBusinessUnitName.DataSource = li.BusinessUnitNameist().Tables[0];
                    ddlBusinessUnitName.DataTextField = "BusinessUnitName";
                    ddlBusinessUnitName.DataBind();

                    ddlCompanyName.DataSource = li.CompanyNameList().Tables[0];
                    ddlCompanyName.DataTextField = "CompanyName";
                    ddlCompanyName.DataBind();

                    ddlBusinessUnitManagerName.DataSource = li.BusinessUnitManagerNameList().Tables[0];
                    ddlBusinessUnitManagerName.DataTextField = "BusinessUnitManagerName";
                    ddlBusinessUnitManagerName.DataBind();

                    newCompanyName.DataSource = li.CompanyNameList().Tables[0];
                    newCompanyName.DataTextField = "CompanyName";
                    newCompanyName.DataBind();

                    newBusinessUnitManagerName.DataSource = li.BusinessUnitManagerNameList().Tables[0];
                    newBusinessUnitManagerName.DataTextField = "BusinessUnitManagerName";
                    newBusinessUnitManagerName.DataBind();

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
              
        protected void BusinessUnit_RowEditing(object sender, GridViewEditEventArgs e)
        {
            BusinessUnitGridView.EditIndex = e.NewEditIndex;
            int index = e.NewEditIndex;
            GridViewRow row = BusinessUnitGridView.Rows[e.NewEditIndex];

            BindGridView();
        }
        
        protected void BusinessUnit_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            BusinessUnitGridView.EditIndex = -1;
            BindGridView();
        }


        protected void BusinessUnit_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (Page.IsValid)
            {
                BusinessUnitReportingChild li = new BusinessUnitReportingChild();
                GridViewRow row = BusinessUnitGridView.Rows[e.RowIndex];
                string display = "";
                bool isFormFilled = true;
                try
                {
                    li.BusinessUnitID = Convert.ToInt32(BusinessUnitGridView.DataKeys[e.RowIndex].Values[0]);

                    if (((TextBox)row.FindControl("BusinessUnitCode")).Text != string.Empty)
                    {
                        li.BusinessUnitCode = Convert.ToInt32(((TextBox)row.FindControl("BusinessUnitCode")).Text);
                    }
                    else
                    {
                        display = "Business Unit Code cannot be empty";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (((TextBox)row.FindControl("BusinessUnitName")).Text != string.Empty)
                    {
                        li.BusinessUnitName = Convert.ToString(((TextBox)row.FindControl("BusinessUnitName")).Text);
                    }
                    else
                    {
                        display = "Business Unit Name cannot be empty";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (((DropDownList)row.FindControl("BusinessUnitManagerName")).SelectedValue != "Select One")
                    {
                        li.BusinessUnitManagerName = ((DropDownList)row.FindControl("BusinessUnitManagerName")).SelectedValue;
                    }
                    else
                    {
                        display = "Select Business Unit Manager Name from dropdown";
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
                    else
                    {
                        display = "Expiration Date cannot be empty";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (li.ExpirationDate < li.EffectiveDate)
                    {
                        display = "Expiration Date must be after Effective date";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (isFormFilled)
                    {
                        if (memberships == 1 || memberships == 2)
                        {
                            DataSet result = li.UpdateSKPickingBoard(li, memberships);

                            string res = Convert.ToString(result.Tables[0].Rows[0].ItemArray[0]);

                            if (res.Equals("Duplicate BusinessUnitCode"))
                            {
                                display = "BusinessUnit Code already exists in the database";
                                ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                            }
                            else if (res.Equals("Duplicate BusinessUnitName"))
                            {
                                display = "BusinessUnit Name already exists in the database";
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
                    //if (memberships > 0)
                    //{
                    //    li.UpdateSKPickingBoard(li, memberships);
                    //}
                    //else
                    //{
                    //    string display = "You must be a member of SK_Picking _Operations or SK_Picking_Warehouse groups to make changes.";
                    //    ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + display + "');", true);
                    //}

                }
                catch (Exception ex)
                {
                    throw ex;
                }

                BusinessUnitGridView.EditIndex = -1;
                BindGridView();
            }
        }

        protected void BusinessUnit_SortData(object sender, GridViewSortEventArgs e)
        {
            if (BusinessUnitGridView.EditIndex >= -1)
            {
                BusinessUnitGridView.EditIndex = -1;
            }
            BindGridView();
            SortGrid(sender, e);
        }

        protected void BusinessUnit_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && BusinessUnitGridView.EditIndex == e.Row.RowIndex)
            {
                BusinessUnitReportingChild li = new BusinessUnitReportingChild();

                //Find the DropDownList in the Row
                DropDownList ddlBusinessUnitManagerNameList = (e.Row.FindControl("BusinessUnitManagerName") as DropDownList);
                ddlBusinessUnitManagerNameList.DataSource = li.BusinessUnitManagerNameList().Tables[0];
                ddlBusinessUnitManagerNameList.DataTextField = "BusinessUnitManagerName";
                ddlBusinessUnitManagerNameList.DataValueField = "BusinessUnitManagerName";
                ddlBusinessUnitManagerNameList.DataBind();

                //Add Default Item in the DropDownList
                ddlBusinessUnitManagerNameList.Items.Insert(0, new ListItem("Select One"));

                //Select the Country of Customer in DropDownList
                string businessUnitManagerNames = (e.Row.FindControl("lblBusinessUnitManagerName") as Label).Text;
                ListItem item = ddlBusinessUnitManagerNameList.Items.FindByValue(businessUnitManagerNames);
                if (item != null)
                {
                    ddlBusinessUnitManagerNameList.SelectedValue = businessUnitManagerNames;

                }

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

        protected void BusinessUnit_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (BusinessUnitGridView.EditIndex >= -1)
            {
                BusinessUnitGridView.EditIndex = -1;
            }
            BindGridView();
            PageGrid(sender, e);
        }
        
        protected void chkBoxResetCheckedChanged(object sender, EventArgs e)
        {
            if (BusinessUnitGridView.EditIndex >= -1)
            {
                BusinessUnitGridView.EditIndex = -1;
            }
            ddlBusinessUnitName.SelectedIndex = 0;
            ddlBusinessUnitManagerName.SelectedIndex = 0;
            ddlCompanyName.SelectedIndex = 0;
            BindGridView();
        }

        #endregion
  protected void btnSaveNewBusinessUnit_Click(object sender, EventArgs e)
        {
            bool isFormFilled = true;
            string display = "";
            BusinessUnitReportingChild li = new BusinessUnitReportingChild();
            string businessUnitCode = newBusinessUnitCode.Text;
            string businessUnitName = newBusinessUnitName.Text;
            string businessUnitManagerName = newBusinessUnitManagerName.Text;
            string companyName = newCompanyName.Text;
            string effectiveDate = Request.Form[newEffectiveDate.UniqueID];
            
          
            if (String.IsNullOrEmpty(effectiveDate) || String.IsNullOrEmpty(businessUnitCode) 
                || String.IsNullOrEmpty(businessUnitName) || String.IsNullOrEmpty(businessUnitManagerName) || String.IsNullOrEmpty(companyName))
            {
                display = "Please select all the mandatory fields ";
                ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                isFormFilled = false;
            }
            

            if (isFormFilled)
            {
                if (memberships == 1 || memberships == 2)
                {
                    DataSet result = li.AddNewBusinessUnit(businessUnitCode, businessUnitName, businessUnitManagerName, companyName, effectiveDate);

                    string res = Convert.ToString(result.Tables[0].Rows[0].ItemArray[0]);

                    if (res.Equals("Duplicate BusinessUnitCode"))
                    {
                        display = "Business Unit Code already exists in the database";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }
                    else if (res.Equals("Duplicate BusinessUnitName"))
                    {
                        display = "Business Unit Name already exists in the database";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }
                    else if (res.Equals("Success"))
                    {
                        display = "A new Business Unit is successfully added in the database";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = true;
                    }
                    if (isFormFilled)
                    {
                        newBusinessUnitCode.Text = "";
                        newBusinessUnitName.Text = "";
                        ddlBusinessUnitManagerName.DataSource = li.BusinessUnitManagerNameList().Tables[0];
                        ddlBusinessUnitManagerName.DataTextField = "BusinessUnitManagerName";
                        ddlBusinessUnitManagerName.DataBind();

                        ddlCompanyName.DataSource = li.CompanyNameList().Tables[0];
                        ddlCompanyName.DataTextField = "CompanyName";
                        ddlCompanyName.DataBind();
                        BindGridView();
                    }
                }

                else
                {
                    display = "You must be a member of Consolidated Sales Reporting – Admin or Consolidated Sales Reporting – Finance  groups to Add New Business Units.";
                    ClientScript.RegisterStartupScript(this.GetType(), "yourMessage", "alert('" + display + "');", true);
                }
            }
        }

        protected void btnAddNewBusinessUnit_Click(object sender, EventArgs e)
        {
            ModalPopupExtender1.Show();
        }

        protected void ddl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (BusinessUnitGridView.EditIndex >= -1)
            {
                BusinessUnitGridView.EditIndex = -1;
            }
            BindGridView();
        }

        private void BindGridView()
        {
            int count;
            BusinessUnitReportingChild obj = new BusinessUnitReportingChild();
           
            string businessUnitName = ddlBusinessUnitName.SelectedValue.ToString();
            string businessUnitManagerName = ddlBusinessUnitManagerName.SelectedValue.ToString();
            string companyName = ddlCompanyName.SelectedValue.ToString();
            DataSet ds = obj.GetSKPickingBoard2(businessUnitName, businessUnitManagerName, companyName);// businessUnitManagerName, companyName);// fromDate, toDate, period, fromQuantity, toQuantity, fromAmount, toAmount, adjustmentType, countryName, subBusinessUnitName, companyName, subSegmentName, accountSubTypeName, subCategoryName, rblMeasurementSystemText);
            BusinessUnitGridView.DataSource = ds.Tables[0];
            BusinessUnitGridView.DataBind();
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
            BusinessUnitReportingChild obj = new BusinessUnitReportingChild();
            DataSet ds = obj.GetSKPickingBoard2("Select One", "Select One", "Select One");
            WorkbookEngine we = new WorkbookEngine();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                if (dr.IsNull("ExpirationDate"))
                {
                    dr.Delete();
                }
                //DateTime expirationDate = Convert.ToDateTime(dr["ExpirationDate"].ToString());
            }
            we.ExportDataSetToExcel(ds.Tables[0], "BusinessUnit Reporting");
        }

        protected void btnexcelDownload_Click(object sender, EventArgs e)
        {
            ModalPopupExtender2.Hide();
            BusinessUnitReportingChild obj = new BusinessUnitReportingChild();
            DataSet ds = obj.GetSKPickingBoard2("Select One", "Select One", "Select One");
            WorkbookEngine we = new WorkbookEngine();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                if (!dr.IsNull("ExpirationDate"))
                {
                    dr.Delete();
                }
                //DateTime expirationDate = Convert.ToDateTime(dr["ExpirationDate"].ToString());
            }
            we.ExportDataSetToExcel(ds.Tables[0], "BusinessUnit Reporting");
        }
    }
}