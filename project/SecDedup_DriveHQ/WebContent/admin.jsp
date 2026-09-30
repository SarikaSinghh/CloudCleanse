<!DOCTYPE html>
<html lang="en">
<head><%@include file="header.html"%></head>
<body>
<%@include file="menu1.html"%>

<div class="form-page-bg" style="align-items:center">
  <div class="container">
    <div class="row" style="justify-content:center;align-items:center">

      <!-- LEFT: Info -->
      <div class="col-md-5" style="padding-right:30px;margin-bottom:30px">
        <span class="section-label" style="background:rgba(239,68,68,0.08);color:#dc2626;border-color:rgba(239,68,68,0.2)">
          <i class="fa fa-shield" style="margin-right:6px"></i>Restricted Access
        </span>
        <h2 class="section-title" style="margin-top:10px">Admin Control Panel</h2>
        <div class="divider" style="margin:14px 0 20px;margin-left:0"></div>
        <p style="font-size:0.92rem;color:#64748b;line-height:1.8;margin-bottom:24px">
          This portal is for system administrators only. Admin access allows you to monitor all file uploads, downloads, and user activity across the entire platform.
        </p>
        <div class="warning-box">
          <p><strong><i class="fa fa-exclamation-triangle" style="margin-right:6px"></i>Admin Access Only</strong><br>
          This login is restricted to authorized system administrators. If you are a regular user, please use the <a href="user.jsp" style="color:#d97706;font-weight:600">User Login</a> instead.</p>
        </div>
        <div style="margin-top:20px">
          <div style="display:flex;align-items:flex-start;gap:12px;margin-bottom:14px">
            <div style="width:36px;height:36px;background:rgba(239,68,68,0.1);border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0">
              <i class="fa fa-list-alt" style="color:#dc2626"></i>
            </div>
            <div>
              <div style="font-size:0.88rem;font-weight:600;color:#1e293b;margin-bottom:2px">View All Uploads</div>
              <div style="font-size:0.8rem;color:#64748b">Monitor every file uploaded to the system by all users</div>
            </div>
          </div>
          <div style="display:flex;align-items:flex-start;gap:12px">
            <div style="width:36px;height:36px;background:rgba(239,68,68,0.1);border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0">
              <i class="fa fa-download" style="color:#dc2626"></i>
            </div>
            <div>
              <div style="font-size:0.88rem;font-weight:600;color:#1e293b;margin-bottom:2px">Track Downloads</div>
              <div style="font-size:0.8rem;color:#64748b">See who downloaded which files and when</div>
            </div>
          </div>
        </div>
      </div>

      <!-- RIGHT: Card -->
      <div class="col-md-5">
        <div class="form-card">
          <div class="form-card-header" style="background:linear-gradient(135deg,#1e3a8a,#dc2626)">
            <div class="header-icon"><i class="fa fa-shield"></i></div>
            <h2>Admin Sign In</h2>
            <p>Authorized personnel only</p>
          </div>
          <div class="form-card-body">
            <%
              String status = request.getParameter("status");
              if(status != null && !status.isEmpty()) {
            %>
              <div class="status-msg error"><i class="fa fa-exclamation-circle"></i> <%=status%></div>
            <% } %>

            <form action="admin_login" method="post">
              <div class="form-group-cc">
                <label>Admin Username <span class="required">*</span></label>
                <input type="text" class="form-control-cc" name="username" placeholder="Admin username" required autofocus>
                <span class="form-hint">Your system administrator username</span>
              </div>
              <div class="form-group-cc">
                <label>Admin Password <span class="required">*</span></label>
                <input type="password" class="form-control-cc" name="password" placeholder="Admin password" required>
                <span class="form-hint">Your secure administrator password</span>
              </div>
              <div style="margin-top:28px">
                <input type="submit" value="Access Admin Panel" class="btn-cc-primary" style="background:linear-gradient(135deg,#1e3a8a,#dc2626);display:block;width:100%">
              </div>
            </form>
            <div class="form-alt-link" style="margin-top:16px">
              Not an admin? <a href="user.jsp">Go to User Login</a>
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
