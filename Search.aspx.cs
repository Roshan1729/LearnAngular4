﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.User.Identity.IsAuthenticated)
            { 
                FormsAuthentication.RedirectToLoginPage();
            }
            else
            {
                GetDropDownValues();
            }
            

        }
        protected void GetDropDownValues()
        {
            DataSet ds = new DataSet();
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_SearchFields", con))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        con.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(ds);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            location.DataSource = ds.Tables[0];
            location.DataTextField = "CityName";
            location.DataBind();
            location.Items.Insert(0, new ListItem("--Select--", "NA"));

            borough.DataSource = ds.Tables[1];
            borough.DataTextField = "BoroughName";
            borough.DataBind();
            borough.Items.Insert(0, new ListItem("--Select--", "NA"));

            county.DataSource = ds.Tables[2];
            county.DataTextField = "CountyName";
            county.DataBind();
            county.Items.Insert(0, new ListItem("--Select--", "NA"));

            place.DataSource = ds.Tables[3];
            place.DataTextField = "PlaceName";
            place.DataBind();
            place.Items.Insert(0, new ListItem("--Select--", "NA"));

            town.DataSource = ds.Tables[4];
            town.DataTextField = "TownName";
            town.DataBind();
            town.Items.Insert(0, new ListItem("--Select--", "NA"));

            village.DataSource = ds.Tables[5];
            village.DataTextField = "VillageName";
            village.DataBind();
            village.Items.Insert(0, new ListItem("--Select--", "NA"));

            waterbody.DataSource = ds.Tables[6];
            waterbody.DataTextField = "WaterBodyName";
            waterbody.DataBind();
            waterbody.Items.Insert(0, new ListItem("--Select--", "NA"));

            action.DataSource = ds.Tables[7];
            action.DataTextField = "ActionType";
            action.DataBind();
            action.Items.Insert(0, new ListItem("--Select--", "NA"));

            SASS.DataSource = ds.Tables[8];
            SASS.DataTextField = "SassID";
            SASS.DataBind();
            SASS.Items.Insert(0, new ListItem("--Select--", "NA"));

            SCFWH.DataSource = ds.Tables[9];
            SCFWH.DataTextField = "SCFWHName";
            SCFWH.DataBind();
            SCFWH.Items.Insert(0, new ListItem("--Select--", "NA"));

            CEHA.DataSource = ds.Tables[10];
            CEHA.DataTextField = "CEHAName";
            CEHA.DataBind();
            CEHA.Items.Insert(0, new ListItem("--Select--", "NA"));
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
             DataSet ds = new DataSet();
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_GetSearchResults", con))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.Add("@ReviewID", SqlDbType.VarChar).Value = ReviewID.Text;
                        con.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(ds);
                        gvSearchResults.DataSource = ds.Tables[0];
                        gvSearchResults.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }
}
        