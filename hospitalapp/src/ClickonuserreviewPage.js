import React, { Component } from "react";
import { useNavigate } from "react-router-dom";
import "./AvailablePage.css";

const ClickonuserreviewPage = () => {
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
          <br />
          <content1>User Reviews for Dr. SamplePokhrel</content1>
          <div className='review'>
            <img src={"hx_4 1.png"} alt='Description of the image' />
            <span>sample pokhrel</span>
            <p>anesthesiology</p>
            <text>MBBS, FCPS, FICS (USA)</text>
            <text1>4.1</text1>
            <text2>3 Ratings</text2>
            <img
              className='image1'
              src={"Ellipse 66 (2).png"}
              alt='Description of the image'
            />
          </div>
          <div className='review1'>
          <div className="image-gallery">
               <img src="Star 1.png" alt="Image 1" style={{ width: '20px', height: '20px', top: '240px', left: '1050px' }} />
               <img src="Star 1.png" alt="Image 2" style={{ width: '20px', height: '20px', top: '240px', left: '1100px' }} />
               <img src="Star 1.png" alt="Image 3" style={{ width: '20px', height: '20px', top: '240px', left: '1150px' }} />
               <img src="Star 5.png" alt="Image 4" style={{ width: '20px', height: '20px', top: '240px', left: '1200px' }}/>
               <img src="Star 5.png" alt="Image 5" style={{ width: '20px', height: '20px', top: '215px', left: '1250px' }} />
          </div>
            <p1>Anonymous</p1>
            <p>May 23, 2023</p>
            <div className='border1'></div>
          </div>
          < div className='review2'>
          <div className="image-gallery">
               <img src="Star 1.png" alt="Image 1" style={{ width: '20px', height: '20px', top: '330px', left: '1050px' }} />
               <img src="Star 1.png" alt="Image 2" style={{ width: '20px', height: '20px', top: '330px', left: '1100px' }} />
               <img src="Star 1.png" alt="Image 3" style={{ width: '20px', height: '20px', top: '330px', left: '1150px' }} />
               <img src="Star 1.png" alt="Image 4" style={{ width: '20px', height: '20px', top: '330px', left: '1200px' }}/>
               <img src="Star 1.png" alt="Image 5" style={{ width: '20px', height: '20px', top: '285px', left: '1250px' }} />
          </div>
          
          
            <p1>Anonymous</p1>
            <p>May 23, 2023</p>
            <div className='border2'></div>
          </div>
          <div className='review3'>
          <div className="image-gallery">
               <img src="Star 1.png" alt="Image 1" style={{ width: '20px', height: '20px', top: '410px', left: '1050px' }} />
               <img src="Star 1.png" alt="Image 2" style={{ width: '20px', height: '20px', top: '410px', left: '1100px' }} />
               <img src="Star 1.png" alt="Image 3" style={{ width: '20px', height: '20px', top: '410px', left: '1150px' }} />
               <img src="Star 1.png" alt="Image 4" style={{ width: '20px', height: '20px', top: '410px', left: '1200px' }}/>
               <img src="Star 1.png" alt="Image 5" style={{ width: '20px', height: '20px', top: '345px', left: '1250px' }} />
          </div>

            <p1>Patient ID:</p1>
            <p>May 23, 2023</p>
            <content>
              Doctor was very helpful right until the end of my follow-up.
              Highly Recommended
            </content>
            <div className='border3'></div>
          </div>
        </div>
      
        </div>
    );
  }
export default ClickonuserreviewPage;
