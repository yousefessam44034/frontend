// DoctorPage.js
import React, { useState, useEffect } from 'react';

const DoctorPage = () => {
  const [username, setUsername] = useState('');
  const [dayOfWeek, setDayOfWeek] = useState('');
  const [timeSlot, setTimeSlot] = useState('');
  const [message, setMessage] = useState('');
  const [doctorSlots, setDoctorSlots] = useState([]);
  const [doctorNotifications, setDoctorNotifications] = useState([]);

  const handleAddSlot = async () => {
    try {
      const response = await fetch('http://backend:6000/insert_doctor_slots', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          doctor_username: username,
          day_of_week: dayOfWeek,
          time_slot: timeSlot,
        }),
      });



  const handleFetchDoctorNotifications = async () => {
      try {
        const response = await fetch(`http://backend:6000/doctor_notifications?doctor_username=${username}`);
        const data = await response.json();  
        setDoctorNotifications(data.doctor_messages || []);
          } catch (error) {
            console.error('Error fetching doctor notifications:', error);
          }
        };


      const data = await response.json();

      console.log(data);

      // Update the message state based on the response
      setMessage(data.message);

      // Fetch doctor's slots after adding a new slot
      fetchDoctorSlots();
    } catch (error) {
      console.error('Error adding slot:', error);
    }
  };

  const fetchDoctorSlots = async () => {
    try {
      const response = await fetch('http://backend:6000/view_doctor_slots', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          doctor_username: username,
        }),
      });

      if (!response.ok) {
        throw new Error('Failed to fetch doctor slots');
      }

      const data = await response.json();
      setDoctorSlots(data.slots || []);
    } catch (error) {
      console.error('Error fetching doctor slots:', error.message);
    }
  };

  useEffect(() => {
    // Fetch doctor's slots when the component mounts
    fetchDoctorSlots();
  }, [username]); // Re-fetch when the doctor's username changes

  return (
    <div>
      <h2>Hello, User (User Type: Doctor)</h2>
      <p>Doctor's Slots</p>
      <table border="1">
        <thead>
          <tr>
            <th>Day of Week</th>
            <th>Time Slot</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {doctorSlots.length > 0 ? (
            doctorSlots.map((slot, index) => (
              <tr key={index}>
                <td>{slot.day_of_week}</td>
                <td>{slot.time_slot}</td>
                <td>{slot.status}</td>
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan="3">No slots available</td>
            </tr>
          )}
        </tbody>
      </table>
      
      <div>
        <h2>Create a new slot</h2>
        <div>
          <label>Doctor's Username:</label>
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
        </div>
        <div>
          <label>Day of the Week:</label>
          <input
            type="text"
            value={dayOfWeek}
            onChange={(e) => setDayOfWeek(e.target.value)}
          />
        </div>
        <div>
          <label>Time Slot:</label>
          <input
            type="text"
            value={timeSlot}
            onChange={(e) => setTimeSlot(e.target.value)}
          />
        </div>
        <div>
          <button type="button" onClick={handleAddSlot}>
            Add Slot
          </button>
        </div>
        {message && <p>{message}</p>}
      </div>
      <div>
        <h2>Doctor Notifications</h2>
        <button type="button" onClick={handleFetchDoctorNotifications}>
          Fetch Doctor Notifications
        </button>
        <ul>
          {doctorNotifications.map((notification, index) => (
            <li key={index}>{notification.message}</li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default DoctorPage;
