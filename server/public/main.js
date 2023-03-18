const socket = io()

const chatMessage = document.querySelector('.chat-messages')
const messageForm = document.getElementById('message-form')
const messageInput = document.getElementById('message-input')

const { userName, room } = Qs.parse(location.search, {
  ignoreQueryPrefix: true
})

socket.emit('joinRoom', { userName, room })

//broadcast message
socket.on('getMessage', (data) => {
  console.log(data)
  const div = document.createElement('div')
  div.classList.add('message')
  div.innerHTML = `
    <p class="meta">${data.userName} <span>${data.dateTime}</span></p>
    <p class="text">
      ${data.message}
    </p>
  `
  document.querySelector('.chat-messages').appendChild(div)

  chatMessage.scrollTop = chatMessage.scrollHeight
})

//message
function sendMessage() {
  if (messageInput.value === '') return
  const data = {
    message: messageInput.value,
    dateTime: new Date(), 
  }
  socket.emit('sendMessage', data)
}

//sumbit message  
messageForm.addEventListener('submit', (e) => {
  e.preventDefault()
  sendMessage()
  e.target.reset()
})










// // const clientsTotal = document.getElementById('client-total')

// socket.on('clients-total', (data) => {
//   clientsTotal.innerText = `Total Clients: ${data}`
// })



// socket.on('chat-message', (data) => {
//   // console.log(data)
//   messageTone.play()
//   addMessageToUI(false, data)
// })

// function addMessageToUI(isOwnMessage, data) {
//   clearFeedback()
//   const element = `
//       <li class="${isOwnMessage ? 'message-right' : 'message-left'}">
//           <p class="message">
//             ${data.message}
//             <span>${data.name} ● ${moment(data.dateTime).fromNow()}</span>
//           </p>
//         </li>
//         `

//   messageContainer.innerHTML += element
//   scrollToBottom()
// }

// function scrollToBottom() {
//   messageContainer.scrollTo(0, messageContainer.scrollHeight)
// }

// // messageInput.addEventListener('keypress', (e) => {
// //   socket.emit('feedback', {
// //     feedback: `✍️ ${nameInput.value} is typing a message`,
// //   })
// // })

// // messageInput.addEventListener('blur', (e) => {
// //   socket.emit('feedback', {
// //     feedback: '',
// //   })
// // })

// socket.on('feedback', (data) => {
//   clearFeedback()
//   const element = `
//         <li class="message-feedback">
//           <p class="feedback" id="feedback">${data.feedback}</p>
//         </li>
//   `
//   messageContainer.innerHTML += element
// })

// function clearFeedback() {
//   document.querySelectorAll('li.message-feedback').forEach((element) => {
//     element.parentNode.removeChild(element)
//   })
// }