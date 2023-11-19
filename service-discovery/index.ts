import express from 'express'

const PORT = process.env.PORT || 8080
let SERVICE_TARGETS: Record<string, string> = {}

const app = express()
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// headlthCheck
app.get('/health', (req, res) => {
  console.log('health')
  return res.status(200).json({
    msg: 'success',
  })
})

interface TargetParams {
  key: string
  host: string
  port: string
}

//////////////////////////////////////////// Add ////////////////////////////////////////////
app.post('/add', (req, res) => {
  console.log('add', req.body)
  const { key, host, port }: TargetParams = req.body as TargetParams

  const hostPort = `${host}:${port}`

  if (Object.keys(SERVICE_TARGETS).some((it) => it === key)) {
    return res.status(400).json({
      msg: `Is Already Exists Key : ${key}`,
    })
  }

  if (Object.values(SERVICE_TARGETS).some((it) => it === hostPort)) {
    return res.status(400).json({
      msg: `Is Already Exsits host:port : ${hostPort}`,
    })
  }

  SERVICE_TARGETS[key] = hostPort

  return res.status(200).json({
    msg: 'success',
    result: JSON.stringify(SERVICE_TARGETS),
  })
})

//////////////////////////////////////////// Remove ////////////////////////////////////////////
app.post('/remove', (req, res) => {
  console.log('remove')
  const { key }: Pick<TargetParams, 'key'> = req.body

  SERVICE_TARGETS = Object.entries(SERVICE_TARGETS)
    .filter(([k, _]) => k !== key)
    .reduce((acc, [k, hostPort]) => {
      acc[k] = hostPort
      return acc
    }, {} as Record<string, string>)

  return res.status(200).json({
    msg: 'success',
    result: JSON.stringify(SERVICE_TARGETS),
  })
})

//////////////////////////////////////////// Get Targets ////////////////////////////////////////////
app.get('/targets', (req, res) => {
  console.log('targets')
  const hostPortArr = Object.values(SERVICE_TARGETS).map((hp) => hp)
  console.log(SERVICE_TARGETS)

  return res.status(200).json([
    {
      targets: hostPortArr,
      labels: {
        service: 'web',
        role: 'role-1',
      },
    },
  ])
})

app.listen(PORT, () => {
  console.log(`localhost:${PORT} is connect`)
})
