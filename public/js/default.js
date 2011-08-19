$(document).ready(function() {
    $("a").click(function() {
         var link_id = $(this).attr('id');
         var search_term = link_id.split(':');
         $.get('/ajax/' + search_term[0] + '/' + search_term[1], function(data) {
             $("#tweet_list").html(data);
         });
    });
});
