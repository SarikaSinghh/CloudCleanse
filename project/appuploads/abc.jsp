<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="pack.Dbconnection"%>
<!DOCTYPE html>
<html lang="en">
<head><%@include file="header.html"%></head>
<body>
<%@include file="menu2.jsp"%>

<div class="page-banner">
  <div class="container">
    <div class="breadcrumb-cc">
      <a href="index.jsp">Home</a><span>/</span><span class="current">Admin &mdash; Download Logs</span>
    </div>
    <h1 style="margin-top:10px"><i class="fa fa-download" style="margin-right:10px;color:#06b6d4"></i>Download Activity Log</h1>
    <p>Track who downloaded which files and when</p>
  </div>
</div>

<div class="content-section">
  <div class="container">
    <div class="tip-box" style="margin-bottom:24px">
      <p><strong><i class="fa fa-eye" style="margin-right:6px;color:#06b6d4"></i>Admin View:</strong>
      This log records every file download across the entire system. Use this to audit file access, track usage, and monitor security.</p>
    </div>

    <%
      Connection con = Dbconnection.getConn();
      Statement st = con.createStatement();
      ResultSet rt = st.executeQuery("select * from downloads");
      int cnt = 0;
    %>

    <div class="table-card">
      <div class="table-card-header">
        <h3><i class="fa fa-history" style="color:#1d4ed8;margin-right:8px"></i>Download History</h3>
        <span class="badge-count">All Records</span>
      </div>
      <div style="overflow-x:auto">
        <table class="cc-table">
          <thead>
            <tr>
              <th>#</th>
              <th>File Name</th>
              <th>Downloaded By</th>
              <th>Downloaded At</th>
            </tr>
          </thead>
          <tbody>
            <% while(rt.next()) {
                 cnt++;
                 String fname = rt.getString("filename");
                 String ext   = fname.contains(".") ? fname.substring(fname.lastIndexOf(".")+1).toUpperCase() : "FILE";
            %>
            <tr>
              <td style="color:#94a3b8;font-size:0.8rem"><%=cnt%></td>
              <td>
                <div class="td-filename">
                  <div class="file-icon"><i class="fa fa-file-text"></i></div>
                  <div>
                    <div class="file-name"><%=fname%></div>
                    <div style="font-size:0.72rem;color:#94a3b8"><%=ext%></div>
                  </div>
                </div>
              </td>
              <td>
                <span style="display:inline-flex;align-items:center;gap:6px;font-size:0.875rem">
                  <i class="fa fa-user-circle" style="color:#06b6d4;font-size:1rem"></i>
                  <%=rt.getString("username")%>
                </span>
              </td>
              <td style="font-size:0.85rem;color:#64748b"><%=rt.getString("time")%></td>
            </tr>
            <% } %>
            <% if(cnt == 0) { %>
            <tr><td colspan="4">
              <div class="empty-state">
                <div class="empty-icon"><i class="fa fa-download"></i></div>
                <p style="font-weight:600;color:#475569">No downloads yet</p>
                <p>No files have been downloaded yet.</p>
              </div>
            </td></tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>

    <div style="margin-top:16px;font-size:0.82rem;color:#94a3b8">
      <i class="fa fa-info-circle" style="margin-right:4px"></i>
      Total download records: <strong><%=cnt%></strong>
    </div>
  </div>
</div>

<%@include file="footer.html"%>
</body>
</html>
