<%@page import="java.util.Iterator"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pack.decryption"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.InputStream"%>
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
      <a href="index.jsp">Home</a><span>/</span>
      <a href="upload.jsp">Upload</a><span>/</span>
      <span class="current">File Preview</span>
    </div>
    <h1 style="margin-top:10px"><i class="fa fa-file-text" style="margin-right:10px;color:#06b6d4"></i>File Block Preview</h1>
    <p>Review the file blocks before final upload</p>
  </div>
</div>

<div class="content-section">
  <div class="container">

    <%
      String status = request.getParameter("status");
      if(status != null && !status.isEmpty()) {
    %>
      <div class="status-msg error" style="margin-bottom:20px"><i class="fa fa-exclamation-circle"></i> <%=status%></div>
    <% } %>

    <div class="info-box" style="margin-bottom:24px">
      <p><strong><i class="fa fa-info-circle" style="margin-right:6px"></i>File Block Deduplication</strong><br>
      Your file has been split into blocks. Our system checks each block for duplicates before encrypting and uploading. Duplicate blocks are automatically skipped to save storage.</p>
    </div>

    <%
      String fname = request.getParameter("filename");
      ArrayList<String> list = new ArrayList<String>();
      FileInputStream fis = new FileInputStream("C:\\Users\\HP 640 G5\\Desktop\\project\\appuploads\\"+fname);
      byte[] bytes = new byte[1024];
      int position = 0;
      while((position = fis.read(bytes)) != -1) {
    	  String block = new String(bytes, 0, position);
    	  list.add(block.trim());
      }
      fis.close();
      session.setAttribute("filelist", list);
      session.setAttribute("filename", fname);
    %>

    <div class="table-card" style="margin-bottom:24px">
      <div class="table-card-header">
        <h3><i class="fa fa-th-large" style="color:#1d4ed8;margin-right:8px"></i>File: <%=fname%></h3>
        <span class="badge-count"><%=list.size()%> Block(s)</span>
      </div>
      <div style="padding:24px">
        <form action="upload" method="post">
          <%
            Iterator<String> it = list.iterator();
            int j = 1;
            while(it.hasNext()) {
              String blo = it.next();
          %>
          <div class="form-group-cc">
            <label>
              <span class="badge-pill badge-info" style="margin-right:8px">Block <%=j%></span>
              <span style="font-size:0.78rem;color:#94a3b8">1024 bytes</span>
            </label>
            <textarea class="form-control-cc" name="content" rows="4"
                      style="font-family:monospace;font-size:0.8rem;resize:vertical;background:#f8fafc"><%=blo%></textarea>
          </div>
          <% j++; } %>
          <div style="margin-top:24px;display:flex;gap:12px">
            <input type="submit" value="Confirm & Upload All Blocks" class="btn-cc-primary" style="flex:1">
            <a href="upload.jsp" class="btn-cc-secondary" style="flex:1;display:flex;align-items:center;justify-content:center">Cancel</a>
          </div>
        </form>
      </div>
    </div>

  </div>
</div>

<%@include file="footer.html"%>
</body>
</html>
