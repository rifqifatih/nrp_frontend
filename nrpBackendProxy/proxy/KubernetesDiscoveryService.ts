const k8s = require('@kubernetes/client-node');
const q = require('q');

async function query(configuration) {
    try {
        const kc = new k8s.KubeConfig();
        kc.loadFromDefault();

        const k8sApi = kc.makeApiClient(k8s.CoreV1Api);

        const deferred = q.defer();
        k8sApi.listServiceForAllNamespaces(undefined, undefined, undefined, "app=nrp-service-per-pod", undefined, undefined, undefined, undefined, undefined).then((res) => {
            let results = {};

            if (res == null || res.statusCode != 200) {
                console.log('Failed to query Kubernetes API, returning default.');
                deferred.resolve(configuration.servers);
            } else {
                let items = res.body.items;
                for (let i in items) {
                    let item = items[i];
                    let ip = item.spec.clusterIP;
                    let port = item.spec.ports[0].nodePort;
                    let address = ip + ":" + port;
                    results[item.metadata.name] = {
                        "gzweb": {
                            "assets": "http://" + address + "/assets",
                            "nrp-services": "http://" + address,
                            "videoStreaming": "http://" + address + "/webstream/",
                            "websocket": "ws://" + address + "/gzbridge"
                        },
                        "rosbridge": {
                            "websocket": "ws://" + address + "/rosbridge"
                        },
                        "serverJobLocation": "local"
                    }
                }

                deferred.resolve(results);
            }
        }).catch((error) => {
            console.error("Exception occurred: " + error)
            deferred.resolve(configuration.servers);
        });

        const servers = await deferred.promise;
        configuration.servers = servers;
        return configuration;
    } catch (error) {
        console.error("Exception occurred: " + error);
        return configuration;
    }
}

export default {
    query
};