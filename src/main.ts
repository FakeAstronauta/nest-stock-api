import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.enableCors();

  const config = new DocumentBuilder()
    .setTitle('Stock interface')
    .setDescription('Management')
    .addBearerAuth()
    .setVersion('1.0')
    .addTag('Auth')
    .addTag('Product')
    .addTag('Purchase')
    .addTag('Stock')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('', app, document);

  await app.listen(3000);
}

bootstrap();
