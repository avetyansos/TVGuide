#  TVGuide

TVGuide is a TV Guide application that displays a list of channels and their associated programs using the VIPER architecture, Swift, and Diffable Data Source. The project demonstrates how to fetch data from a remote API and display it using UITableView or UICollectionView. It also shows how to use Swagger/OpenAPI to generate API client code for the application.

## Features

- Fetches channels and programs from remote API
- Displays channels vertically and associated programs horizontally
- Implements VIPER architecture
- Uses Diffable Data Source for managing table view or collection view
- Uses Swagger/OpenAPI for generating API client code
- Includes unit tests for the Interactor

## Project Structure

The project is organized into the following main directories:

- VIPER: Contains the VIPER components (Interactors, Presenters, Views, Routers, and Protocols)
- Networking: Contains the networking layer (OpenAPIClient)
- Utils: Contains utility classes (TVGuideError, TVGuideAPIClient, StoryboardType. Storyboardable)
- TVGuideTests: Contains the test files (TVGuideInteractorTests) and mocks (TVGuideInteractorOutputMock, TVGuideAPIClientMock)

## Getting Started

1. Clone the repository: `git clone https://github.com/avetyansos/TVGuide`
2. Open the project in Xcode: `open TVGuide.xcodeproj`
3. Install the required dependencies (if any) and ensure that the project builds successfully.
4. Run the project on the iOS Simulator or an iOS device.

## Dependencies

- (List any third-party libraries, frameworks, or tools used in the project.)

