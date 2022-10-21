import { Injectable, UnauthorizedException } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { PassportStrategy } from "@nestjs/passport";
import { ExtractJwt, Strategy } from "passport-jwt";
import { PrismaService } from "src/prisma/prisma.service";

@Injectable()
export class JwtStrategy extends PassportStrategy(
    Strategy,
    'jwt'
){
    constructor(
        private prisma: PrismaService,
        private config: ConfigService
    ){
        super({
            jwtFromRequest:
            ExtractJwt.fromAuthHeaderAsBearerToken(),
            secretOrKey: config.get('JWT_SECRET')
        })
    }

    async validate(
        payload: {
            sub: number,
            name: string,
            role: string
        }
    ){
        const user = await this.prisma.warehouseUsers.findFirst({
            where: {
                name: payload.name
            }
        });

        return user;
    }
}