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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/octicons/3.5.0/octicons.min.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/student_company.css">
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
     <li class="active"><a href="shortlisted_interviews.jsp" style="background-color:#4eb1ba;border-radius:5px">Shortlisted Interviews</a></li>
     <li><a href="view_info.jsp">View Information </a></li>
     <li><a href="logout.jsp"><i class="octicon octicon-sign-out" style="font-size:22px"></i></a></li>	
   </ul>
 </div>
</nav>
<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">


      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Message:</h4>
        </div>
        <div class="modal-body">
          <p id="modal_text"></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
        </div>
      </div>

    </div>
  </div>
<div class="container-fluid" id="table_container">
  <h1 class="heading"> Shortlisted Interviews </h1>
    <div class="table-responsive">
      <table class="table">
        <thead>
          <tr>
           
            <th> Company Name </th>
            <th> Interview Date <span id="date_format">(YYYY-MM-DD)</span> </th>
            <th> Interview Time </th>
            <th> Eligible Branches </th>
            <th> Rounds </th>
            <th></th>
          </tr>
        </thead>
        <tbody>
			<%@include file="connect.jsp" %>
			<%
				if(conn!=null){
					int i=1;
					int count=0;
					String trid="";
					String inter="";
					if(session.getAttribute("student_id")!=null){
						String sid=(String)session.getAttribute("student_id");
						int student_id=Integer.parseInt(sid);
					
						//System.out.println("now here");
						String q="SELECT c.company_name,c.rounds,c.interview_date,c.interview_time,c.branch,s.company_id FROM company c,shortlist s WHERE c.company_id=s.company_id AND s.student_id="+student_id+";";
							rs=st.executeQuery(q);
							while(rs.next()){
								count++;
								trid="tr"+count;
					%>
					<tr id="<%=trid%>">
						
						<td><%=rs.getString("company_name").toUpperCase() %></td>
						<td><%=rs.getString("interview_date") %></td>
						<td><%=rs.getString("interview_time") %></td>
						<td><%=rs.getString("branch") %></td>
						<td><% String temp=rs.getString("rounds");
								String[] printstr=temp.split(",");
								for(int k=0;k<printstr.length;k++){
									%><%= k+1%>  <%= printstr[k]%><br> <%
									
								}
						
						
						%></td>
						<td><button  onclick="removeInterest('<%=rs.getString("company_id") %>','<%=trid %>')"  class="btn btn-success" >Remove?</button></td>
					</tr>	
				<%
					i++;
					}
				}
				}
			
				
				
			if(conn!=null)
				conn.close();
			if(st!=null)
				st.close();
			%>
        </tbody>
      </table>
    </div>
  </div>
<script>
  	function removeInterest(id,trid){
  		//alert(id);
  		
  		var req=new XMLHttpRequest();
  		req.onreadystatechange=function(){
  			if(req.readyState==4 && req.status==200){
  				
  				//alert(req.responseText);
  				if(req.responseText.indexOf("OK")!=-1){
  					displayModal("Updated Successfully");
  					//window.location.replace("shortlisted_interviews.jsp");
  					removeRow(trid);
  					
  				}
  				else{
  					displayModal("Error in updating. Kindly try again later.")
  				}
  			
  			
  			}
  		}
  		req.open("POST","addToInterestedCompany.jsp",true);
  		req.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  		req.send("remove_id="+id);
  	
  	}
  	 function displayModal(message){
 		//alert('here');
 		document.getElementById("modal_text").innerHTML=message;
 		$("#myModal").modal('show');
	 }
  	 function removeRow(trid){
  		 document.getElementById(trid).remove();
  	 }
  
  </script>
</body>
</html>
  