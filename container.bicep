param location string = resourceGroup().location
param appName string = uniqueString(resourceGroup().id)
resource registry 'Microsoft.ContainerRegistry/registries@2021-12-01-preview' = {
  name: 'reactoronthesixth'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

resource container 'Microsoft.ContainerInstance/containerGroups@2022-09-01' = {
  name: appName
  location: location
  properties: {
    osType: 'Linux'
    imageRegistryCredentials: [
      {
        server: 'reactoronthesixth.azurecr.io'
        username: 'reactoronthesixth'
        password: 'Dx34dM01HoeKxw4QATnkjbo+mQglf+75x0IAGcTg+q+ACRD2vTxS'
      }
    ]
    ipAddress: {
      type: 'Public'
      dnsNameLabel: appName
      ports: [
        {
          port: 80
          protocol: 'TCP'
        }
      ]
    }
    containers: [
      {
        name: 'webapp'
        properties: {
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 2
            }
          }
          image: 'reactoronthesixth.azurecr.io/aspnetrazor:latest'
          ports: [
            {
              port: 80
              protocol: 'TCP'
            }
          ]
        }
      }
    ]
  }
}
