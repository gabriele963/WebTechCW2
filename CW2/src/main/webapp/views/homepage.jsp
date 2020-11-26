<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.8.10/themes/smoothness/jquery-ui.css" type="text/css">
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>


    <style>
        h1 {text-align: center;}
        h2 {text-align: center;}
    </style>
    <title>CW2</title>
</head>
<body>
 <h1>Select a date to see the COVID-19 data from that date</h1>

 <div class="DateTime">
     <input type="hidden" id="Date" name="Date" value=""/>
     <center><input style="width: 20%" required="true" placeholder=" Date" id="selectedDate" type="date" name="date" value=""/></center>
 </div>
 <br>
 <br>
 <div id="message"></div>
 <br>
 <div id="NumNewMessage"></div>

 <div id="and"></div>

 <div id="NumTotalMessage"></div>


 <script>

     //Setting the maximum and minimum dates available for the calendar.
    document.getElementById("selectedDate").max = "${currentDate}";
    document.getElementById("selectedDate").min = "2020-02-28";

    //variable holding the number of cases
    var numberOfNewCases;
    var numberOfTotalCases;

    //Updates the Text and runs a method to get the number of COVID cases from that date
    var selectedDate = document.getElementById('selectedDate');
    //Using the onChanged to detect when a new date is selected
    selectedDate.addEventListener("change", async function() {
        //Get the new selected date
        var selectedDate =  document.getElementById('selectedDate').value;

        //Showing the text
        document.getElementById('message').innerHTML = '<h2> On this date there were</h2>';

        //Gets the covid data and displays it using a callback method.
        getCovidData(selectedDate,function (){
            //Displays the COVID data
            document.getElementById('NumNewMessage').innerHTML =  ' <center>  <h3>'+ numberOfNewCases +' New Cases in England</h3></center>\n'

            document.getElementById('and').innerHTML =  ' <center>  <h4>And</h4></center>\n'

            document.getElementById('NumTotalMessage').innerHTML =  ' <center>  <h3>'+ numberOfTotalCases +' Total Cases in England</h3></center>\n'
        });
    });


    //This method gets the COVID data for a specific date from the N
     function getCovidData(date, callback){
         $( function() {
            var pageUrl = 'https://api.coronavirus.data.gov.uk/v1/data?' +
                'filters=areaType=nation;date='+date+';areaName=england&' +
                'structure={' +
                '"date":"date",' +
                '"cumCases":"cumCasesByPublishDate",' +
                '"newCases":"newCasesByPublishDate"}'
            ;
            $.ajax({
                type: 'GET',
                url: pageUrl,
                headers: {
                    'Content-Type':'application/json'
                },
                dataType: 'json',
                success: function (data) {
                    //Putting the covid Cases in a variable
                    numberOfNewCases = (data.data[0].newCases)
                    numberOfTotalCases = (data.data[0].cumCases)
                    if(callback) callback();
                }
            });
        });
     }
</script>

</body>
</html>