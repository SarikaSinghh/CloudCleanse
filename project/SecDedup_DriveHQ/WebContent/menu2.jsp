<%
    String _role=(String)request.getSession().getAttribute("role");
    String _uname=(String)request.getSession().getAttribute("username");
    String _displayName=(_uname!=null)?_uname:"User";
%>
<nav class="cc-navbar">
  <div class="container">
    <a class="cc-brand" href="index.jsp">
      <span class="brand-icon"><i class="fa fa-cloud"></i></span>
      <span class="brand-text">
        Cloud Cleanse
        <small>Intelligent Deduplication</small>
      </span>
    </a>
    <button class="cc-nav-toggle" onclick="document.getElementById('dashNav').classList.toggle('open')" aria-label="Toggle menu">
      <i class="fa fa-bars"></i>
    </button>
    <div class="cc-nav-links" id="dashNav">
      <% if("admin".equals(_role)) { %>
        <a href="a_uploads.jsp"><i class="fa fa-upload"></i> View Uploads</a>
        <a href="a_downloads.jsp"><i class="fa fa-download"></i> View Downloads</a>
        <span style="color:rgba(255,255,255,0.4);padding:0 6px;font-size:0.8rem;align-self:center;">Admin: <%=_displayName%></span>
      <% } else if("user".equals(_role)) { %>
        <a href="upload.jsp"><i class="fa fa-upload"></i> Upload File</a>
        <a href="download.jsp"><i class="fa fa-folder-open"></i> My Files</a>
        <span style="color:rgba(255,255,255,0.55);padding:0 8px;font-size:0.82rem;align-self:center;"><i class="fa fa-user-circle" style="color:var(--secondary)"></i> <%=_displayName%></span>
      <% } %>
      <a href="logout.jsp" class="btn-nav-logout"><i class="fa fa-sign-out"></i> Logout</a>
    </div>
  </div>
</nav>