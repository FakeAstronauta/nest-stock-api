/*
  Warnings:

  - You are about to drop the column `roleId` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `warehouseId` on the `Users` table. All the data in the column will be lost.
  - You are about to drop the column `warehouseAdminId` on the `Warehouse` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Users" DROP CONSTRAINT "Users_roleId_fkey";

-- DropForeignKey
ALTER TABLE "Users" DROP CONSTRAINT "Users_warehouseId_fkey";

-- DropForeignKey
ALTER TABLE "Warehouse" DROP CONSTRAINT "Warehouse_warehouseAdminId_fkey";

-- AlterTable
ALTER TABLE "Users" DROP COLUMN "roleId",
DROP COLUMN "warehouseId";

-- AlterTable
ALTER TABLE "Warehouse" DROP COLUMN "warehouseAdminId";

-- CreateTable
CREATE TABLE "warehouseUsers" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,
    "warehouseId" INTEGER NOT NULL,

    CONSTRAINT "warehouseUsers_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "warehouseUsers_userId_key" ON "warehouseUsers"("userId");

-- AddForeignKey
ALTER TABLE "warehouseUsers" ADD CONSTRAINT "warehouseUsers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "warehouseUsers" ADD CONSTRAINT "warehouseUsers_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "warehouseUsers" ADD CONSTRAINT "warehouseUsers_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "Warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
