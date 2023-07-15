import React from "react";
import { useNavigate } from "react-router-dom";
import "./DashboardPage.css";

function DashboardPage() {
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
    <>
      <div className='container3'>
        <content> Hospital Administration Centre </content>
        
        <div className='deeper'></div>
        <div className='search-container1'>
          <input
            type='text'
            className='search-input1'
            placeholder='Search...'
          />
          <button className='search-button1'></button>
        </div>
        <div className='button-container'>
          <button className='button1' onClick={handleHomeClick}>
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
          <button className='button6' onClick={handleClickdoctor}>
            Doctor Records
          </button>
        </div>

        <div className='path'>
        <img
          style={{
            height: "50.82109451293945px",
            width: "49.58333206176758px",
            left: "17.7083740234375px",
            top: "15.6787109375px",
            borderRadius: "10px", // Provide a valid border-radius value
          }}
          img src={"Vector (1).png"}
          alt='image1'
        />
          <div className='path1'>
            <img src={"Vector (1).png"} alt='image1' />
            <text3>Available Doctor</text3>
            <text4>total</text4>
          </div>
          <div className='path2'>
            <img src={"/Rectangle 25.png"} alt='image1' />
            <img src={"/Rectangle 26.png"} alt='image2' />
            <text3>Patient Records</text3>
            <text4>total</text4>
          </div>

          <div className='path3'>
            <img src={"/Vector.png"} alt='image2' />
            <img src={"/Vector (2).png"} alt='image2' />
            <text3>Pending Patients</text3>
            <text4>total</text4>
          </div>
          <div className='path4'>
            <img src={"/Rectangle 25 (1).png"} alt='image3' />
            <img src={"/Vector 8 (1).png"} alt='image3' />
            <text3>User Reviews</text3>
            <text4>total</text4>
          </div>
          <div className='path5'>
            <img src={"/Rectangle 25.png"} alt='image1' />
            <img src={"/Rectangle 26.png"} alt='image2' />
            <text3>Doctor Record</text3>
            <text4>total</text4>
          </div>
        </div>
      </div>
    </>
  );
}

export default DashboardPage;
