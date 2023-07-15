import React from 'react';
import { BrowserRouter as Router, Route,Routes} from 'react-router-dom';
import LoginPage from './LoginPage';
import DashboardPage from './DashboardPage';
import AvailablePage from './AvailablePage';
import PatientPage from './PatientPage';
import PendingPage from './PendingPage';
import UserPage from './UserPage';
import DoctorPage from './DoctorPage';
import ClickonuserreviewPage from './ClickonuserreviewPage';
import ViewreportPage from './ViewreportPage'; // Import the correct component
import ClickindoctorPage from './ClickindoctorPage'; // Import the correct component
import ClickonuserprofilePage from './ClickonuserprofilePage'; 


import './App.css';

function App() {
  return (
    <Router>
      <Routes >
        <Route path="/" element={<LoginPage />} />
        <Route path="/dashboard" element={<DashboardPage />} />
        <Route path="/available" element={<AvailablePage />} />
        <Route path="/patient" element={<PatientPage />} />
        <Route path="/pending" element={<PendingPage />} />
        <Route path="/user" element={<UserPage />} />
        <Route path="/doctor" element={<DoctorPage />} />
        <Route path="/review" element={<ClickonuserreviewPage />} />
        <Route path="/viewreport" element={<ViewreportPage />} />
        <Route path="/profile" element={<ClickonuserprofilePage />} />
        <Route path="/click" element={<ClickindoctorPage />} />
      </Routes>
    </Router>
  );
}

export default App;
