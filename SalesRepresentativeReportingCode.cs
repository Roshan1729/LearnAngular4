﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for LowInventory
/// </summary>
public abstract class SalesRepresentativeReportingCode
{
    public SalesRepresentativeReportingCode()
    {

        _SalesRepID = 0;
        _SalesRepLastName = String.Empty;
        _SalesRepTypeID = 0;
        _SalesRepTypeName = String.Empty;
        _TerritoryName = String.Empty;
        _RegionName = String.Empty;
        _DistributionRegionName = String.Empty;
        _SubBusinessUnitName = String.Empty;
        _BusinessUnitName = String.Empty;
        _CompanyName = String.Empty;
        _SalesRepFirstName = String.Empty;
        _Title = String.Empty;
        _HireDate = DateTime.MinValue;
        _TerminationDate = DateTime.MinValue;
        _Notes = String.Empty;
        _VendorID = String.Empty;
        _SalesRepCompanyName = String.Empty;
        _DemoSigned = DateTime.MinValue;
        _TerritoryID = 0;
        _RegionID = 0;
        _DistributionRegionID = 0;
        _SubBusinessUnitID = 0;
        _SalesRepContactID = 0;
        _BusinessUnitID = 0;
        _CompanyID = 0;
        _CustomerID = 0;
        _CustomerNumber = String.Empty;
        _Address1 = String.Empty;
        _Address2 = String.Empty;
        _Address3 = String.Empty;
        _City = String.Empty;
        _StateProvinceID = 0;
        _PostalCodeID = 0;
        _CountryID = 0;
        _StateProvinceName = String.Empty;
        _PostalCode = String.Empty;
        _CountryName = String.Empty;
        _WorkPhone = String.Empty;
        _VoiceMailExtension = String.Empty;
        _VoiceMailPin = 0;
        _FaxNumber = String.Empty;
        _MobilePhone = String.Empty;
        _Pager = String.Empty;
        _PersonalCellPhone = String.Empty;
        _InternationalPhone = String.Empty;
        _InternationalFax = String.Empty;
        _InternationalCell = String.Empty;
        _PrimaryEmail = String.Empty;
        _SecondaryEmail = String.Empty;
        _EffectiveDate = DateTime.MinValue;
        _ExpirationDate = DateTime.MinValue;
        _InventoryNotes = String.Empty;
        //   _GlobalAddress = String.Empty;

    }

    private string _InventoryNotes;
    // private string _GlobalAddress;
    private int _SalesRepID;
    private string _SalesRepLastName;
    private int _SalesRepTypeID;
    private string _SalesRepTypeName;
    public string _TerritoryName;
    public string _RegionName;
    public string _DistributionRegionName;
    public string _SubBusinessUnitName;
    public string _BusinessUnitName;
    private string _CompanyName;
    public string _SalesRepFirstName;
    public string _Title;
    private int _SalesRepContactID;
    private DateTime _HireDate;
    private DateTime _TerminationDate;
    public string _Notes;
    private string _VendorID;
    public string _SalesRepCompanyName;
    private DateTime _DemoSigned;
    private int _TerritoryID;
    private int _RegionID;
    private int _DistributionRegionID;
    private int _SubBusinessUnitID;
    private int _BusinessUnitID;
    private int _CompanyID;
    private int _CustomerID;
    private string _CustomerNumber;
    private string _Address1;
    private string _Address2;
    private string _Address3;
    private string _City;
    private int _StateProvinceID;
    private int _PostalCodeID;
    private int _CountryID;
    private string _StateProvinceName;
    private string _PostalCode;
    private string _CountryName;
    private string _WorkPhone;
    private int _VoiceMailPin;
    private string _VoiceMailExtension;
    private string _FaxNumber;
    private string _MobilePhone;
    private string _Pager;
    private string _PersonalCellPhone;
    private string _InternationalPhone;
    private string _InternationalFax;
    private string _InternationalCell;
    private string _PrimaryEmail;
    private string _SecondaryEmail;
    private DateTime _EffectiveDate;
    private DateTime _ExpirationDate;


    public string InventoryNotes
    {
        get { return _InventoryNotes; }
        set { _InventoryNotes = value; }
    }

    //public string _GlobalAddress
    //{
    //    get { return _GlobalAddress; }
    //    set { _GlobalAddress = value; }
    //}

    public int SalesRepID
    {
        get { return _SalesRepID; }
        set { _SalesRepID = value; }
    }

    public int SalesRepContactID
    {
        get { return _SalesRepContactID; }
        set { _SalesRepContactID = value; }
    }

    public string SalesRepLastName
    {
        get { return _SalesRepLastName; }
        set { _SalesRepLastName = value; }
    }

    public int SalesRepTypeID
    {
        get { return _SalesRepTypeID; }
        set { _SalesRepTypeID = value; }
    }

    public string SalesRepTypeName
    {
        get { return _SalesRepTypeName; }
        set { _SalesRepTypeName = value; }
    }

    public string TerritoryName
    {
        get { return _TerritoryName; }
        set { _TerritoryName = value; }
    }

    public string RegionName
    {
        get { return _RegionName; }
        set { _RegionName = value; }
    }

    public string DistributionRegionName
    {
        get { return _DistributionRegionName; }
        set { _DistributionRegionName = value; }
    }

    public string SubBusinessUnitName
    {
        get { return _SubBusinessUnitName; }
        set { _SubBusinessUnitName = value; }
    }

    public string BusinessUnitName
    {
        get { return _BusinessUnitName; }
        set { _BusinessUnitName = value; }
    }
    public string CompanyName
    {
        get { return _CompanyName; }
        set { _CompanyName = value; }
    }

    public string SalesRepFirstName
    {
        get { return _SalesRepFirstName; }
        set { _SalesRepFirstName = value; }
    }

    public string Title
    {
        get { return _Title; }
        set { _Title = value; }
    }
    public DateTime HireDate
    {
        get { return _HireDate; }
        set { _HireDate = value; }
    }
    public DateTime TerminationDate
    {
        get { return _TerminationDate; }
        set { _TerminationDate = value; }
    }
    public string Notes
    {
        get { return _Notes; }
        set { _Notes = value; }
    }

    public string VendorID
    {
        get { return _VendorID; }
        set { _VendorID = value; }
    }

    public string SalesRepCompanyName
    {
        get { return _SalesRepCompanyName; }
        set { _SalesRepCompanyName = value; }
    }

    public DateTime DemoSigned
    {
        get { return _DemoSigned; }
        set { _DemoSigned = value; }
    }


    public int TerritoryID
    {
        get { return _TerritoryID; }
        set { _TerritoryID = value; }
    }

    public int RegionID
    {
        get { return _RegionID; }
        set { _RegionID = value; }
    }

    public int DistributionRegionID
    {
        get { return _DistributionRegionID; }
        set { _DistributionRegionID = value; }
    }


    public int SubBusinessUnitID
    {
        get { return _SubBusinessUnitID; }
        set { _SubBusinessUnitID = value; }
    }


    public int BusinessUnitID
    {
        get { return _BusinessUnitID; }
        set { _BusinessUnitID = value; }
    }

    public int CompanyID
    {
        get { return _CompanyID; }
        set { _CompanyID = value; }
    }


    public int CustomerID
    {
        get { return _CustomerID; }
        set { _CustomerID = value; }
    }


    public string CustomerNumber
    {
        get { return _CustomerNumber; }
        set { _CustomerNumber = value; }
    }


    public string Address1
    {
        get { return _Address1; }
        set { _Address1 = value; }
    }

    public string Address2
    {
        get { return _Address2; }
        set { _Address2 = value; }
    }

    public string Address3
    {
        get { return _Address3; }
        set { _Address3 = value; }
    }


    public string City
    {
        get { return _City; }
        set { _City = value; }
    }

    public int StateProvinceID
    {
        get { return _StateProvinceID; }
        set { _StateProvinceID = value; }
    }

    public int PostalCodeID
    {
        get { return _PostalCodeID; }
        set { _PostalCodeID = value; }
    }

    public int CountryID
    {
        get { return _CountryID; }
        set { _CountryID = value; }
    }

    public string StateProvinceName
    {
        get { return _StateProvinceName; }
        set { _StateProvinceName = value; }
    }

    public string PostalCode
    {
        get { return _PostalCode; }
        set { _PostalCode = value; }
    }

    public string CountryName
    {
        get { return _CountryName; }
        set { _CountryName = value; }
    }

    public string WorkPhone
    {
        get { return _WorkPhone; }
        set { _WorkPhone = value; }
    }


    public int VoiceMailPin
    {
        get { return _VoiceMailPin; }
        set { _VoiceMailPin = value; }
    }


    public string VoiceMailExtension
    {
        get { return _VoiceMailExtension; }
        set { _VoiceMailExtension = value; }
    }

    public string FaxNumber
    {
        get { return _FaxNumber; }
        set { _FaxNumber = value; }
    }

    public string MobilePhone
    {
        get { return _MobilePhone; }
        set { _MobilePhone = value; }
    }

    public string Pager
    {
        get { return _Pager; }
        set { _Pager = value; }
    }

    public string PersonalCellPhone
    {
        get { return _PersonalCellPhone; }
        set { _PersonalCellPhone = value; }
    }

    public string InternationalPhone
    {
        get { return _InternationalPhone; }
        set { _InternationalPhone = value; }
    }

    public string InternationalFax
    {
        get { return _InternationalFax; }
        set { _InternationalFax = value; }
    }

    public string InternationalCell
    {
        get { return _InternationalCell; }
        set { _InternationalCell = value; }
    }

    public string PrimaryEmail
    {
        get { return _PrimaryEmail; }
        set { _PrimaryEmail = value; }
    }


    public string SecondaryEmail
    {
        get { return _SecondaryEmail; }
        set { _SecondaryEmail = value; }
    }
    public DateTime EffectiveDate
    {
        get { return _EffectiveDate; }
        set { _EffectiveDate = value; }
    }

    public DateTime ExpirationDate
    {
        get { return _ExpirationDate; }
        set { _ExpirationDate = value; }
    }



    public DataSet GetSKPickingBoard2(string salesRepLastName, string salesRepTypeName, string territoryName, string regionName, string subBusinessUnitName, string businessUnitName, string companyName)// string distributionRegionName,
    {
        DataSet ds = new DataSet();

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString()))
            try
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetSalesRepresentativeRecords", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (salesRepLastName == "Select One" || String.IsNullOrEmpty(salesRepLastName))
                    {
                        cmd.Parameters.AddWithValue("SalesRepLastName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("SalesRepLastName", salesRepLastName);
                    }

                    if (salesRepTypeName == "Select One" || String.IsNullOrEmpty(salesRepTypeName))
                    {
                        cmd.Parameters.AddWithValue("SalesRepTypeName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("SalesRepTypeName", salesRepTypeName);
                    }

                    if (territoryName == "Select One" || String.IsNullOrEmpty(territoryName))
                    {
                        cmd.Parameters.AddWithValue("TerritoryName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("TerritoryName", territoryName);
                    }

                    //if (distributionRegionName == "Select One" || String.IsNullOrEmpty(distributionRegionName))
                    //{
                    //    cmd.Parameters.AddWithValue("DistributionRegionName", DBNull.Value);
                    //}
                    //else
                    //{
                    //    cmd.Parameters.AddWithValue("DistributionRegionName", distributionRegionName);
                    //}

                    if (regionName == "Select One" || String.IsNullOrEmpty(regionName))
                    {
                        cmd.Parameters.AddWithValue("RegionName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("RegionName", regionName);
                    }

                    if (subBusinessUnitName == "Select One" || String.IsNullOrEmpty(subBusinessUnitName))
                    {
                        cmd.Parameters.AddWithValue("SubBusinessUnitName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("SubBusinessUnitName", subBusinessUnitName);
                    }

                    if (businessUnitName == "Select One" || String.IsNullOrEmpty(businessUnitName))
                    {
                        cmd.Parameters.AddWithValue("BusinessUnitName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("BusinessUnitName", businessUnitName);
                    }

                    if (companyName == "Select One" || String.IsNullOrEmpty(companyName))
                    {
                        cmd.Parameters.AddWithValue("CompanyName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("CompanyName", companyName);
                    }

                    connection.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(ds);
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
            }
        return ds;
    }


    public DataSet UpdateSKPickingBoard(SalesRepresentativeReportingChild li, int memberships)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        SqlCommand sqlCmd = new SqlCommand("dbo.Web_SR_UpdateSalesRepresentative", sqlConn);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        //   if (memberships == 1 || memberships == 2)
        //   {

        sqlCmd.Parameters.Add("@SalesRepContactID", SqlDbType.Int).Value = li.SalesRepContactID;
        // sqlCmd.Parameters.Add("@EffectiveDate", SqlDbType.DateTime).Value = li.EffectiveDate;
        sqlCmd.Parameters.Add("@HireDate", SqlDbType.DateTime).Value = li.HireDate;
        if (li.DemoSigned != DateTime.MinValue)
            sqlCmd.Parameters.Add("@DemoSigned", SqlDbType.DateTime).Value = li.DemoSigned;
        // if (li.TerminationDate != DateTime.MinValue)
        sqlCmd.Parameters.Add("@TerminationDate", SqlDbType.DateTime).Value = li.TerminationDate;
        sqlCmd.Parameters.Add("@Title", SqlDbType.NVarChar).Value = li.Title;
        if (!String.IsNullOrEmpty(li.CompanyName))
            sqlCmd.Parameters.Add("@CompanyName", SqlDbType.NVarChar).Value = li.CompanyName;
        if (!String.IsNullOrEmpty(li.Notes))
            sqlCmd.Parameters.Add("@Notes", SqlDbType.NVarChar).Value = li.Notes;
        if (!String.IsNullOrEmpty(li.InventoryNotes))
            sqlCmd.Parameters.Add("@InventoryNotes", SqlDbType.NVarChar).Value = li.InventoryNotes;
        if (!String.IsNullOrEmpty(li.SalesRepCompanyName))
            sqlCmd.Parameters.Add("@SalesRepCompanyName", SqlDbType.NVarChar).Value = li.SalesRepCompanyName;
        if (!String.IsNullOrEmpty(li.WorkPhone))
            sqlCmd.Parameters.Add("@WorkPhone", SqlDbType.NVarChar).Value = li.WorkPhone;
        if (!String.IsNullOrEmpty(li.SalesRepTypeName))
            sqlCmd.Parameters.Add("@SalesRepTypeName", SqlDbType.NVarChar).Value = li.SalesRepTypeName;
        if (!String.IsNullOrEmpty(li.TerritoryName))
            sqlCmd.Parameters.Add("@TerritoryName", SqlDbType.NVarChar).Value = li.TerritoryName;
        if (!String.IsNullOrEmpty(li.RegionName))
            sqlCmd.Parameters.Add("@RegionName", SqlDbType.NVarChar).Value = li.RegionName;
        if (!String.IsNullOrEmpty(li.SubBusinessUnitName))
            sqlCmd.Parameters.Add("@SubBusinessUnitName", SqlDbType.NVarChar).Value = li.SubBusinessUnitName;
        if (!String.IsNullOrEmpty(li.BusinessUnitName))
            sqlCmd.Parameters.Add("@BusinessUnitName", SqlDbType.NVarChar).Value = li.BusinessUnitName;
        //if (!String.IsNullOrEmpty(li.VoiceMailExtension))
        //    sqlCmd.Parameters.Add("@VoiceMailExtension", SqlDbType.NVarChar).Value = li.VoiceMailExtension;

        if (!String.IsNullOrEmpty(li.Address1))
            sqlCmd.Parameters.Add("@Address1", SqlDbType.NVarChar).Value = li.Address1;

        if (!String.IsNullOrEmpty(li.Address2))
            sqlCmd.Parameters.Add("@Address2", SqlDbType.NVarChar).Value = li.Address2;

        if (!String.IsNullOrEmpty(li.Address3))
            sqlCmd.Parameters.Add("@Address3", SqlDbType.NVarChar).Value = li.Address3;


        if (!String.IsNullOrEmpty(li.FaxNumber))
            sqlCmd.Parameters.Add("@FaxNumber", SqlDbType.NVarChar).Value = li.FaxNumber;
        if (!String.IsNullOrEmpty(li.MobilePhone))
            sqlCmd.Parameters.Add("@MobilePhone", SqlDbType.NVarChar).Value = li.MobilePhone;
        //if (!String.IsNullOrEmpty(li.Pager))
        //    sqlCmd.Parameters.Add("@Pager", SqlDbType.NVarChar).Value = li.Pager;
        if (!String.IsNullOrEmpty(li.PersonalCellPhone))
            sqlCmd.Parameters.Add("@PersonalCellPhone", SqlDbType.NVarChar).Value = li.PersonalCellPhone;
        if (!String.IsNullOrEmpty(li.InternationalPhone))
            sqlCmd.Parameters.Add("@InternationalPhone", SqlDbType.NVarChar).Value = li.InternationalPhone;
        //if (!String.IsNullOrEmpty(li.InternationalFax))
        //    sqlCmd.Parameters.Add("@InternationalFax", SqlDbType.NVarChar).Value = li.InternationalFax;
        if (!String.IsNullOrEmpty(li.InternationalCell))
            sqlCmd.Parameters.Add("@InternationalCell", SqlDbType.NVarChar).Value = li.InternationalCell;
        if (!String.IsNullOrEmpty(li.PrimaryEmail))
            sqlCmd.Parameters.Add("@PrimaryEmail", SqlDbType.NVarChar).Value = li.PrimaryEmail;
        if (!String.IsNullOrEmpty(li.SecondaryEmail))
            sqlCmd.Parameters.Add("@SecondaryEmail", SqlDbType.NVarChar).Value = li.SecondaryEmail;

        if (String.IsNullOrEmpty(HttpContext.Current.User.Identity.Name))
        {
            sqlCmd.Parameters.Add("@UpdateUser", SqlDbType.VarChar).Value = "sysadmin";
        }
        else
        {
            sqlCmd.Parameters.Add("@UpdateUser", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name;
        }
        //  }

        try
        {
            sqlConn.Open();
            using (SqlDataAdapter adapter = new SqlDataAdapter(sqlCmd))
            {
                adapter.Fill(ds);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ds;
    }


    // public DataSet AddNewSalesRepresentative(string salesRepFirstName, string salesRepLastName, string title, string hireDate, string terminationDate,
    //     string notes, string vendorID, string salesRepCompanyName, string demoSigned, string effectiveDate, string inventoryNotes, string salesRepTypeName,
    //     string territoryName, string regionName, string distributionRegionName, string subBusinessUnitName, string businessUnitName, string companyName, string address1, 
    //     string address2, string address3, string city, string stateProvinceName, string postalCode, string countryName, string customerID, string workPhone, string voiceMailExtension, 
    //     string voiceMailPin, string faxNumber, string mobilePhone, string pager, string personalCellPhone, string internationalPhone, string internationalFax, string internationalCell,
    //     string primaryEmail, string secondaryEmail, string globaladdress)
    public DataSet AddNewSalesRepresentative(SalesRepresentativeReportingChild li)
    {
        DataSet ds = new DataSet();
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString()))
            try
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_AddNewSalesRepresentative", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("SalesRepFirstName", li.SalesRepFirstName);
                    cmd.Parameters.AddWithValue("SalesRepLastName", li.SalesRepLastName);
                    if (!String.IsNullOrEmpty(li.Title))
                        cmd.Parameters.AddWithValue("Title", li.Title);
                   // if (!String.IsNullOrEmpty(li.CustomerNumber))
                        cmd.Parameters.AddWithValue("CustomerNumber", li.CustomerNumber);
                    if (!String.IsNullOrEmpty(li.SalesRepTypeName))
                        cmd.Parameters.AddWithValue("SalesRepTypeName", li.SalesRepTypeName);
                    if (!String.IsNullOrEmpty(li.SalesRepCompanyName))
                        cmd.Parameters.AddWithValue("SalesRepCompanyName", li.SalesRepCompanyName);
                    if (!String.IsNullOrEmpty(li.Address1))
                        cmd.Parameters.AddWithValue("Address1", li.Address1);
                    if (!String.IsNullOrEmpty(li.Address2))
                        cmd.Parameters.AddWithValue("Address2", li.Address2);
                    if (!String.IsNullOrEmpty(li.Address3))
                        cmd.Parameters.AddWithValue("Address3", li.Address3);
                    if (!String.IsNullOrEmpty(li.City))
                        cmd.Parameters.AddWithValue("City", li.City);
                    if (!String.IsNullOrEmpty(li.StateProvinceName))
                        cmd.Parameters.AddWithValue("StateProvinceName", li.StateProvinceName);
                    //if (!String.IsNullOrEmpty(li.PostalCode))
                        cmd.Parameters.AddWithValue("PostalCode", li.PostalCode);
                    if (!String.IsNullOrEmpty(li.CountryName))
                        cmd.Parameters.AddWithValue("CountryName", li.CountryName);
                    //  if (li.HireDate != DateTime.MinValue)
                    cmd.Parameters.AddWithValue("HireDate", li.HireDate);
                    if (li.TerminationDate != DateTime.MinValue)
                        cmd.Parameters.AddWithValue("TerminationDate", li.TerminationDate);
                    if (!String.IsNullOrEmpty(li.WorkPhone))
                        cmd.Parameters.AddWithValue("WorkPhone", li.WorkPhone);
                    //if (!String.IsNullOrEmpty(li.VoiceMailExtension))
                    //    cmd.Parameters.AddWithValue("VoiceMailExtension", li.VoiceMailExtension);
                    // if (!(li.VoiceMailPin.GetValueOrDefault(0) == 0))
                    cmd.Parameters.AddWithValue("VoiceMailPin", li.VoiceMailPin);
                    if (!String.IsNullOrEmpty(li.FaxNumber))
                        cmd.Parameters.AddWithValue("FaxNumber", li.FaxNumber);
                    if (!String.IsNullOrEmpty(li.MobilePhone))
                        cmd.Parameters.AddWithValue("MobilePhone", li.MobilePhone);
                    if (!String.IsNullOrEmpty(li.Pager))
                        cmd.Parameters.AddWithValue("Pager", li.Pager);
                    if (!String.IsNullOrEmpty(li.PersonalCellPhone))
                        cmd.Parameters.AddWithValue("PersonalCellPhone", li.PersonalCellPhone);
                    if (!String.IsNullOrEmpty(li.InternationalPhone))
                        cmd.Parameters.AddWithValue("InternationalPhone", li.InternationalPhone);
                    if (!String.IsNullOrEmpty(li.InternationalFax))
                        cmd.Parameters.AddWithValue("InternationalFax", li.InternationalFax);
                    if (!String.IsNullOrEmpty(li.InternationalCell))
                        cmd.Parameters.AddWithValue("InternationalCell", li.InternationalCell);
                    if (!String.IsNullOrEmpty(li.PrimaryEmail))
                        cmd.Parameters.AddWithValue("PrimaryEmail", li.PrimaryEmail);
                    if (!String.IsNullOrEmpty(li.SecondaryEmail))
                        cmd.Parameters.AddWithValue("SecondaryEmail", li.SecondaryEmail);
                    //cmd.Parameters.AddWithValue("VendorID", li.VendorID);
                    cmd.Parameters.AddWithValue("Notes", li.Notes);
                    if (!String.IsNullOrEmpty(li.InventoryNotes))
                        cmd.Parameters.AddWithValue("InventoryNotes", li.InventoryNotes);
                    if (li.DemoSigned != DateTime.MinValue)
                        cmd.Parameters.AddWithValue("DemoSigned", li.DemoSigned);
                    if (!String.IsNullOrEmpty(li.TerritoryName))
                        cmd.Parameters.AddWithValue("TerritoryName", li.TerritoryName);
                    if (!String.IsNullOrEmpty(li.RegionName))
                        cmd.Parameters.AddWithValue("RegionName", li.RegionName);
                    if (!String.IsNullOrEmpty(li.DistributionRegionName))
                        cmd.Parameters.AddWithValue("DistributionRegionName", li.DistributionRegionName);
                    if (!String.IsNullOrEmpty(li.SubBusinessUnitName))
                        cmd.Parameters.AddWithValue("SubBusinessUnitName", li.SubBusinessUnitName);
                    if (!String.IsNullOrEmpty(li.BusinessUnitName))
                        cmd.Parameters.AddWithValue("BusinessUnitName", li.BusinessUnitName);
                    if (!String.IsNullOrEmpty(li.CompanyName))
                        cmd.Parameters.AddWithValue("CompanyName", li.CompanyName);
                    // if (li.EffectiveDate != DateTime.MinValue)
                    //    cmd.Parameters.AddWithValue("EffectiveDate", li.EffectiveDate);
                    //if (!String.IsNullOrEmpty(li.GlobalAddress))
                    //    cmd.Parameters.AddWithValue("Globaladdress", li.GlobalAddress);

                    if (String.IsNullOrEmpty(HttpContext.Current.User.Identity.Name))
                    {
                        cmd.Parameters.Add("@UpdateUser", SqlDbType.VarChar).Value = "sysadmin";
                    }
                    else
                    {
                        cmd.Parameters.Add("@UpdateUser", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name;
                    }


                    connection.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(ds);
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
            }
        return ds;
    }


}
