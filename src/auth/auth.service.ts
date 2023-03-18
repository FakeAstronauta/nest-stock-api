import {
  BadRequestException,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from 'src/prisma/prisma.service';
import { AuthDto } from './dto';
import { SignInDto } from './dto/signIn.dto';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwt: JwtService,
    private config: ConfigService,
  ) {}

  // not related to auth
  async signUp(dto: AuthDto) {
    try {
      await this.prisma.users.create({
        data: dto,
      });
      return { message: 'User Created succesfully' };
    } catch (error) {
      throw new BadRequestException(
        'There is something wrong in the field ' + error.meta.target[0],
      );
    }
  }

  async signIn(userName: SignInDto) {
    const user = await this.prisma.users.findFirst({
      where: {
        name: userName.name,
      },
      include: {
        warehouseUsers: {
          include: {
            role: true,
          },
        },
      },
    });

    if (!user) {
      throw new ForbiddenException('Credentials incorrect');
    }

    return this.asignToken(
      user.id,
      user.name,
      user.warehouseUsers[0].role.name,
    );
  }

  async asignToken(
    userId: number,
    name: string,
    role: string,
  ): Promise<{ access_token: string }> {
    const payload = {
      sub: userId,
      name: name,
      role: role,
    };

    const secret = this.config.get('JWT_SECRET');

    const token = await this.jwt.signAsync(payload, {
      expiresIn: '60m',
      secret: secret,
    });

    return {
      access_token: token,
    };
  }
}
