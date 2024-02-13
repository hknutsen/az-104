# Routes example

Consider a virtual network `vNet1` containing a subnet `subnet1`:

- Virtual network address space: `10.10.0.0/16`.
- Subnet address prefix: `10.10.1.0/24`.
- Virtual network appliance (NVA) IP address: `10.10.1.12`.
- Peered with virtual network `vNet2` with address space `10.11.0.0/16`.

The following routes are configured for `subnet1`. The objective is to route all traffic to `vNet2` through the NVA.

## User-defined routes

| Source | Address prefixes | Next hop type | IP |
| --- | --- | --- | --- |
| User | 10.11.0.0/16 | Virutal appliance | 10.10.1.12 |

## BGP routes

| Source | Address prefixes | Next hop type |
| --- | --- | --- |
| N/A | N/A | N/A |

## Default routes

| Source | Address prefixes | Next hop type |
| --- | --- | --- |
| Default | 10.10.0.0/16 | Virtual network |
| Default | 10.11.0.0/16 | vNet peering |
| Default | 0.0.0.0/0 | Internet |
| Default | 10.0.0.0/8 | None |
| Default | 172.16.0.0/12 | None |
| Default | 192.168.0.0/16 | None |
| Default | 100.64.0.0/10 | None |
