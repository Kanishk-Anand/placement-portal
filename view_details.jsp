<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
    <%@include file="connect.jsp" %>
<html>
  <head>
    <title> Placement Portal| Student Interview Listing </title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/octicons/3.5.0/octicons.min.css">
   	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
     
    <link href="css/header.css" rel="stylesheet">
    <link href="css/view_info.css" rel="stylesheet">
   
 </head>
 <body>

  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="student_company.jsp" id="webname">Be~Placed</a>
      </div>
   <ul class="nav navbar-nav navbar-right">
     <li><a href="student_company.jsp"><i class="fa fa-home"></i></a></li>
     <li class="active"><a href="student_company.jsp" style="background-color:#4eb1ba;border-radius:5px">Available Interviews</a></li>
     <li><a href="shortlisted_interviews.jsp">Shortlisted Interviews</a></li>
     <li><a href="view_info.jsp">View Information </a></li>
     <li><a href="logout.jsp"><i class="octicon octicon-sign-out" style="font-size:22px"></i></a></li>	
   </ul>
 </div>
</nav>
<div class="container-fluid">
<a class="btn btn-primary" href="student_company.jsp">Go Back?</a>
<% 	
	if(conn!=null && request.getParameter("cname")!=null){
			String cname=request.getParameter("cname");
			String q="SELECT company_name,branch,rounds,gpa,interview_date,interview_time,description FROM company where company_name="+cname+";";
			rs=st.executeQuery(q);
			while(rs.next()){
		%>
 <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >
   
   
          <div class="panel panel-info">
            <div class="panel-heading">
              <h2 class="panel-title">Interview Details</h2>
            </div>
            <div class="panel-body">
              <div class="row">

                
                <div class=" col-md-9 col-lg-9 "> 
                  <table class="table table-user-information">
                    <tbody>
                      <tr>
                        <td>Company Name:</td>
                        <td><%=rs.getString("company_name").toUpperCase() %></td>
                      </tr>
                      <tr>
                        <td>Branches Eligible</td>
                        <td><%=rs.getString("branch") %></td>
                      </tr>
                      <tr>
                        <td>Minimum GPA</td>
                        <%
                        		String cgpa=rs.getString("gpa");
                        		if(cgpa.length()>=3)
                        			cgpa=cgpa.substring(0,3);
                        %>
                        <td><%=cgpa %></td>
                      </tr>
                   
                         
                      <tr>
                        <td>Interview Date</td>
                        
                        <td><%=rs.getString("interview_date") %></td>
                      </tr> 
                      <tr>
                        <td>Interview Time</td>
                        
                        <td><%=rs.getString("interview_time") %></td>
                      </tr> 
                      <tr>
                        <td>Rounds</td>
                        
                        <td><% String temp=rs.getString("rounds");
								String[] printstr=temp.split(",");
								for(int k=0;k<printstr.length;k++){
									%><%= k+1%>  <%= printstr[k]%><br> <%
									
								}
						
						
						%>
                        
                        </td>
                      </tr> 
                      <% if(rs.getString("description")!=null &&rs.getString("description").compareTo("")!=0){ %>
                      	<tr>
                      		<td>Description </td>
                      		<td><%=rs.getString("description") %></td>
                      	</tr>
                      	<%} %>
                         
                    </tbody>
                  </table> 
                 <%
			}
		}
	if(conn!=null)
		conn.close();
	if(st!=null)
		st.close();
                 %>
                </div>
              </div>
            </div>
                 
            
          </div>
        </div>
      </div>
    </div>
    </body>
    </html>
    