1) I started this project by creating 3 folders to separate the Views, Models and API manager from each other so it would be easier to know what each class is responsible for and be able to easily make changes in the future.

2) After that I wrapped the entire application code with a ValueListenableBuilder that will be responsible for changing the theme of the app from light mode to dark mode and vice versa and I linked it to a trailing button on the AppBar of the HomePage and used the ternary operator to switch between the two modes.

3) For the model I used an online tool (https://javiercbk.github.io/json_to_dart/) that automatically creates a model in Dart by just coping the JSON code into the website.

4) For the API request I created an Asnyc Future method called "getJobs" that creates an instance of the JobsModel class and makes a GET request from the JSON URL and checks to see if the response code is 200 (successful) and if that's the case, it will store the data (body) of the JSON into a variable and then decode the JSON data and store it into the JobsModel instance which will be the return value of the method.

5) For the HomePage I created a Future JobsModel variable called "_jobsModel" that will have the same value as the method in the API manager (getJobs) and then I created a FutureBuilder inside the body of the HomePage that takes the variable "_jobsModel" as its Future and builds a ListView from it. The ListView will be responsible for storing all the Widgets that will be displaying the data we got from the API request using the "jobs" variable that we created from the snapshot variable that comes with the FutureBuilder, I then wrapped all the ListView sub-widgets into an InkWell Widget that will be responsible for handling the touch input so that it takes the app into the JobInformationScreen unsing the GetX package as the Navigator whenever the user clicks on a List item.

6) For the JobInformationPage I created a StatelessWidget that takes many variables as inputs in the constructor (such as the Job Title, Company Name, Description) and then displays those variables using a variety of Widgets wrapped with a SingleChildScrollView Widget to allow the user to scroll through the screen, and then I added an ElevatedButton that opens a WebView to the URL variable from the HomeScreen using the url_launcher package.

7) In the AppBar of the HomePage I created a PopupMenu that allows the user to sort all the jobs either by name or salary, I used an Enum to be able to switch between the two items and then inside the ListView I used an if-if else statement to sort the jobs list based on what the user chooses in the PopupMenu.

8) To make sure the layout is flexible across all device screens, I used the MediaQuery Widget to scale down the other Widgets to fit the screen.

9) Lastly, I added an extra RefreshIndicator so that the user can refresh the screen and get the latest data whenever they scroll from the top to the bottom inside the HomePage.