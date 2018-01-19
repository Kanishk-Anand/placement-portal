<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
 <%@page import="java.util.*" %>
 <%@include file="connect.jsp" %>

<html>
  <head>
    <title> Placement Portal| Student Interview Listing </title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/octicons/3.5.0/octicons.min.css">
    <link href="css/header.css" rel="stylesheet">
    <link href="css/student_company.css" rel="stylesheet">
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
  <h1 class="heading"> Available Interviews' Information </h1>
    <div class="table-responsive">
      <table class="table">
        <thead>
          <tr>
            <th> # </th>
            <th> Company Name </th>
            <th> Interview Date <span id="date_format">(YYYY-MM-DD)</span> </th>
            <th> Interview Time </th>
            <th> Eligible Branches </th>
            <th> Min GPA </th>
            <th> Rounds </th>
            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
      		
			<%	
			if(conn!=null && session.getAttribute("student_id")!=null){
			
  				String sid=(String)session.getAttribute("student_id");
				int student_id=Integer.parseInt(sid);
  				String sql="SELECT cgpa,branch FROM student WHERE student_id='"+sid+"';";
  				float stu_gpa=0;
  				String stu_branch="";
  				rs=st.executeQuery(sql);
  				if(rs.next()){
  				  	stu_gpa=Float.valueOf(rs.getString("cgpa"));	
  				  	stu_branch=rs.getString("branch");
  			
  				}
  				sql="SELECT company_id FROM shortlist WHERE student_id="+student_id+";";
  				rs=st.executeQuery(sql);
  				String interest="";
  				while(rs.next()){
  					if(rs.getString("company_id")!=null)
  						interest=interest+rs.getString("company_id")+",";
  				}
  		
  		
  			
  	
				
					int i=1;
					String btnid="",tdid="";
					String q="SELECT * from company";
					rs=st.executeQuery(q);
					
					while(rs.next()){
						btnid="btn"+i;
						tdid="td"+i;
					%>
					<tr>
						<td><%= i %></td>
						<td><%=rs.getString("company_name").toUpperCase() %></td>
						<td><%=rs.getString("interview_date") %></td>
						<td><%=rs.getString("interview_time") %></td>
						<td><%=rs.getString("branch") %></td>
						<td><%=rs.getString("gpa") %></td>
						<td><% String temp=rs.getString("rounds");
								String[] printstr=temp.split(",");
								for(int k=0;k<printstr.length;k++){
									%><%= k+1%>  <%= printstr[k]%><br> <%
									
								}
						
						
						%></td>
						<td id="<%=tdid%>">
							<%	String cid=rs.getString("company_id");
								if(interest.compareTo("")!=0){
								
								
								if(interest.indexOf(cid)!=-1){
								%><span class="shortlised">Shortlisted</span>
								<%}
								else	{ %>
									<button class="btn btn-success" onclick="checkEligible('<%=stu_gpa%>','<%=stu_branch %>','<%=rs.getString("gpa") %>','<%=rs.getString("branch") %>','<%=cid%>','<%=tdid %>')">Interested?</button>
							<%	}
							}
							else{%>
								
								<button class="btn btn-success" onclick="checkEligible('<%=stu_gpa%>','<%=stu_branch %>','<%=rs.getString("gpa") %>','<%=rs.getString("branch") %>','<%=cid%>','<%=tdid %>')">Interested?</button>
							<%}
							
							
							%>
						
						</td>
						<td><a href="view_details.jsp?cname='<%=rs.getString("company_name")%>'">View Details</a>
					</tr>	
				<%
					i++;
					}
				}
			else{
				response.sendRedirect("index.html");
			}
			
			
			
			%>
        </tbody>
      </table>
    </div>
  </div>
  <script>
  var comp='';
  var req=new XMLHttpRequest();
  
  function checkEligible(stu_gpa,stu_branch,comp_gpa,comp_branch,id,tdid){
	  var boolgpa=false;
	var boolbranch=false;
	//alert(comp_gpa);
	  comp_gpa=parseFloat(comp_gpa);
	  //alert(stu_gpa + stu_branch + comp_gpa + comp_branch);
	  if(stu_gpa>=comp_gpa)
	  	boolgpa=true;
	  if(comp_branch.indexOf(stu_branch)!=-1)
		  boolbranch=true;
	 if(boolgpa && boolbranch)
		 addToInterest(id,tdid);
	 else
		 displayModal("You are not eligible for this company's interview");
	  
	  
  }
  function addToInterest(id,tdid){
  		//alert(id);
  		//alert(id);
  		
  		
  		req.onreadystatechange=function(){
  			if(req.readyState===4 && req.status===200){
  				if(req.responseText.indexOf("OK")!=-1){
  					
  					var td=document.getElementById(tdid);
  					td.removeChild(td.childNodes[0]);
  					td.innerHTML="Shortlisted";
  					displayModal("Updated Successfully");
  				}
  				else
  					displayModal("Error in updating. Kindly try again later.");
  			}
  			
  			
  		}
  		req.open("POST","addToInterestedCompany.jsp",true);
  		req.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  		req.send("add_id="+id);
  	}
    function displayModal(message){
		//alert('here');
		document.getElementById("modal_text").innerHTML=message;
		$("#myModal").modal('show');
	}
    
    
  
  </script>
</body>
</html>
