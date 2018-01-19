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
    
    <link rel="stylesheet" href="css/interview.css">
    
</head>
 <body onload="showCompany()">
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
 
 
 <div class="container" id="modify_company_div">

  <div class="row">
  <div class="btn-group btn-group-justified">
  		<a href="interview.html" class="btn btn-success">Add Interview</a>
  		<a href="modify_interview.html" class="btn btn-primary active">Modify Interview</a>
  		<a href="delete_interview.jsp" class="btn btn-danger">Delete Interview</a>
  		<a href="interview_report.jsp" class="btn btn-warning">View Report</a>
	</div> 
    <h1 class="heading"> View Interview Report </h1>
   	<div class="form-group">
      <label class="control-label col-sm-3" for="search_company">Enter Company Name </label>
      <div class="col-sm-6 text-left">
        <input type="text" class="form-control" id="search_company" placeholder="Find company's interview here" name="company_name" onkeyup="showResult(this.value)">

      </div>
    </div>
   	<div id="search_div" class="col-sm-offset-3 col-sm-6" >
   		<div id="search_result_div" style="display:none"></div>	
   	
   	</div>

	</div>
  <br><br>
  <h2 id="company_name" class="heading"></h2>
  <h4 id="count_heading" class="heading"></h4>
  
  <div class="table-responsive" id="report_table">
      <table class="table">
        <thead>
          <tr>
           
            <th> # </th>
            <th> Student Name</th>
            <th> GPA </th>
            <th> Branch </th>
            <th> Email </th>
            
          </tr>
        </thead>
        <tbody id="tbody">
        <%@include file="connect.jsp"%>
        <%
        		if(request.getParameter("cid")!=null){
        			
        			//System.out.println("here");
        			String cid=request.getParameter("cid");
        			int company_id=Integer.parseInt(cid);
        			String q="SELECT s.name,s.email,s.cgpa,s.branch FROM student s,shortlist WHERE s.student_id=shortlist.student_id AND shortlist.company_id="+company_id+";";
        			rs=st.executeQuery(q);
        			int count=0;
        			while(rs.next()){
        				//System.out.println(count);
        			%>
        			<tr>
        				<td><%=count+1 %></td>
        				<td><%=rs.getString("name") %></td>
        				<td><%=rs.getString("cgpa") %></td>
        				<td><%=rs.getString("branch") %></td>
        				<td><%=rs.getString("email") %></td>
        				
        			</tr>
        			
        			<%
        			count++;
        			}
        			%><tr><td style="display:none" id="tdcount"><%=count %></td></tr><%
        		}
        			
        	%>
        
        </tbody>
     </table>
   </div>
  </div>
  
  <script>
  function showResult(compname){
		var req=new XMLHttpRequest();
			req.onreadystatechange=function(){
				if(req.readyState==4 && req.status==200){
					var search_result=document.getElementById("search_result_div");
					var res=req.responseText;
						//alert(res);
						if(res.indexOf("404")!=-1){
							search_result.style.display="block";
							document.getElementById("report_table").style.display="none";
							search_result.innerHTML="No company's interview found";
							
							
						}
						else{
							search_result.style.display="block";
		  					search_result.innerHTML=res;
						}

				}

			}
			if(compname!=""){
				req.open("GET","searchCompany.jsp?compname="+compname,true);
				req.send();
			}
			else{
				document.getElementById("report_table").style.display="none";
				document.getElementById("search_result_div").style.display="none";
				document.getElementById("company_name").innerHTML="";
	  			document.getElementById("count_heading").innerHTML="";
	  			
			}
	}
  	function displayCompanyInfo(compname,cid){
  		document.getElementById("company_name").innerHTML="Report for:"+compname;
  		window.location.href="interview_report.jsp?cid="+cid+"&cname="+compname;
  	}
  	function showCompany(){
  		var val=document.getElementById("search_company").value;
  		//alert(val);

  		var urlstr=window.location.href;
  		var url=new URL(urlstr);
  		var compname=url.searchParams.get("cname");
  		
  		if(compname!==null){
  			var count=document.getElementById("tdcount").innerHTML;
  			document.getElementById("company_name").innerHTML="Report for company: "+compname.toUpperCase();
  			document.getElementById("count_heading").innerHTML="Number of students interested: "+count;
  			if(count==0)
  				document.getElementById("report_table").style.display="none";
  			
  		}
  		else
  			document.getElementById("report_table").style.display="none";
  		
  	}
  
  
  
  </script>
  </body>
  </html>