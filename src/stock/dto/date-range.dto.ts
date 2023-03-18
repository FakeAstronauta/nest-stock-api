import { ApiProperty } from '@nestjs/swagger';
import { IsDate, IsNotEmpty } from 'class-validator';

export class DateRangeDto {
  @IsDate()
  @IsNotEmpty()
  @ApiProperty({ description: 'the maximun date you want to filter' })
  greaterDate: Date;

  @IsDate()
  @IsNotEmpty()
  @ApiProperty({ description: 'the minimun date you want to filter' })
  lowerDate: Date;
}
