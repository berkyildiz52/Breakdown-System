function openPopUp (data){

var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {
 if (this.readyState == 4 && this.status == 200) {
 let historyTemp =this.responseText;
//console.log(historyTemp);

 let myObject= JSON.parse(historyTemp);
 // convert keys to array
 let arrLength = Object.keys(myObject);

 for (i=0;i<arrLength.length;i++){

    if (data['id']==myObject[i]['breakdownId']){

        //console.log(myObject[i]['id']);

        const breakdown = document.createTextNode(data['id']+" " + data['creationTime']+" " + data['machineId']+" " + data['type']+" " + data['state']+" " + 
                                                data['description']+" "+ data['estimatedDeadline']+" "+ data['remainingTime']+" ");
      
        const history = document.createTextNode(myObject[i]['id']+" "+myObject[i]['breakdownId']+" "+myObject[i]['process']);

        const space = document.createTextNode(" ┃");

        const para = document.createElement("p");
        para.appendChild(breakdown);
        para.appendChild(space);
        para.appendChild(history);

        const element = document.getElementById("history");
        element.appendChild(para);
     }
   }
 }
}
xhttp.open("POST", 'historyQuery.php', true);
xhttp.send();
//alert(data['id']);
}