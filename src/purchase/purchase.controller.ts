import { Body, Controller, Headers, Post, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { Roles } from 'src/auth/decorator';
import { Role } from 'src/auth/enum/roles.enum';
import { JwtGuard, RolesGuard } from 'src/auth/guard';
import { PurchaseDto } from 'src/purchase/dto/purchase.dto';
import { PurchaseService } from './purchase.service';

@ApiTags('Purchase')
@UseGuards(RolesGuard)
@UseGuards(JwtGuard)
@ApiBearerAuth()
@Controller('purchase/')
export class PurchaseController {
  constructor(private purchaseService: PurchaseService) {}

  @Roles(Role.Admin, Role.Seller)
  @Post('new/')
  registerPurchase(
    @Body() dto: PurchaseDto,
    @Headers('Authorization') headers: string,
  ) {
    return this.purchaseService.registerPurchase(dto, headers);
  }
}
