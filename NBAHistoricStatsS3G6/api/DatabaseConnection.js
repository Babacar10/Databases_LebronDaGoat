const express = require('express')

const sql = require('mssql');

const config = {

    driver: process.env.SQL_DRIVER, 

    server: process.env.SQL_SERVER, 

    database: process.env.SQL_DATABASE,

    user: process.env.SQL_UID,

    password: process.env.SQL_PWD,

    options: {

        encrypt: false, 

        enableArithAbort: false

    }, 

};

const connectPool = new sql.ConnectionPool(config); 

const router = express.Router();

router.get('/:id', async (req, res) => {
	// get single player
});
router.get('/', async (req, res) => {
	// get all players

    try{

        await connectPool.connect();

        const result = await connectPool.request().query(`Select * From Team`);

        const temp = result.recordset;

        res.json(temp);
    }

    catch (error) {

        res.status(500).json(error);
    }
});

router.post('/', async (req, res) => {
	// create player
});
router.put('/:id', async (req, res) => {
	// update player
});
router.delete('/:id', async (req, res) => {
	// delete player
});

module.exports = router;



 