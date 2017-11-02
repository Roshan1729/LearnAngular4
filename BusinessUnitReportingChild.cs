using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for SKPickingBoardChild
/// </summary>
public class BusinessUnitReportingChild : BusinessUnitReportingCode
{

   

  
    
    public DataSet BusinessUnitNameist() {
        DataSet dsCommCode = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetBusinessUnitName", sqlConn);
            da.Fill(dsCommCode);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsCommCode;
    }

    public DataSet CompanyNameList() {
        DataSet dsDateRequested = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetCompanyName", sqlConn);
            da.Fill(dsDateRequested);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsDateRequested;
    }

    public DataSet BusinessUnitManagerNameList() {
        DataSet dsInventoryStatus = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetBusinessUnitManagerName", sqlConn);
            da.Fill(dsInventoryStatus);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsInventoryStatus;
    }

    
}