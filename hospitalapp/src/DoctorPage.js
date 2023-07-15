import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import "./AvailablePage.css";
import { addDoc } from "firebase/firestore";
import { firestore } from "./firebase";

const DoctorPage = () => {
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

  const [count] = useState("156");


  return (
    <div className='container5'>
      <h5>Hospital Administration Centre</h5>
      <div className='search-container'>
        <input type='text' className='search-input' placeholder='Search...' />
        <button className='search-button'></button>
      </div>

      <div className='deeper1'></div>
      <div className='button-container'>
        <button
          className='button1'
          style={{ border: " none" }}
          onClick={handleHomeClick}
        >
          Home
        </button>
        <button className='button2' onClick={handleAvailableDoctorsClick}>
          Available Doctors
        </button>
        <button className='button3' onClick={handlePatientsRecordsClick}>
          Patients Records
        </button>
        <button className='button4' onClick={handlePendingPatientsClick}>
          Pending Patients
        </button>
        <button className='button5' onClick={handleUserReviewsClick}>
          User Reviews
        </button>
        <button
          className='button6'
          style={{ border: " 4px solid #FFB800" }}
          onClick={handleClickdoctor}
        >
          Doctor Records
        </button>
      </div>

      <div className='pending'>
        <text9 style={{ marginLeft: "100px", Top: "200px" }}>
          Total Doctor<b>{count}</b>
        </text9>

        <div className='pending1'>
          <h7>Doctor ID</h7>
          <h8>Doctor Name</h8>
          <h9>View Profile</h9>
          <h10>Department</h10>
          <h11>Status </h11>

          <table>
            <thead>
              <tr>
                <th style={{color:" black"}}> 221 </th>
                <th style={{color:" black"}}> Sample Pokhrel </th>
                <th style={{color:" black"}}>
                  <Link style={{color:" black"}} to='/profile'>View Profile</Link>
                </th>
                <th style={{color:" black"}}>eurology</th>
                <th style={{color:" black"}}>Part Timer/ Full Timer/ Left </th>
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
export default DoctorPage;
