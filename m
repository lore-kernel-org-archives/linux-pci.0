Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87E3AA9DA
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486813; cv=fail; b=M9B/L7IxI3Kpr9KzMzmi9bwZVdeQ6CUnJLdUmrYOI+YEPZ/sMJYmYrfwRvBnQqzkhDLEkl8FBS0VKgTLR5raUTYmWwMNVij1SlVrBVW8a+Qi2BKQb30po1qaTyQ0EDGc80iJdFShRHbI3pptRgW7CMlaMoSX10dSs/qjoIH6mXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486813; c=relaxed/simple;
	bh=Al+NmnjVG43XuRtbKMeKBkNtfQ1QqwIugH4gWkxnfYU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gsKbD/4oOYuflFD0mMCyauuO0RoCXldXlQL0LMlnrnQfSKBGIKtj4QRODVzLVdNqQK+M9RlHH61NABOqqXXRBNjD3Jm33OH2ENqUlnsnK12nCb9ZpdLP8REXDVF+Oa7INM4zmnBJR3YKxxOoeFhPaFRtorLcCyaBLL01dKw/cL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=onvfa/Me; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="onvfa/Me"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKmFNtmo13C2LtlCqwXakfIKjpVg2t6qSXZldHxvBZKgFCb8cg6fUBpTb2XM1oQAr5ObVshyxFgop4zUpJuKyfRnz7dT+zArgqh6o3KqI7eg0dkIjIy5g3PdnVeuiKMploPudr0b0T/beqegXN8GMDmOreKPAEbbt7kHFB0FpIdc2z3T5pfx1hmmPTTJTHlbjgfee3gRItdX3w8HkANh8jPWZFmwGErz75qNKhH5OrbShPoKfjyN4Ro87U7hKheq2GqiUyR+aBTZppfNTJIWQmKbZaVjgzgqZ0gLL8s5KTP4IpXu07mFxl44Mp6/DXbfJaGmZ5bBEQIgs1SOSQrR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcxSrSJs9LA8hG42e7dMo+31TEtCLJ1l5R/TSDbYaLs=;
 b=uxAFLVZh4AsqAh0qmpx/T8C/JNTtnJ1WP+f5f8fYKcbC/kmk0jD3Wm4YtBq8JwXJz6kgdNdYTTD/ccrkkk7V21DddcZl6kdJH26reCg6ByRQDdFGE6NZssps6r5O3/TaVpO+Ur4d0+TjZZNSKWilQTl8fQXv+zzgFd2Vqz9zQia2bD8FUmuz7IH0UPK/pICMeAm6v15H6iOHqPhquV7aDhyjspO0qhVk8F+NBUfeLQEtuxTiTpI5ovLyFKj/ntpIvho6h5Dw2duNW3x8YhhIhQtAd+TM79Lm+A73vINpVtYBtojYDXBkFuLKvVR/BzhO+Zy2954MGUftJGU5mK0dQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcxSrSJs9LA8hG42e7dMo+31TEtCLJ1l5R/TSDbYaLs=;
 b=onvfa/Me/X8B3GgC2mVD+0+HJM1LLoZ90Z5kr2GtZy9UrcJgnurnMiuu7uOoDkFlbFykDiPR7uxXSQR7keMq3xQwPiCHdSgQFxaODfFejwcqslzUtOlNntCAlUlhylaLjBjXnxNHJYKPDLorICvyYZZA2eU+r9aAkbaakJxLTYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by PH8PR12MB8607.namprd12.prod.outlook.com
 (2603:10b6:510:1cf::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 05:00:07 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 05:00:07 +0000
Message-ID: <e42b9ef3-a177-4e38-8aad-c3f4061f1b64@amd.com>
Date: Wed, 8 Jul 2026 15:00:01 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] PCI/TSM: Add device evidence support
To: Dan Williams <djbw@kernel.org>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
 ankita@nvidia.com, Bjorn Helgaas <bhelgaas@google.com>,
 Alistair Francis <alistair.francis@wdc.com>, Lukas Wunner <lukas@wunner.de>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-7-djbw@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260705220819.2472765-7-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0052.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::11) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4ac87a-f5e9-4683-d95c-08dedcadc7a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iYIrI/PteinfhMBkLrvXEWLKDUz2PFmoJwJj2A68nVs73HCtPJeM6sZ/YiyuqEFmrvC2hKeTR86ScZilxneEIU9wExI8+bVdz5DJtF+DioS9iK1GVkCKrkExJUnKcET23QbJp79ncZB6cCYNZ4W52APoviMXW3XTPoCTtu6d7yoHlRW7SUJJbTSxFcPM9V5/EZJVJONt9QJiM12j8M1xjSbHDtnR3GyjFXKPZKrY3eD+JpAfv4JU0oVRLdaxVM5zP6cIE5TfjOw+yPaGR9GskGNR4SIkE9yHn1MluNIztBB2Cox9N+jXyHSFvGeOiL2sTYUya/bQEC6RHpqH8xDQty1/T4cjR2iBWKhyFgE9B1qOBcvHZWA1LTgwZ51exYDpGu631PLMpS85sm86sSo6XhnuuMF/vjsUW1CCvA/f3vWAK1lzFHnjAiw1Rp2QEhgVZAU+DJlNFclQpLN5+zv5EoJIS+4c0XoTfyQu/IgsaixjDd0ioLnmjAONP8v9tpwAVR2tNmSrNpDhNIGfXOu8vxEKQ0nIrXWqKr5Gy9Q7OiRFI0rAhmlBOotmOrFP8ePiehgGmZzjbafdDHsGrNFFDJW2WDmT5o7E4jZsOV93LLBuWDbxKs80kFbKDFtodmOYNgioTdXeKDHrAZhofFKM+x9Lq6vKQIMAjqpA6pmlO1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWd2bVV3c1JsRXdsZFRKYTNLZnRmTU9YWktGQ2NNWWNOQy9UdHRTU0Y3YkVD?=
 =?utf-8?B?SEd5aXlQUURLWXBjMmF0OUhoRkVDckxBbk1hRVB2U3dpMC9jV09sMEhOYXph?=
 =?utf-8?B?OE95YnVTNGlhYzdWYUtQM2NKNjFlNlRjOXVxTS9GalYrNUFQMGpBSU4rQlhZ?=
 =?utf-8?B?bHFBeW5sQm5zS0tHVEZoV2hEWERXS0VrS2VJcW9rbXBHZjRBbHoraXZDQ3BT?=
 =?utf-8?B?VlVwM3pMblBLWXIvMmNrc3FMRXRPMWFyV2NMYlI3OTE4amloem1XUktXeHBJ?=
 =?utf-8?B?dDJLR29La0pkUFJuRy9GMDAyTVRyVllIVkRIVVdVbitEMUIrQ1BFZzdBblJ0?=
 =?utf-8?B?WEw1bDJqeWNsMlpPM0hlUXFaSk9lM2tqQnRCYWR1Yng2Q0FUOU03dlFWVHJ1?=
 =?utf-8?B?WW11M3dvMDNWTWlFSUtYTHBsRGFMeWdKckJ4WG12aEttWWhCamZpZlhLbkJL?=
 =?utf-8?B?ZTNKRVR3a0x3Z2Q3NjV2aXlNZVFaSkF4VzVEL0R3YWJ0QzVCSVNJWHBQeHls?=
 =?utf-8?B?dGtFbWhCaTFybVkxbDRCby9qTE91L3RhRVNsQ1FBbjR0NDFGdVAzWnVENnZ3?=
 =?utf-8?B?bVUrejhteWwrWDN4QkVGdFVjVHVuaXFJcy9rWThhOUhKTExkOTlnaDE1L2VT?=
 =?utf-8?B?WFZueWxHc3lYcTlqbGxEWTlTWTRPSitJUmQvVUpVVjNkblhneC9OZFhjRGxJ?=
 =?utf-8?B?d1UrWEJyYjYyRXJEaXRmU0xSSVFRV0lzSGJId1d1QWlEVjdrWEt5ZHNVZkNl?=
 =?utf-8?B?K1Z1VjJNS3h5TzNPeXBrdzNSU1Q4Vko5SlE3T2I1M2tHVW1uNEJMd2JlOHdM?=
 =?utf-8?B?QjZaaDBwMTVxdkU4eXdBZjNhMnoyNm1BalJqbkZCYVh1MmZ1dzRtSm9iMC95?=
 =?utf-8?B?RDVvTkJKQlNvKzB5ZlYzcWxDWWo3TG9jMis5aU53R2N5UU9EY3ptSStXUXYv?=
 =?utf-8?B?ZDFiVlpVQ3FnUEVkUkJ1cmRxTEZqL1dpSUZMaXhEdzhvQWFPZThGQi9wemh0?=
 =?utf-8?B?MWpzY0JvK1R6YjFpMVhjbk9oOE9HLzFXbUlGWGY3MXU3Z1R2cEV0d3dvR3JZ?=
 =?utf-8?B?bXRjN1ZrbTJsRmp5R2RXR1I3UVpBbGhTOE1UaDlKL3ZFZnN2R1AvTXI3cVNC?=
 =?utf-8?B?bzhxQVJHM2ViQVhvT3NlZzhnOGlYNmxGRGowL1VwOUlReWZpbHVlbW14KzA0?=
 =?utf-8?B?N0JMRGtjN3g4US9SMmhKclIvMHlrYmJxa0MvMXhTQnVqL21TOTJpbUNIZTVt?=
 =?utf-8?B?WG0wa0JCaVJ1MWpHTUlMTm8xRXprT1ZEWlRyVGlxMFRpRDM4MWVrbklPOU51?=
 =?utf-8?B?bXBFbm1mQjBSaURxMVVhVWdBbUg4bXhOR05NTXMwa0Y2eENUT09HSFBwcFZx?=
 =?utf-8?B?V2UvSDVsZmRsTUZOZ0tuTjZVUVlhTVp1ZXBSYkVMUElUNWo5SXR1VjBnM3J4?=
 =?utf-8?B?Mlc0Q0QxN1Bhc2xhejg5SzdGWW9qZCtLS1VPcEFxSW12Q05ncHlEb2dRRWI3?=
 =?utf-8?B?bDBYaHhFa3IwdjZneXRUc3d4MDZINHFPRUsxck9MTWNSUjNzWUthOWRwYjRh?=
 =?utf-8?B?U0FyS0tkSlJyWndsMVcyeUpEbnFscjZJbm1yUGdvMEhTTHVJRlZqY2ZYbmx5?=
 =?utf-8?B?RU9GRWJZaG9EVEttTXFaZms4ODJRU0FXOXRPODZNSG0wZ3B3Q3Jncnk2bHIy?=
 =?utf-8?B?bEhCcElQS1VOUGZ2bTRPR3U2SGpsVWJYNmFzTVhpdTZ6WXNtZE56YktIY0ph?=
 =?utf-8?B?Y2IvUlJoWUc0WHAxbmtyclNjS09CUGdObVI5UUNvQXUxbHFENEo5dk1SNU00?=
 =?utf-8?B?Nm5VakpzcmlDY2R3NmN2YWJBRkF5OUxybTc3LzUxQzNpdGlwenZyU1QwaU1w?=
 =?utf-8?B?dE9WQkcwTjhRYUpFTVYxU1BYZWc5Wks2bTZXQTRqMUZBSGV0M0gvN2VIVUIr?=
 =?utf-8?B?R0srQUlHcGJ3ME8wWWlidjRTaG5wVmsvWGlkODNpcmhFbVhHRWNaZXlUYUlX?=
 =?utf-8?B?Y3M2S0VudlA3UlN1QVpROVN1YVRrdGliMml1NnpodC9KRUhieGJ5NkttV2lz?=
 =?utf-8?B?UzRFNUU0VlA4ZE8zT0xiV3M5ZGcyNDN1WTJTWHJaaitmYXhzcFQydVJMM3g5?=
 =?utf-8?B?Yno5eTFxSjZIK21ENmIxbjZRL3hGQ2JYRTd3QVNoSVgvQWhBc0dzZEZTd3hC?=
 =?utf-8?B?eWU3S0w4ZllpNk9PMU5ZYjdHMTlidjIybzk3M1ZPS3BaUDF4cC9NdVkyZEZM?=
 =?utf-8?B?Z2JHaGg5RHFoY2ZacFkrRk10dGhkaytydGJ3ZWNsNWlMVThqa3diTXhTc0lr?=
 =?utf-8?B?UzlUdk9wS3AwNHlhTVJvR21lQ0VTdmU3eFd3M21lY1pFdEtYK0Yrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4ac87a-f5e9-4683-d95c-08dedcadc7a8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 05:00:07.2768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/KJodowpb6NLpbxXAaEqqALq4EGo3ghr6GJynBhWkk9JTIOD+ejrkOvuAUdVJ50fwAFC0SLpK1YhSDbbo58+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

On 6/7/26 08:08, Dan Williams wrote:
> Register the PCI Trusted Execution Environment Security Manager (TSM)
> framework with the device-evidence netlink ABI. The security operations
> that PCI core coordinates with a device security manager (DSM) through a
> platform TEE security manager (TSM), builds upon the SPDM protocol.
> 
> A TSM owns an SPDM session and publishes the corresponding evidence through
> TSM firwmware ABIs. A low level TSM driver is responsible for creating a
> 'struct device_evidence' context and carrying out refresh_evidence()


a nit: so it is really refresh_measurements() as it won't refresh the report? may be call it so?

> requests for regenerating measurement transcripts with a nonce.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> ---
>   drivers/pci/Kconfig               |   1 +
>   drivers/pci/Makefile              |   2 +-
>   drivers/pci/tsm/Makefile          |   8 +++
>   include/linux/pci-tsm.h           |  14 ++++
>   drivers/pci/{tsm.c => tsm/core.c} |   9 +--
>   drivers/pci/tsm/evidence.c        | 110 ++++++++++++++++++++++++++++++
>   MAINTAINERS                       |   2 +-
>   7 files changed, 137 insertions(+), 9 deletions(-)
>   create mode 100644 drivers/pci/tsm/Makefile
>   rename drivers/pci/{tsm.c => tsm/core.c} (99%)
>   create mode 100644 drivers/pci/tsm/evidence.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0c7408509ba2..ed17b5d2d5ae 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -126,6 +126,7 @@ config PCI_IDE
>   
>   config PCI_TSM
>   	bool "PCI TSM: Device security protocol support"
> +	select DEVICE_EVIDENCE if NET
>   	select PCI_IDE
>   	select PCI_DOE
>   	select TSM
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 41ebc3b9a518..211f195ff2c9 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,7 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_IDE)		+= ide.o
> -obj-$(CONFIG_PCI_TSM)		+= tsm.o
> +obj-$(CONFIG_PCI_TSM)		+= tsm/
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/tsm/Makefile b/drivers/pci/tsm/Makefile
> new file mode 100644
> index 000000000000..fd7ac2e862f1
> --- /dev/null
> +++ b/drivers/pci/tsm/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the PCI/TSM infrastructure
> +
> +obj-$(CONFIG_PCI_TSM) += tsm.o
> +
> +tsm-y := core.o
> +tsm-$(CONFIG_DEVICE_EVIDENCE) += evidence.o
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index a6435aba03f9..8bc16029d31e 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -3,7 +3,10 @@
>   #define __PCI_TSM_H
>   #include <linux/mutex.h>
>   #include <linux/pci.h>
> +#include <linux/rwsem.h>

then this file is missing extern struct rw_semaphore pci_tsm_rwsem;

>   #include <linux/sockptr.h>
> +#include <linux/tsm.h>
> +#include <linux/device/evidence.h>
>   
>   struct pci_tsm;
>   struct tsm_dev;
> @@ -18,6 +21,7 @@ enum pci_tsm_req_scope;
>    * @devsec_ops: Lock, unlock, and interrogate the security state of the
>    *		function via the platform TSM (typically virtual function
>    *		operations).
> + * @refresh_evidence: Common operation to regenerate attestation objects
>    *
>    * This operations are mutually exclusive either a tsm_dev instance
>    * manages physical link properties or it manages function security
> @@ -75,6 +79,9 @@ struct pci_tsm_ops {
>   					struct pci_dev *pdev);
>   		void (*unlock)(struct pci_tsm *tsm);
>   	);
> +
> +	int (*refresh_evidence)(struct pci_tsm *tsm, const void *nonce,
> +				size_t nonce_len);
>   };
>   
>   /**
> @@ -96,6 +103,8 @@ struct pci_tdi {
>    * @tsm_dev: PCI TEE Security Manager device for Link Confidentiality or Device
>    *	     Function Security operations
>    * @tdi: TDI context established by the @bind link operation
> + * @evidence: cached evidence from SPDM session establishment (connect), or
> + *	      TDISP bind (lock)
>    *
>    * This structure is wrapped by low level TSM driver data and returned by
>    * probe()/lock(), it is freed by the corresponding remove()/unlock().
> @@ -112,6 +121,7 @@ struct pci_tsm {
>   	struct pci_dev *dsm_dev;
>   	struct tsm_dev *tsm_dev;
>   	struct pci_tdi *tdi;
> +	struct device_evidence *evidence;
>   };
>   
>   /**
> @@ -216,6 +226,10 @@ void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
>   ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
>   			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
>   			  size_t out_len, u64 *tsm_code);
> +static inline const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
> +{
> +	return tsm->tsm_dev->pci_ops;
> +}
>   #else
>   static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>   {
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm/core.c
> similarity index 99%
> rename from drivers/pci/tsm.c
> rename to drivers/pci/tsm/core.c

This move + related makefile changes + exposing pci_tsm_rwsem are better be in a separate patch. Thanks,

> index 5fdcd7f2e820..220842df42bc 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm/core.c
> @@ -15,13 +15,13 @@
>   #include <linux/sysfs.h>
>   #include <linux/tsm.h>
>   #include <linux/xarray.h>
> -#include "pci.h"
> +#include "../pci.h"
>   
>   /*
>    * Provide a read/write lock against the init / exit of pdev tsm
>    * capabilities and arrival/departure of a TSM instance
>    */
> -static DECLARE_RWSEM(pci_tsm_rwsem);
> +DECLARE_RWSEM(pci_tsm_rwsem);
>   
>   /*
>    * Count of TSMs registered that support physical link operations vs device
> @@ -30,11 +30,6 @@ static DECLARE_RWSEM(pci_tsm_rwsem);
>   static int pci_tsm_link_count;
>   static int pci_tsm_devsec_count;
>   
> -static const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
> -{
> -	return tsm->tsm_dev->pci_ops;
> -}
> -
>   static inline bool is_dsm(struct pci_dev *pdev)
>   {
>   	return pdev->tsm && pdev->tsm->dsm_dev == pdev;
> diff --git a/drivers/pci/tsm/evidence.c b/drivers/pci/tsm/evidence.c
> new file mode 100644
> index 000000000000..ffb08208f0c0
> --- /dev/null
> +++ b/drivers/pci/tsm/evidence.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2026 NVIDIA Corporation & Affiliates */
> +
> +#include <linux/device/evidence.h>
> +#include <linux/init.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/tsm.h>
> +
> +extern struct rw_semaphore pci_tsm_rwsem;
> +
> +static bool evidence_available(struct pci_dev *pdev)
> +{
> +	return pdev->tsm && pdev->tsm->evidence;
> +}
> +
> +static struct device *pci_tsm_evidence_find_device(const char *name)
> +{
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if (ACQUIRE_ERR(rwsem_read_intr, &lock))
> +		return NULL;
> +
> +	struct device *dev __free(put_device) =
> +		bus_find_device_by_name(&pci_bus_type, NULL, name);
> +
> +	/*
> +	 * Bail evidence gathering early if we know at this point that
> +	 * the device has no valid evidence provider, but still need to
> +	 * revalidate the same in pci_tsm_evidence_read_begin().
> +	 */
> +	if (!dev || !evidence_available(to_pci_dev(dev)))
> +		return NULL;
> +
> +	return no_free_ptr(dev);
> +}
> +
> +static struct device_evidence *pci_tsm_evidence_read_begin(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct device_evidence *evidence;
> +	int rc;
> +
> +	rc = down_read_interruptible(&pci_tsm_rwsem);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	if (!evidence_available(pdev))
> +		goto err;
> +
> +	/* Hold the evidence stable against conflicting refresh updates */
> +	evidence = pdev->tsm->evidence;
> +	rc = down_read_interruptible(&evidence->lock);
> +	if (rc)
> +		goto err;
> +
> +	return evidence;
> +err:
> +	up_read(&pci_tsm_rwsem);
> +	return ERR_PTR(-ENXIO);
> +}
> +
> +static void pci_tsm_evidence_read_end(struct device_evidence *evidence)
> +{
> +	up_read(&evidence->lock);
> +	up_read(&pci_tsm_rwsem);
> +}
> +
> +static int pci_tsm_refresh_evidence(struct device *dev, const void *nonce,
> +				    size_t nonce_len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct device_evidence *evidence;
> +	const struct pci_tsm_ops *ops;
> +	int rc;
> +
> +	/* Sync against disconnect */
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	ops = to_pci_tsm_ops(pdev->tsm);
> +	if (!ops->refresh_evidence)
> +		return -EOPNOTSUPP;
> +
> +	/* Sync against pci_tsm_evidence_read_begin */
> +	evidence = pdev->tsm->evidence;
> +	ACQUIRE(rwsem_write_kill, elock)(&evidence->lock);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &elock)))
> +		return rc;
> +
> +	return ops->refresh_evidence(pdev->tsm, nonce, nonce_len);
> +}
> +
> +static const struct device_evidence_ops pci_tsm_evidence_ops = {
> +	.subsys_name = "pci",
> +	.find_device = pci_tsm_evidence_find_device,
> +	.evidence_read_begin = pci_tsm_evidence_read_begin,
> +	.evidence_read_end = pci_tsm_evidence_read_end,
> +	.refresh_evidence = pci_tsm_refresh_evidence,
> +};
> +
> +static int __init pci_tsm_evidence_init(void)
> +{
> +	return device_evidence_register(&pci_tsm_evidence_ops);
> +}
> +subsys_initcall(pci_tsm_evidence_init);
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cb4f74957f69..6cefaddc1120 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27472,7 +27472,7 @@ F:	Documentation/driver-api/coco/
>   F:	Documentation/driver-api/pci/tsm.rst
>   F:	Documentation/netlink/specs/device-evidence.yaml
>   F:	drivers/base/*evidence*
> -F:	drivers/pci/tsm.c
> +F:	drivers/pci/tsm/
>   F:	drivers/virt/coco/guest/
>   F:	include/uapi/linux/device-evidence.h
>   F:	include/linux/device/evidence.h

-- 
Alexey

