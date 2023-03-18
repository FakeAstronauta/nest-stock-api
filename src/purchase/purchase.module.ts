import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { PurchaseController } from './purchase.controller';
import { PurchaseService } from './purchase.service';

@Module({
  imports: [JwtModule.register({})],
  controllers: [PurchaseController],
  providers: [PurchaseService],
})
export class purchaseModule {}
