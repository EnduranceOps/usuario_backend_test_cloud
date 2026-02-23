const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function main() {
  await prisma.usuario.create({
    data: {
      nombre: "Juan",
      email: "juan@email.com"
    }
  });
}

main()
  .then(() => {
    console.log("Seed ejecutada 🌱");
    prisma.$disconnect();
  })
  .catch((e) => {
    console.error(e);
    prisma.$disconnect();
  });