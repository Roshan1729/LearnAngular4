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
public class SalesRepresentativeReportingChild : SalesRepresentativeReportingCode
{

    public DataSet CompanyNameList()
    {
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
    public DataSet BusinessUnitNameList()
    {
        DataSet dsInventoryStatus = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetBusinessUnitName", sqlConn);
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
    public DataSet SubBusinessUnitNameList()
    {
        DataSet dsValueStrm = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetSubBusinessUnitName", sqlConn);
            da.Fill(dsValueStrm);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsValueStrm;
    }

    public DataSet DistributionRegionNameList()
    {
        DataSet dsValueStrm = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetDistributionRegionName", sqlConn);
            da.Fill(dsValueStrm);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsValueStrm;
    }


    public DataSet RegionNameList()
    {
        DataSet dsValueStrm = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetRegionName", sqlConn);
            da.Fill(dsValueStrm);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsValueStrm;
    }

    public DataSet TerritoryNameList()
    {
        DataSet dsValueStrm = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetTerritoryName", sqlConn);
            da.Fill(dsValueStrm);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsValueStrm;
    }

    public DataSet SalesRepTypeNameList()
    {
        DataSet dsValueStrm = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetSalesRepTypeName", sqlConn);
            da.Fill(dsValueStrm);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsValueStrm;
    }

    public DataSet LastNameList()
    {
        DataSet dsValueStrm = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetLastName", sqlConn);
            da.Fill(dsValueStrm);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsValueStrm;
    }
}