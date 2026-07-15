Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0587C47DF95;
	Wed, 15 Jul 2026 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120092; cv=fail; b=Dw4+rAA+VjwEqi9Xu/p0zNdij3DCbWCDY468XUerI84j0d5mGugmsOVXLGPmh4CR1BU2ct4CRjE8TzFr+ZO6ql3rUV5kidWb7gUO/oxuwki3qGaVSZl2PUzGi15d9LuPFuzWdkuxbrk3JRd2U+LvV4fEz/iQ51bncOc76gSeCO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120092; c=relaxed/simple;
	bh=+kiJHZ+2kuzlDWDiSRxtFe7NzzCUJ+wlYlrK2HRHG9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OmqU0Ozr3P/ZQuAwXh+dj6f4E56z2VB8Lilqa/LsUjz9M4ETpG6ItGWaG7VvipTKK/WGATY0j1kVWcndyU4XtaaQLP2bq+LNkF/COlZb4x6b3nF0n0s90+AGCqBs16GDek2vDf44SABQENf7gGh+bG1GH4NBCqUYyuu4az40PN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vakjvsVp; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vakjvsVp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAhdRJ7lq25P5I/frjTD+GjY/cBHnOWz/MdlEV30YIsAs/hvJxC/k/z7Xap3kZZy6mSlwu4TCvpNVL3lAcRROCJjYwYM2YYEsNy8VUrAti4dWJIxLYQvaaGOctzXGkTtUoPzacKawy8FzDY+eYNyvw55nw7bVGaDLtfFVzOKBVs1p4gFFDyM2Ek7uJk1KKA0t4Yc+pDst1mKyzGzYbZiC4eXiwGujlJC/6MIyovvuR3exIsZMsFgsPj7li5vyEsF/f6ncQH99eIzsc9yxT/H5vfH6V2Oas//p0bGPsEtEHRSioT5XvkTSPDDR8be5XX8d7IyCxTtMQHJZJKP4NlPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/Q4G9Ruh4wSL/WA21+H2zyYxJea+iP5vpmhAhUe8/E=;
 b=Cc16b0stU6DTMYPTRdyvxN6cO2LwtbsALcxRBypGmGfL27wUPRREVm4EDnIpdOYl05E+DaAutz62QWDjyU/IQ1r9NriH/6aiw/dsbkEZ5xZbqcoStqo+3PZeTcHPZSNgVRCdRsMSsO/iX7wT6JOqVDUgxE9NQlGQyHNtNNBQIB+3RFuL4uosnUQReKGjMqQUaaQZxxDSw1lUpzSThJ8ETbnKzI951ugEe/KGNWHWGaj1hJE6Fp1zVD6VH7cPwiGP1riVxXGjXifWx9wSvDfqQJFJn+wro8uPosF3R94PNkxa0QwC9E90iNJ6kX/4HRJZZ0e/yqMj2W/lmU9grs7Jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/Q4G9Ruh4wSL/WA21+H2zyYxJea+iP5vpmhAhUe8/E=;
 b=vakjvsVp2jfYZATaPaCwVVjXbR+ygwnmE2xYk6tH8/PFchJE2pyB6nVSarEq0lXnmBORhc1qhbGNvLXhjI3PLhlOZrB4AaO+eGuQlj6rF951q3BHZt8CdysZb6MjPO45e3IyB1Fb/TaASWaleFYTwh4agwJYcs3hhYdKN806JX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 12:54:44 +0000
Received: from CH1PR12MB9717.namprd12.prod.outlook.com
 ([fe80::b26:bd7c:5076:9cd4]) by CH1PR12MB9717.namprd12.prod.outlook.com
 ([fe80::b26:bd7c:5076:9cd4%6]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 12:54:44 +0000
Message-ID: <4d582140-72a5-47a8-b99e-125e7f0f743b@amd.com>
Date: Wed, 15 Jul 2026 18:24:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup
To: Rosen Penev <rosenp@gmail.com>, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260715011142.1261469-1-rosenp@gmail.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260715011142.1261469-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0064.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::13) To CH1PR12MB9717.namprd12.prod.outlook.com
 (2603:10b6:610:2b2::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9717:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 1077d3b7-15b3-4c69-6e10-08dee2703e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rXbjGQvQkO6ujefLw82P53TepYHCYkV6WBSlSV9zeuP5r4j1y+Zf9X3puYiA0lCDFRA0gaqI8fgfrl0sAJrv56isAMtE05QNmCy9Xbb/hMqghfEjVbQpxQv+ZkqrhVpXaOZbbFgtU+DwAW9/VvKGuqHBTVWnNjaCyAKld1DCeebLU6G3KNyV67NdEezPcuznO3OCYPNyBSCfasy9iETz+SwKqstefi5UPh06i2bBbzme/rrilNOZUPM4NuWWRuN3opqBbQcPvTeI7XAJs3U5EF+XkTowg1ooA2apCg5GY8q17p5trqi0hKk8AL65KZLo7cumWhVaj8ch/KGN6YamKK3mckRkgE3bIN+Ew96CB+ORXs5WWpr4dZQlahsn21gjdRmWOSA4t8UVG8PIlZfuFMYVa0JXwp/SQPXMOC111WZrrJOYYZ7bBSHye4qjmMxevtqBQi4h2Br5Hp2ajrOh0qBwPAoZrrEIPIC6udfbB1BdunWmlAXWZLwbaL5O4CS/N6rrmVIo02UIClinLeJ0EeURSEUadkCT6YaQ8Fg3BG0k7I57HbEvGk8qbv4CJ5Roh4gyiAdyKopDU988OcRrLpjZkKcnCB9G/SsQlT5hUPhEPrFUmAFpLCJ/QREYm71aT36xoM88FmWeGh8xZGfftxKVdJdoaSh/YvR4PxwbeWs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9717.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU92YXVCdXVzZCtoVktYUXNTL1ZoRFZKbHV3NERjNTd5VDRTQnkzTU1SSnJN?=
 =?utf-8?B?K1NmN3RTbUFVWkVCSGRxMHVVSmRjd3JweC8rZFl5bUNRdVhUQlA3WjBycGVx?=
 =?utf-8?B?WVBRVzF6U0FCWmRmdDliTmNGRUdpVFZ3ZnVkaEh0TzhYekFtK3lzUURpN3hL?=
 =?utf-8?B?Y2l3Smttd2l4ME5NV3I5TnRkZGYyeVo5MHNFZ0ZndDBxRUdFb3lwRDQxQVVz?=
 =?utf-8?B?bzNHeFNPSlMxZ2FBQVJVUE14bllPenhXc1doWUtiRHpaTVB6ODd2b0swM0FU?=
 =?utf-8?B?VnNEMVhSSmpFKzlucy81WisxdGtQSndLZHJDU0MvOUhZM0pKeTJPakg0aWJ6?=
 =?utf-8?B?QUltVnkyMFBWSkltN2dTL3BWV3lwZm9jeHc5WlNwZ2ZIbjN0L2RXRGZaVDVO?=
 =?utf-8?B?OXVGNkpMRStaWlc3ZDVIaUx5OUNoa2Q4S1EwNXFjRTlNbTArbXErcGkwTW1n?=
 =?utf-8?B?SEsvcmlRZUdZNXU0TkRyY1RiOFVMNnM1RjV6ZE80OXF6Q3dzTHVGWVBJU055?=
 =?utf-8?B?cGM4UWtmeTBQUG9QdnM0Y3YwRmpnSWMwTy9wVVFOWmczSVJZQU1HWXVrRita?=
 =?utf-8?B?Nm9VWVlGalFzQ2pPaXFYOXZITHlPV24xVUF5Qk0yOVlxVWtEN3RlY1pMMmpj?=
 =?utf-8?B?N296ZEpsWVFBUFgxaVR0dFZsaXBGSnVvMWgyZjdTTUM3MExGbjdmdTJ5N3cw?=
 =?utf-8?B?MFdDLzZld1VMOFZNRUtOVDU5RDN4RkM3UVZ3eEx4M2ZROEt2N3NaWnM3MXZV?=
 =?utf-8?B?VEFFeUxrbFRDZ1kvYXlCWkZuQ0o5TVpaNmcwUXdwUm44TlpsZjhydWhFdk9s?=
 =?utf-8?B?dzdDeGFMK0RRVkVsc1lBZXN1N2hTMVZDbDJ3YTZQSEpXOGxmOG0zdTBsNk8r?=
 =?utf-8?B?eVgxeE9qWnpRdHR5U3NlekJoTjZJd0l3LzBJZjZaa2gvQnFmWHk1blhrU1pk?=
 =?utf-8?B?aU56RHNtODl2bUgwcnlMTElZOGZ1NEowd3lYUkhOdzc1UW1xK2JOckx6RTBE?=
 =?utf-8?B?UXFNd3hud0lJMmczWklLYnNCbWJla0ZDUWk5aUhUUW14Sy95Sk82NFduSEdC?=
 =?utf-8?B?QTVoSGRicXM3eks5MzZ3K1BqaTRVc2VnRlNKM21KZHU2TUtqYU9lN3YyLzh4?=
 =?utf-8?B?UVpMUTZqTkJsRkFCVXNDbm1DOGhUR3FidDlONmRQN1lPL09ndUpUWHczU3d5?=
 =?utf-8?B?Q3AyU2lhZGVuTTJaRHk4bndwM3ZhUHNyV3RDWVA3ZXJtMTJpMmt1M1NLell2?=
 =?utf-8?B?eGErU3M5OFdVLzdRMmZpK3hYSDJWeERSN3lCYVZzNkdIZW80MHBBSkREYXVv?=
 =?utf-8?B?MFRvSkpiYWwxTEoydHRaTi9XbENFODFWVGt6Q2RPZXBBdVduWlQxa2hJUEZs?=
 =?utf-8?B?Skc0OXFXbEVWVlBUeUFCcUN4b3krSWI2c1Nsb1JlRjdFSURrU3MxU2xwQUpT?=
 =?utf-8?B?bW1iRmZnK0Y2SUp0UUFyaFFWWVNYZ3JWZWYyaytDb01acWNDQTRPeHZWL2VG?=
 =?utf-8?B?UlhOczhlVzVmRjRRelIvN1YvU09hektCMGc0YUZKR1pXMlNFeVM5VG9HSDJH?=
 =?utf-8?B?SjlHWStENVNybU5mQmxzNEtsWkYwaktYMTV2d1FPSnRYalRxdk91NFF0a1k2?=
 =?utf-8?B?R1QyWHFJd3hGSWJQSFhtNU91TWJFdElXeEFrZ3RRTGZDY0xSNVZGdWg3Q0Nu?=
 =?utf-8?B?TkJXbitqdWpGNG52Qzl0TGFFM0w5Q0NGaGhEYTlsTFJjNy9ET0dvblg4Ny9h?=
 =?utf-8?B?c0h4R3NhSExKRjAxVHpKa0M3T1VScmNmUm9oQ0tuVWVhM0tmOE1PYmsyMTFy?=
 =?utf-8?B?UG9QME1UNW9IWnVYWkFseFNmbEdDRGloTzdjTFBXd0FKcUJHdTFQdVdTdEVr?=
 =?utf-8?B?OWZ0T3JxeVRqbzBLeWJoOWlhNmVMdldXMWd2UW1PKzJxNDJpcGRpYkhEemhX?=
 =?utf-8?B?ZGs4K2E0V05mUjUzWGFlSW5QV3drTkgxd0VUUCs2OCtuOUx0MVJFbUgyTWJJ?=
 =?utf-8?B?MjZuMVZyaXVlejlZT0ZoVGJpZ3dBN0dtVDVOMy96c0lqMkNBZDZUem4zQjV4?=
 =?utf-8?B?Vk1aMmpFZHRnSnEvdmc0NzRxcmxZNkJ1KzNoaTBxN1pRSGZOMGl2eXl2dzhr?=
 =?utf-8?B?ZHhnZmV5SjdSTmNqbkRrVllqVGd3cDE4VFhqbE13ZGIzd1djcE5UdU8vWnly?=
 =?utf-8?B?MlBlRWpRT1g3ZTZHTXlrTFN6akF2SmNFdURuV0tDNDViYklFQ2tGekdvQXVM?=
 =?utf-8?B?K3M1NklhSlY1OE9BdmRNMWdnRndzYjNRZG9JVkpIcmVxWjZXcWNoODBLUVpT?=
 =?utf-8?B?NTJVTjNnZVNEblZJQm1MOEtKQ3RYVnlaNCtmTWsybmpUZFFPTUlBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1077d3b7-15b3-4c69-6e10-08dee2703e3d
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9717.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:54:44.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqpoTgjRaug1EjqJGC7a2FPVDwdhdSp87Yl6WC9Ij4iKVjxBBnKpG2+19s+tGi9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367

> Replace irq_of_parse_and_map() with fwnode_irq_get(dev_fwnode(dev), 0)
> in xilinx_pcie_parse_dt(). For an OF-backed device this is equivalent to
> the previous call, but uses the generic firmware-node API.
> 
> Unlike irq_of_parse_and_map(), fwnode_irq_get() returns a positive IRQ or
> a negative errno and never 0 (it rewrites 0 to -EINVAL). Store the result
> in an int and check for irq < 0, returning the error (including
> -EPROBE_DEFER). This also adds the error handling the previous code
> lacked, where irq_of_parse_and_map() failures were passed straight into
> devm_request_irq().
> 
> Built for ARM (multi_v7_defconfig + CONFIG_PCIE_XILINX) with LLVM=1;
> drivers/pci/controller/pcie-xilinx.o compiles cleanly.
> 
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/pci/controller/pcie-xilinx.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 4aa139abac16..a7b069f7673a 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -20,10 +20,10 @@
>   #include <linux/of_address.h>
>   #include <linux/of_pci.h>
>   #include <linux/of_platform.h>
> -#include <linux/of_irq.h>
>   #include <linux/pci.h>
>   #include <linux/pci-ecam.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   
>   #include "../pci.h"
>   
> @@ -535,7 +535,7 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie *pcie)
>   	struct device *dev = pcie->dev;
>   	struct device_node *node = dev->of_node;
>   	struct resource regs;
> -	unsigned int irq;
> +	int irq;
>   	int err;
>   
>   	err = of_address_to_resource(node, 0, &regs);
> @@ -548,7 +548,10 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie *pcie)
>   	if (IS_ERR(pcie->reg_base))
>   		return PTR_ERR(pcie->reg_base);
>   
> -	irq = irq_of_parse_and_map(node, 0);
> +	irq = fwnode_irq_get(dev_fwnode(dev), 0);
> +	if (irq < 0)
> +		return irq;
> 

Thanks for the patch.
Nit - as Sashiko review mentioned better to update xilinx_pcie_probe() 
to use dev_err_probe() to avoid noise on defer.

Rest changes looks fine.

Thanks,
Radhey>   	err = devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
>   			       IRQF_SHARED | IRQF_NO_THREAD,
>   			       "xilinx-pcie", pcie);

