const { v4: uuidv4 } = require("uuid");
const { db, storage } = require("../database/firestore-connection");

module.exports = {
  getAllUser: async (req, res) => {
    try {
      const userSnapshot = await db.collection("users").get();
      let users = [];
      userSnapshot.forEach((x) =>
        users.push({
          ...x.data(),
        })
      );
      return res.status(200).json({
        total: users.length,
        data: users,
      });
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },

  getPetowners: async (req, res) => {
    try {
      if (req.user.role == "petsitter") {
        const userSnapshot = await db.collection("users").where("role", "==", "petowner").get();
        let users = [];
        userSnapshot.forEach((x) =>
          users.push({
            ...x.data(),
          })
        );
        return res.status(200).json({
          total: users.length,
          data: users,
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  getPetowner: async (req, res) => {
    try {
      if (req.user.role == "petsitter") {
        let userID = req.params.userID;
        const userRef = await db.collection("users").doc(userID);
        const result = await userRef.get();
        if (!result.exists) {
          return res.status(400).json({
            message: "User not found",
          });
        } else {
          return res.status(200).json({
            data: result.data(),
          });
        }
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },

  getPetsitters: async (req, res) => {
    try {
      if (req.user.role == "petowner") {
        const userSnapshot = await db.collection("users").where("role", "==", "petsitter").get();
        let users = [];
        userSnapshot.forEach((x) =>
          users.push({
            ...x.data(),
          })
        );
        return res.status(200).json({
          total: users.length,
          data: users,
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  getPetsitter: async (req, res) => {
    try {
      if (req.user.role == "petowner") {
        let userID = req.params.userID;
        const userRef = await db.collection("users").doc(userID);
        const result = await userRef.get();
        if (!result.exists) {
          return res.status(400).json({
            message: "User not found",
          });
        } else {
          return res.status(200).json({
            data: result.data(),
          });
        }
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },

  getReviews: async (req, res) => {
    try {
      if (req.user.role == "petowner") {
        const reviewSnapshot = await db.collection("users").where("role", "==", "petsitter").orderBy("review", "desc").get();
        let reviews = [];
        reviewSnapshot.forEach((x) =>
          reviews.push({
            ...x.data(),
          })
        );
        return res.status(200).json({
          total: reviews.length,
          data: reviews,
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },

  filterUser: async (req, res) => {
    try {
      if (req.user.role == "petsitter") {
        let filter = req.query.q;

        const userSnapshot = await db.collection("users").get();
        let users = [];
        userSnapshot.forEach((x) =>
          users.push({
            ...x.data(),
          })
        );
        const filterUsersByPet = (users, pet) => {
          const filteredPetSitters = users.filter((user) => {
            return user.role === req.user.role && user.pets.includes(pet);
          });
          return filteredPetSitters;
        };

        if (filterUsersByPet(users, filter).length == 0) {
          return res.status(400).json({
            message: `No petsitter has owned ${filter}`,
          });
        } else {
          return res.status(200).json({
            total: filterUsersByPet(users, filter).length,
            data: filterUsersByPet(users, filter),
          });
        }
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },

  uploadAvatar: async (req, res) => {
    try {
      const userID = req.params.userID;
      if (!req.file) {
        return res.status(400).json({
          message: "No file uploaded",
        });
      };

      const image = req.file;
      const uniqueFilename = `${uuidv4()}.jpg`;
      const blob = storage.file("images/" + uniqueFilename);

      const stream = blob.createWriteStream({
        metadata: {
          contentType: image.mimetype,
        },
      });

      stream.on("error", (error) => {
        console.log(error);
        return res.status(500).json("Internal server error");
      });

      stream.on("finish", async () => {
        await blob.makePublic();
        const publicUrl = `https://storage.googleapis.com/${blob.metadata.bucket}/${blob.metadata.name}`;
        console.log(publicUrl);
        
        const userRef = await db.collection("users").doc(userID);
        const result = await userRef.get();
        if (!result.exists) {
          return res.status(400).json({
            message: "User not found",
          });
        }
        await userRef.update({
          userAvatar: publicUrl,
        });
        return res.status(200).json({
          message: "Upload avatar successfully",
          data: publicUrl,
        });
      });

      stream.end(image.buffer);
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },

  getUserInformation: async (req, res) => {
    try {
      if (req.user.role == "petsitter") {
        const userID = req.params.userID;
        const userRef = await db.collection("users").doc(userID);
        const result = await userRef.get();
        if (!result.exists) {
          return res.status(400).json({
            message: "User not found",
          });
        } else {
          return res.status(200).json({
            data: result.data(),
          });
        }
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  updateInformation: async (req, res) => {
    try {
      if (req.user.role == "petsitter") {
        const userID = req.user.userID;
        let infoUpdate = req.body;

        if (infoUpdate.email != undefined) {
          const checkEmail = await db.collection("users").where("email", "==", infoUpdate.email).get();
          if (!checkEmail.empty) {
            return res.status(400).json({
              message: "Email already existed",
            });
          }
        }

        const userRef = await db.collection("users").doc(userID);
        const data = await userRef.get();
        if (!data.exists) {
          return res.status(400).json({
            message: "User not found",
          });
        }
        await userRef.update(infoUpdate);
        return res.status(200).json({
          message: "Update successfully!",
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
  deleteUser: async (req, res) => {
    try {
      if (req.user.role == "petsitter") {
        const userID = req.user.userID;
        const userRef = await db.collection("users").doc(userID);
        const data = await userRef.get();
        if (!data.exists) {
          return res.status(400).json({
            message: "User not found",
          });
        }
        await userRef.delete();
        return res.status(200).json({
          message: "Delete successfully!",
        });
      }
    } catch (error) {
      console.log(error);
      return res.status(500).json("Internal server error");
    }
  },
};
