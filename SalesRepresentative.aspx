<%@ Page Title="Sales Representative" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesRepresentative.aspx.cs" Inherits="SalesReportingWebsite.SalesRepresentative" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

 <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div>
                <asp:Table ID="Table1" runat="server" Width="100%" Style="margin-bottom: 0px">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="btnAddNewSalesRepresentative" runat="server" Text="Add New Sales Representative" OnClick="btnAddNewSalesRepresentative_Click"
                            />
                            <asp:HyperLink ID="HiddenAddNewSalesRepresentative" runat="server" Style="display: none;" />
                        </asp:TableCell>

                        <asp:TableCell Width="100px">
                            <asp:Label ID="Label3" runat="server" Text="Last Name"></asp:Label>
                            <br />
                            <asp:DropDownList ID="ddlSalesRepLastName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                Width="40px">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>


                        <asp:TableCell Width="100px">
                            <asp:Label ID="Label1" runat="server" Text="Sales Rep Type"></asp:Label>
                            <br />
                            <asp:DropDownList ID="ddlSalesRepTypeName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                Width="40px">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                        <asp:TableCell Width="100px">
                            <asp:Label ID="Label4" runat="server" Text="Territory Name"></asp:Label>
                            <br />
                            <asp:DropDownList ID="ddlTerritoryName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                Width="40px">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>


                        <asp:TableCell Width="100px">
                            <asp:Label ID="Label2" runat="server" Text="Region Name"></asp:Label>
                            <br />
                            <asp:DropDownList ID="ddlRegionName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                Width="40px">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>


                        <asp:TableCell Width="100px">
                            <asp:Label ID="Label5" runat="server" Text="Distribution Region Name"></asp:Label>
                            <br />
                            <asp:DropDownList ID="ddlDistributionRegionName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                Width="40px">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>


                        <asp:TableCell Width="100px">
                            <asp:Label ID="Label6" runat="server" Text="Sub Business Unit Name"></asp:Label>
                            <br />
                            <asp:DropDownList ID="ddlSubBusinessUnitName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                Width="40px">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                        <asp:TableCell Width="100px">
                            <asp:Label ID="Label7" runat="server" Text="Business Unit Name"></asp:Label>
                            <br />
                            <asp:DropDownList ID="ddlBusinessUnitName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                Width="40px">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>


                        <asp:TableCell Width="100px">
                            <asp:Label ID="Label8" runat="server" Text="Company Name"></asp:Label>
                            <br />
                            <asp:DropDownList ID="ddlCompanyName" runat="server" AutoPostBack="true" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged"
                                Width="40px">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Button ID="btnExportToExcel" runat="server" Text="Export to Excel" OnClick="btnExportToExcel_Click" />
                            <br />

                            <asp:CheckBox ID="chkBoxReset" runat="server" OnCheckedChanged="chkBoxResetCheckedChanged" AutoPostBack="true" /> Reset Selection
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <br />
                <div>
                    <b>
                        <asp:Label ID="lblRecordCount" runat="server" Text=""></asp:Label>
                    </b>
                </div>

                <asp:GridView ID="SalesRepresentativeGridView" runat="server" AutoGenerateColumns="false" Width="98%" Style="margin: 0% 1% 0% 1%"
                    OnRowEditing="SalesRepresentative_RowEditing" OnRowCancelingEdit="SalesRepresentative_RowCancelingEdit" OnRowDataBound="SalesRepresentative_RowDataBound"
                    OnRowUpdating="SalesRepresentative_RowUpdating" AllowPaging="true" PageSize="10" AllowSorting="true" OnPageIndexChanging="SalesRepresentative_PageIndexChanging"
                    CssClass="SegmentGV" OnSorting="SalesRepresentative_SortData" DataKeyNames="SalesRepID">

                    <Columns>
                        <asp:CommandField ShowEditButton="true" ItemStyle-Width="50" />
                        <asp:BoundField DataField="SalesRepID" HeaderText="SalesRep ID" Visible="false" ReadOnly="true">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                        </asp:BoundField>


                        <asp:TemplateField HeaderText="First Name">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="SalesRepFirstName" Text='<%# Eval("SalesRepFirstName")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="SalesRepFirstName" runat="server" Text='<%# Eval("SalesRepFirstName")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Last Name">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="SalesRepLastName" Text='<%# Eval("SalesRepLastName")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="SalesRepLastName" runat="server" Text='<%# Eval("SalesRepLastName")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Title">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="Title" Text='<%# Eval("Title")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="Title" runat="server" Text='<%# Eval("Title")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Hire Date">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="HireDate" Text='<%#DataBinder.Eval(Container.DataItem, "HireDate").ToString()%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="HireDate" runat="server" ReadOnly="true" Text='<%#Bind("HireDate") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Termination Date">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="TerminationDate" Text='<%#DataBinder.Eval(Container.DataItem, "TerminationDate").ToString()%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TerminationDate" runat="server" ReadOnly="true" Text='<%#Bind("TerminationDate") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>



                        <asp:TemplateField HeaderText="Notes">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="Notes" Text='<%# Eval("Notes")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="Notes" runat="server" Text='<%# Eval("Notes")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Inventory Notes">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="InventoryNotes" Text='<%# Eval("InventoryNotes")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="InventoryNotes" runat="server" Text='<%# Eval("InventoryNotes")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                  <%--      <asp:TemplateField HeaderText="Vendor Number">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="VendorID" Text='<%# Eval("VendorID")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="VendorID" runat="server" Text='<%# Eval("VendorID")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>--%>

                        <asp:TemplateField HeaderText="Sales Rep Company">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="SalesRepCompanyName" Text='<%# Eval("SalesRepCompanyName")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="SalesRepCompanyName" runat="server" Text='<%# Eval("SalesRepCompanyName")%>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Demo Signed">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="DemoSigned" Text='<%#DataBinder.Eval(Container.DataItem, "DemoSigned").ToString()%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="DemoSigned" runat="server" ReadOnly="true" Text='<%#Bind("DemoSigned") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Sales Rep Type">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="SalesRepTypeName" Text='<%# Eval("SalesRepTypeName")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblSalesRepTypeName" runat="server" Text='<%# Eval("SalesRepTypeName")%>' Visible="false"></asp:Label>
                                <asp:DropDownList ID="SalesRepTypeName" runat="server">
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Territory Name">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="TerritoryName" Text='<%# Eval("TerritoryName")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblTerritoryName" runat="server" Text='<%# Eval("TerritoryName")%>' Visible="false"></asp:Label>
                                <asp:DropDownList ID="TerritoryName" runat="server">
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Region Name">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="RegionName" Text='<%# Eval("RegionName")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblRegionName" runat="server" Text='<%# Eval("RegionName")%>' Visible="false"></asp:Label>
                                <asp:DropDownList ID="RegionName" runat="server">
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <%--     <asp:TemplateField HeaderText="Distribution Region Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="DistributionRegionName" Text='<%# Eval("DistributionRegionName")%>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblDistributionRegionName" runat="server" Text='<%# Eval("DistributionRegionName")%>' Visible="false"></asp:Label>
                                <asp:DropDownList ID="DistributionRegionName" runat="server">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            </asp:TemplateField>--%>

                            <asp:TemplateField HeaderText="Sub Business Unit Name">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="SubBusinessUnitName" Text='<%# Eval("SubBusinessUnitName")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblSubBusinessUnitName" runat="server" Text='<%# Eval("SubBusinessUnitName")%>' Visible="false"></asp:Label>
                                    <asp:DropDownList ID="SubBusinessUnitName" runat="server">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Business Unit Name">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="BusinessUnitName" Text='<%# Eval("BusinessUnitName")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblBusinessUnitName" runat="server" Text='<%# Eval("BusinessUnitName")%>' Visible="false"></asp:Label>
                                    <asp:DropDownList ID="BusinessUnitName" runat="server">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Company Name">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="CompanyName" Text='<%# Eval("CompanyName")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("CompanyName")%>' Visible="false"></asp:Label>
                                    <asp:DropDownList ID="CompanyName" runat="server">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <%-- <asp:TemplateField HeaderText="Customer Number">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="CustomerNumber" Text='<%# Eval("CustomerNumber")%>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="CustomerNumber" runat="server" Text='<%# Eval("CustomerNumber")%>'></asp:TextBox>
                                </EditItemTemplate>
                                </asp:TemplateField>--%>


                                <asp:TemplateField HeaderText="Address Line 1">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Address1" Text='<%# Eval("Address1")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="Address1" runat="server" Text='<%# Eval("Address1")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Address Line 2">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Address2" Text='<%# Eval("Address2")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="Address2" runat="server" Text='<%# Eval("Address2")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Address Line 3">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="Address3" Text='<%# Eval("Address3")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="Address3" runat="server" Text='<%# Eval("Address3")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="City">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="City" Text='<%# Eval("City")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="City" runat="server" Text='<%# Eval("City")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <%--<asp:TemplateField HeaderText="State Province">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="StateProvinceName" Text='<%# Eval("StateProvinceName")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="StateProvinceName" runat="server" Text='<%# Eval("StateProvinceName")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                    </asp:TemplateField>



                                    <asp:TemplateField HeaderText="Postal Code">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="PostalCode" Text='<%# Eval("PostalCode")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="PostalCode" runat="server" Text='<%# Eval("PostalCode")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Country Name">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="CountryName" Text='<%# Eval("CountryName")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="CountryName" runat="server" Text='<%# Eval("CountryName")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>--%>

                                    <asp:TemplateField HeaderText="Work Phone">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="WorkPhone" Text='<%# Eval("WorkPhone")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="WorkPhone" runat="server" Text='<%# Eval("WorkPhone")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>


                                 <%--   <asp:TemplateField HeaderText="Voice Mail Ext">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="VoiceMailExtension" Text='<%# Eval("VoiceMailExtension")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="VoiceMailExtension" runat="server" Text='<%# Eval("VoiceMailExtension")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Voice Mail Pin">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="VoiceMailPin" Text='<%# Eval("VoiceMailPin")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="VoiceMailPin" runat="server" Text='<%# Eval("VoiceMailPin")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>--%>

                                    <asp:TemplateField HeaderText="Fax Number">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="FaxNumber" Text='<%# Eval("FaxNumber")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="FaxNumber" runat="server" Text='<%# Eval("FaxNumber")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Mobile Phone">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="MobilePhone" Text='<%# Eval("MobilePhone")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="MobilePhone" runat="server" Text='<%# Eval("MobilePhone")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>


                                  <%--  <asp:TemplateField HeaderText="Pager">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="Pager" Text='<%# Eval("Pager")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="Pager" runat="server" Text='<%# Eval("Pager")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>--%>

                                    <asp:TemplateField HeaderText="Personal CellPhone">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="PersonalCellPhone" Text='<%# Eval("PersonalCellPhone")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="PersonalCellPhone" runat="server" Text='<%# Eval("PersonalCellPhone")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="International Phone">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="InternationalPhone" Text='<%# Eval("InternationalPhone")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="InternationalPhone" runat="server" Text='<%# Eval("InternationalPhone")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

<%--                                    <asp:TemplateField HeaderText="International Fax">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="InternationalFax" Text='<%# Eval("InternationalFax")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="InternationalFax" runat="server" Text='<%# Eval("InternationalFax")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>--%>

                                    <asp:TemplateField HeaderText="International Cell">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="InternationalCell" Text='<%# Eval("InternationalCell")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="InternationalCell" runat="server" Text='<%# Eval("InternationalCell")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Primary Email">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="PrimaryEmail" Text='<%# Eval("PrimaryEmail")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="PrimaryEmail" runat="server" Text='<%# Eval("PrimaryEmail")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="SecondaryEmail">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="SecondaryEmail" Text='<%# Eval("SecondaryEmail")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="SecondaryEmail" runat="server" Text='<%# Eval("SecondaryEmail")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>


                                    <%--   <asp:TemplateField HeaderText="Business Unit Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="BusinessUnitName" Text='<%# Eval("BusinessUnitName")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lblBusinessUnitName" runat="server" Text='<%# Eval("BusinessUnitName")%>' Visible="false"></asp:Label>
                                            <asp:DropDownList ID="BusinessUnitName" runat="server">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        </asp:TemplateField>--%>


                                    <%--    <asp:TemplateField HeaderText="Effective Date">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lnl1" Text='<%#DataBinder.Eval(Container.DataItem, "EffectiveDate").ToString()%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="EffectiveDate" runat="server" ReadOnly="true" Text='<%#Bind("EffectiveDate") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Expiration Date">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lnl2" Text='<%#DataBinder.Eval(Container.DataItem, "ExpirationDate").ToString()%>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="ExpirationDate" runat="server" ReadOnly="true" Text='<%#Bind("ExpirationDate") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
--%>


                                        <asp:BoundField DataField="UpdateUser" HeaderText="Update User" ReadOnly="true" ItemStyle-Width="100">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UpdateDate" HeaderText="Update Date" ReadOnly="true" ItemStyle-Width="100">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                                        </asp:BoundField>
                    </Columns>

                    <%-- <PagerSettings Mode="NextPrevious" FirstPageText="First" LastPageText="Last" NextPageText=" Next &gt;" PreviousPageText="&lt; Prev "/> --%>
                        <PagerStyle CssClass="gridPager" />
                </asp:GridView>
            </div>

            <!-- ModalPopupExtender -->
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel1" TargetControlID="HiddenAddNewSalesRepresentative"
                CancelControlID="btnClose" BackgroundCssClass="modalBackground">
            </cc1:ModalPopupExtender>
            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center"  Style="display: none;width: 90%; height: 90%; overflow: scroll">
                <asp:Label ID="Label15" runat="server" Text="" Font-Size="Large" Style="text-align: left;">Add New Sales Representaive</asp:Label>

                <asp:Table ID="Table2" runat="server">
                    <asp:TableHeaderRow TableSection="TableHeader">
                        <asp:TableCell runat="server" ColumnSpan="2">Sales Representative Information</asp:TableCell>
                        <asp:TableCell runat="server" ColumnSpan="2"></asp:TableCell>
                        <asp:TableCell runat="server" ColumnSpan="2">Groupings</asp:TableCell>
                    </asp:TableHeaderRow>
                    <asp:TableRow runat="server">

                        <asp:TableCell runat="server">First Name:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newSalesRepFirstName" runat="server"></asp:TextBox>
                        </asp:TableCell>
                      <%--  <asp:TableCell runat="server">Vendor Number:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newVendorNumber" runat="server"></asp:TextBox>
                        </asp:TableCell>--%>
                        <asp:TableCell runat="server">
                             </asp:TableCell>
                        <asp:TableCell runat="server">
                             </asp:TableCell>
                     
                        <asp:TableCell runat="server">Sales Rep Type:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newSalesRepTypeName" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>

                    <asp:TableRow runat="server">
                        <asp:TableCell runat="server">Last Name:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newSalesRepLastName" runat="server"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell runat="server">Sales Rep Company:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newSalesRepCompany" runat="server"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell runat="server">Territory Name:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newTerritoryName" runat="server" AppendDataBoundItems="true" OnSelectedIndexChanged = "OnSelectedTypeIndexChanged" AutoPostBack="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                    </asp:TableRow>

                    <asp:TableRow runat="server">
                        <asp:TableCell runat="server">Title:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newTitle" runat="server"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell runat="server">Demo Signed:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newDemoSigned" runat="server" CssClass="DateLabel"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell runat="server">Region Name:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newRegionName" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                    </asp:TableRow>

                    <asp:TableRow runat="server">
                        <asp:TableCell runat="server">Hire Date:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newHireDate" runat="server" CssClass="DateLabel"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell runat="server">Termination Date:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newTerminationDate" runat="server" CssClass="DateLabel"></asp:TextBox>
                        </asp:TableCell>
                      <%--  <asp:TableCell runat="server">Effective Date:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newEffectiveDate" runat="server" CssClass="DateLabel"></asp:TextBox>
                        </asp:TableCell>--%>
                        <asp:TableCell runat="server">Distribution Region Name:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newDistributionRegionName" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>

  <%--              <asp:TableRow runat="server">
                        <asp:TableCell runat="server">Termination Date:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newTerminationDate" runat="server" CssClass="DateLabel"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell runat="server">

                        </asp:TableCell>
                        <asp:TableCell runat="server">

                        </asp:TableCell>
                        <asp:TableCell runat="server">Sub Business Unit Name:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newSubBusinessUnitName" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                    </asp:TableRow>--%>

                    <asp:TableRow runat="server">

                        <asp:TableCell runat="server" rowspan="3">Notes:</asp:TableCell>
                        <asp:TableCell runat="server" rowspan="3">
                            <asp:TextBox ID="newNotes" runat="server" TextMode="multiline" Columns="50" Rows="5"></asp:TextBox>
                        </asp:TableCell>

                        <asp:TableCell runat="server" rowspan="3">Inventory Notes:</asp:TableCell>
                        <asp:TableCell runat="server" rowspan="3">
                            <asp:TextBox ID="newInventoryNotes" runat="server" TextMode="multiline" Columns="50" Rows="5"></asp:TextBox>
                        </asp:TableCell>


                        <asp:TableCell runat="server">Business Unit Name:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newBusinessUnitName" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                    </asp:TableRow>


                    <asp:TableRow runat="server">

                           <asp:TableCell runat="server">Sub Business Unit Name:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newSubBusinessUnitName" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                    </asp:TableRow>

                    <asp:TableRow runat="server">
                        <asp:TableCell runat="server">Company Name:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newCompanyName" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                    </asp:TableRow>                 
                </asp:Table>
                <asp:Table ID="Table3" runat="server">

                    <asp:TableHeaderRow TableSection="TableHeader">
                        <asp:TableCell runat="server" ColumnSpan="3">Sales Representative Conatct</asp:TableCell>
                    </asp:TableHeaderRow>

                    <asp:TableRow runat="server">

                        <asp:TableCell runat="server" HorizontalAlign="Left">Address Line 1:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newAddress1" runat="server"></asp:TextBox>
                        </asp:TableCell>

                        <asp:TableCell runat="server">Customer Number:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newCustomerNumber" runat="server"></asp:TextBox>
                            
                        </asp:TableCell>

                        <asp:TableCell runat="server">Personal Cell Phone:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newPersonalCellPhone" runat="server"></asp:TextBox>
                             <asp:RegularExpressionValidator 
                            ErrorMessage="Invalid Personal Cell Phone Number" 
                            Text="Invalid Personal Cell Phone Number1" 
                            ControlToValidate="newPersonalCellPhone" 
                            ValidationExpression="^(\([0-9]{3}\)|[0-9]{3}-)[0-9]{3}-[0-9]{4}|(\([0-9]{3}\)|[0-9]{3})[0-9]{3}[0-9]{4}$" 
                            runat="server" />
                        </asp:TableCell>

                    </asp:TableRow>

                    <asp:TableRow runat="server">

                        <asp:TableCell runat="server">Address Line 2:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newAddress2" runat="server"></asp:TextBox>
                        </asp:TableCell>

                         <asp:TableCell runat="server">Postal Code:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newPostalCode" runat="server"></asp:TextBox>
                        </asp:TableCell>


                        <asp:TableCell runat="server">International Phone:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newInternationalPhone" runat="server"></asp:TextBox>
                              <asp:RegularExpressionValidator 
                            ErrorMessage="International Phone Number" 
                            Text="Invalid International Phone number" 
                            ControlToValidate="newInternationalPhone" 
                            ValidationExpression="^(\([0-9]{3}\)|[0-9]{3}-)[0-9]{3}-[0-9]{4}|(\([0-9]{3}\)|[0-9]{3})[0-9]{3}[0-9]{4}$" 
                            runat="server" />
                        </asp:TableCell>

                    </asp:TableRow>

                    <asp:TableRow runat="server">

                        <asp:TableCell runat="server">Address Line 3:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newAddress3" runat="server"></asp:TextBox>
                        </asp:TableCell>

                       
                        <asp:TableCell runat="server">Work Phone:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newWorkPhone" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator 
                            ErrorMessage="Work Phone Number" 
                            Text="Invalid Work Phone number" 
                            ControlToValidate="newWorkPhone" 
                            ValidationExpression="^(\([0-9]{3}\)|[0-9]{3}-)[0-9]{3}-[0-9]{4}|(\([0-9]{3}\)|[0-9]{3})[0-9]{3}[0-9]{4}$" 
                            runat="server" />
                        </asp:TableCell>

                    
                      <asp:TableCell runat="server">International Cell:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newInternationalCell" runat="server"></asp:TextBox>
                              <asp:RegularExpressionValidator 
                            ErrorMessage="Invalid Cell Number" 
                            Text="Invalid International cell number" 
                            ControlToValidate="newInternationalCell" 
                            ValidationExpression="^(\([0-9]{3}\)|[0-9]{3}-)[0-9]{3}-[0-9]{4}|(\([0-9]{3}\)|[0-9]{3})[0-9]{3}[0-9]{4}$" 
                            runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>

                    <asp:TableRow runat="server">

                        <asp:TableCell runat="server">City:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newCity" runat="server"></asp:TextBox>
                        </asp:TableCell>
                        
                        <asp:TableCell runat="server">Country:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newCountryName" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>
                        <asp:TableCell runat="server">External Representative</asp:TableCell>
                          <asp:TableCell runat="server">
                    <asp:CheckBox ID="ExternalRepStatus" runat="server" OnCheckedChanged="chkBoxExternalRepCheckedChanged" AutoPostBack="true" />

                          </asp:TableCell>
                       

                    </asp:TableRow>


                    <asp:TableRow runat="server">

                        <asp:TableCell runat="server">State Province:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="newStateProvinceName" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Selected="True">Select One</asp:ListItem>
                            </asp:DropDownList>
                        </asp:TableCell>

                        <asp:TableCell runat="server">Fax Number:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newFaxNumber" runat="server"></asp:TextBox>
                              <asp:RegularExpressionValidator 
                            ErrorMessage="Invalid Fax Number" 
                            Text="Invalid Fax Number" 
                            ControlToValidate="newFaxNumber" 
                            ValidationExpression="^(\([0-9]{3}\)|[0-9]{3}-)[0-9]{3}-[0-9]{4}|(\([0-9]{3}\)|[0-9]{3})[0-9]{3}[0-9]{4}$" 
                            runat="server" />
                        </asp:TableCell>

                        <asp:TableCell runat="server">Primary Email:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newPrimaryEmail" runat="server"></asp:TextBox>
                             <asp:RegularExpressionValidator 
                            ErrorMessage="Invalid Primary Address" 
                            Text="Invalid Primary Email Address" 
                            ControlToValidate="newPrimaryEmail" 
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" />
                        </asp:TableCell>

                    </asp:TableRow>

                    <asp:TableRow runat="server">

                      
                        <asp:TableCell runat="server"></asp:TableCell>
                        <asp:TableCell runat="server"></asp:TableCell>
                        <asp:TableCell runat="server">Mobile Phone:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newMobilePhone" runat="server"></asp:TextBox>
                             <asp:RegularExpressionValidator 
                            ErrorMessage="Invalid Mobile Phone Number" 
                            Text="Invalid Mobile Phone Number" 
                            ControlToValidate="newMobilePhone" 
                            ValidationExpression="^(\([0-9]{3}\)|[0-9]{3}-)[0-9]{3}-[0-9]{4}|(\([0-9]{3}\)|[0-9]{3})[0-9]{3}[0-9]{4}$" 
                            runat="server" />
                        </asp:TableCell>

                        <asp:TableCell runat="server">Secondary Email:</asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:TextBox ID="newSecondaryEmail" runat="server"></asp:TextBox>
                             <asp:RegularExpressionValidator 
                            ErrorMessage="Invalid Email Address" 
                            Text="Invalid Secondary Email" 
                            ControlToValidate="newSecondaryEmail" 
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" />
                        </asp:TableCell>

                    </asp:TableRow>
                </asp:Table>
                <br />
                <br />
                <asp:Button ID="btnSaveNewSalesRepresentative" runat="server" Text="Save" OnClick="btnSaveNewSalesRepresentative_Click" />
                <asp:Button ID="btnClose" runat="server" Text="Close" />
            </asp:Panel>
            <!-- ModalPopupExtender -->


        </asp:Content>
