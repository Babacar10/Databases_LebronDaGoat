var rhit = rhit || {};
const apiURL = "http://localhost:3000/api/DatabaseConnection" 
let allEntries = fetch(apiURL)
        .then(response => response.json())
        .then(data => console.log(data)); 

        rhit.teamController = class {
                constructor(){
                        document.querySelector("#teamsearch").onclick = (event) => {
                                this.loadteams();
                        }
                        document.querySelector("#teamfind").onclick = (event) => {
                                this.chooseteam();
                        }

                }
                loadteams(){
                        let dataHtml = ''
                        
                        for(var i =0; i < 5; i++){
                                dataHtml += `<li> teamname here </li>`
                        }
                        var table = document.getElementById('teamdrop');
                        table.innerHTML = '<li id = "dropdownteams">Teams<ul>' + dataHtml + '</ul></li>';
                }
                chooseteam(){
                //var table = document.getElementById('teamdrop');
               // table.innerHTML = '<li id = "dropdownteams">Teams</li>';
               let year = document.getElementById('41')
               let Team = document.getElementById('40')
               let dataHtml = ''
               fetch("http://localhost:3000/api/DatabaseConnection/:teamid/?" + "year="+ year.value+"&teamid=" + Team.value ).then(response => response.json()).then(data => {
                
                    
                   
                var table = document.getElementById('tableBody1');
                    table.innerHTML ='';
console.log(data);
let dataHtml = ''
data.forEach(element => {
       
        dataHtml += `<tr><td>${element['TeamID']}</td><td>${element['Wins']}</td><td>${element['Losses']}</td><td>${element['Year']}</td><td>${element['FGPercent']}</td><td>${element['ThreePtPercent']}</td><td>${element['PtsPG']}</td><td>${element['TurnoversPG']}</td><td>${element['WinPercent']}</td></tr>`
});
table.innerHTML = dataHtml;
                
                                    
                                })
                        for(var i =0; i < 5; i++){
                                dataHtml += `<li> player here </li>`
                        }
                        var table = document.getElementById('players');
                        table.innerHTML = '<li id = "playersdropdown">Players<ul>' + dataHtml + '</ul></li>';

                        dataHtml = ''
                        
                        for(var i =0; i < 5; i++){
                                dataHtml += `<li> Team stats here </li>`
                        }
                   
                }
        }
        rhit.mvpController = class {
                constructor() {
                        document.querySelector("#createmvp").onclick = (event) => {
                                this.createmvp();
                        }
                        document.querySelector("#findmvp").onclick = (event) => {
                                this.getmvp();
                        }
                } 
                createmvp(){
                        var year = document.getElementById('21');
                        var player = document.getElementById('20');
                        console.log(year.value + ' ' + player.value);
                        fetch("http://localhost:3000/api/DatabaseConnection/addMVP/?" + "playerid="+ player.value +"&year="+year.value,{
                                method: 'POST'
                                });
                                
      
                }

                getmvp(){
                        var year = document.getElementById('21');
                        fetch("http://localhost:3000/api/DatabaseConnection/getMVP/:year/?" + "year="+ year.value).then(response => response.json()).then(data => {
                
                    
                   
                                var table = document.getElementById('tableBody2');
                                    table.innerHTML ='';
                console.log(data);
                let dataHtml = ''
                data.forEach(element => {
                       
                        dataHtml += `<tr><td>${year.value}</td><td>${element['PlayerID']}</td><td>${element['Name']}</td></tr>`;
                        table.innerHTML =dataHtml;
                }
                );
                });
                }
        }

        rhit.compareController = class {
                constructor() {
                                console.log("hello");
                                document.querySelector("#compare").onclick = (event) => {
                                        this.readcompareone();
                                        this.readcomparetwo();
                                        this.loadstats12();
                                }
                    }
                    
            readcompareone(){
                console.log(`Reading Players`);
                let pid = document.getElementById("30").value;
                // TODO: Add your code here.
                //document.querySelector("#getone").innerHTML = "";
                
                fetch("http://localhost:3000/api/DatabaseConnection/id/:id?" + "playerid="+ pid).then(response => response.json()).then(data => {
                    let i = 0
                //     while (i < words.length) {
                //         console.log(words);
                //     }
                    //console.log(words);
                    //var array = words[0];
                    //document.getElementById("display-array").textContent = array.Name +" "+ array.Height +" "+ array.Weight;
                    var table = document.getElementById('tableBody1');
                    table.innerHTML ='';
console.log(data);
let dataHtml = ''
data.forEach(element => {
        let hof = "No"
        if (element['HOF']){
                hof = "Yes"
        }
        dataHtml += `<tr><td>${element['Name']}</td><td>${Math.floor(element['Height'] / 12)}' ${element['Height'] - Math.floor(element['Height'] / 12)*12}"</td><td>${element['Weight']}</td><td>${element['Position']}</td><td>${hof}</td></tr>`
});
table.innerHTML = dataHtml;
                })
                // console.log(words);
                // Hint for something you will need later in the process (after backend call(s))
                
            

            }
            readcomparetwo(){
                console.log(`Reading Players`);
                let pid = document.getElementById("31").value;

                
                fetch("http://localhost:3000/api/DatabaseConnection/id/:id?" + "playerid="+ pid).then(response => response.json()).then(data => {
                    let i = 0
 
                    var table = document.getElementById('tableBody2');
                    table.innerHTML ='';
console.log(data);
let dataHtml = ''
data.forEach(element => {
        let hof = "No"
        if (element['HOF']){
                hof = "Yes"
        }
        dataHtml += `<tr><td>${element['Name']}</td><td>${Math.floor(element['Height'] / 12)}' ${element['Height'] - Math.floor(element['Height'] / 12)*12}"</td><td>${element['Weight']}</td><td>${element['Position']}</td><td>${hof}</td></tr>`
});
table.innerHTML = dataHtml;
                })
                // console.log(words);
                // Hint for something you will need later in the process (after backend call(s))
                
            
                    
            }
        loadstats12(){
                console.log(`Reading Players`);
                let pid = document.getElementById("31").value;

                
                fetch("http://localhost:3000/api/DatabaseConnection/playerStats/:pid?" + "playerid="+ pid+"&year=0000").then(response => response.json()).then(data => {
                    let i = 0
 
                    var table = document.getElementById('tableBody6');
                    table.innerHTML ='';
console.log(data);
let dataHtml = ''
data.forEach(element => {
       
        dataHtml += `<tr><td>${element['AssistsPG']}</td><td>${element['ReboundsPG']}</td><td>${element['PointsPG']}</td><td>${element['TurnoversPG']}</td><td>${element['FGPercent']}</td><td>${element['ThreePtPercent']}</td><td>${element['TrueShootingPercent']}</td><td>${element['PlayerEfficiencyRating']}</td><td>${element['Year']}</td></tr>`
});
table.innerHTML = dataHtml;
                })
                pid = document.getElementById("30").value;
                fetch("http://localhost:3000/api/DatabaseConnection/playerStats/:pid?" + "playerid="+ pid+"&year=0000").then(response => response.json()).then(data => {
                    let i = 0
 
                    var table = document.getElementById('tableBody7');
                    table.innerHTML ='';
console.log(data);
let dataHtml = ''
data.forEach(element => {
       
        dataHtml += `<tr><td>${element['AssistsPG']}</td><td>${element['ReboundsPG']}</td><td>${element['PointsPG']}</td><td>${element['TurnoversPG']}</td><td>${element['FGPercent']}</td><td>${element['ThreePtPercent']}</td><td>${element['TrueShootingPercent']}</td><td>${element['PlayerEfficiencyRating']}</td><td>${element['Year']}</td></tr>`
});
table.innerHTML = dataHtml;
                })
        }
        }
















        rhit.AdminController = class {
                constructor() {
                console.log("construct");
                document.querySelector("#getall").onclick = (event) => {
                                this.readAll();
                        };
                document.querySelector("#getone").onclick = (event) => {
                                this.readone();
                        };
                        document.querySelector("#del").onclick = (event) => {
                                this.deleteone();
                        };
                        document.querySelector("#update").onclick = (event) => {
                                this.editone();
                        };
                        document.querySelector("#create").onclick = (event) => {
                                this.createone();
                        };
                       
            }
            readAll() {
                console.log(`Reading Players`);
            
                // TODO: Add your code here.
                //document.querySelector("#getone").innerHTML = "";
                
                fetch(`http://localhost:3000/api/DatabaseConnection`).then(response => response.json()).then(data => {
                    // let i = 0
                    // while (i < words["words"].length) {
                    //     console.log(words);
                    // }
                    //console.log(words);
                    
                    var table = document.getElementById('tableBody');
                    table.innerHTML ='';
console.log(data);
let dataHtml = ''
data.forEach(element => {
        let hof = "No"
        if (element['HOF']){
                hof = "Yes"
        }
        dataHtml += `<tr><td>${element['PlayerID']}</td><td>${element['Name']}</td><td>${Math.floor(element['Height'] / 12)}' ${element['Height'] - Math.floor(element['Height'] / 12)*12}"</td><td>${element['Weight']}</td><td>${element['Position']}</td><td>${hof}</td></tr>`
});
table.innerHTML = dataHtml;
                    
                })
                // console.log(words);
                // Hint for something you will need later in the process (after backend call(s))
                
            }
            readone() {
                console.log(`Reading Players`);
                let pid = document.getElementById("getoneid").value;
                // TODO: Add your code here.
                //document.querySelector("#getone").innerHTML = "";
                
                fetch("http://localhost:3000/api/DatabaseConnection/id/:id?" + "playerid="+ pid).then(response => response.json()).then(data => {
                    let i = 0
                //     while (i < words.length) {
                //         console.log(words);
                //     }
                    //console.log(words);
                    //var array = words[0];
                    //document.getElementById("display-array").textContent = array.Name +" "+ array.Height +" "+ array.Weight;
                    var table = document.getElementById('tableBody');
                    table.innerHTML ='';
console.log(data);
let dataHtml = ''
data.forEach(element => {
        let hof = "No"
        if (element['HOF']){
                hof = "Yes"
        }
        dataHtml += `<tr><td>${element['PlayerID']}</td><td>${element['Name']}</td><td>${Math.floor(element['Height'] / 12)}' ${element['Height'] - Math.floor(element['Height'] / 12)*12}"</td><td>${element['Weight']}</td><td>${element['Position']}</td><td>${hof}</td></tr>`
});
table.innerHTML = dataHtml;
                })
                // console.log(words);
                // Hint for something you will need later in the process (after backend call(s))
                
            }


            deleteone(){
                console.log(`Deleting Player`);
                let pid = document.getElementById("getdelid").value;
                       

                const response = fetch("http://localhost:3000/api/DatabaseConnection/:id?" + "playerid="+ pid,
                {
                method: 'DELETE'
        });

        console.log("Player "+pid+" deleted");

            }


        editone(){
                        let pid = document.getElementById("10").value;
        let name = document.getElementById("11").value;
        let height = document.getElementById("12").value;
        let weight = document.getElementById("13").value;
        let position = document.getElementById("14").value;
        let hof = document.getElementById("15").value;
        let yearborn =  document.getElementById("16").value;


        const response = fetch("http://localhost:3000/api/DatabaseConnection/:id?" + "playerid="+ pid +"&name="+ name + "&height=" + height + "&weight=" + weight + "&position=" + position + "&hof=" + hof + "&yearborn=" +yearborn,
        {
        method: 'PUT'
        });

        console.log("Player "+pid+" edited");
        }

        createone(){
                let pid = document.getElementById("10").value;
        let nameVal = document.getElementById("11").value;
        let heightVal = document.getElementById("12").value;
        let weight = document.getElementById("13").value;
        let position = document.getElementById("14").value;
        let hof = document.getElementById("15").value;
        let yearborn =  document.getElementById("16").value;
        const response = fetch("http://localhost:3000/api/DatabaseConnection/?" + "name="+ nameVal + "&height=" + heightVal + "&weight=" + weight + "&position=" + position + "&hof=" + hof + "&yearborn=" +yearborn, 
                {
                method: 'POST'
                });
        
                console.log("Player "+nameVal+" added");
        }
        
        }
// document.getElementById("submit").onclick = (event) => {
//         let nameVal = document.getElementById("1").value;
//         let heightVal = document.getElementById("2").value;
//         let weight = document.getElementById("3").value;
//         let position = document.getElementById("4").value;
//         let hof = document.getElementById("5").value;
//         let yearborn =  document.getElementById("6").value;


//         const response = fetch("http://localhost:3000/api/DatabaseConnection/?" + "name="+ nameVal + "&height=" + heightVal + "&weight=" + weight + "&position=" + position + "&hof=" + hof + "&yearborn=" +yearborn, 
//         {
//         method: 'POST'
//         });

//         console.log("Player "+nameVal+" added");
// }

// document.getElementById("del").onclick = (event) => {
//         let pid = document.getElementById("delnum").value;

//         const response = fetch("http://localhost:3000/api/DatabaseConnection/:id/?" + "playerid="+ pid,
//         {
//         method: 'DELETE'
//         });

//         console.log("Player "+pid+" deleted");
// }

// document.getElementById("edit").onclick = (event) => {
//         let pid = document.getElementById("10").value;
//         let name = document.getElementById("11").value;
//         let height = document.getElementById("12").value;
//         let weight = document.getElementById("13").value;
//         let position = document.getElementById("14").value;
//         let hof = document.getElementById("15").value;
//         let yearborn =  document.getElementById("16").value;


//         const response = fetch("http://localhost:3000/api/DatabaseConnection/:id/?" + "playerid="+ pid +"&name="+ name + "&height=" + height + "&weight=" + weight + "&position=" + position + "&hof=" + hof + "&yearborn=" +yearborn,
//         {
//         method: 'PUT'
//         });

//         console.log("Player "+pid+" edited");
// }

// document.getElementById("getone").onclick = (event) => {
//         let pid = document.getElementById("getoneid").value;


//         const response = fetch("http://localhost:3000/api/DatabaseConnection/:id/?" + "playerid="+ pid ,
//         {
//         method: 'GET'
//         })
//         .then(response => response.json())
//         .then(data => console.log(data));
       
// }



rhit.champController = class {
        constructor() {
                document.querySelector("#createchamp").onclick = (event) => {
                        this.createchamp();
                }
                document.querySelector("#loadchamp").onclick = (event) => {
                        this.loadchamp();
                }
        } 
        createchamp(){
                var year = document.getElementById('21');
                var player = document.getElementById('20');
                console.log(year.value + ' ' + player.value);
                fetch("http://localhost:3000/api/DatabaseConnection/addChamp/?" + "teamid="+ player.value +"&year="+year.value,{
                        method: 'POST'
                        });
                        

        }

        loadchamp(){
                var year = document.getElementById('21');
                var one;
                fetch("http://localhost:3000/api/DatabaseConnection/getChampionshipByYear1/:teamyear?" + "year="+ year.value).then(response => response.json()).then(data => {
        
            
           
                        one = data[0]['TeamID'];
                            
        console.log(data[0]['TeamID']);
    
       
        });



                fetch("http://localhost:3000/api/DatabaseConnection/getChampionshipByYear/:teamyear?" + "year="+ year.value).then(response => response.json()).then(data => {
        
            
           
                        var table = document.getElementById('tableBody8');
                            table.innerHTML ='';
        console.log(data);
        let dataHtml = ''
        data.forEach(element => {
               
                dataHtml += `<tr><td>${year.value}</td><td>${one}</td><td>${element['Name']}</td></tr>`;
                table.innerHTML =dataHtml;
        }
        );
        });
        }
}












rhit.playerstatsController = class {
        constructor() {
        
                document.querySelector("#update3").onclick = (event) => {
                        this.editone();
                };
                document.querySelector("#create3").onclick = (event) => {
                        this.createone();
                };
               
    }
    

editone(){
let pid = document.getElementById("50").value;
let APG = document.getElementById("51").value;
let RPG = document.getElementById("52").value;
let PPG = document.getElementById("53").value;
let Turnovers = document.getElementById("54").value;
let FG = document.getElementById("55").value;
let ThreePT =  document.getElementById("56").value;
let TSP =  document.getElementById("57").value;
let year =  document.getElementById("58").value;
let PER =  document.getElementById("59").value;


const response = fetch("http://localhost:3000/api/DatabaseConnection/updatePStats/?" + "playerid="+ pid +"&apg="+ APG + "&rpg=" + RPG + "&ppg=" + PPG + "&topg=" +Turnovers + "&fgpct=" + FG + "&threepct=" +ThreePT +"&per="+PER +"&tsp="+TSP+"&year="+year,
{
method: 'POST'
});

console.log("Player "+pid+" edited");
}

createone(){
let pid = document.getElementById("50").value;
let APG = document.getElementById("51").value;
let RPG = document.getElementById("52").value;
let PPG = document.getElementById("53").value;
let Turnovers = document.getElementById("54").value;
let FG = document.getElementById("55").value;
let ThreePT =  document.getElementById("56").value;
let TSP =  document.getElementById("57").value;
let year =  document.getElementById("58").value;
let PER =  document.getElementById("59").value;
const response = fetch("http://localhost:3000/api/DatabaseConnection/addPlayerStats/?" + "playerid="+ pid +"&apg="+ APG + "&rpg=" + RPG + "&ppg=" + PPG + "&topg=" +Turnovers + "&fgpct=" + FG + "&threepct=" +ThreePT + "&tsp="+TSP+"&per="+PER+"&year="+year,
{
method: 'POST'
});

}

}


















/* Main */
rhit.main = function () {
if(document.querySelector("#home")){	
new rhit.AdminController();}
if(document.querySelector("#compareit")){	
        new rhit.compareController();}
if(document.querySelector("#mvp")){	
        new rhit.mvpController();}

if(document.querySelector("#teams")){	
        new rhit.teamController();}

if(document.querySelector("#champ")){	
        new rhit.champController();
};
if(document.querySelector("#playerstats")){	
        new rhit.playerstatsController();
};
};

rhit.main();