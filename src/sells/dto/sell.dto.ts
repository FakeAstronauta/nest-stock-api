import {
    IsDate,
    IsInt,
    IsNotEmpty,
    IsString,
    Min
} from "class-validator"

export class SellDto{
    @IsInt()
    @Min(1)
    @IsNotEmpty()
    amount: number
    
    @IsDate()
    @IsString()
    @IsNotEmpty()
    registedAt: Date
}