import serverlessExpress from '@vendia/serverless-express';
import { Handler } from 'express';
import { createApp } from './main';

let server: any;

async function bootstrap() {
    const app = await createApp();
    return serverlessExpress({
        app: app.getHttpAdapter().getInstance()
    })
}

export const handler: Handler = async (event, context, callback) => {
    server = server ?? await bootstrap();
    return server(event, context, callback);
};