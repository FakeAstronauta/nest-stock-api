import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards } from '@nestjs/common';
import { SellsService } from './sells.service';
import { DateRangeDto, SellDto } from './dto';
import { JwtGuard, RolesGuard } from 'src/auth/guard';
import { Roles } from 'src/auth/decorator';
import { Role } from 'src/auth/enum/roles.enum';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Sells')
@UseGuards(RolesGuard)
@UseGuards(JwtGuard)
@Controller('sells')
export class SellsController {
  constructor(private readonly sellsService: SellsService) {}

  @Roles(Role.Seller)
  @Patch('/registerSell/:id')
  update(@Param('id') id: string, @Body() SellDto: SellDto) {
    return this.sellsService.registerSell(+id, SellDto);
  }
  
  @Roles(Role.Admin)
  @Post('getAllBetween')
  getAllBetween(@Body() dto: DateRangeDto){
    return this.sellsService.getAllBetween(dto)
  }

}
