 function createFields(){
      var fielddiv= document.getElementById('input_fields');
      var optionfield=document.getElementById('rounds');
      var num=optionfield.options[optionfield.selectedIndex].value;
      fielddiv.style.display="none";
      while (fielddiv.firstChild) {

        fielddiv.removeChild(fielddiv.firstChild);

      }
      var txt='';
      for(var i=0;i<num;i++){

        var sourcediv=document.getElementById('sourcediv');
        var clonediv=sourcediv.cloneNode(true);
        clonediv.id='';
        var cnode=clonediv.childNodes;
        for(j=0;j<cnode.length;j++){
          txt="Round "+(i+1);
          cnode[1].innerHTML=txt;
          cnode[1].setAttribute('for',txt)
          var nestdiv=cnode[3];
          var newinput=nestdiv.childNodes;
          newinput[1].placeholder="Round Name / Description";
          newinput[1].value='';
          newinput[1].id=txt;
          newinput[1].setAttribute('name',txt);
        }
        fielddiv.appendChild(clonediv);
      }
      fielddiv.style.display="block";
	}
 
 
 
 function displayModal(message){
		//alert('here');
		document.getElementById("modal_text").innerHTML=message;
		$("#myModal").modal('show');
}
 
 