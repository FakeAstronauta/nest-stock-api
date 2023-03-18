import { BadRequestException, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { PurchaseDto } from 'src/purchase/dto/purchase.dto';
import { Product, Stock } from '@prisma/client';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class PurchaseService {
  constructor(private prisma: PrismaService, private jwtService: JwtService) {}
  async registerPurchase(dto: PurchaseDto, auth: string) {
    try {
      const find: (Product & { Stock: Stock[] })[] =
        await this.prisma.product.findMany({
          where: {
            OR: dto.purchaseItems.map((e) => ({
              id: e.productId,
            })),
          },
          include: {
            Stock: true,
          },
        });

      // check if every product exist
      if (find.length !== dto.purchaseItems.length) {
        return (
          'these products does not exist ' + this.filterProducts(find, dto)
        );
      }

      // check the state of every product
      const isTrue = find.filter((e) => !e.state);

      if (isTrue.length >= 1) {
        return (
          'these products are out of stock: ' +
          isTrue.map((e) => e.name).join(' ')
        );
      }

      // check if the amount of product exist
      const compared = this.compareStock(find, dto);
      if (compared.length >= 1) {
        return (
          'there is not enough products of: ' +
          find.map((e) => e.name).join(' ')
        );
      }

      // create a new registry
      // many-to-many example
      await this.prisma.purchases.create({
        data: {
          warehouseUserId: this.extractId(auth),
          amount: 500.0,
          purchaseCode: 'random',
          purchaseItems: {
            create: dto.purchaseItems, // is purchase id automatic created?
          },
        },
      });

      return { message: 'Purchase registered successfully' };
    } catch (error) {
      throw new BadRequestException(
        `There is something wrong in the data you send: ${error}`,
      );
    }
  }

  extractId = (auth: string) => {
    const jwt = auth.replace('Bearer ', '');
    const idJwt: any = this.jwtService.decode(jwt, { json: true });
    return idJwt.sub;
  };

  filterProducts = (fromDB: Product[], fromReq: PurchaseDto) => {
    const last = [];

    fromReq.purchaseItems.forEach((e) => {
      const find = fromDB.filter((el) => e.productId === el.id);
      if (find.length !== 1) {
        last.push(e.productId);
      }
    });

    return last;
  };

  compareStock = (
    fromDB: (Product & { Stock: Stock[] })[],
    fromReq: PurchaseDto,
  ) => {
    const find = fromDB.filter(
      (e, i) => e.Stock[0].quantity < fromReq.purchaseItems[i].quantity,
    );
    return find;
  };
}
