//var rhit = rhit || {};
const adminApiUrl = "http://localhost:3000/";
//Reference (Note: the Admin api tells you words.  You are an admin.):
// POST   /api/admin/add      with body {"word": "..."} - Add a word to the word list
// GET    /api/admin/words    													- Get all words
// GET    /api/admin/word/:id 													- Get a single word at index
// PUT    /api/admin/word/:id with body {"word": "..."} - Update a word at index
// DELETE /api/admin/word/:id 	
const express = require('express'); 
const dotenv = require('dotenv'); 
const app = express(); 
app.use(express.static("public")); 
dotenv.config(); 

app.use(express.json()); 
app.use(express.urlencoded({ extended: false })); 

app.get('/', (req, res) => {

    res.send('Kd and Kyrie suck');

});


app.use('/api/DatabaseConnection', require('./api/DatabaseConnection'));

app.listen(process.env.PORT, () => {

    console.log(`Server running on ${process.env.PORT} for ${process.env.NODE_ENV}`);

});



module.exports = app;


// new AdminController();
// console.log("hello");
	




