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
      <a href="index.jsp">Home</a><span>/</span><span class="current">Admin &mdash; Upload Logs</span>
    </div>
    <h1 style="margin-top:10px"><i class="fa fa-upload" style="margin-right:10px;color:#06b6d4"></i>All File Uploads</h1>
    <p>Monitor all files uploaded to the cloud storage system</p>
  </div>
</div>

<div class="content-section">
  <div class="container">
    <div class="info-box" style="margin-bottom:24px">
      <p><strong><i class="fa fa-info-circle" style="margin-right:6px"></i>Admin View:</strong>
      This dashboard shows every file uploaded by all users. You can see the filename, who uploaded it, and when. Use this to monitor system usage and storage.</p>
    </div>

    <%
      Connection con = Dbconnection.getConn();
      Statement st = con.createStatement();
      ResultSet rt = st.executeQuery("select * from files");
      int rowCount = 0;
    %>

    <div class="table-card">
      <div class="table-card-header">
        <h3><i class="fa fa-cloud-upload" style="color:#1d4ed8;margin-right:8px"></i>Upload History</h3>
        <span class="badge-count">All Records</span>
      </div>
      <div style="overflow-x:auto">
        <table class="cc-table">
          <thead>
            <tr>
              <th>#</th>
              <th>File Name</th>
              <th>Uploaded By</th>
              <th>Upload Date &amp; Time</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <% while(rt.next()) {
                 rowCount++;
                 java.sql.Date exDate = rt.getDate("time");
                 java.sql.Date today  = new java.sql.Date(new java.util.Date().getTime());
                 boolean active = (today.compareTo(exDate) <= 0);
                 String fname = rt.getString("filename");
                 String ext   = fname.contains(".") ? fname.substring(fname.lastIndexOf(".")+1).toUpperCase() : "FILE";
            %>
            <tr>
              <td style="color:#94a3b8;font-size:0.8rem"><%=rowCount%></td>
              <td>
                <div class="td-filename">
                  <div class="file-icon"><i class="fa fa-file"></i></div>
                  <div>
                    <div class="file-name"><%=fname%></div>
                    <div style="font-size:0.72rem;color:#94a3b8"><%=ext%></div>
                  </div>
                </div>
              </td>
              <td>
                <span style="display:inline-flex;align-items:center;gap:6px;font-size:0.875rem">
                  <i class="fa fa-user-circle" style="color:#1d4ed8;font-size:1rem"></i>
                  <%=rt.getString("owner_name")%>
                </span>
              </td>
              <td style="font-size:0.85rem;color:#64748b"><%=rt.getString("upload_time")%></td>
              <td>
                <% if(active) { %>
                  <span class="badge-pill badge-success"><i class="fa fa-circle" style="font-size:0.4rem;margin-right:4px"></i>Active</span>
                <% } else { %>
                  <span class="expired-badge">Expired</span>
                <% } %>
              </td>
            </tr>
            <% } %>
            <% if(rowCount == 0) { %>
            <tr><td colspan="5">
              <div class="empty-state">
                <div class="empty-icon"><i class="fa fa-cloud-upload"></i></div>
                <p style="font-weight:600;color:#475569">No uploads yet</p>
                <p>No files have been uploaded to the system.</p>
              </div>
            </td></tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>

    <div style="margin-top:16px;font-size:0.82rem;color:#94a3b8">
      <i class="fa fa-info-circle" style="margin-right:4px"></i>
      Total records shown: <strong><%=rowCount%></strong>
    </div>
  </div>
</div>

<%@include file="footer.html"%>
</body>
</html>
