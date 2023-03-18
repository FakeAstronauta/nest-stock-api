import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { productModule } from './product/product.module';
import { StockModule } from './stock/stock.module';
import { purchaseModule } from './purchase/purchase.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    PrismaModule,
    AuthModule,
    productModule,
    StockModule,
    purchaseModule,
  ],
})
export class AppModule {}
