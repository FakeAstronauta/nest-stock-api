import { BadRequestException, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { ProductDto } from './dto/product.dto';

@Injectable()
export class ProductService {
  constructor(private prisma: PrismaService) {}
  // nice to add a method fot update
  // add new product to the database
  async registerProduct(dto: ProductDto) {
    try {
      await this.prisma.product.create({
        data: dto,
      });

      return { message: 'Product registered succesfully' };
    } catch (error) {
      throw new BadRequestException('There is something wrong. ' + error);
    }
  }
}
