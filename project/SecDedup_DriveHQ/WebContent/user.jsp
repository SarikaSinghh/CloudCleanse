<!DOCTYPE html>
<html lang="en">
<head><%@include file="header.html"%></head>
<body>
<%@include file="menu1.html"%>

<div class="form-page-bg" style="align-items:center">
  <div class="container">
    <div class="row" style="justify-content:center;align-items:center">

      <!-- LEFT: Feature highlights -->
      <div class="col-md-5" style="padding-right:30px;margin-bottom:30px">
        <span class="section-label"><i class="fa fa-sign-in" style="margin-right:6px"></i>User Portal</span>
        <h2 class="section-title" style="margin-top:10px">Welcome Back!</h2>
        <div class="divider" style="margin:14px 0 20px;margin-left:0"></div>
        <p style="font-size:0.92rem;color:#64748b;line-height:1.8;margin-bottom:24px">
          Sign in to access your personal cloud storage. Upload files, manage downloads, and share securely with access keys.
        </p>
        <div class="tip-box" style="margin-bottom:16px">
          <p><strong><i class="fa fa-info-circle" style="margin-right:6px;color:#06b6d4"></i>What can you do?</strong></p>
          <ul style="margin-top:8px;padding-left:0;list-style:none">
            <li style="font-size:0.84rem;color:#475569;margin-bottom:6px"><i class="fa fa-upload" style="color:#1d4ed8;margin-right:8px;width:14px"></i>Upload & encrypt files</li>
            <li style="font-size:0.84rem;color:#475569;margin-bottom:6px"><i class="fa fa-download" style="color:#1d4ed8;margin-right:8px;width:14px"></i>Download your files</li>
            <li style="font-size:0.84rem;color:#475569;margin-bottom:6px"><i class="fa fa-share-alt" style="color:#1d4ed8;margin-right:8px;width:14px"></i>Share with access keys</li>
            <li style="font-size:0.84rem;color:#475569"><i class="fa fa-trash" style="color:#1d4ed8;margin-right:8px;width:14px"></i>Delete your own files</li>
          </ul>
        </div>
        <div class="warning-box">
          <p><strong><i class="fa fa-exclamation-triangle" style="margin-right:6px"></i>First time?</strong><br>
          You need to <a href="register.jsp" style="color:#d97706;font-weight:600">create an account</a> before you can login. Registration is free and takes only a minute!</p>
        </div>
      </div>

      <!-- RIGHT: Login Card -->
      <div class="col-md-5">
        <div class="form-card">
          <div class="form-card-header">
            <div class="header-icon"><i class="fa fa-user-circle"></i></div>
            <h2>User Sign In</h2>
            <p>Enter your credentials to continue</p>
          </div>
          <div class="form-card-body">
            <%
              String status = request.getParameter("status");
              if(status != null && !status.isEmpty()) {
            %>
              <div class="status-msg error"><i class="fa fa-exclamation-circle"></i> <%=status%></div>
            <% } %>

            <form action="user_login" method="post">
              <div class="form-group-cc">
                <label>Username <span class="required">*</span></label>
                <input type="text" class="form-control-cc" name="username" placeholder="Enter your username" required autofocus>
                <span class="form-hint">The username you chose during registration</span>
              </div>
              <div class="form-group-cc">
                <label>Password <span class="required">*</span></label>
                <input type="password" class="form-control-cc" name="password" placeholder="Enter your password" required>
                <span class="form-hint">Your account password (case-sensitive)</span>
              </div>
              <div style="margin-top:28px">
                <input type="submit" value="Sign In to My Account" class="btn-cc-primary" style="display:block;width:100%">
              </div>
            </form>
            <div class="form-divider">or</div>
            <a href="register.jsp" class="btn-cc-secondary">Create New Account</a>
            <div class="form-alt-link" style="margin-top:14px">
              Are you an administrator? <a href="admin.jsp">Admin login</a>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<%@include file="footer.html"%>
</body>
</html>
