/*
  Warnings:

  - You are about to drop the column `unitPrice` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `warehouseId` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `finalPrice` on the `Purchases` table. All the data in the column will be lost.
  - You are about to drop the column `productId` on the `Purchases` table. All the data in the column will be lost.
  - You are about to drop the column `warehouseId` on the `Purchases` table. All the data in the column will be lost.
  - You are about to drop the `Sells` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WarehouseUsers` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `cost` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `purchaseCode` to the `Purchases` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Purchases` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_warehouseId_fkey";

-- DropForeignKey
ALTER TABLE "Purchases" DROP CONSTRAINT "Purchases_productId_fkey";

-- DropForeignKey
ALTER TABLE "Purchases" DROP CONSTRAINT "Purchases_warehouseId_fkey";

-- DropForeignKey
ALTER TABLE "Sells" DROP CONSTRAINT "Sells_productId_fkey";

-- DropForeignKey
ALTER TABLE "Sells" DROP CONSTRAINT "Sells_warehouseId_fkey";

-- DropForeignKey
ALTER TABLE "Warehouse" DROP CONSTRAINT "Warehouse_warehouseAdminId_fkey";

-- DropForeignKey
ALTER TABLE "WarehouseUsers" DROP CONSTRAINT "WarehouseUsers_roleId_fkey";

-- DropForeignKey
ALTER TABLE "WarehouseUsers" DROP CONSTRAINT "WarehouseUsers_warehouseId_fkey";

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "unitPrice",
DROP COLUMN "warehouseId",
ADD COLUMN     "cost" DECIMAL(65,30) NOT NULL,
ADD COLUMN     "registerAt" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" DATE;

-- AlterTable
ALTER TABLE "Purchases" DROP COLUMN "finalPrice",
DROP COLUMN "productId",
DROP COLUMN "warehouseId",
ADD COLUMN     "purchaseCode" TEXT NOT NULL,
ADD COLUMN     "updatedAt" DATE NOT NULL,
ALTER COLUMN "amount" SET DATA TYPE DECIMAL(65,30);

-- DropTable
DROP TABLE "Sells";

-- DropTable
DROP TABLE "WarehouseUsers";

-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,
    "lastName" VARCHAR(250) NOT NULL,
    "roleId" INTEGER NOT NULL,
    "bornAt" DATE NOT NULL,
    "dui" CHAR(9) NOT NULL,
    "state" BOOLEAN NOT NULL,
    "registerAt" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATE NOT NULL,
    "warehouseId" INTEGER,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PurchaseItems" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "purchaseId" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "unit" TEXT NOT NULL,
    "total" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "PurchaseItems_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Stock" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit" TEXT NOT NULL,
    "total" DOUBLE PRECISION NOT NULL,
    "registedAt" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "warehouseId" INTEGER NOT NULL,

    CONSTRAINT "Stock_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_dui_key" ON "Users"("dui");

-- AddForeignKey
ALTER TABLE "Warehouse" ADD CONSTRAINT "Warehouse_warehouseAdminId_fkey" FOREIGN KEY ("warehouseAdminId") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Users" ADD CONSTRAINT "Users_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Users" ADD CONSTRAINT "Users_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "Warehouse"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseItems" ADD CONSTRAINT "PurchaseItems_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PurchaseItems" ADD CONSTRAINT "PurchaseItems_purchaseId_fkey" FOREIGN KEY ("purchaseId") REFERENCES "Purchases"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stock" ADD CONSTRAINT "Stock_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stock" ADD CONSTRAINT "Stock_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "Warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
