<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<html>
  <head>
    <title> Placement Portal| Interview </title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/octicons/3.5.0/octicons.min.css">
    
    <link rel="stylesheet" href="css/header.css">
    
</head>
 <body>
  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="interview.html" id="webname">Be~Placed</a>
      </div>
   <ul class="nav navbar-nav navbar-right">
     <li><a href="interview.html"><i class="fa fa-home" style="font-size:22px"></i></a></li>
     <li class="active"><a href="interview.html" style="background-color:#4eb1ba;border-radius:5px">Companies</a></li>
     <li><a href="student_status.jsp">Placement Status</a></li>
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




<div class="container-fluid" id="add_company_div">
  <div class="row">
  	<div class="btn-group btn-group-justified">
  		<a href="interview.html" class="btn btn-success">Add Interview</a>
  		<a href="modify_interview.html" class="btn btn-primary">Modify Interview</a>
  		<a href="delete_interview.jsp" class="btn btn-danger active">Delete Interview</a>
  		<a href="interview_report.jsp" class="btn btn-warning">View Report</a>
	</div> 
  </div>
  <div class="row">
  	<h1 class="heading">Available Interviews</h1>
  	<div class="table-responsive">
      <table class="table">
        <thead>
          <tr>
           
            <th> Company Name </th>
            <th> Interview Date <span id="date_format">(YYYY-MM-DD)</span> </th>
            <th> Interview Time </th>
            <th> Eligible Branches </th>
            <th></th>
          </tr>
        </thead>
        <tbody>
			<%@include file="connect.jsp" %>
			<%
				if(conn!=null){
					String trid="";
					int i=1;
					String q="SELECT * from company";
					rs=st.executeQuery(q);
					while(rs.next()){
						trid="tr"+i;
					%>
					<tr id=<%=trid %>>
						
						<td><%=rs.getString("company_name").toUpperCase() %></td>
						<td><%=rs.getString("interview_date") %></td>
						<td><%=rs.getString("interview_time") %></td>
						<td><%=rs.getString("branch") %></td>
						<td><button  onclick="deleteCompany('<%=rs.getString("company_id") %>','<%=trid %>')"  class="btn btn-danger" >Delete</button></td>
					</tr>	
				<%
					i++;
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
  </div>
  <script src="js/handle.js"></script>
  <script>
  function deleteCompanyConfirm(){
	  
	  
	  
  }
  	function deleteCompany(id,trid){
  		//alert(id);
		
  		var req=new XMLHttpRequest();
  		req.onreadystatechange=function(){
  			if(req.readyState===4 && req.status===200){
  				if(req.responseText.indexOf("OK")!=-1){
  					displayModal("Deleted Successfully");
  					removeRow(trid);
  				}
  				else
  					displayModal("Error in updating. Kindly try again later.");
  			}
  			
  			
  		}
  		req.open("POST","remove_company.jsp",true);
  		req.setRequestHeader("Content-type","application/x-www-form-urlencoded");
  		req.send("company_id="+id);
  	}
  	function removeRow(trid){
 		 document.getElementById(trid).remove();
 	 }
  	</script>
  
  
  
  
  
    
    

</body>
</html>