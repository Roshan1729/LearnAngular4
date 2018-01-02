﻿<%@ Page Title="Search" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="WebApplication1.Search" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <link href="/content/style.css" rel="stylesheet" type="text/css" />
        <fieldset style="width:1000px">
            <legend>Search Criteria</legend>
            Review ID:
            <asp:TextBox ID="ReviewID" runat="server" style="margin-left:70px"></asp:TextBox>
            <div style="float:right;margin-right:3px">
                <%-- Location:
    <asp:DropDownList ID="DropDownList1" runat="server" style="margin-left:35px">
        <asp:ListItem>--Select--</asp:ListItem>
        <asp:ListItem>City</asp:ListItem>
        <asp:ListItem>Village</asp:ListItem>
        <asp:ListItem>Borough</asp:ListItem>
        <asp:ListItem>Place</asp:ListItem>
    </asp:DropDownList>
            <asp:DropDownList ID="DropDownList2" runat="server" Visible="false" style="margin-left:35px">
                </asp:DropDownList>--%>
                    City Location:
                    <asp:DropDownList ID="location" runat="server" style="margin-left:35px" Width="82">
                        <asp:ListItem>--Select--</asp:ListItem>
                    </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:169px">
                Project Category:
                <asp:DropDownList ID="category" runat="server" style="margin-left:30px">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br /> Applicant:
            <asp:TextBox ID="applicant" runat="server" style="margin-left:77px"></asp:TextBox>
            <div style="float:right;margin-right:2px">
                Federal Agency:
                <asp:DropDownList ID="agency" runat="server" style="margin-left:19px">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:169px">
                Town location:
                <asp:DropDownList ID="town" runat="server" style="margin-left:50px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br /> Project Title:
            <asp:TextBox ID="title" runat="server" style="margin-left:61px"></asp:TextBox>
            <div style="float:right;margin-left:100px">
                Village Location:
                <asp:DropDownList ID="village" runat="server" style="margin-left:20px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:70px">
                Action:
                <asp:DropDownList ID="action" runat="server" style="margin-left:95px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br /> Project Description:
            <asp:TextBox ID="desc" runat="server" style="margin-left:17px"></asp:TextBox>

            <div style="float:right;">
                Borough Location:
                <asp:DropDownList ID="borough" runat="server" style="margin-left:8px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:77px">
                Consultant:
                <asp:TextBox ID="consultant" runat="server" style="margin-left:68px"></asp:TextBox>
            </div>
            <br /> Project Address:
            <asp:TextBox ID="address" runat="server" style="margin-left:35px"></asp:TextBox>
            <div style="float:right;margin-left:130px">
                Place Location:
                <asp:DropDownList ID="place" runat="server" style="margin-left:26px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:39px">
                Final Destination:
                <asp:DropDownList ID="final" runat="server" style="margin-left:30px">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br /> Reviewer:
            <asp:DropDownList ID="reviewer" runat="server" style="margin-left:76px">
                <asp:ListItem>--Select--</asp:ListItem>
            </asp:DropDownList>
            <div style="float:right;">
                CEHA:
                <asp:DropDownList ID="CEHA" runat="server" style="margin-left:79px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:169px">
                Secondary Decision:
                <asp:DropDownList ID="secondary" runat="server" style="margin-left:10px">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br /> Secondary Reviewer:
            <asp:DropDownList ID="reviewer2" runat="server" style="margin-left:5px">
                <asp:ListItem>--Select--</asp:ListItem>
            </asp:DropDownList>
            <div style="float:right;">

                Region:
                <asp:DropDownList ID="region" runat="server" style="margin-left:74px">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:169px">
                Active:
                <asp:DropDownList ID="active" runat="server" style="margin-left:96px">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br /> Year:
            <asp:TextBox ID="year" runat="server" style="margin-left:106px"></asp:TextBox>
            <div style="float:right;margin-left:100px">
                LWRP:
                <asp:DropDownList ID="LWRP" runat="server" style="margin-left:79px">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:69px">
                Project Modified:
                <asp:DropDownList ID="project" runat="server" style="margin-left:34px">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br /> Agencies
            <br /> Application #:
            <asp:TextBox ID="appnumber" runat="server" style="margin-left:54px"></asp:TextBox>

            <div style="float:right;">
                SASS:
                <asp:DropDownList ID="SASS" runat="server" style="margin-left:81px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:169px">
                County:
                <asp:DropDownList ID="county" runat="server" style="margin-left:90px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br /> Consultant
            <br/>Project Number(s):
            <asp:TextBox ID="number" runat="server" style="margin-left:21px"></asp:TextBox>
            <div style="float:right;margin-left:130px">
                SCFWH:
                <asp:DropDownList ID="SCFWH" runat="server" style="margin-left:66px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="float:right;margin-right:39px">
                Waterbody:
                <asp:DropDownList ID="waterbody" runat="server" style="margin-left:67px" Width="82">
                    <asp:ListItem>--Select--</asp:ListItem>
                    <asp:ListItem>test1</asp:ListItem>
                    <asp:ListItem>test2</asp:ListItem>
                    <asp:ListItem>test3</asp:ListItem>
                </asp:DropDownList>
            </div>
            <br />
        </fieldset>
        <div align="center">

            <asp:Button Text="Find" ID="Find" runat="server" CssClass="roundCorner"  OnClick="btnGetData_Click" />
            <%--OnClick="BtnSelect_Click"--%> &nbsp; &nbsp; &nbsp;
                <asp:Button ID="Reset_Button" runat="server" CssClass="roundCorner" Text="Clear" OnClientClick="this.form.reset();return false;"
                    AutoPostBack="True" />
        </div>

        <%--<div id="container">
            <h2>Selected Value :
                <asp:Label runat="server" ID="lblSelectedValue" Style="color: red"></asp:Label></h2>
       </div>

    <div class="panel panel-primary">
<div class="panel-heading">
<h3>Reviews</h3>
</div>
<div class="panel-body">
<div class="col-xs-10">--%>
            <asp:GridView CssClass="table table-bordered" ID="gvSearchResults" runat="server" AutoGenerateColumns="False" EmptyDataText="There are no data records to display.">
                <Columns>
                    <asp:BoundField DataField="ReviewID" HeaderText="ReviewID" ItemStyle-Width="150" />
                    <asp:BoundField DataField="Project_Description" HeaderText="Project Description" ItemStyle-Width="150" />
                    <asp:BoundField DataField="Date_Action_Due" HeaderText="Date Action Due" ItemStyle-Width="150" />
                    <asp:BoundField DataField="Active" HeaderText="Active" ItemStyle-Width="150" />
                    <asp:BoundField DataField="Actions_Needed" HeaderText="Action Needed" ItemStyle-Width="150" />
                    <asp:BoundField DataField="Project_Latitude" HeaderText="Latitude" ItemStyle-Width="150" />
                    <asp:BoundField DataField="Project_Longitude" HeaderText="Longitude" ItemStyle-Width="150" />
                </Columns>
            </asp:GridView>
            <%--</div>
</div>
</div>--%>

    </asp:Content>