import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';
import { PurchasItem } from './purchase_item';

export class PurchaseDto {
  @IsNotEmpty()
  @ApiProperty({ type: [PurchasItem] })
  purchaseItems: PurchasItem[];
}
