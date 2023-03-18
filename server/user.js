const users = [];

function getAllUsers() {
  const arrayID = [];
  users.forEach(user => {
    arrayID.push(user.id);
  });
  return arrayID;
}

// Join user to chat
function userJoin(id, userName, room) {
  const user = { id, userName, room };
  users.push(user);
  return user;
}

// Get current user
function getCurrentUser(id) {
  return users.find(user => user.id === id);
}

// User leaves chat
function userLeave(id) {
  const index = users.findIndex(user => user.id === id);

  if (index !== -1) {
    return users.splice(index, 1)[0];
  }
}

// Get room users
function getRoomUsers(room) {
  return users.filter(user => user.room === room);
}

const formatMessage = (userName, message) => {
  return {
    userName,
    message,
    dateTime: new Date()
  }
}

module.exports = {
  getAllUsers,
  userJoin,
  getCurrentUser,
  userLeave,
  getRoomUsers,
  formatMessage
};


