/*
  Warnings:

  - You are about to drop the `WarehouseAdmin` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Warehouse" DROP CONSTRAINT "Warehouse_warehouseAdminId_fkey";

-- DropForeignKey
ALTER TABLE "WarehouseAdmin" DROP CONSTRAINT "WarehouseAdmin_roleId_fkey";

-- DropTable
DROP TABLE "WarehouseAdmin";

-- AddForeignKey
ALTER TABLE "Warehouse" ADD CONSTRAINT "Warehouse_warehouseAdminId_fkey" FOREIGN KEY ("warehouseAdminId") REFERENCES "WarehouseUsers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
