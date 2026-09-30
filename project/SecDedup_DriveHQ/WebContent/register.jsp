<!DOCTYPE html>
<html lang="en">
<head><%@include file="header.html"%></head>
<body>
<%@include file="menu1.html"%>

<div class="form-page-bg">
  <div class="container">
    <div class="row" style="justify-content:center">

      <!-- LEFT: Info Panel -->
      <div class="col-md-5" style="padding-right:30px;margin-bottom:30px">
        <div style="padding-top:20px">
          <span class="section-label"><i class="fa fa-user-plus" style="margin-right:6px"></i>New Account</span>
          <h2 class="section-title" style="margin-top:10px">Join Cloud Cleanse</h2>
          <div class="divider" style="margin:14px 0 20px;margin-left:0"></div>
          <p style="font-size:0.92rem;color:#64748b;line-height:1.8;margin-bottom:24px">
            Create your free account to start uploading, managing, and sharing files securely in the cloud. Our system automatically detects duplicates and encrypts your data.
          </p>
          <div class="tip-box" style="margin-bottom:16px">
            <p><strong><i class="fa fa-lightbulb-o" style="margin-right:6px;color:#06b6d4"></i>Why Register?</strong><br>
            Get personal cloud storage with AES encryption, access key sharing, and automatic duplicate detection — completely free.</p>
          </div>
          <div class="info-box">
            <p><strong><i class="fa fa-envelope" style="margin-right:6px"></i>Email Confirmation</strong><br>
            After registering, check your email for a welcome message with your account details.</p>
          </div>
          <ul style="margin-top:20px;padding-left:0;list-style:none">
            <li style="display:flex;align-items:center;gap:10px;margin-bottom:10px;font-size:0.88rem;color:#475569">
              <i class="fa fa-check-circle" style="color:#10b981;font-size:1rem"></i> Secure AES file encryption
            </li>
            <li style="display:flex;align-items:center;gap:10px;margin-bottom:10px;font-size:0.88rem;color:#475569">
              <i class="fa fa-check-circle" style="color:#10b981;font-size:1rem"></i> Intelligent duplicate detection
            </li>
            <li style="display:flex;align-items:center;gap:10px;margin-bottom:10px;font-size:0.88rem;color:#475569">
              <i class="fa fa-check-circle" style="color:#10b981;font-size:1rem"></i> Time-based file access control
            </li>
            <li style="display:flex;align-items:center;gap:10px;font-size:0.88rem;color:#475569">
              <i class="fa fa-check-circle" style="color:#10b981;font-size:1rem"></i> Secure file sharing with keys
            </li>
          </ul>
        </div>
      </div>

      <!-- RIGHT: Form Card -->
      <div class="col-md-6">
        <div class="form-card">
          <div class="form-card-header">
            <div class="header-icon"><i class="fa fa-user-plus"></i></div>
            <h2>Create Account</h2>
            <p>Fill in the details below to register</p>
          </div>
          <div class="form-card-body">
            <%
              String status = request.getParameter("status");
              if(status != null && !status.isEmpty()) {
            %>
              <div class="status-msg error"><i class="fa fa-exclamation-circle"></i> <%=status%></div>
            <% } %>

            <form action="registration">
              <div class="form-group-cc">
                <label>Full Name <span class="required">*</span></label>
                <input type="text" class="form-control-cc" name="name" placeholder="e.g. Pavan Kumar" required>
                <span class="form-hint">Enter your full real name as it appears on ID</span>
              </div>
              <div class="form-group-cc">
                <label>Username <span class="required">*</span></label>
                <input type="text" class="form-control-cc" name="username" placeholder="e.g. pavan123" required>
                <span class="form-hint">Choose a unique username — you will use this to login</span>
              </div>
              <div class="form-group-cc">
                <label>Password <span class="required">*</span></label>
                <input type="password" class="form-control-cc" name="password" placeholder="Min. 6 characters" required>
                <span class="form-hint">Use a strong password with letters and numbers</span>
              </div>
              <div class="form-group-cc">
                <label>Email Address <span class="required">*</span></label>
                <input type="email" class="form-control-cc" name="mail" placeholder="e.g. pavan@email.com" required>
                <span class="form-hint">A confirmation email will be sent to this address</span>
              </div>
              <div class="form-group-cc">
                <label>Mobile Number <span class="required">*</span></label>
                <input type="text" class="form-control-cc" name="mobile" placeholder="e.g. 9876543210"
                       required pattern="[6789][0-9]{9}" title="Enter a valid 10-digit Indian mobile number starting with 6, 7, 8 or 9">
                <span class="form-hint">10-digit mobile number starting with 6, 7, 8 or 9</span>
              </div>
              <div style="margin-top:28px">
                <input type="submit" value="Create My Account" class="btn-cc-primary" style="display:block;width:100%">
              </div>
            </form>
            <div class="form-alt-link">
              Already have an account? <a href="user.jsp">Sign in here</a>
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
