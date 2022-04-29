
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

})

module.exports = app;

