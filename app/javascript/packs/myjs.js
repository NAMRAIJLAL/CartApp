import axios from 'axios';

axios.get('/api/v1/store/')
.then(function (response) {
  const stores = response.data.stores;
  stores.map((store) => {
    $(".mytable").append(
      `
        <tr><th scope="col">${store.name}</th></tr>
      `
    );

    $.each( store.categories, function( key) {
      $(".mytable").append(
        `
          <tr><td scope="row">${key}</td></tr>
          <tr><td scope="row">${store.categories[key]}</td></tr>
         
        `
      );
    });
  });
 
  // jQuery.map(stores, function(s) {  
  //   console.log(s,"S");
  //   jQuery.each(s,function(i) {
  //     var id= s[i].id;
  //     var name= s[i].name;
  //     console.log(s[i].categories,"store") ;
  //     $(".mytable").append("<tr><th scope=col"+name+"</th>")
  //     jQuery.each(s[i].categories,function(cat) {
  //       console.log(cat,"Category");
  //       $(".mytable").append("<tr></tr><td scope=row>"+cat+"</td>");
  //       jQuery.each(s[i].categories[cat],function(prod) {
  //         // console.log(s[i].categories[cat][prod][0],"products");
  //         $(".mytable").append("<td>"+s[i].categories[cat][prod][0]+"</td>");
          
  //       });
  //     });
      
  //   });
  //   console.log(s,"id");    
  // });
  // console.log(response.data);
});

axios.get('/api/v1/welcomes')
.then(function (response) {
  console.log(response.data);
});

$(document).on("click", ".show-store-btn", (e) => {
  console.log("Fetching store data", e.target)
  axios.get(`/api/v1/store/${e.target.dataset.id}`)
  .then(function (response) {
    console.log(response.data);
  });
})
