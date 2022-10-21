import { Type } from "class-transformer"
import { IsBoolean, isBoolean, IsDataURI, IsDate, IsDecimal, IsInt, isNotEmpty, IsNotEmpty, IsNotIn, IsObject, IsString, Min } from "class-validator"
import { PurchaseDto } from "./purchase.dto"

export class ProductDto{
    @IsString()
    @IsNotEmpty()
    name: string
    
    @IsDate()
    @IsNotEmpty()
    producedAt: Date
    
    @IsDate()
    @IsNotEmpty()
    expiresAt: Date

    @IsInt()
    @Min(1)
    @IsNotEmpty()
    categoryId: number

    @IsDecimal()
    @IsNotEmpty()
    @Min(0.00)
    unitPrice: number

    @IsBoolean()
    @IsNotEmpty()
    state: boolean

    @IsInt()
    @Min(1)
    @IsNotEmpty()
    warehouseId: number
}