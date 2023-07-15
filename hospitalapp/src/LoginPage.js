import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { collection, addDoc } from "firebase/firestore";
import { firestore } from "./firebase";

const LoginPage = () => {
  const navigate = useNavigate();
  const [User, setUser] = useState({
    userid: "",
    password: "",
  });

  const getUserDATA = (e) => {
    setUser({
      ...User,
      [e.target.name]: e.target.value,
    });
  };

  const { userid, password } = User;

  const posthandleLogin = async (e) => {
    if (userid.trim() === "" || password.trim() === "") {
      alert("Please enter a username and password");
      return;
    }

    // const isAuthenticated = true;

    // if (isAuthenticated) {
    //   navigate("/dashboard");
    // } else {
    //   // Show an error message or perform other error handling
    // }

    if(userid=="sagat" && password=="sagat"){
      navigate("/dashboard")
    }else{
      alert("Please enter correct id and password")
    }
    e.preventDefault();
    try {
      const docRef = await addDoc(collection(firestore, "admin"), {
        userid,
        password,
      });
      console.log("User data stored in Firestore successfully!");
      console.log("Document ID:", docRef.id);
    } catch (error) {
      console.error("Error storing user data:", error);
    }
  };

  return (
    <div className="container">
      <div className="column1">
        <h1>Hospital Administration Centre</h1>
        <form >
          <input
            className="line-input"
            type="text"
            name="userid"
            value={User.userid}
            onChange={getUserDATA}
            placeholder="Hospital UserID"
          />
          <input
            className="custom-input"
            type="password"
            name="password"
            value={User.password}
            onChange={getUserDATA}
            placeholder="Password"
          />
          <button className="custom-button" onClick={posthandleLogin}>
            Login  
          </button>
        </form>
      </div>
      <div className="column2">
        <div className="heading">
          <div className="header-container">
            <h13>AboutUmbrellaCare</h13>
            <br />
            <h14>Regulation</h14>
            <br />
            <h15>ContactUs</h15>
          </div>
        </div>
        <div className="border"></div>
      </div>
    </div>
  );
};

export default LoginPage;