import { BadRequestException, ForbiddenException, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from 'src/prisma/prisma.service';
import { AuthDto } from './dto';

@Injectable()
export class AuthService {
    constructor(
        private prisma: PrismaService,
        private jwt: JwtService,
        private config: ConfigService
    ) { }

    async addOne(dto: AuthDto) {
        try {
            const user = await this.prisma.warehouseUsers.create({
                data: dto
            })
            return { message: "User Created succesfully" };
        } catch (error) {
            throw new BadRequestException(
                "There is something wrong in the field "
                + error.meta.target[0]
            )
        }
    }

    async signInAdmin(userName: {name: string}) {
        let user = await this.prisma.warehouseUsers.findFirst({
            where: {
                name: userName.name
            },
            include: {
                role: true
            }
        })

        if (!user) {
            throw new ForbiddenException(
                'Credentials incorrect'
            )

        }

        return this.asignToken(user.id, user.name, user.role.name)
    }

    async signInSeller(userName: {name: string}) {
        let user = await this.prisma.warehouseUsers.findFirst({
            where: {
                name: userName.name
            },
            include: {
                role: true
            }
        })

        if (!user) {
            throw new ForbiddenException(
                'Credentials incorrect'
            )
        }

        return this.asignToken(user.id, user.name, user.role.name)
    }

    async asignToken(
        userId: number,
        name: string,
        role: string
    ): Promise<{ access_token: string }> {

        const payload = {
            sub: userId,
            name: name,
            role: role
        }
        
        const secret = this.config.get('JWT_SECRET')


        let token = await this.jwt.signAsync(payload, {
            expiresIn: '30m',
            secret: secret
        })
        
        return {
            access_token: token
        }
    }

}

/* 
{
                    "name": "shel",
                    "lastName": "Pera",
                    "roleId": 2,                    
                    "bornAt": "2020"01-01T00:00:00.000Z',
                    "dui": "11111111",
                    "state": true
                    "registerAt": "2020-01-01T00:00:00.000Z",
                    "updatedAt": "2020-01-01T00:00:00.000Z",
                    "warehouseId": 1
                }"*/
