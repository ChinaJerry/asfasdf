<%@ Page Language="C#" %>
<script language="c#" runat="server">
    string strPath = "";
 
    void AddRecord(object sender, EventArgs e)
    {
        customersDS.InsertParameters[0].DefaultValue = cid.Text;
        customersDS.InsertParameters[1].DefaultValue = cname.Text;
        customersDS.InsertParameters[2].DefaultValue = cemail.Text;
        //customersDS.InsertParameters[3].DefaultValue = cpic.Text; 
        customersDS.InsertParameters[3].DefaultValue = cid.Text+@".jpg"; 
        customersDS.Insert();

        gvCustomers.DataBind();


        if (fileUploadFILE.HasFile)
        {
            UpLoadFile(cid.Text + @".jpg");
        }
        else
        {

        }

    }

    void UpLoadFile(string strFileName)
    {
        strPath =
          Server.MapPath(".") + @"\images\" + strFileName;

        fileUploadFILE.PostedFile.SaveAs(strPath);
    }

</script>


<html>
    <head><title>AccessDataSource Control</title></head>
    <body>
<asp:AccessDataSource
    id="customersDS"
    DataFile="customers.accdb"
    runat="server"
    SelectCommand="SELECT customer_id, customer_name, customer_email, customer_pic FROM customers"
    InsertCommand="INSERT INTO [customers] ([customer_id], [customer_name], [customer_email], [customer_pic]) VALUES (?, ?, ?, ?)" >
  <InsertParameters> 
   <asp:Parameter Name="cid" Type="Int32" /> 
   <asp:Parameter Name="cname" Type="String" /> 
   <asp:Parameter Name="cemail" Type="String" /> 
   <asp:Parameter Name="cpic" Type="String" /> 
  </InsertParameters>

</asp:AccessDataSource>
        <form id="Form1" runat="server">
            <asp:GridView id="gvCustomers" 
                HeaderStyle-BackColor="CornflowerBlue" 
                HeaderStyle-ForeColor="White"
                runat="server" DataSourceID="customersDS"
                CellPadding="3"
                Font-Names="arial"
                Font-Size="12pt"
                AutoGenerateColumns="false">
                
                <Columns>
                    <asp:BoundField DataField="customer_id" 
                        HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="customer_name" 
                        HeaderText="Name" />
                    <asp:BoundField DataField="customer_email" 
                        HeaderText="Email" />
                    <asp:ImageField AlternateText="customer image"  
                        DataImageUrlField="customer_pic" DataImageUrlFormatString="images/{0}" HeaderText="Photo" />
                </Columns>
                
            </asp:GridView>
            <p />
            

                    <table>
                    <tr>
                        <td>Customer ID:</td>
                        <td><asp:TextBox ID="cid" runat="server" Text='<%# Bind("customer_id") %>' Width="50" /></td>
                    </tr>
                    <tr>
                        <td>Customer Name:</td>
                        <td><asp:TextBox ID="cname" runat="server" Text='<%# Bind("customer_name") %>' Width="200"/></td>
                    </tr>
                    <tr>
                        <td>Customer Email:</td>
                        <td><asp:TextBox ID="cemail" runat="server" Text='<%# Bind("customer_email") %>' Width="200" /></td>
                    </tr>
                    <tr>
                        <td>Customer Pic:</td>
                        <td><asp:FileUpload ID="fileUploadFILE" runat="server" width="430" />
                            <asp:HiddenField ID="cpic" runat="server"  /></td>

                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    </table>
                                     
                    <asp:Button ID="btnInsert" runat="server" 
                        CausesValidation="True" OnClick="AddRecord" Text="Add"   />
                    <asp:Button ID="btnCancel" runat="server" 
                        CausesValidation="False" CommandName="Cancel" Text="Cancel" />
  
            
        </form>
    </body>
</html>