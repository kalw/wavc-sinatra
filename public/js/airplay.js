$.get()  
    $("#get").click(function(){  
        $("#result").html(ajax_load);  
        $.get(  
            airplay.html,  
            {language: "php", version: 5},  
            function(responseText){  
                $("#result").html(responseText);  
            },  
            "html"  
        );  
    });  
