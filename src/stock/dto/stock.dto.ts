import { ApiProperty } from '@nestjs/swagger';
import {
  IsDate,
  IsDecimal,
  IsInt,
  IsNotEmpty,
  IsString,
  Min,
} from 'class-validator';

export class StockDto {
  @IsInt()
  @Min(1)
  @IsNotEmpty()
  @ApiProperty()
  productId: number;

  @IsDecimal()
  @Min(0.0)
  @IsNotEmpty()
  @ApiProperty()
  price: number;

  @IsInt()
  @Min(0)
  @IsNotEmpty()
  @ApiProperty()
  quantity: number;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  unit: string;

  @IsDecimal()
  @Min(0.0)
  @IsNotEmpty()
  @ApiProperty()
  total: number;

  @IsDate()
  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  warehouseId: number;
}
