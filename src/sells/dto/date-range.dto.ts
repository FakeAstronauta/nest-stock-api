import { IsDate, IsNotEmpty } from "class-validator";

export class DateRangeDto{
    @IsDate()
    @IsNotEmpty()
    greaterDate: Date;

    @IsDate()
    @IsNotEmpty()
    lowerDate: Date;
}