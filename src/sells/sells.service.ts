import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateSellDto } from './dto/create-sell.dto';
import { DateRangeDto, SellDto } from './dto';

@Injectable()
export class SellsService {
  constructor(
    private prisma: PrismaService
  ) { }

  async registerSell(id: number, sellDto: SellDto) {
    const purchase: any = await this.prisma.purchases.findUnique({
      where: {
        id: id
      },
      include: {
        product: true
      }
    })

    if (!!purchase) {
     await this.prisma.purchases.update({
        where: {
          id: id
        },
        data: {
          amount: sellDto.amount
        }
      })

      let sell: any = await this.prisma.sells.create({
        data: {
          productId: +id,
          amount: sellDto.amount,
          finalPrice: purchase.product.unitPrice * sellDto.amount,
          warehouseId: purchase.warehouseId,
          registedAt: undefined
        }
      })

      return {message: `Sell registered succesfully, ${sell.id}`};
    }
  }

  async getAllBetween(dto: DateRangeDto){
    let range: any = await this.prisma.sells.findMany({
      where: {
        registedAt: {
          gte: new Date(dto.greaterDate),
          lte: new Date(dto.lowerDate),
        },
      },
    });

    let total: number = 0;
    
    range.forEach((element: { finalPrice: number; }) => {
      total += +element.finalPrice;
      console.log(total)
    });

    return `The total earnings are ${total}`;
  }
}
