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

## Project Structure
```plaintext
lib/
|-- main.dart       // Entry point of the application
|-- components/     // Reusable UI components
|-- database/       // Local database management
|-- models/         // Data models
|-- pages/          // Application pages/screens
|-- utils/          // Utility functions and helpers
