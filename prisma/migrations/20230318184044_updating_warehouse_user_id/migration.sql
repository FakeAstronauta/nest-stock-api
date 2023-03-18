/*
  Warnings:

  - The primary key for the `warehouseUsers` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `warehouseUsers` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Purchases" DROP CONSTRAINT "Purchases_warehouseUserId_fkey";

-- AlterTable
ALTER TABLE "warehouseUsers" DROP CONSTRAINT "warehouseUsers_pkey",
DROP COLUMN "id",
ADD CONSTRAINT "warehouseUsers_pkey" PRIMARY KEY ("userId");

-- AddForeignKey
ALTER TABLE "Purchases" ADD CONSTRAINT "Purchases_warehouseUserId_fkey" FOREIGN KEY ("warehouseUserId") REFERENCES "warehouseUsers"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
