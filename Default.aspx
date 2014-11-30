<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="HTTP_Diagnostic_Utility" Debug="true" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title>HTTP Diagnostic Utility</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <link rel="stylesheet" type="text/css" media="screen" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" />
    </head>
    
    <body>
      <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
        <div class="container form-horizontal">
            <h1 class="page-header">HTTP Diagnostic Utility</h1>
            
            <div class="form-group">
                <asp:Label runat="server" CssClass="col-sm-2 control-label" AssociatedControlID="uri">URI</asp:Label>
                <div class="col-sm-10">
                <asp:TextBox ID="uri" runat="server" CssClass="form-control input-lg" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" CssClass="col-sm-2 control-label" AssociatedControlID="method">Method</asp:Label>
                <div class="col-sm-10">
                <asp:DropDownList ID="method" runat="server" CssClass="form-control input-lg">
                    <asp:ListItem Value="get">GET</asp:ListItem>
                    <asp:ListItem Value="post">POST</asp:ListItem>
                </asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" CssClass="col-sm-2 control-label" AssociatedControlID="userAgent">User Agent</asp:Label>
                <div class="col-sm-10">
                <asp:TextBox ID="userAgent" runat="server" CssClass="form-control input-lg" />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" CssClass="col-sm-2 control-label" AssociatedControlID="postData">POST Data</asp:Label>
                <div class="col-sm-10">
                <asp:TextBox ID="postData" runat="server" TextMode="MultiLine" CssClass="form-control input-lg" />
                </div>
            </div>
            
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                      <asp:Button ID="Button1" runat="server" onclick="GenerateRequest" 
                      Text="Generate Request" CssClass="btn btn-primary btn-lg" />
                    </div>
                  </div>
                  
                  <asp:Panel ID="responsePanel" visible="false" runat="server">
                    
                    <hr />
                    
                    <asp:Repeater ID="requestHeaderRepeater" runat="server">
                      <HeaderTemplate>
                        <div class="form-group">
                          <label class="col-sm-2 control-label">Request Headers</label>
                          <div class="col-sm-10">
                            <table class="table table-striped table-hover">
                              <thead>
                                <tr>
                                  <th class="col-sm-3">Header</th>
                                  <th class="col-sm-7">Value</th>
                                </tr>
                              </thead>
                              <tbody>
                      </HeaderTemplate>
                      <ItemTemplate>
                        <tr>
                          <th><%# Container.DataItem %></th>
                          <td><%# ((NameValueCollection)((Repeater)Container.Parent).DataSource)[(string)Container.DataItem] %></td>
                        </tr>
                      </ItemTemplate>
                      <FooterTemplate>
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </FooterTemplate>
                    </asp:Repeater>
                    
                    <div class="form-group">
                      <label class="col-sm-2 control-label">Status Code</label>
                      <div class="col-sm-10">
                        <asp:Label ID="statusCode" runat="server" CssClass="form-control input-lg" />
                      </div>
                    </div>
                    
                    <asp:Repeater ID="responseHeaderRepeater" runat="server">
                      <HeaderTemplate>
                        <div class="form-group">
                          <label class="col-sm-2 control-label">Response Headers</label>
                          <div class="col-sm-10">
                            <table class="table table-striped table-hover">
                              <thead>
                                <tr>
                                  <th class="col-sm-3">Header</th>
                                  <th class="col-sm-7">Value</th>
                                </tr>
                              </thead>
                              <tbody>
                      </HeaderTemplate>
                      <ItemTemplate>
                        <tr>
                          <th><%# Container.DataItem %></th>
                          <td><%# ((NameValueCollection)((Repeater)Container.Parent).DataSource)[(string)Container.DataItem] %></td>
                        </tr>
                      </ItemTemplate>
                      <FooterTemplate>
                              </tbody>
                            </table>
                          </div>
                        </div>
                      </FooterTemplate>
                    </asp:Repeater>
                    
                    <div class="form-group">
                      <asp:Label runat="server" CssClass="col-sm-2 control-label" AssociatedControlID="response">Response Payload</asp:Label>
                      <div class="col-sm-10">
                        <pre class="pre-scrollable"><asp:Literal runat="server" ID="response" Mode="Encode" /></pre>
                      </div>
                    </div>
                    
                  </asp:Panel>
                  
                </ContentTemplate>
            </asp:UpdatePanel>
            
        </div>
      </form>
    </body>
</html>