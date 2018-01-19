<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="connect.jsp" %>
<html>
  <head>
    <title> Placement Portal| Personal Details </title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/octicons/3.5.0/octicons.min.css">
     <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/view_info.css">
   
 </head>
 <body>
  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="student_company.jsp" id="webname">Be~Placed</a>
      </div>
   <ul class="nav navbar-nav navbar-right">
     <li><a href="student_company.jsp"><i class="fa fa-home"></i></a></li>
     <li><a href="student_company.jsp">Available Interviews</a></li>
     <li><a href="shortlisted_interviews.jsp" >Shortlisted Interviews</a></li>
     <li class="active"><a href="view_info.jsp" style="background-color:#4eb1ba;border-radius:5px">View Information </a></li>
     <li><a href="logout.jsp"><i class="octicon octicon-sign-out" style="font-size:22px"></i></a></li>	
   </ul>
 </div>
</nav>
<div class="container">
	<%
		if(conn!=null){
			String q="SELECT name,email,branch,cgpa,placed FROM student where student_id='"+session.getAttribute("student_id")+"';";
			rs=st.executeQuery(q);
			while(rs.next()){
		%>
	
	
	
      <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >
   
   
          <div class="panel panel-info">
            <div class="panel-heading">
              <h3 class="panel-title"><%=rs.getString("name") %> </h3>
            </div>
            <div class="panel-body">
              <div class="row">
                <div class="col-md-3 col-lg-3 " align="center"> <img alt="User Pic" src="img/user.png" class="img-circle img-responsive"> </div>
                
                <div class=" col-md-9 col-lg-9 "> 
                  <table class="table table-user-information">
                    <tbody>
                      <tr>
                        <td>Email:</td>
                        <td><%=rs.getString("email") %></td>
                      </tr>
                      <tr>
                        <td>Department</td>
                        <td><%=rs.getString("branch") %></td>
                      </tr>
                      <tr>
                        <td>GPA</td>
                        <%
                        		String cgpa=rs.getString("cgpa");
                        		if(cgpa.length()>=3)
                        			cgpa=cgpa.substring(0,3);
                        %>
                        <td><%=cgpa %></td>
                      </tr>
                   
                         
                      <tr>
                        <td>Placed</td>
                        <%String placed=rs.getString("placed");
                        		if(placed.compareTo("f")==0)
                        			placed="NO";
                        		else
                        			placed="YES";
                        %>
                        <td><%=placed %></td>
                      </tr>    
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