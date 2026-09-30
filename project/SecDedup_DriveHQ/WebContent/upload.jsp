<!DOCTYPE html>
<html lang="en">
<head><%@include file="header.html"%></head>
<body>
<%@include file="menu2.jsp"%>

<%
  HttpSession userSession = request.getSession();
  Object unameObj = userSession.getAttribute("username");
  Object nameObj  = userSession.getAttribute("name");
  if(unameObj == null) { response.sendRedirect("user.jsp?status=Please login first"); return; }
  String uname = unameObj.toString();
  String name  = nameObj  != null ? nameObj.toString() : uname;
  String status = request.getParameter("status");
%>

<!-- Page Banner -->
<div class="page-banner">
  <div class="container">
    <div class="breadcrumb-cc">
      <a href="index.jsp">Home</a><span>/</span><span class="current">Upload File</span>
    </div>
    <h1 style="margin-top:10px"><i class="fa fa-cloud-upload" style="margin-right:10px;color:#06b6d4"></i>Upload a File</h1>
    <p>Encrypt and store your file securely in the cloud</p>
  </div>
</div>

<div class="content-section">
  <div class="container">
    <div class="welcome-bar">
      <span class="wi"><i class="fa fa-user-circle" style="color:#1d4ed8"></i></span>
      Welcome, <strong style="margin:0 4px"><%=name%></strong>! Ready to upload a file?
    </div>

    <% if(status != null && !status.isEmpty()) { %>
      <div class="status-msg error" style="max-width:700px;margin-bottom:20px"><i class="fa fa-exclamation-circle"></i> <%=status%></div>
    <% } %>

    <div class="row">
      <!-- FORM -->
      <div class="col-md-7" style="margin-bottom:30px">
        <div class="form-card" style="max-width:100%">
          <div class="form-card-header" style="padding:24px 32px 20px">
            <div style="display:flex;align-items:center;gap:12px">
              <div class="header-icon" style="width:48px;height:48px;font-size:1.3rem;margin:0"><i class="fa fa-upload"></i></div>
              <div style="text-align:left">
                <h2 style="font-size:1.2rem;margin:0">Upload New File</h2>
                <p style="font-size:0.8rem;margin:0">File will be encrypted before upload</p>
              </div>
            </div>
          </div>
          <div class="form-card-body">
            <form action="AddFileServlet" method="post" enctype="multipart/form-data">
              <div class="form-group-cc">
                <label>Select File <span class="required">*</span></label>
                <div class="upload-dropzone">
                  <input type="file" name="file" required>
                  <div class="dz-icon"><i class="fa fa-cloud-upload"></i></div>
                  <p style="font-weight:600;color:#334155;margin-bottom:4px">Click to browse or drag & drop</p>
                  <small>Supports all file types &bull; File will be AES encrypted automatically</small>
                </div>
                <span class="form-hint"><i class="fa fa-lock" style="color:#10b981;margin-right:4px"></i>Your file will be encrypted with AES before being stored</span>
              </div>

              <div class="form-group-cc">
                <label>Access Expiry Date <span class="required">*</span></label>
                <input type="text" class="form-control-cc" name="time" placeholder="dd-MM-yyyy  e.g. 31-12-2026" required>
                <span class="form-hint"><i class="fa fa-calendar" style="color:#1d4ed8;margin-right:4px"></i>After this date, the download link will automatically expire. Format: <strong>dd-MM-yyyy</strong></span>
              </div>

              <div style="margin-top:28px">
                <input type="submit" value="Upload & Encrypt File" class="btn-cc-primary" style="display:block;width:100%">
              </div>
            </form>
          </div>
        </div>
      </div>

      <!-- TIPS PANEL -->
      <div class="col-md-5" style="margin-bottom:30px">
        <div class="tip-box" style="margin-bottom:16px">
          <p><strong><i class="fa fa-lightbulb-o" style="color:#06b6d4;margin-right:6px"></i>How Uploads Work</strong></p>
          <ol style="margin:10px 0 0 16px;padding:0;font-size:0.84rem;color:#475569;line-height:2">
            <li>Your file is split into blocks and hashed</li>
            <li>Duplicate blocks are automatically detected</li>
            <li>Unique blocks are encrypted with AES</li>
            <li>Encrypted file is uploaded to cloud via FTP</li>
            <li>A unique access key is generated for sharing</li>
          </ol>
        </div>
        <div class="info-box" style="margin-bottom:16px">
          <p><strong><i class="fa fa-key" style="margin-right:6px"></i>Access Key</strong><br>
          After uploading, a unique key is generated for your file. Share this key with others so they can download it securely.</p>
        </div>
        <div class="warning-box">
          <p><strong><i class="fa fa-clock-o" style="margin-right:6px"></i>Set the Right Expiry Date</strong><br>
          Choose a realistic date. Once expired, even you cannot download the file. You can delete it and re-upload if needed.</p>
        </div>
        <div style="background:#f8fafc;border-radius:12px;padding:20px;border:1px solid #e2e8f0;margin-top:16px">
          <h5 style="font-size:0.88rem;color:#1e293b;margin-bottom:12px"><i class="fa fa-folder-open" style="color:#1d4ed8;margin-right:8px"></i>Quick Actions</h5>
          <a href="download.jsp" class="btn-action download" style="display:block;text-align:center;margin-bottom:8px;padding:10px">
            <i class="fa fa-folder"></i> View My Files
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<%@include file="footer.html"%>
</body>
</html>
