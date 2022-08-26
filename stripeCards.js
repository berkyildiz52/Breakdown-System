   var xhttp = new XMLHttpRequest();
   xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
    let tempo =this.responseText;
    //console.log(tempo);

    let myObj = JSON.parse(tempo);
    // convert keys to array
    let sampleObjectKeys = Object.keys(myObj);
 
    for (i=0;i<sampleObjectKeys.length;i++){

      let state = myObj[i]['state'];
      //console.log(state);
     
      let symbol;
      //Reported
      if(state=='0'){
        symbol = document.createTextNode("☐ ");
      }
      //On repair
      else if(state=='1'){
        symbol = document.createTextNode("☒ ");
      }
      //Fixed
      else if(state=='2'){
        symbol = document.createTextNode("☑ ");
      }
      //Cancel
      else{
        symbol = document.createTextNode("☓ ");
      }
      const para = document.createElement("p");
      const node = document.createTextNode(myObj[i]['id']);
      const space = document.createTextNode(" ┃");
      const node2 = document.createTextNode(myObj[i]['creationTime']);
      const space2 = document.createTextNode(" ┃ ");
      const node3 = document.createTextNode(myObj[i]['description']);

      para.appendChild(symbol);
      para.appendChild(node);
      para.appendChild(space);
      para.appendChild(node2);
      para.appendChild(space2);
      para.appendChild(node3);
  
      const temp= document.createElement("div");

      if (state=='0'){
        temp.setAttribute("class", "w3-card w3-yellow w3-hover-shadow w3-text-black w3-round w3-hover-text-red w3-hover-aqua");
      }
      else if (state=='1'){
        temp.setAttribute("class", "w3-card w3-blue w3-hover-shadow w3-text-black w3-round w3-hover-text-red w3-hover-aqua");
      }
      else if (state=='2'){
        temp.setAttribute("class", "w3-card w3-green w3-hover-shadow w3-text-black w3-round w3-hover-text-red w3-hover-aqua");
      }
      else{
        temp.setAttribute("class", "w3-card w3-red w3-hover-shadow w3-text-black w3-round w3-hover-text-red w3-hover-aqua");
      }

      temp.appendChild(para);
      const element = document.getElementById("stripe");
      element.appendChild(temp);

      let message =myObj[i]['id'];
      temp.onclick = function(){
        if (state=='0'){
          alert ("pending");
        }
        else if (state=='1'){
          alert ("on repair");
          }
          else if (state=='2'){
            alert ("fixed");
          }
          else {
            alert ("cancelled");
          }
      }
      }
    }
  };
  xhttp.open("POST", 'stripeQuery.php', true);
  xhttp.send();


