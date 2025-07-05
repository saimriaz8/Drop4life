# 🩸 Drop4Life – Blood Donation App

**Drop4Life** is a Flutter-based mobile application designed to streamline the process of donating and receiving blood. It connects donors and recipients in real time using location services, Firebase backend, and smart request filtering. The app also includes money donation support and an AI-powered assistant to answer health-related queries.

---

## 🚀 Features

- 🧑‍🤝‍🧑 **Donor & Recipient Flows**  
  Users can request or donate blood with a simple form interface.

- 📍 **Nearby Requests & Google Maps Integration**  
  Users can view blood requests near their location and navigate with real-time directions.

- 💬 **AI Health Assistant**  
  Integrated with OpenRouter and Mistral AI to answer health-related questions directly inside the app.

- 🔔 **Push Notifications**  
  Recipients are notified when someone shows interest in their request.

- ✅ **Authentication & Profile Management**  
  Firebase Authentication with email/password sign-in and user profile setup.

- 📦 **Real-time Firestore Backend**  
  All data — requests, interests, users — is managed and updated in real time using Firebase Firestore.

---

## 🛠 Tech Stack

- **Flutter** (Riverpod for state management)
- **Firebase** (Auth, Firestore, Cloud Functions, Storage)
- **Google Maps API & Geolocator**
- **OpenRouter API (Mistral AI)**
- **Push Notifications (Firebase Messaging)**

---

## 🧠 AI Integration

Drop4Life includes a built-in chatbot specialized in **health and blood donation-related queries**, powered by:

- **Mistral 7B Instruct via OpenRouter**
- Easily swappable with Claude, Gemini, or OpenAI via prompt engineering.

---

## 🔐 Permissions Required

- Location
- Internet
- Notification access

---

## 🛡 Security

- `.env` file used to store API keys (excluded from Git)
- Firestore rules restrict sensitive access
- API keys are restricted to Android app & specific APIs

---

## 📦 Installation (Dev)

1. Clone the repo  
   `git clone https://github.com/saimriaz8/Drop4life`

2. Install dependencies  
   `flutter pub get`

3. Add your `.env` file  
   GOOGLE_MAPS_API_KEY=...
   OPENROUTER_API_KEY=...


4. Set up Firebase (Google Services files)

5. Run the app  
   `flutter run`

---

## 📌 Folder Structure Highlights

   lib/
   ├── features/
   │ ├── auth/
   │ ├── home/
   │ ├── donation/
   │ ├── ai_chat/
   │ ├── requestdetails/
   ├── core/
   │ ├── services/
   │ ├── theme/
   │ ├── utils/
   
---

## 🙋‍♂️ Author

**Saim Riaz**  
📧 saimriaz234@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/saimriazz/)  

---

## ❤️ Contributing

PRs and feedback are welcome!  
If you’d like to improve or extend features (like adding hospitals, better AI, or donation history), feel free to fork and contribute.

