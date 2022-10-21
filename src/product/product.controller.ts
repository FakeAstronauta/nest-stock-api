import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { Roles } from 'src/auth/decorator';
import { Role } from 'src/auth/enum/roles.enum';
import { JwtGuard, RolesGuard } from 'src/auth/guard';
import { ProductDto } from './dto/product.dto';
import { PurchaseDto } from './dto/purchase.dto';
import { ProductService } from './product.service';

@ApiTags('Product')
@UseGuards(RolesGuard)
@UseGuards(JwtGuard)
@Controller('product')
export class ProductController {
    constructor(
        private productService: ProductService
    ){}
    
    @Roles(Role.Admin)
    @Post("registerProduct")
    registerProduct(@Body() dto: ProductDto){
        return this.productService.registerProduct(
            dto
        );
    }
        
    @Roles(Role.Admin)
    @Post("registerPurchase/:id")
    registerPurchase(@Param('id') id: string, @Body() dto: PurchaseDto){
        return this.productService.registerPurchase(
            id,
            dto
        );
    }
}

