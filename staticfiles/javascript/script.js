var body = document.body;
var test = 0;

body.addEventListener("click", (event) => {
    if (test == 0) {
        body.style.backgroundColor = 'red';  // Change background color to red
        test = 1;
    } else {
        body.style.backgroundColor = 'blue'; // Change background color to blue
        test = 0;
    }
});

