# SemResource (Upgraded Version of SemBreaker)

An advanced platform available on both Android and Web, designed to empower users with streamlined access to academic resources and utilities.

## Features

### Mobile Application Features
- **Login**: Official IIITA Gmail login with OTP verification.
- **Profile Selection**: Choose semester, branch, and batch.
- **Features**: Based on the selected semester, the user will be provided with:
  - **Material**: Lecture Notes PDFs
  - **Question Papers**: Year-wise previous papers (PDF)
  - **Moderators**
  - **Important Links**: Videos and documentation
  - **Recommended Books**
- **Access PDFs**: View, download, and share PDFs for selected semester subjects.
- **Edit Profile**: Update semester, branch, and batch details.
- **Theme Options**: Switch between dark and light themes.
- **Recent Searches**: Access recent searches offline (stored locally).
- **TA Connect**: Connect with TAs for respective subjects.
- **Calendar**: Add and manage class schedules, extra lectures, tutorials, labs, and day-to-day events using local storage.

### Web Application Features
- **Login**: Official IIITA Gmail login with OTP verification.
- **Profile Selection**: Choose semester, branch, and batch.
- **Material Access**: Based on the selected semester, access:
  - **Lecture Notes PDFs**
  - **Question Papers** (year-wise previous papers)
  - **Moderators**
  - **Important Links**: Videos and documentation
  - **Recommended Books**
- **Resource Upload**: Add specific PDFs, links, moderators, and papers after selecting a particular semester, batch, and branch.

### App Development
- **Flutter Framework**: For cross-platform compatibility.

### Web Development
- **React Framework**: For an interactive frontend.

### Common Backend
- **Node.js, Express.js, TypeScript**: For type-safe and efficient backend development.

### Database
- **MongoDB**: For flexible and reliable data storage.

## Getting Started

### Prerequisites
- Install Flutter SDK (ensure version compatibility)
- Install React for web development
- Install Node.js and npm
- A device/emulator to run the application
- flutter pub get
- flutter run
- cd web/
- npm install
- npm start

## Contact
For any questions or support, please contact:

- **Name**: Naitik Jain
- **Email**: [naitikjain2005@gmail.com](mailto:naitikjain2005@gmail.com)
- **GitHub**: [ParadoxNJ005](https://github.com/ParadoxNJ005)


### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/ParadoxNJ005/CyberShelf.git
   cd <repository-folder>

## Project Structure
```plaintext
lib/
|-- main.dart       // Entry point of the application
|-- components/     // Reusable UI components
|-- database/       // Local database management
|-- models/         // Data models
|-- pages/          // Application pages/screens
|-- utils/          // Utility functions and helpers
