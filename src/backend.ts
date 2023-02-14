import {
    ServerAPI
} from "decky-frontend-lib"

var serverAPI: ServerAPI | undefined = undefined;
  
export function setServerAPI(s: ServerAPI) {
    serverAPI = s;
}
  
async function backend_call<I, O>(name: string, params: I): Promise<O> {
    try {
        const result = await serverAPI!.callPluginMethod<I, O>(name, params);
        if (result.success)
            return result.result;
        else {
            console.error(result.result);
            throw result.result;
        }
    } catch (e) {
        console.error(e);
        throw e;
    }
}

export async function configurator(): Promise<boolean> {
    return backend_call<{}, boolean>("configurator", {});
}

export async function sendpacket(): Promise<boolean> {
    return backend_call<{}, boolean>("sendpacket", {});
}
