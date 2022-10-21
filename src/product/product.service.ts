import { 
    BadRequestException,
    Injectable,
} from '@nestjs/common';
import { Type } from 'class-transformer';
import { PrismaService } from 'src/prisma/prisma.service';
import { ProductDto } from './dto/product.dto';
import { PurchaseDto } from './dto/purchase.dto';

@Injectable()
export class ProductService {
    
    constructor(private prisma: PrismaService){}
    
    async registerProduct(dto: ProductDto){
        /* 
        {
            "name": "milk",
            "producedAt": "2022-02-02T00:00:00.000Z",
            "expiresAt": "2022-02-02T00:00:00.000Z",
            "categoryId": 1,
            "unitPrice": 2.25,
            "state": true,
            "warehouseId": 2,
        }
 */ 
        try{
            await this.prisma.product.create({
                data: dto
            });
            
            return { message:
                "Product registered succesfully"
            };
        }catch(error){
            throw new BadRequestException(
                "There is something wrong. "
                + error
            );
        }
    }
    
    async registerPurchase(productId: string, dto: PurchaseDto){
        /*{
            "productId": 1,
            "amount": 4,
            "warehouseId": 1,
            "registedAt": "2022-02-02T00:00:00.000Z"
        } */
        let product = await this.prisma.product.findUnique({
            where: {
                id: +productId
            }
        })

        try{
            await this.prisma.purchases.create({
                data: {
                    productId: +productId,
                    amount: +dto.amount,
                    finalPrice: +product.unitPrice * dto.amount,
                    warehouseId: +dto.warehouseId,
                    registedAt: dto.registedAt
                }
            });

            return { message:
                "Purchase registered succesfully"
            };

        }catch(error){
            throw new BadRequestException(
                "There is something wrong in the data you send"
            );
        }
    }
}
