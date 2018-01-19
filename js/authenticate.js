	var urlstr=window.location.href;
	var url=new URL(urlstr);
	var status=url.searchParams.get("status");
	//alert(status);
  	if(status==1){
  		displayModal("Incorrect Username/Password");
  	}	
  		
  		
  		function displayModal(message){
  			
  			//alert("here");
  			document.getElementById("modal_text").innerHTML=message;
  			$("#myModal").modal('show');
  		}
  		