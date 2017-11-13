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
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetBusinessUnitNameNumber", sqlConn);
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
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetSubBusinessUnitNameNumber", sqlConn);
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
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetRegionNameNumber", sqlConn);
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
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetTerritoryNameNumber", sqlConn);
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

    public DataSet StateProvinceNameList()
    {
        DataSet dsValueStrm = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetStateProvinceName", sqlConn);
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

    public DataSet CountryNameList()
    {
        DataSet dsDateRequested = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetCountryName", sqlConn);
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


    public DataSet CustomerNumberList()
    {
        DataSet dsDateRequested = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetCustomerNumber", sqlConn);
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



    internal DataSet GetTerritoryNameRelatedData(string AdjustmentTypeName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetTerritoryNameRelatedData", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("TerritoryName", TerritoryName);
                sqlConn.Open();
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
            sqlConn.Close();
        }
        return ds;
    }


    public DataSet NewSubBusinessUnitNameList(string territoryName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetNewTerritorySubBusinessUnitName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("TerritoryName", territoryName);
               // cmd.Parameters.AddWithValue("CompanyName", companyName);
                sqlConn.Open();
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
            sqlConn.Close();
        }
        return ds;
    }



    public DataSet NewBusinessUnitNameList(string territoryName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetNewTerritoryBusinessUnitName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("TerritoryName", territoryName);
                sqlConn.Open();
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
            sqlConn.Close();
        }
        return ds;
    }




    public DataSet NewRegionNameList(string territoryName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetNewTerritoryRegionName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("TerritoryName", territoryName);
                sqlConn.Open();
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
            sqlConn.Close();
        }
        return ds;
    }




    public DataSet NewCompanyNameList(string territoryName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetNewTerritoryCompanyName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("TerritoryName", territoryName);
                sqlConn.Open();
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
            sqlConn.Close();
        }
        return ds;
    }

}