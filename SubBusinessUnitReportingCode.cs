using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for LowInventory
/// </summary>
public abstract class SubBusinessUnitReportingCode
{
    public SubBusinessUnitReportingCode()
    {

        _SubBusinessUnitID = 0;
        _SubBusinessUnitCode = 0;
        _SubBusinessUnitName = String.Empty;
        _SubBusinessUnitManagerID = 0;
        _SubBusinessUnitManagerName = String.Empty;
        _BusinessUnitID = 0;
        _BusinessUnitName = String.Empty;
        _CompanyID = 0;
        _SubSegmentID = 0;
        _SubSegmentName = String.Empty;
        _CompanyName = String.Empty;
        _EffectiveDate = DateTime.MinValue;
        _ExpirationDate = DateTime.MinValue;

    }

    private int _SubBusinessUnitID;
    private int _SubBusinessUnitCode;
    private string _SubBusinessUnitName;
    public string _SubBusinessUnitManagerName;
    private int _SubBusinessUnitManagerID;
    private int _BusinessUnitID;
    private string _BusinessUnitName;
    public string _CompanyName;
    private int _CompanyID;
    public string _SubSegmentName;
    private int _SubSegmentID;
    private DateTime _EffectiveDate;
    private DateTime _ExpirationDate;
    
    public int SubBusinessUnitID
    {
        get { return _SubBusinessUnitID; }
        set { _SubBusinessUnitID = value; }
    }


    public int SubBusinessUnitCode
    {
        get { return _SubBusinessUnitCode; }
        set { _SubBusinessUnitCode = value; }
    }

    public string SubBusinessUnitName
    {
        get { return _SubBusinessUnitName; }
        set { _SubBusinessUnitName = value; }
    }

    public string SubBusinessUnitManagerName
    {
        get { return _SubBusinessUnitManagerName; }
        set { _SubBusinessUnitManagerName = value; }
    }
    public int SubBusinessUnitManagerID
    {
        get { return _SubBusinessUnitManagerID; }
        set { _SubBusinessUnitManagerID = value; }
    }

    public string BusinessUnitName
    {
        get { return _BusinessUnitName; }
        set { _BusinessUnitName = value; }
    }


    public int BusinessUnitID
    {
        get { return _BusinessUnitID; }
        set { _BusinessUnitID = value; }
    }

    public string CompanyName
    {
        get { return _CompanyName; }
        set { _CompanyName = value; }
    }
    public int CompanyID
    {
        get { return _CompanyID; }
        set { _CompanyID = value; }
    }

    public string SubSegmentName
    {
        get { return _SubSegmentName; }
        set { _SubSegmentName = value; }
    }
    public int SubSegmentID
    {
        get { return _SubSegmentID; }
        set { _SubSegmentID = value; }
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

    

    public DataSet GetSKPickingBoard2(string subBusinessUnitName,  string businessUnitName, string companyName,string subBusinessUnitManagerName)//,string companyName)// string fromDate, string toDate, string period, string fromQuantity, string toQuantity, string fromAmount, string toAmount, string adjustmentType, string countryName, string subBusinessUnitName, string companyName, string subSegmentName, string accountSubTypeName, string subCategoryName, string rblMeasurementSystemText)
    {
        DataSet ds = new DataSet();

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString()))
            try
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetSubBusinessUnitRecords", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

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


                    if (subBusinessUnitManagerName == "Select One" || String.IsNullOrEmpty(subBusinessUnitManagerName))
                    {
                        cmd.Parameters.AddWithValue("SubBusinessUnitManagerName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("SubBusinessUnitManagerName", subBusinessUnitManagerName);
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


    public DataSet UpdateSKPickingBoard(SubBusinessUnitReportingChild li, int memberships)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        SqlCommand sqlCmd = new SqlCommand("dbo.Web_SR_UpdateSubBusinessUnits", sqlConn);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        //   if (memberships == 1 || memberships == 2)
        //   {

        sqlCmd.Parameters.Add("@SubBusinessUnitID", SqlDbType.Int).Value = li.SubBusinessUnitID;
        sqlCmd.Parameters.Add("@EffectiveDate", SqlDbType.DateTime).Value = li.EffectiveDate;
        if (li.ExpirationDate != DateTime.MinValue)
        {
            sqlCmd.Parameters.Add("@ExpirationDate", SqlDbType.DateTime).Value = li.ExpirationDate;
        }
        sqlCmd.Parameters.Add("@SubBusinessUnitCode", SqlDbType.Int).Value = li.SubBusinessUnitCode;
        sqlCmd.Parameters.Add("@SubBusinessUnitName", SqlDbType.NVarChar).Value = li.SubBusinessUnitName;
        sqlCmd.Parameters.Add("@SubBusinessUnitManagerName", SqlDbType.NVarChar).Value = li.SubBusinessUnitManagerName;
        sqlCmd.Parameters.Add("@BusinessUnitName", SqlDbType.NVarChar).Value = li.BusinessUnitName;
        sqlCmd.Parameters.Add("@CompanyName", SqlDbType.NVarChar).Value = li.CompanyName;
        
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
    
   
    public DataSet AddNewSubBusinessUnit(string subBusinessUnitCode, string subBusinessUnitName, string subSegmentName, string subBusinessUnitManagerName, string businessUnitName, string companyName, string effectiveDate)//string date, string period, string quantity, string amountLCY, string amountSpotUSD, string amountAverageUSD, string costLCY, string costSpotUSD, string costAverageUSD, string comment, string adjustmentType, string countryName, string subBusinessUnitName, string companyName, string subSegmentName, string accountSubTypeName, string subCategoryName, string currencyName)
    {
        DataSet ds = new DataSet();
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString()))
            try
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_AddNewSubBusinessUnit", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("EffectiveDate", Convert.ToDateTime(effectiveDate));
                    cmd.Parameters.AddWithValue("SubBusinessUnitCode", subBusinessUnitCode);
                    cmd.Parameters.AddWithValue("SubBusinessUnitName", subBusinessUnitName);
                    cmd.Parameters.AddWithValue("SubBusinessUnitManagerName", subBusinessUnitManagerName);
                    cmd.Parameters.AddWithValue("SubSegmentName", subSegmentName);
                    cmd.Parameters.AddWithValue("BusinessUnitName", businessUnitName);
                    cmd.Parameters.AddWithValue("CompanyName", companyName);


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
