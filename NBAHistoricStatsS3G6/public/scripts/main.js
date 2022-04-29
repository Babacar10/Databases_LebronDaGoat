const apiURL = "http://localhost:3000/api/DatabaseConnection" 
let allEntries = fetch(apiURL)
        .then(response => response.json())
        .then(data => console.log(data)); 