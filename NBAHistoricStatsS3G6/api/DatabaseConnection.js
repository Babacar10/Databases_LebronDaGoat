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
router.get('/:teamid', async (req, res) => {
    // get team stats

    try {

        await connectPool.connect();

        const result = await connectPool.request()
        .input('Year', req.query.year)
        .input('TeamID', req.query.teamid)

        .execute('GetTeamStats');

        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});
router.get('/id/:id', async (req, res) => {
    // get single player
    try {

        await connectPool.connect();

        const result = await connectPool.request()
        .input('PlayerID', req.query.playerid)
        .execute('GetPlayerByID');

        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});
router.get('/', async (req, res) => {
    // get all players

    try {

        await connectPool.connect();

        const result = await connectPool.request().execute('GetAllPlayers');

        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});

router.post('/', async (req, res) => {
    // create player
    try {

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
    } catch (error) {

        res.status(500).json(error);
    }
});
router.put('/:id', async (req, res) => {
    // update player
    try {

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
    } catch (error) {

        res.status(500).json(error);
    }
});
router.delete('/:id', async (req, res) => {
    // delete player
    try {

        await connectPool.connect();

        const result = await connectPool.request()
            .input('PlayerID', req.query.playerid)
            .execute('delete_Player');


        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});

router.post('/updatePStats', async (req, res) => {
    // edit player stats
    try {

        await connectPool.connect();

        const result = await connectPool.request()
            .input('PlayerID', req.query.playerid)
            .input('AssistsPG', req.query.apg)
            .input('ReboundsPG', req.query.rpg)
            .input('PointsPG', req.query.ppg)
            .input('TurnoversPG', req.query.topg)
            .input('FGPercent', req.query.fgpct)
            .input('ThreePtPercent', req.query.threepct)
            .input('TrueShootingPercent', req.query.tsp)
            .input('PlayerEfficiencyRating', req.query.per)
            .input('Year', req.query.year)
            .execute('edit_PlayerStats');


        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});

router.post('/addMVP', async (req, res) => {
    // add MVP
    try {

        await connectPool.connect();

        const result = await connectPool.request()
            .input('PlayerID', req.query.playerid)
            .input('Year', req.query.year)
            .execute('add_MVP');


        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});

router.post('/addChamp', async (req, res) => {
    // add Champ
    try {

        await connectPool.connect();

        const result = await connectPool.request()
            .input('TeamID', req.query.teamid)
            .input('Year', req.query.year)
            .execute('add_Championship');


        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});

router.post('/addPlayerStats', async (req, res) => {
    // add Player Stats
    try {

        await connectPool.connect();

        const result = await connectPool.request()
        .input('Name', req.query.name)
        .input('APG', req.query.apg)
        .input('RPG', req.query.rpg)
        .input('PPG', req.query.ppg)
        .input('TOPG', req.query.topg)
        .input('FGPCNT', req.query.fgpct)
        .input('3PPCNT', req.query.threepct)
        .input('TSP', req.query.tsp)
        .input('Year', req.query.year)
        .input('PER', req.query.per)       
        .execute('add_PlayerStats');


        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});

router.get('/playerStats/:pid', async (req, res) => {
    // get single player
    try {

        await connectPool.connect();

        const result = await connectPool.request()
        .input('PlayerID', req.query.playerid)
        .input('Year', req.query.year)
        .execute('GetPlayerStats');

        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});

router.get('/getMVP/:year', async (req, res) => {
    // get single player
    try {

        await connectPool.connect();

        const result = await connectPool.request()
        
        .input('Year', req.query.year)
        .execute('GetMVP');

        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});

router.get('/getChamp/:year', async (req, res) => {
    // get single player
    try {

        await connectPool.connect();

        const result = await connectPool.request()
        
        .input('Year', req.query.year)
        .execute('GetChampion');

        const temp = result.recordset;

        res.json(temp);
    } catch (error) {

        res.status(500).json(error);
    }
});

module.exports = router;