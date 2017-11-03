<%@ Page Title="Sub Business Unit" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SubBusinessUnit.aspx.cs" Inherits="SalesReportingWebsite.SubBusinessUnit" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <asp:Table ID="Table1" runat="server" Width="100%" Style="margin-bottom: 0px">
            <asp:TableRow>
                <asp:TableCell>
                    <asp:Button ID="btnAddNewSubBusinessUnit" runat="server" Text="Add New Sub Business Unit" OnClick="btnAddNewSubBusinessUnit_Click" />
                    <asp:HyperLink ID="HiddenAddNewSubBusinessUnit" runat="server" Style="display: none;" />
                </asp:TableCell>
               
                <asp:TableCell Width="100px">
                    <asp:Label ID="Label1" runat="server" Text="Sub Business Unit Name"></asp:Label>
                    <br />
                    <asp:DropDownList ID="ddlSubBusinessUnitName" runat="server" AutoPostBack="true" AppendDataBoundItems="true"
                        OnSelectedIndexChanged="ddl_SelectedIndexChanged" Width="40px">
                        <asp:ListItem Selected="True">Select One</asp:ListItem>
                    </asp:DropDownList>
                     </asp:TableCell>
               
                <asp:TableCell Width="100px">
                    <asp:Label ID="Label12" runat="server" Text="Sub Business Unit Manager"></asp:Label>
                    <br />
                    <asp:DropDownList ID="ddlSubBusinessUnitManagerName" runat="server" AutoPostBack="true" AppendDataBoundItems="true"
                        OnSelectedIndexChanged="ddl_SelectedIndexChanged" Width="40px">
                        <asp:ListItem Selected="True">Select One</asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>

                <asp:TableCell Width="100px">
                    <asp:Label ID="Label3" runat="server" Text="Business Unit Name"></asp:Label>
                    <br />
                    <asp:DropDownList ID="ddlBusinessUnitName" runat="server" AutoPostBack="true" AppendDataBoundItems="true"
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
        

         <asp:GridView ID="SubBusinessUnitGridView" runat="server" AutoGenerateColumns="false"
            Width="98%" Style="margin: 0% 1% 0% 1%" OnRowEditing="SubBusinessUnit_RowEditing"
            OnRowCancelingEdit="SubBusinessUnit_RowCancelingEdit" OnRowDataBound="SubBusinessUnit_RowDataBound"
           OnRowUpdating="SubBusinessUnit_RowUpdating"  AllowPaging="true"
            PageSize="20" AllowSorting="true"
            OnPageIndexChanging="SubBusinessUnit_PageIndexChanging"  CssClass="SegmentGV"
            OnSorting="SubBusinessUnit_SortData" DataKeyNames="SubBusinessUnitID">
            <HeaderStyle CssClass="gridHeader" />
            <Columns>
                <asp:CommandField ShowEditButton="true" ItemStyle-Width="50" />
                <asp:BoundField DataField="SubBusinessUnitID" HeaderText="Sub Business Unit ID" Visible="false" ReadOnly="true">
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                </asp:BoundField>
              
                <asp:TemplateField HeaderText="Sub Business Unit Code">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="SubBusinessUnitCode" Text='<%# Eval("SubBusinessUnitCode")%>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="SubBusinessUnitCode" runat="server" Text='<%# Eval("SubBusinessUnitCode")%>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sub Business Unit Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="SubBusinessUnitName" Text='<%# Eval("SubBusinessUnitName")%>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="SubBusinessUnitName" runat="server" Text='<%# Eval("SubBusinessUnitName")%>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Sub Business Unit Manager">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblSubBusinessUnitManagerName" Text='<%# Eval("SubBusinessUnitManagerName")%>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                         <asp:Label ID="lblSubBusinessUnitManagerName" runat="server" Text='<%# Eval("SubBusinessUnitManagerName")%>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="SubBusinessUnitManagerName" runat="server">
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>


                 <asp:TemplateField HeaderText="Business Unit Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblBusinessUnitName" Text='<%# Eval("BusinessUnitName")%>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                         <asp:Label ID="lblBusinessUnitName" runat="server" Text='<%# Eval("BusinessUnitName")%>' Visible="false"></asp:Label>
                        <asp:DropDownList ID="BusinessUnitName" runat="server">
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="Company Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblCompanyName" Text='<%# Eval("CompanyName")%>'></asp:Label>
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
    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel1" TargetControlID="HiddenAddNewSubBusinessunit"
        CancelControlID="btnClose" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" Style="display: none">
        <asp:Label ID="Label15" runat="server" Text="" Font-Size="Large" style="text-align:left;">Add New Sub Business Unit</asp:Label>
           	    
        <asp:Table ID="Table2" runat="server">
           
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Sub Business Unit Code:</asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:TextBox ID="newSubBusinessUnitCode" runat="server" ></asp:TextBox>
                </asp:TableCell>
      </asp:TableRow>
             <asp:TableRow runat="server">
                <asp:TableCell runat="server">Sub Business Unit Name:</asp:TableCell>

                <asp:TableCell runat="server">
                    <asp:TextBox ID="newSubBusinessUnitName" runat="server"></asp:TextBox>
                    </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Sub Segment Name:</asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:DropDownList ID="newSubSegmentName" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Selected="True">Select One</asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>


            <asp:TableRow runat="server">
                <asp:TableCell runat="server">Sub Business Unit Manager:</asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:DropDownList ID="newSubBusinessUnitManagerName" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Selected="True">Select One</asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>

                <asp:TableRow runat="server">
                <asp:TableCell runat="server">Business Unit Name:</asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:DropDownList ID="newBusinessUnitName" runat="server" AppendDataBoundItems="true">
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
        <asp:Button ID="btnSaveNewSubBusinessUnit" runat="server" Text="Save" OnClick="btnSaveNewSubBusinessUnit_Click" />
        <asp:Button ID="btnClose" runat="server" Text="Close" />
    </asp:Panel>
    <!-- ModalPopupExtender -->
     <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" PopupControlID="Panel2" TargetControlID="HiddenExportToExcel"
        CancelControlID="btnExcelClose" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>
    <asp:Panel ID="Panel2" runat="server" CssClass="modalPopupSegment" align="center" Style="display: none">
        <asp:Label ID="Label4" runat="server" Text="" Font-Size="Large" style="text-align:left;">Export to Excel</asp:Label>
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
