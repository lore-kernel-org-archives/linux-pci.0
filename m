Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793076101;
	b=VuBSiHpKVkpjXLe8gtpBFmfk2ZLrpHAeXpfasnQ090fpqXPNRPPdd2SuQPXXcHgNujg8
	 W1UkvkF6FKnInfSC2MieavhnGRqxdpNXj5wjQ8oQ047gUHpN1UzfX38pJ1jsi+Wa8QVcf
	 R7tyDsWL8BkJwPjnCNz+X3s3cvxRDdml1iQGWQQR1iUKVeelm0OSojNsxGlqIOm7Yc1J1
	 nx5Qd67oIdTcxHEBYlcXqjF0tRouZFrZxnO1MHktEgpHVDPctbFnOJHcOXfQh0j9tatr4
	 75OWnnROFzdZ8KLyP48CXOUFsFsG/cZmODgjTpAG9Zn45rWxeFcnzVxp28E4G9TpzcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076101;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SVK/bV1B3kvBJC10uWIJEZvjX8nNtALCrupE7TaYsME=;
	b=ZXzALR4Sxj65lAwMQqVXk9KSUW1NA++oTw3UFx51a9DmztCukCdgA0c3t01rVM5YxjQW
	 x3d11xjJNpgPWjXTdtN7l12Z2AobWO1kmwWpti/J+8aEJEkiG8GWQl7QiYbR9y7P7Nggg
	 R8WeZxQCBGR3HA0itjNQPgRWFDcJX3YFcTbnhzTu+2ZqHyVIsC2cB7RBj0x7lGSgl+BrJ
	 Cr84RWZo559rZJq6t8avt+kDLZaHnP3/9Oi4Bx5JGlbeZlvao1vuLZvAHSPzTsNSXE8vZ
	 YZgVVxQQszLsBL4J3IHNSDGMQh5xV9zk9Fz5Hdp4EWVxCLSJCdTKBTWF0oH9whw9nFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ByZVhisO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.49
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16F606A31A;
	Tue, 27 Oct 2026 04:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A16F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ByZVhisO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6dRIAeCTGp1YCDM+EkZOgT4SV8sAHz9XB9Aua7/aGSPzhYm+0YmzbwrXZ1/deS3c0G4NMsKNImbvh8w1c6C46W6jZY8O8cb2s0HhDqi3fu63h9Fxnqv50oaxIzX51bgDOkYC+eLr1ImxT4KboYuz1fRRsP+phyMdpkgV3MGH34uf2HFzYvmyG6RvSWA2NvCpXQRifTl1atMvBlkn5NNP/TiUJfm91++A9EYwjjvtu8rfjP3bTcCCW7NOZ2qmfC8j7YPCGPVyWc5RQk1vLhk4s2/xdbhpbNkbxnptCIDtkgPfxWdU+9THwH1x6RCWotVP5wrw978pwtQjGin7pMQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVK/bV1B3kvBJC10uWIJEZvjX8nNtALCrupE7TaYsME=;
 b=xpDtB+Nn//o6usppo1l2FxhBI6yGICaHtgyp/dXdNUNG8mnT+nCSVDdXtub1wdGjZAltpJbPjYMG46hYR+UFWLsgJ5+OT4nIXQBuFGpJ3TShhtjlfuTHKjdcte69E57yNo7JuAKZJR6Yj5/UsyTyoLkFdAEOp0Jk+DSA/QnSZq9B4680M0GYdYa+YZUi2yTbyaEeZAS5DxAH5OOyUPQIcXqO/8d5wSm+wY/f4RzPxkeRMpc7K1LJsmSJv03gAuQ8183lZ+24XHnQs37gGka8W5kGeVuOvwh0SJNUuWsH6FKjIXK7vA0F9hCROZaLn1ikKPaSh2RHT3xF+HsrUsZuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVK/bV1B3kvBJC10uWIJEZvjX8nNtALCrupE7TaYsME=;
 b=ByZVhisOnCbUByZW66biup2EA0IXrAi2Ym/eKK3thct+gCJDNNO7mx5dp0fQzYptMEg//YI1AsYwZ16zeiaDtxzT89jAfpj/cOC4NRguphbFW5kwt43x0VpUxEnd+HOi9JpZFv8Mx9EF8XTk/cxrmOmRcSQueQqKOUci6YHlsUo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:41:38 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:41:38 +0000
Message-ID: <bb135cd6-5e36-4330-9635-885bb26576e3@amd.com>
Date: Tue, 27 Oct 2026 10:11:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] PCI: Preserve the initial bus number in pci_bus
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
 <20261026-vfct-regression-v3-1-fe9586ed6978@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261026-vfct-regression-v3-1-fe9586ed6978@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c04c03-5065-405b-eaee-08df33e49643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|56012099006|261026121527099003|3023799007|22082099003|18002099003|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	AG+i+YcszxkaC6OmkGKQSXyP7RyELYAxo0s+ED+FzdIyv/gcl4UqrS1X40L2j3oCnK4KSkTQOHCCZ8GZ9bOIhLe8gWDkiiXfcQ+lniRtoDpKUS0BSlHtxAPpst0vXmyJnExPkNtZeAvxa5RS2oatLhBxh3/8sNIbEZL+aJlVspvWi+/4DTlfeCXQ4fP5aVLOWzwW0sNlapQpiKsJkORlQAAOMmEIMQzN0ibeFDAiFdtB+BqyVp7RqNg5gyVtU9fEznHPt92ujgRf4rg/jD/WVhqTyglXUIQG5lzHHeukavApn5X1Tfk2gUrGn+0U4HSdlTi4XkbgSEXtnVEdNb3voZuYnEquiSPFZq+wLjdfUplfRBnX3jhipQBuuTm4zn/SHp9VBUbcT8bCeRvAvVreUakHXbeA4kAfuXCvqjJjx1EfkenhP5Z8rWyOM9mRUzLsQQR9CJfFDfjs0sIdCr2F7wk+y2z5QqRbY8AB1Nt8q7JAEGbc+P4C8EOG+Y7lpbCJiUjLDfoOc4eiUXD5pU+eNlGzWqpMOUmWVT1z2lhzZUI48qPJ6ZAG9+yn+/9nli6u3tUI/UO1sz+MjPW/lX5GseozQjwZ2L7AuiOC9X/oPBW/AI6oiZjFeSFMsTWZRflz2IOab1hNkFkghFouSB/wd4MvXBQXr5dyXsaMx4pTUkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3J1ZHR4UmY2cVNUK09Tbi8wbE5JWFF6OVc1cEtQWU1XMVhZdHBYWjlsTFQz?=
 =?utf-8?B?citRSVU1bjlRYjVGUkdLZTFyM1RRS21nZXFLQzg2VXg0M3pIMjgxZTZsdU9M?=
 =?utf-8?B?WnFHejdlT0xKOTg0eTlnczBzSGVMY3Z4MXZBOWFQckMxOWhXYmdPNzBtdzJI?=
 =?utf-8?B?TDZDSEUzczdiWkZuczl5ekZzSmlBT1dlZVBTTGxYcklxNnYxdVdTSk56Z0Jl?=
 =?utf-8?B?Q05qRG53NlljVW5yQmROelpZVjdkOEhCeGpWMDFmK3RpZWdQRlNrS3BKZkZF?=
 =?utf-8?B?WjJ6WE12ZUlVQUpKbDNialFtYmtrLzZ0bXRyVTZhbGFYSHZZY2k5QmViQVZH?=
 =?utf-8?B?cS9JV2dOVWczTnZtY0dCaU5GOGZBbW1GWkpHZFd1V3VtNk1LTUJjZmJVbGJP?=
 =?utf-8?B?NXFudmlzUVdWaTRENDlXOXBTbEw1NGFGSzBnTXhoT3Z2MXJmM0hwQ2x0ZDVa?=
 =?utf-8?B?emE0akR3eEtMWjJNQzdTRzVPNkdxNmJtK1JYS0JDaTBSOUtncEx5MzlSRmpo?=
 =?utf-8?B?TE82TlRqeGZNTWd4YWY0T3dFQ2xQbGVrQkVBNmRpNnJVa0pqb3dObXpDcGJz?=
 =?utf-8?B?ZUxLQXcxYndGdFg1QnNrVVYwanVtY1I1YUpCT0hNcG0zTUlRVFJzSVFoUU13?=
 =?utf-8?B?ZVd4K2tRRFE2Rmx0NDJzOHkwWXJsVllGUnNqTWREVFBOZzNJVUFvN3RPdUZU?=
 =?utf-8?B?Ui84UlJTbWhDZlFoSS81NUt0Q1l3ZTNoODFMV0d0bVZ2ZFdJTE8xZ3YveWk5?=
 =?utf-8?B?U2I2bkl6K0lvZzNWRlVVbWFLbnA5RmovWk1JZzFRQzI0YmlZZ21SWDFPdUtS?=
 =?utf-8?B?Vy91UDRIcVZLNFNYdUczNUpIR1V4S281OFNMdkJJVDBBNWxsM3hPN0RUb2I4?=
 =?utf-8?B?ajFqbXdiM3ZJNzhDYjVHVGYzQWtjMlczcGl2d1REQVRDT3o0Z1hWbS9FTVdX?=
 =?utf-8?B?UnFud3VYNUdRRVlRSzNmOVQwU25EVGJpRms1MXdpbzFMSmp4N3R3aXpkMHJp?=
 =?utf-8?B?MU1CaDNyQnlxSnpDalFzeWN2eWpYYXBoeFk0Y3lHbytOQm1OUjkwUjQrN0Jj?=
 =?utf-8?B?TitUMU9sdGlhN1NmeUNLZ29vcGVlQmpwdVBFa2NFa0pPUmd3QndMZVdlMW9Y?=
 =?utf-8?B?NFVnakd2WnoydmJaNTFoZWJ1OEJHUUdXU2tSV1diRng0b1BYWTJnalZkZ2RD?=
 =?utf-8?B?azNxd2V1L1VUbHlaWUlObjdYd2cvSFU3RnFpa1U0YjNzSXIzOUgrQ25NV0hS?=
 =?utf-8?B?Q1M3THNyMFlXMUkrS2FLZVJ2OUt4c3RtN1JSTVp1b3RYbzYvQllFWFlxbEEv?=
 =?utf-8?B?Nm9Dd1MzOEZJVHhnNlpMQzdJZHdjRlBUK0FvMFBVOUNPRHFmU3ZCN1ZKZGR3?=
 =?utf-8?B?b0k3dk5iczBGWktCZUg5aHl3dk83QUpKSXZ6Q3NqUTRvRUl4dE1iRkxjZDdp?=
 =?utf-8?B?VmhtMEVOREhHUUFNbU1SdXEwM01wZnk5SWxDRk9GYVp5V0V4Ukx4Qlpab0dD?=
 =?utf-8?B?VGhJeHdEaUJrTjhabHpZSmJ6ZlBCcTVObXZySEJJbllHK0F2QmpQbHRtOEtQ?=
 =?utf-8?B?d01qakJQWmg0dGJ3RDBybndMVWRJMCtXTzVQdEk3azlGd25DeEFreFJhb3ZQ?=
 =?utf-8?B?dFFMSDRJQWhtV3FTK3JvZVJuUFFOcTd0TDdCQ2JPUnJPa2VUVU4vYWRleWhp?=
 =?utf-8?B?dHpaQ1VMc3JTdEpZVVVRMVc0Tm01aWlaYk05L3ZWQVBHSlRwdFMvZGpjdlBH?=
 =?utf-8?B?V1dHOXZCLytsajRhaStHeElhY0xJNHd2eSs2WktwWUdreFkya1ZlMkw4RzV6?=
 =?utf-8?B?ZnhwRTlGWmF2akM5d1VWditqRXVuc0xnOGQwc1Z6c0ExYnlDRU5qdmhWQlJi?=
 =?utf-8?B?VEo0dStNSTVhQnVaeGZpVVQrMEtoUEx3d24xM1ZQQWorTUNaMjJzZzhQbTFw?=
 =?utf-8?B?ZHNSVUJYbmlNT2NuWTk3aFE4K2VtdXR0UXJnRXlacmpoNVpHZ1NuRUJLRVN3?=
 =?utf-8?B?Rlc2eGVSd25pQmg1bG5QclJtelpydzliQkV3R1pObW1Rc1l4RGphdU01UjFZ?=
 =?utf-8?B?M3VJL25hUWtuVFovaGtmVnJTL2xRcURxYkw3TGZoMDNIS2Q3cjZuUUw5dVdQ?=
 =?utf-8?B?RW9JeUZSeFM3L3pWbElPSFNydXllSDMwbjN1aE9GMHloV3BkS2F6cTJYcGNO?=
 =?utf-8?B?SWNWV3FwclpzQTNMckRsOXgydzVtd0F5RkhVT3lRYk8wTXdweWVzUXdtRTVj?=
 =?utf-8?B?NytCS2kxTG5QUUVVdkZhUW9rTHpHak94YXFNdDYyU2VjVmh3QmxNYUFQdm9K?=
 =?utf-8?Q?Ot8GVEb45Fi9tE4x/Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c04c03-5065-405b-eaee-08df33e49643
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:41:37.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1fP2TmBLKnJl5SwaRDLwgY1XS2y1foF+gv2lNyqlhnf2YpG5eEXSDanEBI+cyxu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552



On 26-Oct-26 9:18 PM, Mario Limonciello wrote:
> Bridges that need bus reassignment are scanned in two passes. Save
> the firmware secondary bus number during the first pass, before the
> bridge is disabled, and carry it to the bus created in the second
> pass. Drivers can then match firmware records against the bus number
> from before PCI bus renumbering.
> 
> The initial number belongs to the bus, so consumers can use the
> pci_bus value directly without copying it into every pci_dev.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/pci/probe.c | 9 +++++++++
>   include/linux/pci.h | 2 ++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..9950a9dd1db1f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1012,6 +1012,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>   	bus->sysdata = bridge->sysdata;
>   	bus->ops = bridge->ops;
>   	bus->number = bus->busn_res.start = bridge->busnr;
> +	bus->number_initial = bus->number;
>   #ifdef CONFIG_PCI_DOMAINS_GENERIC
>   	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
>   		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> @@ -1232,6 +1233,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>   
>   	/* Set up the primary, secondary and subordinate bus numbers */
>   	child->number = child->busn_res.start = busnr;
> +	child->number_initial = busnr;
>   	child->primary = parent->busn_res.start;
>   	child->busn_res.end = 0xff;
>   
> @@ -1470,6 +1472,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>   			child = pci_add_new_bus(bus, dev, secondary);
>   			if (!child)
>   				goto out;
> +			child->number_initial = secondary;
>   			child->primary = primary;
>   			pci_bus_insert_busn_res(child, secondary, subordinate);
>   			child->bridge_ctl = bctl;
> @@ -1491,6 +1494,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>   		 * do in the second pass.
>   		 */
>   		if (!pass) {
> +			if (!dev->secondary_busnr)
> +				dev->secondary_busnr = secondary;
>   			if (pcibios_assign_all_busses() || broken)
>   
>   				/*
> @@ -1529,6 +1534,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>   			pci_bus_insert_busn_res(child, next_busnr,
>   						bus->busn_res.end);
>   		}
> +		if (dev->secondary_busnr) {
> +			child->number_initial = dev->secondary_busnr;
> +			dev->secondary_busnr = 0;
> +		}
>   		max++;
>   		if (available_buses)
>   			available_buses--;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5ffcf5ce8c966..75a5fd2374acb 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,7 @@ struct pci_dev {
>   	struct pci_slot	*slot;		/* Physical slot this device is in */
>   
>   	unsigned int	devfn;		/* Encoded device & function index */
> +	u8		secondary_busnr;	/* Original secondary bus number */

This doesn't make sense for end point devices. Is it possible to keep 
under bus itself?

Thanks,
Lijo

>   	unsigned short	vendor;
>   	unsigned short	device;
>   	unsigned short	subsystem_vendor;
> @@ -724,6 +725,7 @@ struct pci_bus {
>   	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
>   
>   	unsigned char	number;		/* Bus number */
> +	unsigned char	number_initial;	/* Bus number before reassignment */
>   	unsigned char	primary;	/* Number of primary bridge */
>   	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
>   	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
> 

