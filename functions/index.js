const functions = require("firebase-functions");
const axios = require("axios");
require("dotenv").config();

exports.getCoordinates = functions.https.onRequest(async (req, res) => {
  const address = req.body.address;

  if (!address) {
    return res.status(400).send("Address is required");
  }

  try {
    const apiKey = process.env.GOOGLE_MAPS_API_KEY;
    const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(address)}&key=${apiKey}`;

    const response = await axios.get(url);
    const data = response.data;

    if (data.status === "OK") {
      const location = data.results[0].geometry.location;
      res.send({
        latitude: location.lat,
        longitude: location.lng,
      });
    } else {
      res.status(500).send({error: data.status});
    }
  } catch (error) {
    res.status(500).send({error: error.message});
  }
});
