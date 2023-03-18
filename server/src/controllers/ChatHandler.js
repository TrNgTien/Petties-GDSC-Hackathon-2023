const express = require("express");
const app = express();
const server = require("http").Server(app);
const io = require("socket.io")(server);

const createRandomRoom = () => {
    // const randomRoom = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    // return randomRoom;
    const roomId = `room-${Date.now()}-${Math.floor(Math.random() * 1000)}`;
    // io.on('connection', (socket) => {
    //     socket.join(roomId);
    //     console.log(`User joined room ${roomId}: ${socket.id}`);
    // });
    console.log(`Room ${roomId} created!`);
    return roomId;
}

module.exports = {
    createRoom: async (req, res) => {
        try {
            const getRoomID = await createRandomRoom();
            io.on('connection', (socket) => {
                socket.join(getRoomID);
                console.log(`User joined room ${getRoomID}: ${socket.id}`);
            });

            res.send(`Room ${getRoomID} created!`);
        }
        catch (error) {
            console.log(error);
            return res.status(500).json("Internal server error");
        }
    },
}