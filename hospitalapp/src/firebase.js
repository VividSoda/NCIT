import { collection, addDoc, getDocs } from 'firebase/firestore';
import { initializeApp } from 'firebase/app';
import { getFirestore } from 'firebase/firestore';

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "YAIzaSyBh57pLUOpoQgRHONKprth42XuAEzppK9c",
  authDomain: "hospital1-3c371.firebaseapp.com",
  projectId: "hospital1-3c371",
  storageBucket: "hospital1-3c371.appspot.com",
  messagingSenderId: "306288948173",
  appId: "1:306288948173:web:2a0de179b664d8ce704a84"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const firestore = getFirestore(app);

// Function to add dummy data to Firestore collection
const addDummyData = async () => {
  try {
    const dummyData = [
      { name: "John Doe", specialization: "Cardiology" },
      { name: "Jane Smith", specialization: "Pediatrics" },
      { name: "Michael Johnson", specialization: "Dermatology" }
    ];

    for (const data of dummyData) {
      await addDoc(collection(firestore, 'doctor'), data);
    }

    console.log('Dummy data added successfully!');
  } catch (error) {
    console.error('Error adding dummy data:', error);
  }
};

// Function to fetch doctors from Firestore
const fetchDoctors = async () => {
  try {
    const querySnapshot = await getDocs(collection(firestore, 'doctor'));
    querySnapshot.forEach((doc) => {
      console.log('name:', doc.name);
      console.log(' specialization:', doc.data());
    });
  } catch (error) {
    console.error('Error fetching doctors:', error);
  }
};

// Call the function to add dummy data and fetch doctors
addDummyData().then(() => {
  fetchDoctors().then(() => {
    console.log('Doctors fetched successfully!');
    // You can perform any additional operations with the fetched data here
    // For example, update UI, display the data, etc.
  }).catch((error) => {
    console.error('Error fetching doctors:', error);
  });
}).catch((error) => {
  console.error('Error adding dummy data:', error);
});

export { firestore }; // Exporting firestore as named export
export default app;

