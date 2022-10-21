import {
    Body,
    Controller,
    HttpCode,
    HttpStatus,
    Post,
    UseGuards
} from '@nestjs/common';

import { ApiTags } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { Roles } from './decorator';
import { AuthDto } from './dto';
import { Role } from './enum/roles.enum';
import { JwtGuard, RolesGuard } from './guard';

@ApiTags('Auth')
@Controller('auth')
@UseGuards(RolesGuard)
export class AuthController {
    constructor(
        private authService: AuthService,
    ) { }

    @Roles(Role.Admin)
    @UseGuards(JwtGuard)
    @Post('registerSeller')
    @HttpCode(HttpStatus.OK)
    addOne(@Body() dto: AuthDto) {
        return this.authService.addOne(dto)
    }

    @Post('signInAdmin')
    @HttpCode(HttpStatus.OK)
    signInAdmin(@Body() userName: {name: string}) {
        return this.authService.signInAdmin(userName)
    }

    @Post('signInSeller')
    @HttpCode(HttpStatus.OK)
    signInSeller(@Body() userName: {name: string}) {
        return this.authService.signInSeller(userName)
    }
}
