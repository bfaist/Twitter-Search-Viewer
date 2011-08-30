$(document).ready(function() {
    $('#loading').hide().ajaxStart(function(){$(this).show();}).ajaxStop(function(){$(this).hide();});

    $(".search_term_item a").click(function() {
         var link_id = $(this).attr('id');
         var search_term = link_id.split(':');
         $.get('/ajax/' + search_term[0] + '/' + search_term[1], function(data) {
             $("#tweet_list").html(data);
         });
         $(".search_term_item a").removeClass("triangle-obtuse top");
         $(this).addClass("triangle-obtuse top");
    });
    $(".search_term_item:first a").click();    
});
