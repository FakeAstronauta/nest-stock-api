import { Injectable } from '@nestjs/common';
import { Stock } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { DateRangeDto, StockDto } from './dto';

@Injectable()
export class StockService {
  constructor(private prisma: PrismaService) {}

  // still needs to validate the total
  async register(dto: StockDto) {
    await this.prisma.stock.create({
      data: dto,
    });
  }

  async getAllBetween(dto: DateRangeDto) {
    const range: Stock[] = await this.prisma.stock.findMany({
      where: {
        registedAt: {
          gte: new Date(dto.greaterDate), // farest
          lte: new Date(dto.lowerDate), // nearest
        },
      },
    });

    let total = 0;

    range.forEach((element) => {
      total += +element.total;
    });

    return `The total earnings are ${total}`;
  }
}
