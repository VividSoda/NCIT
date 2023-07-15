import React, { Component } from 'react'
import { useNavigate } from 'react-router-dom';
import './AvailablePage.css';

const ClickonuserprofilePage = () => {
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
  return (
    <div className='container5'>
      <h5>Hospital Administration Centre</h5>
      <div className='search-container'>
        <input type='text' className='search-input' placeholder='Search' />
        <button className='search-button'aria-label="Search through site content"></button>
      </div>

      <div className='deeper1'></div>
      <div className='button-container'>
        <button
          className='button1'
          style={{ border: "none" }}
          onClick={handleHomeClick}
        >
          Home
        </button>
        <button
          className='button2'
          style={{ border: " 4px solid #FFB800" }}
          onClick={handleAvailableDoctorsClick}
        >
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
        <button className='button6' onClick={handleClickdoctor}>
          Doctor Records
        </button>
      </div>

 
        <div className='available'>
            <p0>Doctor ko verification gareko form yeta aaucha hamro APPLICATION BATA</p0>
            </div>
        </div>
    )
  }
export default ClickonuserprofilePage;
