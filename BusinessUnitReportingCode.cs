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
public abstract class BusinessUnitReportingCode
{
    public BusinessUnitReportingCode()
    {

        _BusinessUnitID = 0;
        _BusinessUnitCode = 0;
        _BusinessUnitName = String.Empty;
        _BusinessUnitManagerName = String.Empty;
        _BusinessUnitManagerID = 0;
        _CompanyID = 0;
        _CompanyName = String.Empty;
        _EffectiveDate = DateTime.MinValue;
        _ExpirationDate = DateTime.MinValue;

    }

    private int _BusinessUnitID;
    private int _BusinessUnitCode;
    private string _BusinessUnitName;
    public string _BusinessUnitManagerName;
    private int _BusinessUnitManagerID;
    public string _CompanyName;
    private int _CompanyID;
    private DateTime _EffectiveDate;
    private DateTime _ExpirationDate;
    
    public int BusinessUnitID
    {
        get { return _BusinessUnitID; }
        set { _BusinessUnitID = value; }
    }


    public int BusinessUnitCode
    {
        get { return _BusinessUnitCode; }
        set { _BusinessUnitCode = value; }
    }

    public string BusinessUnitName
    {
        get { return _BusinessUnitName; }
        set { _BusinessUnitName = value; }
    }

    public string BusinessUnitManagerName
    {
        get { return _BusinessUnitManagerName; }
        set { _BusinessUnitManagerName = value; }
    }
    public int BusinessUnitManagerID
    {
        get { return _BusinessUnitManagerID; }
        set { _BusinessUnitManagerID = value; }
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

    

    public DataSet GetSKPickingBoard2(string businessUnitName, string businessUnitManagerName, string companyName)//string businessUnitManagerName,string companyName)// string fromDate, string toDate, string period, string fromQuantity, string toQuantity, string fromAmount, string toAmount, string adjustmentType, string countryName, string subBusinessUnitName, string companyName, string subSegmentName, string accountSubTypeName, string subCategoryName, string rblMeasurementSystemText)
    {
        DataSet ds = new DataSet();

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString()))
            try
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetBusinessUnitRecords", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (businessUnitName == "Select One" || String.IsNullOrEmpty(businessUnitName))
                    {
                        cmd.Parameters.AddWithValue("BusinessUnitName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("BusinessUnitName", businessUnitName);
                    }


                    if (businessUnitManagerName == "Select One" || String.IsNullOrEmpty(businessUnitManagerName))
                    {
                        cmd.Parameters.AddWithValue("BusinessUnitManagerName", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("BusinessUnitManagerName", businessUnitManagerName);
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


    public DataSet UpdateSKPickingBoard(BusinessUnitReportingChild li, int memberships)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        SqlCommand sqlCmd = new SqlCommand("dbo.Web_SR_UpdateBusinessUnits", sqlConn);
        sqlCmd.CommandType = CommandType.StoredProcedure;

        //   if (memberships == 1 || memberships == 2)
        //   {

        sqlCmd.Parameters.Add("@BusinessUnitID", SqlDbType.Int).Value = li.BusinessUnitID;
        sqlCmd.Parameters.Add("@EffectiveDate", SqlDbType.DateTime).Value = li.EffectiveDate;
        if (li.ExpirationDate != DateTime.MinValue)
        {
            sqlCmd.Parameters.Add("@ExpirationDate", SqlDbType.DateTime).Value = li.ExpirationDate;
        }
        sqlCmd.Parameters.Add("@BusinessUnitCode", SqlDbType.Int).Value = li.BusinessUnitCode;
        sqlCmd.Parameters.Add("@BusinessUnitName", SqlDbType.NVarChar).Value = li.BusinessUnitName;
        sqlCmd.Parameters.Add("@BusinessUnitManagerName", SqlDbType.NVarChar).Value = li.BusinessUnitManagerName;
        sqlCmd.Parameters.Add("@CompanyName", SqlDbType.NVarChar).Value = li.CompanyName;
        //if (li.SegmentName == string.Empty)
        //{
        //    sqlCmd.Parameters.Add("@SegmentName", SqlDbType.VarChar).Value = DBNull.Value;
        //}
        //else
        //{
        //    sqlCmd.Parameters.Add("@SegmentName", SqlDbType.VarChar).Value = li.SegmentName;
        //}
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
    
   
    public DataSet AddNewBusinessUnit(string businessUnitCode, string businessUnitName, string businessUnitManagerName, string companyName, string effectiveDate)//string date, string period, string quantity, string amountLCY, string amountSpotUSD, string amountAverageUSD, string costLCY, string costSpotUSD, string costAverageUSD, string comment, string adjustmentType, string countryName, string subBusinessUnitName, string companyName, string subSegmentName, string accountSubTypeName, string subCategoryName, string currencyName)
    {
        DataSet ds = new DataSet();
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString()))
            try
            {
                using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_AddNewBusinessUnit", connection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("EffectiveDate", Convert.ToDateTime(effectiveDate));
                    cmd.Parameters.AddWithValue("BusinessUnitCode", Convert.ToInt32(businessUnitCode));
                    cmd.Parameters.AddWithValue("BusinessUnitName", businessUnitName);
                    cmd.Parameters.AddWithValue("BusinessUnitManagerName", businessUnitManagerName);
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
