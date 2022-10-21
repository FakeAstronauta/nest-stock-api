-- DropForeignKey
ALTER TABLE "Warehouse" DROP CONSTRAINT "Warehouse_warehouseAdminId_fkey";

-- DropForeignKey
ALTER TABLE "WarehouseUsers" DROP CONSTRAINT "WarehouseUsers_warehouseId_fkey";

-- AlterTable
ALTER TABLE "Warehouse" ALTER COLUMN "warehouseAdminId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "WarehouseUsers" ALTER COLUMN "warehouseId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Warehouse" ADD CONSTRAINT "Warehouse_warehouseAdminId_fkey" FOREIGN KEY ("warehouseAdminId") REFERENCES "WarehouseUsers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WarehouseUsers" ADD CONSTRAINT "WarehouseUsers_warehouseId_fkey" FOREIGN KEY ("warehouseId") REFERENCES "Warehouse"("id") ON DELETE SET NULL ON UPDATE CASCADE;
