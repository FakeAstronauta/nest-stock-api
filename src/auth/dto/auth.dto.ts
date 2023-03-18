import { ApiProperty } from '@nestjs/swagger';
import {
  IsBoolean,
  IsDate,
  IsEmail,
  IsInt,
  IsNotEmpty,
  IsString,
  Length,
  Min,
} from 'class-validator';

export class AuthDto {
  @IsEmail()
  @IsNotEmpty()
  @ApiProperty()
  name: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  lastName: string;

  // this may throw an error if pass a form
  @IsInt()
  @Min(1)
  @IsNotEmpty()
  @ApiProperty()
  roleId: number;

  @IsDate()
  @IsNotEmpty()
  @ApiProperty()
  bornAt: Date;

  @IsString()
  @Length(9, 9)
  @IsNotEmpty()
  @ApiProperty()
  dui: string;

  @IsBoolean()
  @IsNotEmpty()
  @ApiProperty()
  state: boolean;

  @IsNotEmpty()
  @IsDate()
  @ApiProperty()
  registerAt: Date;

  @IsNotEmpty()
  @IsDate()
  @ApiProperty()
  updatedAt: Date;

  @IsInt()
  @IsNotEmpty()
  @Min(0)
  @ApiProperty()
  warehouseId: number;
}
