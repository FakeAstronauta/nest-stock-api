-- DropIndex
DROP INDEX "WarehouseUsers_roleId_key";

-- AlterTable
ALTER TABLE "Warehouse" ALTER COLUMN "warehouseAdminId" DROP DEFAULT;
