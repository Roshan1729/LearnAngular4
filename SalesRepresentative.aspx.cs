using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace SalesReportingWebsite
{
    public partial class SalesRepresentative : PageBase
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
                if (memberships == 1 || memberships == 4)
                {
                    SalesRepresentativeReportingChild li = new SalesRepresentativeReportingChild();

                    DataTable table = new DataTable();

                    ddlSalesRepLastName.DataSource = li.LastNameList().Tables[0];
                    ddlSalesRepLastName.DataTextField = "SalesRepLastName";
                    ddlSalesRepLastName.DataBind();

                    ddlSalesRepTypeName.DataSource = li.SalesRepTypeNameList().Tables[0];
                    ddlSalesRepTypeName.DataTextField = "SalesRepTypeName";
                    ddlSalesRepTypeName.DataBind();

                    newSalesRepTypeName.DataSource = ddlSalesRepTypeName.DataSource;
                    newSalesRepTypeName.DataTextField = "SalesRepTypeName";
                    newSalesRepTypeName.DataBind();

                    ddlTerritoryName.DataSource = li.TerritoryNameList().Tables[0];
                    ddlTerritoryName.DataTextField = "TerritoryName";
                    ddlTerritoryName.DataBind();

                    newTerritoryName.DataSource = ddlTerritoryName.DataSource;
                    newTerritoryName.DataTextField = "TerritoryName";
                    newTerritoryName.DataBind();

                    ddlRegionName.DataSource = li.RegionNameList().Tables[0];
                    ddlRegionName.DataTextField = "RegionName";
                    ddlRegionName.DataBind();

                    newRegionName.DataSource = ddlRegionName.DataSource;
                    newRegionName.DataTextField = "RegionName";
                    newRegionName.DataBind();

                    ddlDistributionRegionName.DataSource = li.DistributionRegionNameList().Tables[0];
                    ddlDistributionRegionName.DataTextField = "DistributionRegionName";
                    ddlDistributionRegionName.DataBind();

                    newDistributionRegionName.DataSource = ddlDistributionRegionName.DataSource;
                    newDistributionRegionName.DataTextField = "DistributionRegionName";
                    newDistributionRegionName.DataBind();

                    ddlSubBusinessUnitName.DataSource = li.SubBusinessUnitNameList().Tables[0];
                    ddlSubBusinessUnitName.DataTextField = "SubBusinessUnitName";
                    ddlSubBusinessUnitName.DataBind();

                    newSubBusinessUnitName.DataSource = ddlSubBusinessUnitName.DataSource;
                    newSubBusinessUnitName.DataTextField = "SubBusinessUnitName";
                    newSubBusinessUnitName.DataBind();

                    ddlBusinessUnitName.DataSource = li.BusinessUnitNameList().Tables[0];
                    ddlBusinessUnitName.DataTextField = "BusinessUnitName";
                    ddlBusinessUnitName.DataBind();

                    newBusinessUnitName.DataSource = ddlBusinessUnitName.DataSource;
                    newBusinessUnitName.DataTextField = "BusinessUnitName";
                    newBusinessUnitName.DataBind();

                    ddlCompanyName.DataSource = li.CompanyNameList().Tables[0];
                    ddlCompanyName.DataTextField = "CompanyName";
                    ddlCompanyName.DataBind();

                    newCompanyName.DataSource = ddlCompanyName.DataSource;
                    newCompanyName.DataTextField = "CompanyName";
                    newCompanyName.DataBind();


                    newCountryName.DataSource = li.CountryNameList().Tables[0];
                    newCountryName.DataTextField = "CountryName";
                    newCountryName.DataBind();


                    newStateProvinceName.DataSource = li.StateProvinceNameList().Tables[0];
                    newStateProvinceName.DataTextField = "StateProvinceName";
                    newStateProvinceName.DataBind();


                    //newCustomerNumber.DataSource = li.CustomerNumberList().Tables[0];
                    //newCustomerNumber.DataTextField = "CustomerID";
                    //newCustomerNumber.DataBind();

                    BindGridView();
                }
            }
        }

        #region EventHandling

        [WebMethod]
        public static string[] SearchCustomers(string prefix)
        {
            SalesRepresentativeReportingChild li = new SalesRepresentativeReportingChild();
            List<string> customers = new List<string>();
            customers = li.SuggestCustomers(prefix, 0);
            return customers.ToArray(); ;
        }



        protected void chkBoxResetCheckedChanged(object sender, EventArgs e)
        {
            if (SalesRepresentativeGridView.EditIndex >= -1)
            {
                SalesRepresentativeGridView.EditIndex = -1;
            }

            ddlSalesRepLastName.SelectedIndex = 0;
            ddlSalesRepTypeName.SelectedIndex = 0;
            ddlTerritoryName.SelectedIndex = 0;
            ddlRegionName.SelectedIndex = 0;
            ddlDistributionRegionName.SelectedIndex = 0;
            ddlSubBusinessUnitName.SelectedIndex = 0;
            ddlBusinessUnitName.SelectedIndex = 0;
            ddlCompanyName.SelectedIndex = 0;
            BindGridView();
        }

        protected void SalesRepresentative_RowEditing(object sender, GridViewEditEventArgs e)
        {
            SalesRepresentativeGridView.EditIndex = e.NewEditIndex;

            int index = e.NewEditIndex;
            GridViewRow row = SalesRepresentativeGridView.Rows[e.NewEditIndex];

            BindGridView();
        }

        protected void SalesRepresentative_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            SalesRepresentativeGridView.EditIndex = -1;

            BindGridView();
        }



        protected void SalesRepresentative_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if (Page.IsValid)
            {
                SalesRepresentativeReportingChild li = new SalesRepresentativeReportingChild();
                GridViewRow row = SalesRepresentativeGridView.Rows[e.RowIndex];
                string display = "";
                bool isFormFilled = true;
                try
                {
                    li.SalesRepContactID = Convert.ToInt32(SalesRepresentativeGridView.DataKeys[e.RowIndex].Values[0]);
                    li.SalesRepFirstName = Convert.ToString(((TextBox)row.FindControl("SalesRepFirstName")).Text);
                    li.SalesRepLastName = Convert.ToString(((TextBox)row.FindControl("SalesRepLastName")).Text);
                    //if (((TextBox)row.FindControl("SalesRepFirstName")).Text != string.Empty)
                    //{
                    //    li.SalesRepFirstName = Convert.ToString(((TextBox)row.FindControl("SalesRepFirstName")).Text);
                    //}


                    //else
                    //{
                    //    display = "SalesRep FirstName cannot be empty";
                    //    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                    //    isFormFilled = false;
                    //}

                    //if (((TextBox)row.FindControl("SalesRepLastName")).Text != string.Empty)
                    //{
                    //    li.SalesRepLastName = Convert.ToString(((TextBox)row.FindControl("SalesRepLastName")).Text);
                    //}


                    //else
                    //{
                    //    display = "SalesRep LastName cannot be empty";
                    //    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                    //    isFormFilled = false;
                    //}




                    if (((TextBox)row.FindControl("Title")).Text != string.Empty)
                    {
                        li.Title = Convert.ToString(((TextBox)row.FindControl("Title")).Text);
                    }
                   

                    if (!String.IsNullOrEmpty(Convert.ToString((Request.Form[row.FindControl("DemoSigned").UniqueID]))))
                    {
                        li.DemoSigned = Convert.ToDateTime((Request.Form[row.FindControl("DemoSigned").UniqueID]));
                    }
                  

                    if (((TextBox)row.FindControl("SalesRepCompanyName")).Text != string.Empty)
                    {
                        li.SalesRepCompanyName = Convert.ToString(((TextBox)row.FindControl("SalesRepCompanyName")).Text);
                    }
                  

                    if (((DropDownList)row.FindControl("CompanyName")).SelectedValue != "Select One")
                    {
                        li.CompanyName = ((DropDownList)row.FindControl("CompanyName")).SelectedValue;
                    }
                    else
                    {
                        display = "CompanyName from dropdown";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (((DropDownList)row.FindControl("SalesRepTypeName")).SelectedValue != "Select One")
                    {
                        li.SalesRepTypeName = ((DropDownList)row.FindControl("SalesRepTypeName")).SelectedValue;
                    }
                    else
                    {
                        display = "Select SalesRepTypeName from dropdown";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (((DropDownList)row.FindControl("TerritoryName")).SelectedValue != "Select One")
                    {
                        li.TerritoryName = ((DropDownList)row.FindControl("TerritoryName")).SelectedValue;
                    }
                    else
                    {
                        display = "Select TerritoryName from dropdown";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }


                    if (((DropDownList)row.FindControl("RegionName")).SelectedValue != "Select One")
                    {
                        li.RegionName = ((DropDownList)row.FindControl("RegionName")).SelectedValue;
                    }
                    else
                    {
                        display = "Select RegionName from dropdown";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }


                    if (((DropDownList)row.FindControl("SubBusinessUnitName")).SelectedValue != "Select One")
                    {
                        li.SubBusinessUnitName = ((DropDownList)row.FindControl("SubBusinessUnitName")).SelectedValue;
                    }
                    else
                    {
                        display = "Select SubBusinessUnitName from dropdown";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }


                    if (((DropDownList)row.FindControl("BusinessUnitName")).SelectedValue != "Select One")
                    {
                        li.BusinessUnitName = ((DropDownList)row.FindControl("BusinessUnitName")).SelectedValue;
                    }
                    else
                    {
                        display = "Select BusinessUnitName from dropdown";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }


                

                    if (((TextBox)row.FindControl("FaxNumber")).Text != string.Empty)
                    {
                        li.FaxNumber = Convert.ToString(((TextBox)row.FindControl("FaxNumber")).Text);
                    }
                    
                    if (((TextBox)row.FindControl("MobilePhone")).Text != string.Empty)
                    {
                        li.MobilePhone = Convert.ToString(((TextBox)row.FindControl("MobilePhone")).Text);
                    }
                   

                    if (((TextBox)row.FindControl("PersonalCellPhone")).Text != string.Empty)
                    {
                        li.PersonalCellPhone = Convert.ToString(((TextBox)row.FindControl("PersonalCellPhone")).Text);
                    }
                   

                    if (((TextBox)row.FindControl("InternationalPhone")).Text != string.Empty)
                    {
                        li.InternationalPhone = Convert.ToString(((TextBox)row.FindControl("InternationalPhone")).Text);
                    }
                   

                    if (((TextBox)row.FindControl("InternationalCell")).Text != string.Empty)
                    {
                        li.InternationalCell = Convert.ToString(((TextBox)row.FindControl("InternationalCell")).Text);
                    }
                   
                    if (((TextBox)row.FindControl("PrimaryEmail")).Text != string.Empty)
                    {
                        li.PrimaryEmail = Convert.ToString(((TextBox)row.FindControl("PrimaryEmail")).Text);
                    }
                    else
                    {
                        display = "PrimaryEmail cannot be empty";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (((TextBox)row.FindControl("SecondaryEmail")).Text != string.Empty)
                    {
                        li.SecondaryEmail = Convert.ToString(((TextBox)row.FindControl("SecondaryEmail")).Text);
                    }
                 

                    if (!String.IsNullOrEmpty(Convert.ToString((Request.Form[row.FindControl("HireDate").UniqueID]))))
                    {
                        li.HireDate = Convert.ToDateTime((Request.Form[row.FindControl("HireDate").UniqueID]));
                    }
                    else
                    {
                        display = "HireDate Date cannot be empty";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (!String.IsNullOrEmpty(Convert.ToString((Request.Form[row.FindControl("TerminationDate").UniqueID]))))
                    {
                        li.TerminationDate = Convert.ToDateTime((Request.Form[row.FindControl("TerminationDate").UniqueID]));
                    }
                    else
                    {
                        display = "Hire Date cannot be empty";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (li.HireDate  > li.TerminationDate)
                    {
                        display = "Termination Date must be after Hire date";
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        isFormFilled = false;
                    }

                    if (isFormFilled)
                    {
                        DataSet result = li.UpdateSKPickingBoard(li, memberships);

                        string res = Convert.ToString(result.Tables[0].Rows[0].ItemArray[0]);

                        //if (res.Equals("Duplicate CompanyKey"))
                        //{
                        //    display = "Company Key already exists in the database";
                        //    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        //    isFormFilled = false;
                        //}
                        //else if (res.Equals("Duplicate CompanyName"))
                        //{
                        //    display = "Company Name already exists in the database";
                        //    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                        //    isFormFilled = false;
                        //}

                        if (res.Equals("Success"))
                        {

                        }
                    }


                }
                catch (Exception ex)
                {
                    throw ex;
                }

                SalesRepresentativeGridView.EditIndex = -1;

                BindGridView();
            }
        }

        protected void SalesRepresentative_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && SalesRepresentativeGridView.EditIndex == e.Row.RowIndex)
            {
                SalesRepresentativeReportingChild li = new SalesRepresentativeReportingChild();

                //Find the DropDownList in the Row
                DropDownList ddlSalesRepTypeNameList = (e.Row.FindControl("SalesRepTypeName") as DropDownList);
                ddlSalesRepTypeNameList.DataSource = li.SalesRepTypeNameList().Tables[0];
                ddlSalesRepTypeNameList.DataTextField = "SalesRepTypeName";
                ddlSalesRepTypeNameList.DataValueField = "SalesRepTypeName";
                ddlSalesRepTypeNameList.DataBind();

                //Add Default Item in the DropDownList
                ddlSalesRepTypeNameList.Items.Insert(0, new ListItem("Select One"));

                //Select the Country of Customer in DropDownList
                string salesRepTypeNames = (e.Row.FindControl("lblSalesRepTypeName") as Label).Text;
                ddlSalesRepTypeNameList.Items.FindByValue(salesRepTypeNames).Selected = true;

                //Find the DropDownList in the Row
                DropDownList ddlTerritoryNameList = (e.Row.FindControl("TerritoryName") as DropDownList);
                ddlTerritoryNameList.DataSource = li.TerritoryNameList().Tables[0];
                ddlTerritoryNameList.DataTextField = "TerritoryName";
                ddlTerritoryNameList.DataValueField = "TerritoryName";
                ddlTerritoryNameList.DataBind();

                //Add Default Item in the DropDownList
                ddlTerritoryNameList.Items.Insert(0, new ListItem("Select One"));

                //Select the Country of Customer in DropDownList
                string territoryNames = (e.Row.FindControl("lblTerritoryName") as Label).Text;
                ListItem item = ddlTerritoryNameList.Items.FindByValue(territoryNames);

                if (item != null)
                {
                    ddlTerritoryNameList.SelectedValue = territoryNames;

                }

                //Find the DropDownList in the Row
                DropDownList ddlRegionNameList = (e.Row.FindControl("RegionName") as DropDownList);
                ddlRegionNameList.DataSource = li.RegionNameList().Tables[0];
                ddlRegionNameList.DataTextField = "RegionName";
                ddlRegionNameList.DataValueField = "RegionName";
                ddlRegionNameList.DataBind();

                //Add Default Item in the DropDownList
                ddlRegionNameList.Items.Insert(0, new ListItem("Select One"));

                //Select the Country of Customer in DropDownList
                string regionNames = (e.Row.FindControl("lblRegionName") as Label).Text;
                ListItem item1 = ddlRegionNameList.Items.FindByValue(regionNames);

                if (item1 != null)
                {
                    ddlRegionNameList.SelectedValue = regionNames;

                }


                //DropDownList ddlDistributionRegionNameList = (e.Row.FindControl("DistributionRegionName") as DropDownList);
                //ddlDistributionRegionNameList.DataSource = li.DistributionRegionNameList().Tables[0];
                //ddlDistributionRegionNameList.DataTextField = "DistributionRegionName";
                //ddlDistributionRegionNameList.DataValueField = "DistributionRegionName";
                //ddlDistributionRegionNameList.DataBind();

                ////Add Default Item in the DropDownList
                //ddlDistributionRegionNameList.Items.Insert(0, new ListItem("Select One"));

                ////Select the Country of Customer in DropDownList
                //string distributionRegionNames = (e.Row.FindControl("lblDistributionRegionName") as Label).Text;
                //ddlDistributionRegionNameList.Items.FindByValue(distributionRegionNames).Selected = true;


                //Find the DropDownList in the Row
                DropDownList ddlSubBusinessUnitNameList = (e.Row.FindControl("SubBusinessUnitName") as DropDownList);
                ddlSubBusinessUnitNameList.DataSource = li.SubBusinessUnitNameList().Tables[0];
                ddlSubBusinessUnitNameList.DataTextField = "SubBusinessUnitName";
                ddlSubBusinessUnitNameList.DataValueField = "SubBusinessUnitName";
                ddlSubBusinessUnitNameList.DataBind();

                //Add Default Item in the DropDownList
                ddlSubBusinessUnitNameList.Items.Insert(0, new ListItem("Select One"));

                //Select the Country of Customer in DropDownList
                string subBusinessUnitNames = (e.Row.FindControl("lblSubBusinessUnitName") as Label).Text;
                ListItem item2 = ddlSubBusinessUnitNameList.Items.FindByValue(subBusinessUnitNames);

                if (item2 != null)
                {
                    ddlSubBusinessUnitNameList.SelectedValue = subBusinessUnitNames;

                }


                //Find the DropDownList in the Row
                DropDownList ddlBusinessUnitNameList = (e.Row.FindControl("BusinessUnitName") as DropDownList);
                ddlBusinessUnitNameList.DataSource = li.BusinessUnitNameList().Tables[0];
                ddlBusinessUnitNameList.DataTextField = "BusinessUnitName";
                ddlBusinessUnitNameList.DataValueField = "BusinessUnitName";
                ddlBusinessUnitNameList.DataBind();

                //Add Default Item in the DropDownList
                ddlBusinessUnitNameList.Items.Insert(0, new ListItem("Select One"));

                //Select the Country of Customer in DropDownList
                string businessUnitNames = (e.Row.FindControl("lblBusinessUnitName") as Label).Text;
                ListItem item3 = ddlBusinessUnitNameList.Items.FindByValue(businessUnitNames);

                if (item3 != null)
                {
                    ddlBusinessUnitNameList.SelectedValue = businessUnitNames;

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

        protected void SalesRepresentative_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (SalesRepresentativeGridView.EditIndex >= -1)
            {
                SalesRepresentativeGridView.EditIndex = -1;
            }
            BindGridView();
            PageGrid(sender, e);
        }

        protected void SalesRepresentative_SortData(object sender, GridViewSortEventArgs e)
        {
            if (SalesRepresentativeGridView.EditIndex >= -1)
            {
                SalesRepresentativeGridView.EditIndex = -1;
            }

            BindGridView();
            SortGrid(sender, e);
        }

        #endregion
        protected void btnSaveNewSalesRepresentative_Click(object sender, EventArgs e)
        {
            bool isFormFilled = true;
            string display = "";
            SalesRepresentativeReportingChild li = new SalesRepresentativeReportingChild();

            li.SalesRepFirstName = newSalesRepFirstName.Text;
            li.SalesRepLastName = newSalesRepLastName.Text;
            li.Title = newTitle.Text;
            if (!String.IsNullOrEmpty(Convert.ToString((Request.Form[newHireDate.UniqueID]))))
            {
                li.HireDate = Convert.ToDateTime((Request.Form[newHireDate.UniqueID]));
            }
            if (!String.IsNullOrEmpty(Convert.ToString((Request.Form[newDemoSigned.UniqueID]))))
            {
                li.DemoSigned = Convert.ToDateTime((Request.Form[newDemoSigned.UniqueID]));
            }
            //if (!String.IsNullOrEmpty(Convert.ToString((Request.Form[newEffectiveDate.UniqueID]))))
            //{
            //    li.EffectiveDate = Convert.ToDateTime((Request.Form[newEffectiveDate.UniqueID]));
            //}
            if (!String.IsNullOrEmpty(Convert.ToString((Request.Form[newTerminationDate.UniqueID]))))
            {
                li.TerminationDate = Convert.ToDateTime((Request.Form[newTerminationDate.UniqueID]));
            }

            //    li.CustomerID = Convert.ToInt32(newCustomerNumber.Text);



            //li.VoiceMailPin = Convert.ToInt32(newVoiceMailPin.Text);

            li.Notes = newNotes.Text;
            //  li.VendorID = newVendorNumber.Text;
            li.SalesRepCompanyName = newSalesRepCompany.Text;
            li.InventoryNotes = newInventoryNotes.Text;
            li.SalesRepTypeName = newSalesRepTypeName.SelectedValue.ToString();
            li.TerritoryName = newTerritoryName.SelectedValue.ToString();
            li.RegionName = newRegionName.SelectedValue.ToString();
            li.DistributionRegionName = newDistributionRegionName.SelectedValue.ToString();
            li.SubBusinessUnitName = newSubBusinessUnitName.SelectedValue.ToString();
            li.BusinessUnitName = newBusinessUnitName.SelectedValue.ToString();
            li.CompanyName = newCompanyName.SelectedValue.ToString();
            li.Address1 = newAddress1.Text;
            li.Address2 = newAddress2.Text;
            li.Address3 = newAddress3.Text;
            li.City = newCity.Text;
            li.Address1 = newCustomerNumber.Text;
            li.StateProvinceName = newStateProvinceName.SelectedValue.ToString();
            li.PostalCode = newPostalCode.Text;
            li.CountryName = newCountryName.SelectedValue.ToString();
            // li.CustomerID = newCustomerNumber.SelectedValue.ToString();
            li.WorkPhone = newWorkPhone.Text;
            //  li.VoiceMailExtension = newVoiceMailExtension.Text;
            //li.VoiceMailPin = newVoiceMailPin.Text;
            li.FaxNumber = newFaxNumber.Text;
            li.MobilePhone = newMobilePhone.Text;
            //  li.Pager = newPager.Text;
            li.PersonalCellPhone = newPersonalCellPhone.Text;
            li.InternationalPhone = newInternationalPhone.Text;
            // li.InternationalFax = newInternationalFax.Text;
            li.InternationalCell = newInternationalCell.Text;
            li.PrimaryEmail = newPrimaryEmail.Text;
            li.SecondaryEmail = newSecondaryEmail.Text;
            //li.GlobalAddress = newGlobalAddress.SelectedValue.ToString();

            if (String.IsNullOrEmpty(li.SalesRepFirstName)
               || String.IsNullOrEmpty(li.SalesRepLastName) || String.IsNullOrEmpty(li.SalesRepTypeName))
            {
                display = "Please select all the mandatory fields ";
                ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                isFormFilled = false;
            }


            if (isFormFilled)
            {
                // DataSet result = li.AddNewSalesRepresentative(salesRepFirstName, salesRepLastName, title, hireDate, terminationDate, notes, vendorID, salesRepCompanyName, demoSigned,
                //     effectiveDate, inventoryNotes, salesRepTypeName, territoryName, regionName, distributionRegionName, subBusinessUnitName, businessUnitName, companyName, address1, address2, address3,
                //     city, stateProvinceName, postalCode, countryName, customerID, workPhone, voiceMailExtension, voiceMailPin, faxNumber, mobilePhone, pager, personalCellPhone, internationalPhone, internationalFax,
                //     internationalCell, primaryEmail, secondaryEmail, globaladdress);

                DataSet result = li.AddNewSalesRepresentative(li);

                string res = Convert.ToString(result.Tables[0].Rows[0].ItemArray[0]);

                if (res.Equals("Success"))
                {
                    display = "A new Sales Representative is successfully added in the database";
                    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('" + display + "');", true);
                    isFormFilled = true;
                }
                if (isFormFilled)
                {
                    newSalesRepFirstName.Text = "";
                    newSalesRepLastName.Text = "";
                    newTitle.Text = "";
                    newNotes.Text = "";
                    //  newVendorNumber.Text = "";
                    newSalesRepCompany.Text = "";
                    newInventoryNotes.Text = "";
                    newSalesRepTypeName.SelectedIndex = 0;
                    newTerritoryName.SelectedIndex = 0;
                    BindGridView();
                }
            }
        }
        protected void OnSelectedTypeIndexChanged(object sender, EventArgs e)
        {
            string territoryName = newTerritoryName.SelectedValue.ToString();

            SalesRepresentativeReportingChild li = new SalesRepresentativeReportingChild();
            newBusinessUnitName.Items.Clear();
            newBusinessUnitName.Items.Insert(0, new ListItem("Select One"));
            newBusinessUnitName.DataSource = li.NewBusinessUnitNameList(territoryName).Tables[0];
            newBusinessUnitName.DataTextField = "BusinessUnitName";
            newBusinessUnitName.DataBind();

            newSubBusinessUnitName.Items.Clear();
            newSubBusinessUnitName.Items.Insert(0, new ListItem("Select One"));
            newSubBusinessUnitName.DataSource = li.NewSubBusinessUnitNameList(territoryName).Tables[0];
            newSubBusinessUnitName.DataTextField = "SubBusinessUnitName";
            newSubBusinessUnitName.DataBind();

            newCompanyName.Items.Clear();
            newCompanyName.Items.Insert(0, new ListItem("Select One"));
            newCompanyName.DataSource = li.NewCompanyNameList(territoryName).Tables[0];
            newCompanyName.DataTextField = "CompanyName";
            newCompanyName.DataBind();


            newRegionName.Items.Clear();
            newRegionName.Items.Insert(0, new ListItem("Select One"));
            newRegionName.DataSource = li.NewRegionNameList(territoryName).Tables[0];
            newRegionName.DataTextField = "RegionName";
            newRegionName.DataBind();


            ModalPopupExtender1.Show();

        }

        //protected void ddlNewTerritoryName(object sender, EventArgs e)
        //{
        //    ModalPopupExtender1.Show();
        //    btnSaveNewSalesRepresentative.Enabled = false;
        //    SalesRepresentativeReportingChild li = new SalesRepresentativeReportingChild();
        //    DataSet ds = li.GetTerritoryNameRelatedData(newTerritoryName.SelectedValue.ToString());

        //    DropDownList ddlAdjustmentTypeNameList = (FindControl("ddlTerritoryName") as DropDownList);

        //    newRegionName.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["RegionName"]);
        //    newCompanyName.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["CompanyName"]);
        //    newSubBusinessUnitName.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["SubBusinessUnitName"]);
        //    newBusinessUnitName.SelectedValue = Convert.ToString(ds.Tables[0].Rows[0]["BusinessUnitName"]);
        //    btnSaveNewSalesRepresentative.Enabled = true;

        //}



        protected void btnAddNewSalesRepresentative_Click(object sender, EventArgs e)
        {
            ModalPopupExtender1.Show();
        }

        protected void ddl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (SalesRepresentativeGridView.EditIndex >= -1)
            {
                SalesRepresentativeGridView.EditIndex = -1;
            }


            BindGridView();
        }

        private void BindGridView()
        {
            int count;
            SalesRepresentativeReportingChild obj = new SalesRepresentativeReportingChild();

            string companyName = ddlCompanyName.SelectedValue.ToString();
            string lastName = ddlSalesRepLastName.SelectedValue.ToString();
            string salesRepTypeName = ddlSalesRepTypeName.SelectedValue.ToString();
            string territoryName = ddlTerritoryName.SelectedValue.ToString();
            string regionName = ddlRegionName.SelectedValue.ToString();
            // string distributionRegionName = ddlDistributionRegionName.SelectedValue.ToString();
            string subBusinessUnitName = ddlSubBusinessUnitName.SelectedValue.ToString();
            string businessUnitName = ddlBusinessUnitName.SelectedValue.ToString();

            DataSet ds = obj.GetSKPickingBoard2(lastName, salesRepTypeName, territoryName, regionName, subBusinessUnitName, businessUnitName, companyName);//distributionRegionName,
            SalesRepresentativeGridView.DataSource = ds.Tables[0];
            SalesRepresentativeGridView.DataBind();
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
            SalesRepresentativeReportingChild obj = new SalesRepresentativeReportingChild();
            DataSet ds = obj.GetSKPickingBoard2("Select One", "Select One", "Select One", "Select One", "Select One", "Select One", "Select One");//, "Select One");

            WorkbookEngine we = new WorkbookEngine();
            we.ExportDataSetToExcel(ds.Tables[0], "Sales Representative Reporting");
        }
    }
}
