import { ApiProperty } from '@nestjs/swagger';
import { IsDecimal, IsInt, IsNotEmpty, IsString, Min } from 'class-validator';

export class PurchasItem {
  @IsInt()
  @Min(1)
  @IsNotEmpty()
  @ApiProperty()
  productId: number;

  @IsInt()
  @Min(1)
  @IsNotEmpty()
  @ApiProperty()
  quantity: number;

  @IsDecimal()
  @Min(0.0)
  @IsNotEmpty()
  @ApiProperty()
  price: number;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  unit: string;

  @IsInt()
  @Min(1)
  @IsNotEmpty()
  @ApiProperty()
  total: number;
}
