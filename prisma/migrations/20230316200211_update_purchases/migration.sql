/*
  Warnings:

  - Added the required column `warehouseUserId` to the `Purchases` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Purchases" ADD COLUMN     "warehouseUserId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Purchases" ADD CONSTRAINT "Purchases_warehouseUserId_fkey" FOREIGN KEY ("warehouseUserId") REFERENCES "warehouseUsers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
