import { Controller, Post, Body, UseGuards } from '@nestjs/common';
import { StockService } from './stock.service';
import { DateRangeDto, StockDto } from './dto';
import { JwtGuard, RolesGuard } from 'src/auth/guard';
import { Roles } from 'src/auth/decorator';
import { Role } from 'src/auth/enum/roles.enum';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

@ApiTags('Stock')
@UseGuards(RolesGuard)
@UseGuards(JwtGuard)
@ApiBearerAuth()
@Controller('stock/')
export class StockController {
  constructor(private sellsService: StockService) {}

  @Roles(Role.Admin)
  @Post('newRegistry/')
  newRegistry(@Body() stockDto: StockDto) {
    return this.sellsService.register(stockDto);
  }

  // all the registries during a period of time
  @Roles(Role.Admin)
  @Post('allBetween/')
  getAllBetween(@Body() dto: DateRangeDto) {
    return this.sellsService.getAllBetween(dto);
  }
}
