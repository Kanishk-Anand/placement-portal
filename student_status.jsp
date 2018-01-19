<%@ page language="java" contentType="text/html"
    pageEncoding="UTF-8"%>
<html>
  <head>
    <title> Placement Portal| Student Status</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/octicons/3.5.0/octicons.min.css">
    
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/student_company.css">

 <body>
  <nav class="navbar navbar-inverse">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="interview.html" id="webname">Website Name</a>
      </div>
   <ul class="nav navbar-nav navbar-right">
     <li><a href="interview.html"><i class="fa fa-home" style="font-size:22px"></i></a></li>
     <li ><a href="interview.html" >Companies</a></li>
     <li class="active"><a href="student_status.jsp" style="background-color:#4eb1ba;border-radius:5px">Placement Status</a></li>
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
  <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" 
     aria-labelledby="statusModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
          
            <div class="modal-header">
                <button type="button" class="close" 
                   data-dismiss="modal">
                       <span aria-hidden="true">&times;</span>
                       <span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title">
                    Description:
                </h4>
            </div>
            
            <div class="modal-body">
                
                <form role="form" action="change_placement_status.jsp"  method="post" id="statusform">
                  <div class="form-group">
                    <label for="comment">Comments<span class="astericks">*</span></label>
                     <textarea class="form-control" rows="8" id="comment" name="comment" required></textarea>
                  </div>
                  <input type="hidden" name="student_id" id="student_id">
                  <button type="button" class="btn btn-primary" id="submitbtn" >Save Changes</button>
                  
                </form>
                
                
            </div>
            
            
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
               
            </div>
        </div>
    </div>
</div>

  
<div class="container-fluid" id="table_container">
  <h1 class="heading"> Students Placement Status </h1>
    <div class="table-responsive">
      <table class="table">
        <thead>
          <tr>
           
            <th> Student Name </th>
            <th> Department </th>
            <th> Placement Status </th>
            <th></th>
          </tr>
        </thead>
        <tbody>
			<%@include file="connect.jsp" %>
			<%
				if(conn!=null){
					int i=1;
					int count=0;
					String place="";
					String name="";
					String dept="";
					String btnid="";
					String sql="SELECT student_id,name,placed,branch,comment FROM student;";
					rs=st.executeQuery(sql);
					while(rs.next()){
						name=rs.getString("name");
						place=rs.getString("placed");
						dept=rs.getString("branch");
						if(place.compareTo("f")==0)
							place="Not Placed";
						else
							place="Placed";
					
						String comment="";
						if(rs.getString("comment")!=null)
							comment=rs.getString("comment");
					%>
					<tr>
						<%btnid="btn"+i; %>
						<td><%=name.toUpperCase()%></td>
						<td><%=dept %></td>
						<td id=<%=btnid %>><%=place %></td>
						
						<td><button onclick="displayStatusModal('<%=rs.getString("student_id") %>','<%=comment %>')" class="btn btn-success" >Change Status</button></td>
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
<script>
	var urlstr=window.location.href;
	var url=new URL(urlstr);
	var status=url.searchParams.get("status");
	if(status==1)
		displayModal("Updated Successfully");
	else if(status==0)
		displayModal("Error while updating. Try Again Later");
	else{}
	
	function displayModal(message){
		//alert('here');
		document.getElementById("modal_text").innerHTML=message;
		$("#myModal").modal('show');
	}
	function displayStatusModal(sid,comment){
		
		if(comment===null||comment!=="")
			document.getElementById("comment").value='';
		else
			document.getElementById("comment").value=comment;
		document.getElementById("submitbtn").setAttribute("onclick","javascript:submitStatus("+sid+");")
		$("#statusModal").modal('show');
	}
	function submitStatus(sid){
		if(document.getElementById('comment').value!=""){
			document.getElementById('student_id').value=sid;
			document.getElementById('statusform').submit();
		}
		else
			displayModal("Please fill the comment section");
	}
	


</script>
</body>
</html>
    