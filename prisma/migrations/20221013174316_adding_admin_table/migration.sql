/*
  Warnings:

  - A unique constraint covering the columns `[roleId]` on the table `WarehouseUsers` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "WarehouseUsers_lastName_key";

-- DropIndex
DROP INDEX "WarehouseUsers_name_key";

-- AlterTable
ALTER TABLE "Product" ALTER COLUMN "producedAt" DROP NOT NULL,
ALTER COLUMN "expiresAt" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Warehouse" ADD COLUMN     "warehouseAdminId" INTEGER NOT NULL DEFAULT 1;

-- CreateTable
CREATE TABLE "WarehouseAdmin" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,
    "lastName" VARCHAR(250) NOT NULL,
    "roleId" INTEGER NOT NULL,
    "bornAt" DATE NOT NULL,
    "dui" CHAR(9) NOT NULL,
    "state" BOOLEAN NOT NULL,
    "registerAt" DATE NOT NULL,
    "updatedAt" DATE NOT NULL,

    CONSTRAINT "WarehouseAdmin_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "WarehouseAdmin_roleId_key" ON "WarehouseAdmin"("roleId");

-- CreateIndex
CREATE UNIQUE INDEX "WarehouseAdmin_dui_key" ON "WarehouseAdmin"("dui");

-- CreateIndex
CREATE UNIQUE INDEX "WarehouseUsers_roleId_key" ON "WarehouseUsers"("roleId");

-- AddForeignKey
ALTER TABLE "Warehouse" ADD CONSTRAINT "Warehouse_warehouseAdminId_fkey" FOREIGN KEY ("warehouseAdminId") REFERENCES "WarehouseAdmin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WarehouseAdmin" ADD CONSTRAINT "WarehouseAdmin_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
