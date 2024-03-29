import { ApiProperty } from '@nestjs/swagger';
import {
  IsBoolean,
  IsDate,
  IsDecimal,
  IsInt,
  IsNotEmpty,
  IsString,
  Min,
} from 'class-validator';

export class ProductDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  name: string;

  @IsDate()
  @IsNotEmpty()
  @ApiProperty()
  producedAt: Date;

  @IsDate()
  @IsNotEmpty()
  @ApiProperty()
  expiresAt: Date;

  @IsInt()
  @Min(1)
  @IsNotEmpty()
  @ApiProperty()
  categoryId: number;

  @IsDecimal()
  @IsNotEmpty()
  @Min(0.0)
  @ApiProperty()
  cost: number;

  @IsBoolean()
  @IsNotEmpty()
  @ApiProperty()
  state: boolean;
}
