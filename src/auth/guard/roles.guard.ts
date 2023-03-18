import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector, private jwtService: JwtService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const rolesId = this.reflector.get<number[]>('roles', context.getHandler());

    if (!rolesId) {
      return true;
    }

    const request = context.switchToHttp().getRequest().headers;
    const jwt = request.authorization.replace('Bearer ', '');
    const roleJwt: any = this.jwtService.decode(jwt, { json: true });
    return rolesId.some((role) => roleJwt.role == role);
  }
}
