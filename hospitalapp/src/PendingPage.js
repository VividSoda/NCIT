import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import "./AvailablePage.css";
const PendingPage = () => {
  const navigate = useNavigate();
  const handleHomeClick = () => {
    navigate("/dashboard");
  };

  const handleAvailableDoctorsClick = () => {
    navigate("/available");
  };

  const handlePatientsRecordsClick = () => {
    navigate("/patient");
  };

  const handlePendingPatientsClick = () => {
    navigate("/pending");
  };

  const handleUserReviewsClick = () => {
    navigate("/user");
  };
  const handleClickdoctor = () => {
    navigate("/doctor");
  };


  const [count] = useState("1200");

  return (
    <div className='container5'>
      <h5>Hospital Administration Centre</h5>
      <div className='search-container'>
        <input type='text' className='search-input' placeholder='Search...' />
        <button className='search-button'></button>
      </div>

      <div className='deeper1'></div>
      <div className='button-container'>
      <button className="button1"style={{border:" none"}} onClick={handleHomeClick}>
            Home
          </button>
          <button className="button2" onClick={handleAvailableDoctorsClick}>Available Doctors</button>
          <button className="button3" onClick={handlePatientsRecordsClick}>
            Patients Records
          </button>
          <button className="button4" style={{border:" 4px solid #FFB800"}} onClick={handlePendingPatientsClick}>
            Pending Patients
          </button>
          <button className="button5" onClick={handleUserReviewsClick}>
            User Reviews
          </button>
          <button className="button6" onClick={handleClickdoctor}>Doctor Records</button>
      </div>
        <div className='pending'>
        <text9 style={{ marginLeft: "100px", Top: "200px" }}>
          Total Doctor<b>{count}</b>
        </text9>
          <div className='pending1'>
            <h7>Patient ID</h7>
            <h8>Patient Name</h8>
            <h9>Department</h9>
            <h10>AssignedDoctor</h10>
            <h11> AppointmentTime&Date</h11>

            <table>
              <thead>
                <tr>
                <th style={{color:" black"}}>221</th>
                  <th style={{color:" black"}}>Sample Joshi</th>
                  <th style={{color:" black"}}>ENT</th>
                  <th style={{color:" black"}}>Sample Pokhrel</th>
                  <th style={{color:" black"}}>June 10th 2023 , 12:00 am</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    );
  };
  export default PendingPage;
