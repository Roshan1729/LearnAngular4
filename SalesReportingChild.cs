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
public class SalesReportingChild : SalesReportingCode
{

    public DataSet PeriodList()
    {
        DataSet dsPeriod = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetPeriod", sqlConn);
            da.Fill(dsPeriod);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsPeriod;
    }

    public DataSet AdjustmentTypeList()
    {
        DataSet dsAdjustmentType = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetAdjustmentType", sqlConn);
            da.Fill(dsAdjustmentType);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsAdjustmentType;
    }

    public DataSet CountryNameList()
    {
        DataSet dsValueStrm = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetCountryName", sqlConn);
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

    public DataSet SubBusinessUnitNameist()
    {
        DataSet dsCommCode = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetSubBusinessUnitName", sqlConn);
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

    public DataSet SubSegmentNameList()
    {
        DataSet dsInventoryStatus = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetSubSegmentName", sqlConn);
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

    public DataSet AccountSubTypeNameList()
    {
        DataSet dsAssignedTo = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetAccountSubTypeName", sqlConn);
            da.Fill(dsAssignedTo);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsAssignedTo;
    }

    public DataSet SubCategoryNameList()
    {
        DataSet dsAssignedTo = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetSubCategoryName", sqlConn);
            da.Fill(dsAssignedTo);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsAssignedTo;
    }

    public DataSet CurrencyNameList()
    {
        DataSet dsAssignedTo = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter("Web_SR_GetCurrencyName", sqlConn);
            da.Fill(dsAssignedTo);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            sqlConn.Close();
        }
        return dsAssignedTo;
    }

    internal DataSet GetAdjustmentTypeRelatedData(string AdjustmentTypeName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetAdjustmentTypeRelatedData", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("AdjustmentTypeName", AdjustmentTypeName);
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

    public DataSet AdjustmentSubBusinessUnitNameList(string companyName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetAdjustmentSubBusinessUnitName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("CompanyName", companyName);
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

    public DataSet AdjustmentCountryNameList(string companyName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetAdjustmentCountryName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("CompanyName", companyName);
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

    public DataSet AdjustmentSegmentNameList(string companyName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetAdjustmentSegmentName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("CompanyName", companyName);
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

    public DataSet AdjustmentAccountSubTypeNameList()
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetAdjustmentAccountSubTypeName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
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

    public DataSet NewAdjustmentTypeList(string companyName)//, string adjustmentTypeName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetNewAdjustmentTypeName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("CompanyName", companyName);
               // cmd.Parameters.AddWithValue("AdjustmentTypeName", adjustmentTypeName);
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

    public DataSet NewSubCategoryNameList(string adjustmentTypeName ,string companyName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetNewSubCategoryName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("AdjustmentTypeName", adjustmentTypeName);
                cmd.Parameters.AddWithValue("CompanyName", companyName);
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

    public DataSet NewCountryNameList(string companyName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetNewCountryName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("CompanyName", companyName);
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

    public DataSet NewCompanyData(string companyName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetNewCompanyData", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("CompanyName", companyName);
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


    public DataSet NewSubBusinessUnitName(string adjustmentTypeName, string companyName)
    {
        DataSet ds = new DataSet();
        SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ToString());
        try
        {
            using (SqlCommand cmd = new SqlCommand("dbo.Web_SR_GetNewSubBusinessUnitName", sqlConn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("AdjustmentTypeName", adjustmentTypeName);
                cmd.Parameters.AddWithValue("CompanyName", companyName);
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