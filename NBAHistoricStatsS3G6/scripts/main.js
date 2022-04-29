const apiURL = "http://localhost:3000/api" 
let allEntries = fetch(apiURL)
        .then(response => console.log(response))