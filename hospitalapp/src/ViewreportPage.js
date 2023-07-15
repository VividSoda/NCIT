import React, { Component } from "react";

import './AvailablePage.css';

export default class ViewreportPage extends Component {
  render() {
    return (
      <div className='container5'>
        <h5>Hospital Administration Centre</h5>
        <div className='search-container'>
          <input type='text' className='search-input' placeholder='Search...' />
          <button className='search-button'></button>
        </div>

        <div className='deeper1'></div>
        <div className='button-container'>
          <button className='button1'style={{border: 'none'}}>Home</button>
          <button className='button2'>Available Doctors</button>
          <button className='button3' style={{border: '4px solid #ffb800'}}>Patients Records</button>
          <button className='button4'>Pending Patients</button>
          <button className='button5'>User Reviews</button>
          <button className='button6'>Doctor Records</button>
        </div>

        <div className='available'>
          <text5>Patients Report</text5>
          <p1>
            ETA DOCTOR LE LEKHEKO PRESCRIPTION KO PHOTO UPLOAD VHAKO HUCNHA
            HAMRO MAIN APPLICATION BATA. YO UPLOAD GARNE SYSYTEM RA ACCESS CHAI
            HAMLE PATIENT LAI MATRA DINE APPLICATION BATA. KINA VHANE AAFNO
            REPORT GLOBAL DATABASE MA HALNE KI NAHALNE VHANERA CHOICE PATIENT
            LAI DINU PARCHA HAMLE. RIGHT TO PRIVACY VHANAM
          </p1>
        </div>
      </div>
    );
  }
}
