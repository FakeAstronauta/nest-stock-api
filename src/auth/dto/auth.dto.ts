import {
    IsBoolean,
    IsDate,
    IsEmail,
    IsInt,
    IsNotEmpty,
    IsString,
    Length,
    Min
} from "class-validator"

export class AuthDto {
    @IsEmail()
    @IsNotEmpty()
    name: string

    @IsString()
    @IsNotEmpty()
    lastName: string

    // this may throw an error if pass a form
    @IsInt()
    @Min(1)
    @IsNotEmpty()
    roleId: number

    @IsDate()
    @IsNotEmpty()
    bornAt: Date

    @IsString()
    @Length(9, 9)
    @IsNotEmpty()
    dui: string

    @IsBoolean()
    @IsNotEmpty()
    state: boolean

    @IsNotEmpty()
    @IsDate()
    registerAt: Date
    
    @IsNotEmpty()
    @IsDate()
    updatedAt: Date
    
    @IsInt()
    @IsNotEmpty()
    @Min(0)
    warehouseId: number

}