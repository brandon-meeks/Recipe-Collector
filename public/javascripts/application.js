$(document).ready(function(){
  $('#add_ing_button').click(function(e) {
    $('#ingredients').append(
      '<div class="row">\
        <div class="col-sm-4">\
          <input type="text" name="recipe[ingredient][][name]" id="ing_name" placeholder="Flour" class="form-control">\
        </div>\
        <div class="col-sm-1">\
          <input type="text" name="recipe[ingredient][][quantity]" id="ing_qty" placeholder="3" class="form-control">\
        </div>\
        <div class="col-sm-2">\
          <select class="form-control" name="recipe[ingredient][][qty_type]">\
            <option value="cups">Cups</option>\
            <option value="oz">Ounces</option>\
            <option value="lbs">Lbs</option>\
            <option value="grams">Grams</option>\
            <option value="kilograms">Kilograms</option>\
            <option value="liters">Liters</option>\
          </select>\
        </div>\
      </div>'
    );
  });
});