# Welcome to CarBooking application.

By using this SwiftUI application, you will be able to find and search for the available cars for booking.

Steps followed while implementing the application:

- Checked the EndPoint response and created the Model based on needed data.
- For Networking used Moya framework, which is using Alamofire logic under the hood and adding a higher level of enums to facilitate dealing with multiple endpoints, also it provides easy handling for stub files. 
- Created a Service class to handle APIs calls which will be injected to the ViewModel.
  - Used Combine in service fetching logic, used `requestPublisher` to publish cars data fetched from the MoyaProvider and subscribed to it to complete the method with the given response.
- The architecture used is MVVM, used it since ViewModel is pure logic and it’s not coupled with the view code, this will helps on clean visibility of the logic behavior and helps a lot with adding tests to the app.
- Used Async Await methodology in the ViewModel to fetch the available cars data from the service object then working on that data to properly display it.
- Used Combine in `CarListViewModel` to observe `state` changes and update the presented cars accordingly.

- Created multiple screens for the application flow as follows:
	- `MainMenuView`: Contains the main UI to start the app with different options simulation, either with `success`, `empty` or `failure`.
	- `LoadingView`: A view with progress view to be used when there is APIs calling is in progress, will be shown when car list screen starts to load data.
	- `CarListView`: A view with list presenting the car list using List component, and a filter button to allow user to search for cars with specific criterias.
        - `CarCell`: A view to display the content of each car on the list.
    - `CarDetailsView`: A view that will appear when the user tap on a specific car on from the car list, it will show the full data of the tapped car.
	- `ErrorView`: A view that will appear if there is an error occurred while fetching the data, giving the user an option to retry fetching the data by tapping on retry button.
	
    - `EmptyStateView`: will be displayed in one of the following scenarios, 
		- if the response from the backed is empty notifying the user that there are no available cars in the meantime.
		- if we don't have available cars matches the filters that the user selected, in this case the empty screen will be presented and has the following scenarios with slightly different options:
            - the user selected invalid colors and invalid price, CTA will be available to view all cars (remove all filters), this CTA will be added for all filter cases.
            - the user selected invalid colors and valid price, CTA will be available to view all available cars within the price but in different colors (remove color filters).
            - the user selected valid colors and invalid price, CTA will be available to view all available cars with the specified colors but with different prices (remove price filters).
            - the user selected valid colors and valid price but not matched on one car, both previous CTAs will be available to view all available cars with the specified colors but with different prices or within the price but in different colors.

- Added unit testing to test the full logic used in view model, 
	- Used Moya's sample data to simulate stub data needed for the unit tests and added full tests to make sure that the data is properly handled from fetching to presentation and filtering.

*Troubleshooting Notes:*
- run `pod install`
- Select the correct `CarBooking` app scheme 
