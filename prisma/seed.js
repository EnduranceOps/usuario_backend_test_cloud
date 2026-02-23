const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function main() {
  const email = "juan@email.com";

  const usuarioExistente = await prisma.usuario.findUnique({
    where: { email: email }
  });

  if (usuarioExistente) {
    console.log("⚠️ El usuario ya existe, no se creó nuevamente.");
    return;
  }

  await prisma.usuario.create({
    data: {
      nombre: "Juan",
      email: email
    }
  });

  console.log("Usuario creado correctamente");
}

main()
  .catch((e) => {
    console.error("Error en seed:", e);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });