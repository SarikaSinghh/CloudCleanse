<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="pack.Dbconnection"%>
<!DOCTYPE html>
<html lang="en">
<head><%@include file="header.html"%></head>
<body>
<%@include file="menu2.jsp"%>
<%
  HttpSession userSess = request.getSession();
  if(userSess.getAttribute("username") == null){ response.sendRedirect("user.jsp?status=Please login first"); return; }
  String uname = userSess.getAttribute("username").toString();
  String name  = userSess.getAttribute("name") != null ? userSess.getAttribute("name").toString() : uname;
  String status = request.getParameter("status");
  String fid = request.getParameter("fid");
  Connection con = Dbconnection.getConn();
  if(fid != null && !fid.isEmpty()) {
    PreparedStatement stDel1 = con.prepareStatement("delete from fileblocks where fileid=?");
    stDel1.setString(1, fid); stDel1.executeUpdate();
    PreparedStatement stDel2 = con.prepareStatement("delete from files where idfiles=?");
    stDel2.setString(1, fid); stDel2.executeUpdate();
    response.sendRedirect("download.jsp?status=File deleted successfully");
    return;
  }
  PreparedStatement st = con.prepareStatement("select * from files");
  ResultSet rt = st.executeQuery();
%>

<div class="page-banner">
  <div class="container">
    <div class="breadcrumb-cc">
      <a href="index.jsp">Home</a><span>/</span><span class="current">My Files</span>
    </div>
    <h1 style="margin-top:10px"><i class="fa fa-folder-open" style="margin-right:10px;color:#06b6d4"></i>Cloud File Manager</h1>
    <p>View, download, and manage all your cloud-stored files</p>
  </div>
</div>

<div class="content-section">
  <div class="container">
    <div class="welcome-bar">
      <span class="wi"><i class="fa fa-user-circle" style="color:#1d4ed8"></i></span>
      Logged in as <strong style="margin:0 4px"><%=name%></strong>
      &nbsp;&mdash;&nbsp;
      <span style="font-size:0.85rem;color:#64748b"><i class="fa fa-info-circle" style="margin-right:4px"></i>Your files are highlighted. Others require an access key to download.</span>
    </div>

    <% if(status != null && !status.isEmpty()) {
       String msgClass = status.toLowerCase().contains("delete") ? "success" : "error"; %>
      <div class="status-msg <%=msgClass%>" style="margin-bottom:20px">
        <i class="fa fa-<%=msgClass.equals("success")?"check":"exclamation"%>-circle"></i> <%=status%>
      </div>
    <% } %>

    <div class="tip-box" style="margin-bottom:24px">
      <p style="font-size:0.84rem"><i class="fa fa-key" style="color:#06b6d4;margin-right:6px"></i>
        <strong>Access Keys:</strong> Files you own show a direct Download button. Files shared by others require you to validate an access key.
        &nbsp;&bull;&nbsp;
        <i class="fa fa-clock-o" style="color:#f59e0b;margin-right:4px"></i><strong>Expired</strong> files can no longer be downloaded.
      </p>
    </div>

    <div class="table-card">
      <div class="table-card-header">
        <h3><i class="fa fa-files-o" style="color:#1d4ed8;margin-right:8px"></i>All Files</h3>
        <a href="upload.jsp" class="btn-action download" style="padding:8px 18px">
          <i class="fa fa-plus"></i> Upload New File
        </a>
      </div>
      <div style="overflow-x:auto">
        <table class="cc-table">
          <thead>
            <tr>
              <th>File Name</th><th>Owner</th><th>Uploaded On</th><th>Status</th><th>Download</th><th>Action</th>
            </tr>
          </thead>
          <tbody>
            <%
              boolean hasRows = false;
              while(rt.next()) {
                hasRows = true;
                String rowId    = rt.getString("idfiles");
                String owner    = rt.getString("owner_name");
                String filename = rt.getString("filename");
                String upTime   = rt.getString("upload_time");
                boolean isOwner = owner.equals(uname);
                java.sql.Date exDate = rt.getDate("time");
                java.sql.Date today  = new java.sql.Date(new java.util.Date().getTime());
                boolean active = (today.compareTo(exDate) <= 0);
                String ext = filename.contains(".") ? filename.substring(filename.lastIndexOf(".")+1).toUpperCase() : "FILE";
            %>
            <tr style="<%=isOwner?"background:rgba(29,78,216,0.03)":""%>">
              <td><div class="td-filename"><div class="file-icon"><i class="fa fa-file"></i></div><div><div class="file-name"><%=filename%></div><div style="font-size:0.75rem;color:#94a3b8"><%=ext%></div></div></div></td>
              <td class="td-owner">
                <% if(isOwner) { %><span class="badge-pill badge-info"><i class="fa fa-user" style="margin-right:4px"></i>You</span>
                <% } else { %><span style="color:#64748b;font-size:0.85rem"><%=owner%></span><% } %>
              </td>
              <td style="font-size:0.85rem;color:#64748b"><%=upTime%></td>
              <td>
                <% if(active) { %><span class="badge-pill badge-success"><i class="fa fa-circle" style="font-size:0.4rem;margin-right:4px"></i>Active</span>
                <% } else { %><span class="expired-badge"><i class="fa fa-times-circle" style="margin-right:4px"></i>Expired</span><% } %>
              </td>
              <td>
                <% if(active) { if(isOwner) { %><a href="download?fileid=<%=rowId%>&filename=<%=filename%>" class="btn-action download"><i class="fa fa-download"></i> Download</a>
                <% } else { %><a href="validate.jsp?fileid=<%=rowId%>" class="btn-action validate"><i class="fa fa-key"></i> Enter Key</a>
                <% } } else { %><span class="expired-badge">N/A</span><% } %>
              </td>
              <td>
                <% if(isOwner) { %><a href="download.jsp?fid=<%=rowId%>" class="btn-action delete" onclick="return confirm('Delete this file? This cannot be undone.')"><i class="fa fa-trash"></i> Delete</a>
                <% } else { %><span style="color:#cbd5e1;font-size:0.8rem">-</span><% } %>
              </td>
            </tr>
            <% } if(!hasRows) { %>
            <tr><td colspan="6"><div class="empty-state"><div class="empty-icon"><i class="fa fa-folder-open"></i></div>
              <p style="font-weight:600;color:#475569;margin-bottom:8px">No files yet</p>
              <p>Upload your first file to get started!</p>
              <a href="upload.jsp" class="btn-action download" style="margin-top:12px;display:inline-flex"><i class="fa fa-upload"></i> Upload Now</a>
            </div></td></tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<%@include file="footer.html"%>
</body>
</html>
