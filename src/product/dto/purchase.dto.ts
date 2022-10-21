import {
    IsDate,
    IsDecimal,
    IsInt,
    IsNotEmpty,
    IsString,
    Min
} from "class-validator"

export class PurchaseDto{
    @IsInt()
    @Min(1)
    @IsNotEmpty()
    amount: number
    
    @IsInt()
    @Min(1)
    @IsNotEmpty()
    warehouseId: number

    @IsDate()
    @IsString()
    @IsNotEmpty()
    registedAt: Date
}