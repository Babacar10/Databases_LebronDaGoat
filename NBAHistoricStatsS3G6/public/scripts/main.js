const apiURL = "http://localhost:3000/api/DatabaseConnection" 
let allEntries = fetch(apiURL)
        .then(response => response.json())
        .then(data => console.log(data)); 



document.getElementById("submit").onclick = (event) => {
        let nameVal = document.getElementById("1").value;
        let heightVal = document.getElementById("2").value;
        let weight = document.getElementById("3").value;
        let position = document.getElementById("4").value;
        let hof = document.getElementById("5").value;
        let yearborn =  document.getElementById("6").value;


        const response = fetch("http://localhost:3000/api/DatabaseConnection/?" + "name="+ nameVal + "&height=" + heightVal + "&weight=" + weight + "&position=" + position + "&hof=" + hof + "&yearborn=" +yearborn, 
        {
        method: 'POST'
        });

        console.log("Player "+nameVal+" added");
}

document.getElementById("del").onclick = (event) => {
        let pid = document.getElementById("delnum").value;

        const response = fetch("http://localhost:3000/api/DatabaseConnection/:id/?" + "playerid="+ pid,
        {
        method: 'DELETE'
        });

        console.log("Player "+pid+" deleted");
}

document.getElementById("edit").onclick = (event) => {
        let pid = document.getElementById("10").value;
        let name = document.getElementById("11").value;
        let height = document.getElementById("12").value;
        let weight = document.getElementById("13").value;
        let position = document.getElementById("14").value;
        let hof = document.getElementById("15").value;
        let yearborn =  document.getElementById("16").value;


        const response = fetch("http://localhost:3000/api/DatabaseConnection/:id/?" + "playerid="+ pid +"&name="+ name + "&height=" + height + "&weight=" + weight + "&position=" + position + "&hof=" + hof + "&yearborn=" +yearborn,
        {
        method: 'PUT'
        });

        console.log("Player "+pid+" edited");
}

document.getElementById("getone").onclick = (event) => {
        let pid = document.getElementById("getoneid").value;


        const response = fetch("http://localhost:3000/api/DatabaseConnection/:id/?" + "playerid="+ pid ,
        {
        method: 'GET'
        })
        .then(response => response.json())
        .then(data => console.log(data));
       
}