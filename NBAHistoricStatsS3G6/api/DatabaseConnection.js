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
router.use('/api/', express.json());
router.get('/:id', async (req, res) => {
	// get single player
    try{

        await connectPool.connect();

        const result = await connectPool.request().query(`Select * From Player WHERE PlayerID = ${req.query.playerid}`);

        const temp = result.recordset;

        res.json(temp);
    }

    catch (error) {

        res.status(500).json(error);
    }
});
router.get('/', async (req, res) => {
	// get all players

    try{

        await connectPool.connect();

        const result = await connectPool.request().query(`Select * From Player`);

        const temp = result.recordset;

        res.json(temp);
    }

    catch (error) {

        res.status(500).json(error);
    }
});

router.post('/', async (req, res) => {
	// create player
    try{

        await connectPool.connect();

        const result = await connectPool.request()
        .input('Name', req.query.name)
        .input('Height', req.query.height)
        .input('Weight', req.query.weight)
        .input('Position', req.query.position)
        .input('HOF', req.query.hof)
        .input('YearBorn', req.query.yearborn)
        .execute('add_Player');


        const temp = result.recordset;

        res.json(temp);
    }

    catch (error) {

        res.status(500).json(error);
    }
});
router.put('/:id', async (req, res) => {
	// update player
    try{

        await connectPool.connect();

        const result = await connectPool.request()
        .input('PlayerID', req.query.playerid)
        .input('Name', req.query.name)
        .input('Height', req.query.height)
        .input('Weight', req.query.weight)
        .input('Position', req.query.position)
        .input('HOF', req.query.hof)
        .input('YearBorn', req.query.yearborn)
        .execute('edit_Player');


        const temp = result.recordset;

        res.json(temp);
    }

    catch (error) {

        res.status(500).json(error);
    }
});
router.delete('/:id', async (req, res) => {
	// delete player
    try{

        await connectPool.connect();

        const result = await connectPool.request()
        .input('PlayerID', req.query.playerid)
        .execute('delete_Player');


        const temp = result.recordset;

        res.json(temp);
    }

    catch (error) {

        res.status(500).json(error);
    }
});

module.exports = router;




 