<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
 <%@page import="java.util.*" %>
 

<html>
  <head>
    <title> Placement Portal| Shortlisted Interviews </title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
 </head>
 <body>
  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">WebSiteName</a>
      </div>
   <ul class="nav navbar-nav">
     <li><a href="#"><i class="fa fa-home"></i></a></li>
     <li><a href="student_company.jsp">Available Interviews</a></li>
     <li class="active"><a href="shortlisted_interviews.jsp">Shortlisted Interviews</a></li>
     <li><a href="view_info.jsp">View Information </a></li>
   </ul>
 </div>
</nav>
<div class="container-fluid">
  <h1> Shortlisted Interviews </h1>
    <div class="table-responsive">
      <table class="table">
        <thead>
          <tr>
            <th> # </th>
            <th> Company Name </th>
            <th> Interview Date (YYYY-MM-DD) </th>
            <th> Interview Time </th>
            <th> Eligible Branches </th>
            <th> Rounds </th>
          </tr>
        </thead>
        <tbody>
			<%@include file="connect.jsp" %>
			<%
				if(conn!=null){
					int i=1;
					String inter="";
					String sql="SELECT interested_companies FROM student WHERE student_id=1";
					rs=st.executeQuery(sql);
					while(rs.next()){
						 inter=rs.getString("interested_companies");
						 if(inter.length()>=1){
						 inter=inter.substring(0,inter.length()-1);
						 inter="("+inter+")";
						 }
					}
					if(inter.contains(",")||inter.length()==3){
						String q="SELECT * from company WHERE company_id IN " + inter+";";
					rs=st.executeQuery(q);
					while(rs.next()){
					%>
					<tr>
						<td><%= i %></td>
						<td><%=rs.getString("company_name") %></td>
						<td><%=rs.getString("interview_date") %></td>
						<td><%=rs.getString("interview_time") %></td>
						<td><%=rs.getString("branch") %></td>
						<td><% String temp=rs.getString("rounds");
								String[] printstr=temp.split(",");
								for(int k=0;k<printstr.length;k++){
									%><%= k+1%>  <%= printstr[k]%><br> <%
									
								}
						
						
						%></td>
						<td><button  onclick="removeInterest('<%=rs.getString("company_id") %>')"  class="btn btn-danger" >Remove?</button></td>
					</tr>	
				<%
					i++;
					}
				}
			
				}
			%>
        </tbody>
      </table>
    </div>
  </div>
<script>
  	function removeInterest(id){
  		alert(id);
  		id=''+id+',';
  		var req=new XMLHttpRequest();
  		req.onreadystatechange=function(){
  			if(req.readyState==4 && req.status==200){
  				//alert("here");
  				//alert(req.responseText);
  				if(req.responseText.contains("OK")==true){
  					alert("here");
  					window.location.replace("shortlisted_interviews.jsp");
  					//alert("Updated Successfully");
  				}
  			
  			
  			}
  		}
  		req.open("POST","addToInterestedCompany.jsp",true);
  		req.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  		req.send("remove_id="+id);
  	
  	}
  
  </script>
</body>
</html>
  