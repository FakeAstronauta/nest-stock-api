import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { Roles } from 'src/auth/decorator';
import { Role } from 'src/auth/enum/roles.enum';
import { JwtGuard, RolesGuard } from 'src/auth/guard';
import { ProductDto } from './dto/product.dto';
import { ProductService } from './product.service';

@ApiTags('Product')
@UseGuards(RolesGuard)
@UseGuards(JwtGuard)
@ApiBearerAuth()
@Controller('product/')
export class ProductController {
  constructor(private productService: ProductService) {}

  @Roles(Role.Admin)
  @Post('newProduct')
  registerProduct(@Body() dto: ProductDto) {
    return this.productService.registerProduct(dto);
  }
}
