import {
  Body,
  Controller,
  HttpCode,
  HttpStatus,
  Post,
  UseGuards,
} from '@nestjs/common';

import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { Roles } from './decorator';
import { AuthDto } from './dto';
import { SignInDto } from './dto/signIn.dto';
import { Role } from './enum/roles.enum';
import { JwtGuard, RolesGuard } from './guard';

@ApiTags('Auth') // this must be called 'Admin'
@Controller('auth')
@UseGuards(RolesGuard)
export class AuthController {
  constructor(private authService: AuthService) {}

  // only a admin can register new user
  @Roles(Role.Admin)
  @UseGuards(JwtGuard)
  @Post('newUser')
  @ApiBearerAuth()
  @HttpCode(HttpStatus.OK)
  addOne(@Body() dto: AuthDto) {
    return this.authService.signUp(dto);
  }

  @Post('signIn')
  @HttpCode(HttpStatus.OK)
  signIn(@Body() userName: SignInDto) {
    return this.authService.signIn(userName);
  }
}
