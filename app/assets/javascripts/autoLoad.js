/**
 * Created with JetBrains RubyMine.
 * User: junedkazi
 * Date: 10/15/13
 * Time: 12:31 AM
 * To change this template use File | Settings | File Templates.
 */


$(document).ready(function() {

    $("#s").autocomplete({
        source: function(request, response) {
            $.ajax({
                url: "/posts/searchAuto",
                dataType: "json",
                data: {
                    term : request.term,
                    searchType : $("#selectSearch").val()
                },
success: function(data) {
    response(data);
    }
});
}

});


});
