window.addEventListener('DOMContentLoaded', (event) =>{
    getVisitCount();
})

const backendApiUrl = 'https://baz08e6rh8.execute-api.us-east-1.amazonaws.com/prod/count';


const getVisitCount = () => {
    let count = 30;
    fetch(backendApiUrl, {
        // method  : 'GET',
        headers: {

            'Content-Type': 'application/json',
        },
      }).then(response => {
        return response.json()
    }).then(response =>{
        // console.log("Website called function API.");
        // console.log(response)
        count =  response;
        document.getElementById("counter").innerText = count;
    }).catch(function(error){
        console.log(error);
    });

    // document.getElementById("counter").innerText = count;
    return count;
}