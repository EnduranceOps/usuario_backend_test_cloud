const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '..', '..', '.env') });
const express = require("express");
const cors = require("cors");
const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();
const app = express();

app.use(cors());
app.use(express.json());

app.get("/usuarios", async (req, res) => {
  try {
    const usuarios = await prisma.usuario.findMany();
    res.json(usuarios);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error al obtener usuarios" });
  }
});

app.post("/usuarios", async (req, res) => {
  const { nombre, email } = req.body;
  if (!nombre || !email) return res.status(400).json({ error: "Faltan campos" });
  try {
    const usuario = await prisma.usuario.create({ data: { nombre, email } });
    res.status(201).json(usuario);
  } catch (e) {
    console.error(e);
    if (e.code === "P2002") {
      return res.status(400).json({ error: "Email ya registrado" });
    }
    res.status(500).json({ error: "Error al crear usuario" });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en puerto ${PORT} 🚀`);
});