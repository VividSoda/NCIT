import { collection, addDoc, getDoc, getDocs } from "firebase/firestore";
import { firestore } from "./firebase";
import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

const ClickindoctorPage = () => {
  const navigate = useNavigate();
  const [selectedButtons, setSelectedButtons] = useState([]);

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

  const handleBooking = async (doctorName, appointmentTime) => {
    const bookingData = {
      doctor: doctorName,
      date: "2080/3/5", // Update this with the actual date value
      time: appointmentTime,
    };

    try {
      const docRef = await addDoc(collection(firestore, "admin"), bookingData);

      // console.log(docRef)
      console.log("Booking successfully saved!");
      console.log("Document ID:", docRef.id);
    } catch (error) {
      console.error("Error saving booking:", error);
    }
  };

  // useEffect(() => {
  //   const fetchData = async () => {
  //     try {
  //       const snapshot = await collection(firestore, 'admin').get();
  //       snapshot.forEach((doc) => {
  //         console.log(doc.id, ' => ', doc.data());
  //       });
  //     } catch (error) {
  //       console.error('Error fetching data:', error);
  //     }
  //   };

  //   fetchData();
  // }, []);

  useEffect(() => {
    // Function to fetch doctors from Firestore
    const fetchDoctors = async () => {
      try {
        const querySnapshot = await getDocs(collection(firestore, "doctor"));
        querySnapshot.forEach((doc) => {
          console.log("Doctor ID:", doc.id);
          console.log("Doctor Data:", doc.data());
        });
      } catch (error) {
        console.error("Error fetching doctors:", error);
      }
    };
    fetchDoctors();
  }, []);
  const handleButtonClick = (e) => {
    //const clickedButton = e.target;
    //clickedButton.style.backgroundColor = "#f7f7f7";
    //clickedButton.style.border = "1px solid black";

    for (let i = 0; i < selectedButtons.length; i++) {
      selectedButtons[i].style.backgroundColor = "#f7f7f7";
      selectedButtons[i].style.color = "#577CEF";
      selectedButtons[i].style.border = "1px solid #7D32AC";
    }

    const doctorName = "sample pokhrel"; // Replace with the actual doctor name
    const appointmentTime = "10:00 AM"; // Replace with the actual appointment time
    handleBooking(doctorName, appointmentTime);
  };

  const handleButtonSelection = (e) => {
    const button = e.target;

    if (button.style.backgroundColor === "brown") {
      setSelectedButtons((prevButtons) =>
        prevButtons.filter((btn) => btn !== button)
      );
    } else {
      button.style.backgroundColor = "brown";
      setSelectedButtons((prevButtons) => [...prevButtons, button]);
    }
  };

  return (
    <div className='container5'>
      <h5>Hospital Administration Centre</h5>
      <div className='search-container'>
        <input type='text' className='search-input' placeholder='Search' />
        <button
          className='search-button'
          aria-label='Search through site content'
        ></button>
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
        <div className='Appointment'>
          <text
            style={{
              color: "#7D32AC",
              margin: 30,
              width: "208px",
              height: "25px",
              top: "10px",
              left: "470px",
              fontFamily: "M PLUS 1",
              fontSize: "20px",
              fontWeight: "550",
              lineHeight: "20px",
              letterSpacing: "0em",
            }}
          >
            Appointment Schedule
          </text>

          <img src={"hx_4 1.png"} alt='Description of the image' />
          <span>sample pokhrel</span>
          <p style={{ top: "500px" }}>anesthesiology</p>
          <div style={{ top: "550px", position: "absolute", color: "#ffb800" }}>
            MBBS, FCPS, FICS (USA)
          </div>
          <div className='button-container1'></div>
          <div className='scrollable-container'>
            <div className=''>
              <button
                className='button7'
                onClick={() => handleBooking("sample pokhrel", "Sun 13")}
              >
                Sun 13
              </button>

              <button
                className='button8'
                onClick={() => handleBooking("sample pokhrel", "Mon 14")}
              >
                Mon 14
              </button>
              <button
                className='button9'
                onClick={() => handleBooking("sample pokhrel", "Tue 15")}
              >
                Tue 15
              </button>
              <button
                className='button10'
                onClick={() => handleBooking("sample pokhrel", "Sat 16")}
              >
                Sat 16
              </button>
              <button
                className='button11'
                onClick={() => handleBooking("sample pokhrel", "Fri 17")}
              >
                Fri 17
              </button>
            </div>
          </div>
          <button className='button12' disabled onClick={handleBooking}>
            10:00 AM
          </button>
          <button className='button13' onClick={handleButtonSelection}>
            10:30 AM{" "}
          </button>
          <button className='button14' onClick={handleButtonSelection}>
            11:00AM
          </button>
          <button className='button15' onClick={handleBooking}>
            11:30 PM
          </button>
          <button className='button16' onClick={handleButtonSelection}>
            12:00 PM
          </button>
          <button className='button17' onClick={handleBooking}>
            12:30 PM
          </button>
          <button className='button18' onClick={handleBooking}>
            1:00 PM
          </button>
          <button className='button19' onClick={handleButtonSelection}>
            2:30 PM
          </button>
          <button className='button20' onClick={handleButtonSelection}>
            3:00 PM
          </button>
          <button className='button21' onClick={handleButtonSelection}>
            3:30 PM
          </button>
          <button className='button22' onClick={handleBooking}>
            4:00 PM
          </button>
          <button className='button23' onClick={handleBooking}>
            4:30 PM
          </button>
          <button className='button24' onClick={handleButtonClick}>
            <text
              style={{
                color: "#f7f7f7",
                width: "250px",
                height: "27px",
                top: "180px",
                left: "30px",
                fontfamily: "M PLUS 1",
                fontsize: "16px",
                fontweight: "400",
                lineheight: "23px",
                letterspacing: "0em",
              }}
            >
              Confirm
            </text>
          </button>
        </div>
      </div>
    </div>
  );
};

export default ClickindoctorPage;
