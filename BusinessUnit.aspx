<%@ Page Title="Business Unit" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BusinessUnit.aspx.cs" Inherits="SalesReportingWebsite.BusinessUnit" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <asp:Table ID="Table1" runat="server" Width="100%" Style="margin-bottom: 0px">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Button ID="btnAddNewBusinessUnit" runat="server" Text="Add New Business Unit" OnClick="btnAddNewBusinessUnit_Click" />
                    <asp:HyperLink ID="HiddenAddNewBusinessUnit" runat="server" Style="display: none;" />
                </asp:TableCell>
               
                <asp:TableCell Width="100px">
                    <asp:Label ID="Label1" runat="server" Text="Business Unit Name"></asp:Label>
                    <br />
                    <asp:DropDownList ID="ddlBusinessUnitName" runat="server" AutoPostBack="true" AppendDataBoundItems="true"
                        OnSelectedIndexChanged="ddl_SelectedIndexChanged" Width="40px">
                        <asp:ListItem Selected="True">Select One</asp:ListItem>
                    </asp:DropDownList>
                     </asp:TableCell>
               
                <asp:TableCell Width="100px">
                    <asp:Label ID="Label12" runat="server" Text="Business Unit Manager Name"></asp:Label>
                    <br />
                    <asp:DropDownList ID="ddlBusinessUnitManagerName" runat="server" AutoPostBack="true" AppendDataBoundItems="true"
                        OnSelectedIndexChanged="ddl_SelectedIndexChanged" Width="40px">
                        <asp:ListItem Selected="True">Select One</asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>

                <asp:TableCell Width="100px">
                    <asp:Label ID="Label2" runat="server" Text="Company Name"></asp:Label>
                    <br />
                    <asp:DropDownList ID="ddlCompanyName" runat="server" AutoPostBack="true" AppendDataBoundItems="true"
                        OnSelectedIndexChanged="ddl_SelectedIndexChanged" Width="40px">
                        <asp:ListItem Selected="True">Select One</asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
              
                <asp:TableCell HorizontalAlign="Right">
                    <asp:Button ID="btnExportToExcel" runat="server" Text="Export to Excel" OnClick="btnExportToExcel_Click" />
                     <asp:HyperLink ID="HiddenExportToExcel" runat="server" Style="display: none;" />
                    <br />

                    <asp:CheckBox ID="chkBoxReset" runat="server" OnCheckedChanged="chkBoxResetCheckedChanged" AutoPostBack="true" />
                    Reset Selection
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
        <div>
            <b>
                <asp:Label ID="lblRecordCount" runat="server" Text=""></asp:Label></b>
        </div>
        

         <asp:GridView ID="BusinessUnitGridView" runat="server" AutoGenerateColumns="false"
            Width="98%" Style="margin: 0% 1% 0% 1%" OnRowEditing="BusinessUnit_RowEditing"
            OnRowCancelingEdit="BusinessUnit_RowCancelingEdit" OnRowDataBound="BusinessUnit_RowDataBound"
           OnRowUpdating="BusinessUnit_RowUpdating"  AllowPaging="true"
            PageSize="20" AllowSorting="true"
            OnPageIndexChanging="BusinessUnit_PageIndexChanging"  CssClass="SegmentGV"
            OnSorting="BusinessUnit_SortData" DataKeyNames="BusinessUnitID">
            <HeaderStyle CssClass="gridHeader" />
            <Columns>
                <asp:CommandField ShowEditButton="true" ItemStyle-Width="50" />
                <asp:BoundField DataField="BusinessUnitID" HeaderText="Business Unit ID" Visible="false" ReadOnly="true">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
              
                <asp:TemplateField HeaderText="Business Unit Code">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="BusinessUnitCode" Text='<%# Eval("BusinessUnitCode")%>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="BusinessUnitCode" runat="server" Text='<%# Eval("BusinessUnitCode")%>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Business Unit Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="BusinessUnitName" Text='<%# Eval("BusinessUnitName")%>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="BusinessUnitName" runat="server" Text='<%# Eval("BusinessUnitName")%>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Business Unit Manager">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="BusinessUnitManagerName" Text='<%# Eval("BusinessUnitManagerName")%>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                         <asp:Label ID="lblBusinessUnitManagerName" runat="server" Text='<%# Eval("BusinessUnitManagerName")%>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="BusinessUnitManagerName" runat="server">
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
                <asp:TemplateField HeaderText="Effective Date">
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
    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel1" TargetControlID="HiddenAddNewBusinessunit"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
        <asp:Label ID="Label15" runat="server" Text="" Font-Size="Large" style="text-align:left;">Add New Business Unit</asp:Label>
           	    
        <asp:Table ID="Table2" runat="server">
           
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Business Unit Code:</asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:TextBox ID="newBusinessUnitCode" runat="server" ></asp:TextBox>
                        <asp:RegularExpressionValidator 
                            ErrorMessage="Invalid Business Unit Code" 
                            Text="BusinessUnit Code should be Numbers" 
                            ControlToValidate="newBusinessUnitCode" 
                            ValidationExpression="^[0-9]{1,10}$" 
                            runat="server" />
                </asp:TableCell>
      </asp:TableRow>
             <asp:TableRow runat="server">
                <asp:TableCell runat="server">Business Unit Name:</asp:TableCell>

                <asp:TableCell runat="server">
                    <asp:TextBox ID="newBusinessUnitName" runat="server"></asp:TextBox>
                    </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Business Unit Manager:</asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:DropDownList ID="newBusinessUnitManagerName" runat="server" AppendDataBoundItems="true">
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

         <asp:TableRow runat="server">
                <asp:TableCell runat="server">Effective Date:</asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:TextBox ID="newEffectiveDate" runat="server" CssClass="DateLabel"></asp:TextBox></asp:TableCell>
            </asp:TableRow>
                
        </asp:Table>
        <asp:Button ID="btnSaveNewBusinessUnit" runat="server" Text="Save" OnClick="btnSaveNewBusinessUnit_Click" />
        <asp:Button ID="btnClose" runat="server" Text="Close" />
    </asp:Panel>
    <!-- ModalPopupExtender -->
    <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" PopupControlID="Panel2" TargetControlID="HiddenExportToExcel"
        CancelControlID="btnExcelClose" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="Panel2" runat="server" CssClass="modalPopupSegment" align="center" Style="display: none">
        <asp:Label ID="Label3" runat="server" Text="" Font-Size="Large" style="text-align:left;">Export to Excel</asp:Label>
        <asp:Table ID="Table3" runat="server" Height="123px" Width="567px">
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">
                    <asp:Button ID="excelDownload" runat="server" Text="Download with Expiration Date" OnClick="btnexcelDownloadAll_Click" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server">
                 <asp:TableCell runat="server">
                    <asp:Button ID="excelDownloadExpiration" runat="server" Text="Download without Expiration Date" OnClick="btnexcelDownload_Click" />                   
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Button ID="btnExcelClose" runat="server" Text="Close" />
    </asp:Panel>

</asp:Content>
