import React, { useState } from "react";
import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";

import "./AvailablePage.css";

const AvailableaPage = () => {
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

  const [count] = useState("89");
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
        <text5>
          AvailableDoctor<b>{count}</b>
        </text5>
        <div class='scrollable-div'>
          <div className='available1'>
            <img src={"hx_4 1.png"} alt='Description of the image' />
            <span>sample pokhrel</span>
            <p>anesthesiology</p>
            <text>MBBS, FCPS, FICS (USA)</text>
            <text1>4.5</text1>
            <Link
              to='/click'
              style={{ top: "190px", left: "295px" }}
              className='link'
            >
              sun-fri
            </Link>
            <Link to='/click' className='link'>
              10:00 am to 1:00 pm
            </Link>
            <img
              className='image1'
              src={"Star 1.png"}
              alt='Description of the image'
            />
          </div>
          <div className='available2'>
            <img src={"hx_4 1.png"} alt='Description of the image' />
            <span>sample pokhrel</span>
            <p>anesthesiology</p>
            <text>MBBS, FCPS, FICS (USA)</text>
            <text1>4.5</text1>
            <Link
              to='/click'
              style={{ top: "190px", left: "295px" }}
              className='link'
            >
              sun-fri
            </Link>
            <Link to='/click' className='link'>
              10:00 am to 1:00 pm
            </Link>
            <img
              className='image1'
              src={"Star 1.png"}
              alt='Description of the image'
            />
          </div>
          <div className='available3'>
            <img src={"hx_4 1.png"} alt='Description of the image' />
            <span>sample pokhrel</span>
            <p>anesthesiology</p>
            <text>MBBS, FCPS, FICS (USA)</text>
            <text1>4.5</text1>
            <Link
              to='/click'
              style={{ top: "190px", left: "295px" }}
              className='link'
            >
              sun-fri
            </Link>
            <Link to='/click' className='link'>
              10:00 am to 1:00 pm
            </Link>
            <img
              className='image1'
              src={"Star 1.png"}
              alt='Description of the image'
            />
          </div>
          <div className='available4'>
            <img src={"hx_4 1.png"} alt='Description of the image' />
            <span>sample pokhrel</span>
            <p>anesthesiology</p>
            <text>MBBS, FCPS, FICS (USA)</text>
            <text1>4.5</text1>
            <Link
              to='/click'
              style={{ top: "190px", left: "295px" }}
              className='link'
            >
              sun-fri
            </Link>
            <Link to='/click' className='link'>
              10:00 am to 1:00 pm
            </Link>
            <img
              className='image1'
              src={"Star 1.png"}
              alt='Description of the image'
            />
          </div>
          <div className='available5'>
            <img src={"hx_4 1.png"} alt='Description of the image' />
            <span>sample pokhrel</span>
            <p>anesthesiology</p>
            <text>MBBS, FCPS, FICS (USA)</text>
            <text1>4.5</text1>
            <Link
              to='/click'
              style={{ top: "190px", left: "295px" }}
              className='link'
            >
              sun-fri
            </Link>
            <Link to='/click' className='link'>
              10:00 am to 1:00 pm
            </Link>
            <img
              className='image1'
              src={"Star 1.png"}
              alt='Description of the image'
            />
          </div>
          <div className='available6'>
            <img src={"hx_4 1.png"} alt='Description of the image' />
            <span>sample pokhrel</span>
            <p>anesthesiology</p>
            <text>MBBS, FCPS, FICS (USA)</text>
            <text1>4.5</text1>
            <Link
              to='/click'
              style={{ top: "190px", left: "295px" }}
              className='link'
            >
              sun-fri
            </Link>
            <Link to='/click' className='link'>
              10:00 am to 1:00 pm
            </Link>
            <img
              className='image1'
              src={"Star 1.png"}
              alt='Description of the image'
            />
          </div>
        </div>
      </div>
    </div>
  );
};
export default AvailableaPage;
