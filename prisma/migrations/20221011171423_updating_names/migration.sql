/*
  Warnings:

  - You are about to drop the `Category` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Product` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Purchases` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Sells` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Warehouse` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WarehouseUsers` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_categoryId_fkey";

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
ALTER TABLE "WarehouseUsers" DROP CONSTRAINT "WarehouseUsers_roleId_fkey";

-- DropForeignKey
ALTER TABLE "WarehouseUsers" DROP CONSTRAINT "WarehouseUsers_warehouseId_fkey";

-- DropTable
DROP TABLE "Category";

-- DropTable
DROP TABLE "Product";

-- DropTable
DROP TABLE "Purchases";

-- DropTable
DROP TABLE "Role";

-- DropTable
DROP TABLE "Sells";

-- DropTable
DROP TABLE "Warehouse";

-- DropTable
DROP TABLE "WarehouseUsers";

-- CreateTable
CREATE TABLE "warehouse" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,

    CONSTRAINT "warehouse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,

    CONSTRAINT "role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "warehouseusers" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,
    "lastName" VARCHAR(250) NOT NULL,
    "roleId" INTEGER NOT NULL,
    "bornAt" TIMESTAMP NOT NULL,
    "dui" CHAR(9) NOT NULL,
    "state" BOOLEAN NOT NULL,
    "registerAt" DATE NOT NULL,
    "updatedAt" DATE NOT NULL,
    "warehouseId" INTEGER NOT NULL,

    CONSTRAINT "warehouseusers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "category" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(250) NOT NULL,
    "producedAt" DATE NOT NULL,
    "expiresAt" DATE NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "unitPrice" DECIMAL(65,30) NOT NULL,
    "state" BOOLEAN NOT NULL,
    "warehouseId" INTEGER NOT NULL,

    CONSTRAINT "product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "purchases" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "finalPrice" DECIMAL(65,30) NOT NULL,
    "warehouseId" INTEGER NOT NULL,
    "registedAt" DATE NOT NULL,

    CONSTRAINT "purchases_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sells" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "finalPrice" DECIMAL(65,30) NOT NULL,
    "warehouseId" INTEGER NOT NULL,
    "registedAt" DATE NOT NULL,

    CONSTRAINT "sells_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "warehouse_name_key" ON "warehouse"("name");

-- CreateIndex
CREATE UNIQUE INDEX "role_name_key" ON "role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "warehouseusers_name_key" ON "warehouseusers"("name");

-- CreateIndex
CREATE UNIQUE INDEX "warehouseusers_lastName_key" ON "warehouseusers"("lastName");

-- CreateIndex
CREATE UNIQUE INDEX "warehouseusers_dui_key" ON "warehouseusers"("dui");

-- CreateIndex
CREATE UNIQUE INDEX "category_name_key" ON "category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "product_name_key" ON "product"("name");

-- AddForeignKey
ALTER TABLE "warehouseusers" ADD CONSTRAINT "warehouseusers_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "warehouseusers" ADD CONSTRAINT "warehouseusers_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchases" ADD CONSTRAINT "purchases_productId_fkey" FOREIGN KEY ("productId") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "purchases" ADD CONSTRAINT "purchases_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sells" ADD CONSTRAINT "sells_productId_fkey" FOREIGN KEY ("productId") REFERENCES "product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sells" ADD CONSTRAINT "sells_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "warehouse"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
