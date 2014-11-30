using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Text;

/*
 * WebResopnse implements IDisposable:
 * 
 * http://stackoverflow.com/questions/1949610/how-can-i-catch-a-404
 * http://stackoverflow.com/questions/1330856/getting-http-status-code-number-200-301-404-etc-from-httpwebrequest-and-ht
 * http://stackoverflow.com/questions/16619065/curl-request-with-asp-net
 */

public partial class HTTP_Diagnostic_Utility : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        this.EnableViewState = false;
        
        uri.Text = "http://apple.com/";
        userAgent.Text = Request.UserAgent;
    }
        
    protected void GenerateRequest(object sender, EventArgs e)
    {
        // Create request
        HttpWebRequest webRequest = (HttpWebRequest) WebRequest.Create(uri.Text);
        webRequest.AllowAutoRedirect = false;
        
        // Assign User Agent if non-empty
        if (userAgent.Text.Trim() != "")
        {
            webRequest.UserAgent = userAgent.Text;
        }
        
        // Set request method
        if (method.SelectedValue == "post")
        {          
            webRequest.Method = "POST";
            webRequest.ContentLength = postData.Text.Length;
            webRequest.ContentType = "application/x-www-form-urlencoded";
            
            UTF8Encoding encoding = new UTF8Encoding();
            
            Stream dataStream = webRequest.GetRequestStream();
            
            dataStream.Write(encoding.GetBytes(postData.Text), 0, postData.Text.Length);
            dataStream.Close();
        }
        
        HttpWebResponse webResponse;
        
        // Catch 400 and 500 errors
        try
        {
            webResponse = (HttpWebResponse) webRequest.GetResponse();
        }
        catch (WebException we)
        {
            webResponse = (HttpWebResponse) we.Response;
        }
        
        int numericStatusCode = (int) webResponse.StatusCode;
        
        statusCode.Text = "HTTP/" + webResponse.ProtocolVersion + " " + numericStatusCode + " " + webResponse.StatusCode;
        statusCode.CssClass = "form-control input-lg ";
        
        switch (numericStatusCode) {
          case 200:
            statusCode.CssClass += "btn-success";
            break;
          case 301:
          case 302:
          case 304:
            statusCode.CssClass += "btn-warning";
            break;
          case 403:
          case 404:
          case 410:
          case 411:
            statusCode.CssClass += "btn-danger";
            break;
          case 500:
          case 503:
            statusCode.CssClass += "btn-danger";
            break;
          default:
            statusCode.CssClass += "btn-info";
            break;
        }
        
        requestHeaderRepeater.DataSource = webRequest.Headers;
        requestHeaderRepeater.DataBind();
        
        responseHeaderRepeater.DataSource = webResponse.Headers;
        responseHeaderRepeater.DataBind();
        
        StreamReader reader = new StreamReader(webResponse.GetResponseStream());
        response.Text = reader.ReadToEnd();
        
        responsePanel.Visible = true;
    }
}