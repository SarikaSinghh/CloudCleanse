<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="pack.Dbconnection"%>
<%@page import="java.sql.Connection"%>
<html lang="en">
<head><%@include file="header.html"%></head>
<body>
<%@include file="menu2.jsp"%>

<div class="form-page-bg" style="align-items:center">
  <div class="container">
    <div class="row" style="justify-content:center;align-items:center">

      <!-- LEFT: Info -->
      <div class="col-md-5" style="padding-right:30px;margin-bottom:30px">
        <span class="section-label"><i class="fa fa-key" style="margin-right:6px"></i>Secure Access</span>
        <h2 class="section-title" style="margin-top:10px">Validate File Key</h2>
        <div class="divider" style="margin:14px 0 20px;margin-left:0"></div>
        <p style="font-size:0.92rem;color:#64748b;line-height:1.8;margin-bottom:24px">
          This file is owned by someone else. To download it, you need the unique access key that the owner shared with you.
        </p>
        <div class="tip-box" style="margin-bottom:16px">
          <p><strong><i class="fa fa-lightbulb-o" style="color:#06b6d4;margin-right:6px"></i>How Access Keys Work</strong></p>
          <ul style="margin-top:10px;padding-left:0;list-style:none;font-size:0.84rem;color:#475569">
            <li style="margin-bottom:8px"><i class="fa fa-circle" style="font-size:0.4rem;color:#06b6d4;margin-right:8px;vertical-align:middle"></i>The file owner receives a unique key after uploading</li>
            <li style="margin-bottom:8px"><i class="fa fa-circle" style="font-size:0.4rem;color:#06b6d4;margin-right:8px;vertical-align:middle"></i>They share this key with authorized recipients</li>
            <li style="margin-bottom:8px"><i class="fa fa-circle" style="font-size:0.4rem;color:#06b6d4;margin-right:8px;vertical-align:middle"></i>Enter the key below to download the file</li>
            <li><i class="fa fa-circle" style="font-size:0.4rem;color:#06b6d4;margin-right:8px;vertical-align:middle"></i>Keys expire along with the file access date</li>
          </ul>
        </div>
        <div class="warning-box">
          <p><strong><i class="fa fa-exclamation-triangle" style="margin-right:6px"></i>Do not share keys publicly</strong><br>
          Access keys should only be shared privately between the file owner and intended recipient to maintain file security.</p>
        </div>
        <div style="margin-top:16px">
          <a href="download.jsp" class="btn-action download" style="display:inline-flex">
            <i class="fa fa-arrow-left"></i> Back to My Files
          </a>
        </div>
      </div>

      <!-- RIGHT: Form -->
      <div class="col-md-5">
        <div class="form-card">
          <div class="form-card-header">
            <div class="header-icon"><i class="fa fa-key"></i></div>
            <h2>Enter Access Key</h2>
            <p>Enter the key provided by the file owner</p>
          </div>
          <div class="form-card-body">
            <%
              String status = request.getParameter("status");
              if(status != null && !status.isEmpty()) {
                boolean isError = status.toLowerCase().contains("invalid") || status.toLowerCase().contains("error");
            %>
              <div class="status-msg <%=isError?"error":"success"%>">
                <i class="fa fa-<%=isError?"exclamation":"check"%>-circle"></i> <%=status%>
              </div>
            <% } %>

            <form action="validate.jsp" method="get">
              <input type="hidden" name="fid" value="<%=request.getParameter("fileid") != null ? request.getParameter("fileid") : request.getParameter("fid")%>">

              <div class="form-group-cc">
                <label>File Access Key <span class="required">*</span></label>
                <input type="text" class="form-control-cc" name="filekey"
                       placeholder="Paste the access key here" required autofocus>
                <span class="form-hint"><i class="fa fa-shield" style="color:#10b981;margin-right:4px"></i>The key was provided by the file owner. It is case-sensitive.</span>
              </div>

              <div style="margin-top:28px">
                <input type="submit" value="Validate & Download" class="btn-cc-primary" style="display:block;width:100%">
              </div>
            </form>

            <div class="form-alt-link">
              <a href="download.jsp"><i class="fa fa-arrow-left" style="margin-right:4px"></i>Back to file list</a>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<%
  String fid = request.getParameter("fid");
  String ukey = request.getParameter("filekey");

  if(fid != null && ukey != null) {
    Connection con = Dbconnection.getConn();
    PreparedStatement pst = con.prepareStatement("select * from files where idfiles=?");
    pst.setString(1, fid);
    ResultSet rt = pst.executeQuery();
    String fkey="", fname="";
    while(rt.next()) { fkey = rt.getString("accesskey"); fname = rt.getString("filename"); }
    if(fkey.equals(ukey)) {
      response.sendRedirect("download?fileid="+fid+"&filename="+fname);
    } else {
      response.sendRedirect("download.jsp?status=Invalid access key. Please check and try again.");
    }
  }
%>

<%@include file="footer.html"%>
</body>
</html>
