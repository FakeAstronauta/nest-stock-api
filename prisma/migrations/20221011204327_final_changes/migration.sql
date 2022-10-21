/*
  Warnings:

  - You are about to drop the `category` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `product` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `purchases` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sells` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `warehouse` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `warehouseusers` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "product" DROP CONSTRAINT "product_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "product" DROP CONSTRAINT "product_warehouseId_fkey";

-- DropForeignKey
ALTER TABLE "purchases" DROP CONSTRAINT "purchases_productId_fkey";

-- DropForeignKey
ALTER TABLE "purchases" DROP CONSTRAINT "purchases_warehouseId_fkey";

-- DropForeignKey
ALTER TABLE "sells" DROP CONSTRAINT "sells_productId_fkey";

-- DropForeignKey
ALTER TABLE "sells" DROP CONSTRAINT "sells_warehouseId_fkey";

-- DropForeignKey
ALTER TABLE "warehouseusers" DROP CONSTRAINT "warehouseusers_roleId_fkey";

-- DropForeignKey
ALTER TABLE "warehouseusers" DROP CONSTRAINT "warehouseusers_warehouseId_fkey";

-- DropTable
DROP TABLE "category";

-- DropTable
DROP TABLE "product";

-- DropTable
DROP TABLE "purchases";

-- DropTable
DROP TABLE "role";

-- DropTable
DROP TABLE "sells";

-- DropTable
DROP TABLE "warehouse";

-- DropTable
DROP TABLE "warehouseusers";

-- CreateTable
CREATE TABLE "Warehouse" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,

    CONSTRAINT "Warehouse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WarehouseUsers" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,
    "lastName" VARCHAR(250) NOT NULL,
    "roleId" INTEGER NOT NULL,
    "bornAt" DATE NOT NULL,
    "dui" CHAR(9) NOT NULL,
    "state" BOOLEAN NOT NULL,
    "registerAt" DATE NOT NULL,
    "updatedAt" DATE NOT NULL,
    "warehouseId" INTEGER NOT NULL,

    CONSTRAINT "WarehouseUsers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,
    "producedAt" DATE NOT NULL,
    "expiresAt" DATE NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "unitPrice" DECIMAL(65,30) NOT NULL,
    "state" BOOLEAN NOT NULL,
    "warehouseId" INTEGER NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Purchases" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "finalPrice" DECIMAL(65,30) NOT NULL,
    "warehouseId" INTEGER NOT NULL,
    "registedAt" DATE NOT NULL,

    CONSTRAINT "Purchases_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sells" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "finalPrice" DECIMAL(65,30) NOT NULL,
    "warehouseId" INTEGER NOT NULL,
    "registedAt" DATE NOT NULL,

    CONSTRAINT "Sells_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Warehouse_name_key" ON "Warehouse"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_key" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "WarehouseUsers_name_key" ON "WarehouseUsers"("name");

-- CreateIndex
CREATE UNIQUE INDEX "WarehouseUsers_lastName_key" ON "WarehouseUsers"("lastName");

-- CreateIndex
CREATE UNIQUE INDEX "WarehouseUsers_dui_key" ON "WarehouseUsers"("dui");

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Product_name_key" ON "Product"("name");

-- AddForeignKey
ALTER TABLE "WarehouseUsers" ADD CONSTRAINT "WarehouseUsers_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WarehouseUsers" ADD CONSTRAINT "WarehouseUsers_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "Warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "Warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Purchases" ADD CONSTRAINT "Purchases_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Purchases" ADD CONSTRAINT "Purchases_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "Warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sells" ADD CONSTRAINT "Sells_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sells" ADD CONSTRAINT "Sells_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "Warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
