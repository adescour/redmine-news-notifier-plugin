
function promptToRemoteExtended(text, param, url) {
    selected_list_id = document.getElementById('subscriptions_list_id').value;
    selected_index =document.getElementById('subscriptions_list_id').selectedIndex;

    selected_list_text = document.getElementById('subscriptions_list_id').options[selected_index].text;

    value = prompt(text + ':',selected_list_text);

    chbx = document.getElementById('news[watchers_users_ids]');
    div = document.getElementById('news_watchers');
    inputs = div.getElementsByTagName('input');


    param_extended = "";

    // add selected users to params that will be send to the controller's action
    for(i = 0; i < inputs.length; i++){
      if(inputs[i].type.toLowerCase() == 'checkbox' && inputs[i].checked == true){
        param_extended += "&users_ids[]="+inputs[i].value;
      }
    }

    // also add the id of the selected subscriptions_list, if the name isn't changed, the user wants to redefine the list
    // else he wants to create a new one
    param_extended += "&subscriptions_list[id]="+selected_list_id;

    if (value) {
        new Ajax.Request(url + '?' + param + '=' + encodeURIComponent(value) + param_extended, {asynchronous:true, evalScripts:true});
        return false;
    }
}

