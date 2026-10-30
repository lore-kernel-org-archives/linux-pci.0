Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793343746;
	b=o3qy7Rqf6FQ0kGJOUKUJjCvPW3XfFhHsMTT8Du3V8URIkHedw/LveBe9PJcgBW7de9td
	 XpELMdkEgnoj2Nw5jX8GlWv4SlKnKHIFklTJTA0IqziqFsbFgdB+/GFLuvIOcRJj5Qi9y
	 aXetJzVDNmyY7EKRl7GtHFxDMWaDDLxcKyv7BBpaHHKFfBL3SkXyBF3zoKekzoMMWCTx8
	 9TcRR0PLtS98v3+cRlxm9zxBXj0usE4GtG7UewgkIhALGQYvb8+fZgRGO1Q4vsielqIwM
	 fq0kACfexLEeER1xBtuHO3QEVUra5Z+rZqo6OxuuoXsxja+Xx2jBbxgFkya+yiFtSGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343746;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ve3LmqEeleB/KHxIsan85p3UOM4eP1dC03eA4E6LXtg=;
	b=Ux5YXu27H695pNGjg5e/L/7cH68IYblFbB1npiyfE8K1pjl++EevP6GfQMC7EvJWH9TJ
	 ndm8UbGX39dgppQ1ovKaWQ02CTJPyIvV33BfCVPkJniouooAaYbAzGcnMgF9bLCbBwpaf
	 z/rKzOxMkzBBSZLJ8k8BTK2ULUEPo7RoWWWuheslH6Rdt+VzgJXIBQml44c52nuvQWn+q
	 7lHl5/Kp6pO3N6JgHDCc5RH0Gkfv+ASMwPotYYD9q8RlaguEaaSvu2UQwIfTEtpYgrDpk
	 v0pBAYtmZoHMZE12bTXiXP+tNLD2T6giSzgOP1CuM1KNpQGChtTIVup2BuuE08gJrhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Jub4acev;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.3
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67F606A31A;
	Fri, 30 Oct 2026 07:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA67F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Jub4acev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwvAb8h2+sQYs6dACBtNCdZks8XlNGdwFwxkBr3UgnvlLvXNj3LfdYQEDVRHwWZTXKuv6b41nyskb6yTrJIA8WrskDbVHXfbGdxga/HtbE/DU88n+iLSLq/eM4ztYT5YRKhvwTjOEsBZns20BZsb0knVTq/B9VwAhbaSv2Sm8DfJx8QiMo/N767N7mj6PVg6SOPpf5x6dHfC/iZNz7rpp/32MfxY/wyTQTuJ+R3VszTskBmUIUvpdNnEx8OJh11DSKCabpypvBNFq3uJXkniGvtuFYX+UL/1nzQ+4qUcPJqfyTWjSd6GSTW4QiT+hm1242GEBlinAIFZzz3YKxRATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve3LmqEeleB/KHxIsan85p3UOM4eP1dC03eA4E6LXtg=;
 b=M9LJOjGvqoGn/vnAGvgdhVhqdhL44+qF/SKgMv/GzfEuYy5N7Y6sIUhuFwOFsz/rbuft1n8/pjTNKQ3pqrKQKTcxNNF90HzcQ55hWu+RBB9torZFW/XhhBNwnGUvkkzEJNmCcJ36oMCeQKJkuunYa1w32uNSwA1yePDZoaG4U5hTWc+uVrPFQPcoHrQBaACNcdUBk2MlSdV1gQGjoNes9wjmGIKeORMbTD7Sr3PkQYlk44XWA/ta9hG51kHYgH03II30pFH08XGs+JzINpr22dT2VqwB8opNFWkgGEJM4aF9CnMVVPECL6ejSQ5G/4090qVbbtmLhlrmLtzAXEL5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve3LmqEeleB/KHxIsan85p3UOM4eP1dC03eA4E6LXtg=;
 b=Jub4acevXqG1rkxRlBAiQQDNkwe1JfK2bXAWosBHtKqTCrpU9p99/WmG4H2FdGeAptL9U2m6KP+lI+odGorMWkgl30hv2Y9soFw/DFg2HxyWZhY1ag/UzY4uDQ5kp/kAcnA3CfX8H3LSNW5PSVuioOQi2ZXiDsgENU90YPohBzLhetbfinGykq9q/rkwsIFlNZpH0P4qmgrz2bslOxGxVff8N2qDOMEamOLh1Kb4zSkzQPRSasZlWu1YzeiRZa4Qc+hsjcEo/6xK2xIcnRKvPWw5+Jnzv9G4+1/XU6otf7MPvHC42d8+IY1B3Xk+/APq5dk/PHzalh4ehTuhufvaBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 07:02:22 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 07:02:21 +0000
Date: Fri, 30 Oct 2026 15:02:16 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li Ming <ming.li@zohomail.com>, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v16 10/18] cxl: Build register block helpers into the
 kernel
Message-ID: <auRA3DPi6U5-LwxT@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-11-smadhavan@nvidia.com>
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f0fcb0-75bd-4b03-9aa9-08df3653be71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|260925022911599003|260925021911599003|260925021311599003|4143699003|5023799004|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	dfC9xkFKp6uZSoeC7QZwKuYlJfbrciAISeh+wnJ3GRnocHwj06zmcoCeKkz65/zqcyfgBeWpyWQ71XNzORTOhYBRmRd/hQhn1C2BMf2D9dRLEPUT+mZZAcTt0nsvr1mWs2/Pfe0BTQoNv39I24lc1J44TrxsB7KOrdVsl8sWcjw/B5v+MVyX+dwdd5mekk3Ga1gi5PeRu755YKuboY3oW1tLv5QfSxe3aUmaaLmoSeiHNI9ZFOeJRmlPIA7THjdSaZL+InZCssBxJGi78F+ZSQugkBX0VoygWt9lVhNOG3sXpMUYVjfOnARpaV7MQaKAfNX5k2CILODGeiMrkAtQRcz+wEzSvvFg1CiIvMegTnUzV7em//JVHoqlysNkei5EaFRYP+ZPHqyfASichi/79o2QwZusCUiHT8B/6jOEPcAwqeI/NKUxkW2/zHx8b7EGjMfIDiUS6wP14wkkTQZsd1dJ87V1j9OOIAXuZ3zydnhEGr5Qp0g3Vc+KORHpLRWPRGQQ5e8UmKGifNueL7/c5VFNFUkA4IJwUvt+zEk02T32NMPe1qQrnntHorZZkj9ejCIQ08JRp+6ftF2bawi/CNK5nBTWHmvelrc878Eo6cqxVj2YF1bBpbtJFKUMonuefxMr8izdQeDqULp3HUHinmavv6M4ZzeZk93sbTBz/Zg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(260925022911599003)(260925021911599003)(260925021311599003)(4143699003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6MTnYO4f+LGcgYPssn+9NzQf3BdBHFmVvdqcBj8mkTVAi4vYKnse5W01V0p5?=
 =?us-ascii?Q?7NOsac4aM+CY4fVtuWHhHwr7Q6EE1Ak6WHfNgpn882jk3SsRo/cswwSMB8Mf?=
 =?us-ascii?Q?RXcNAwqqOejCI3veoRKAI6MN8qjXlk/qAX3EkWDRjquASkjudhYWeTm6UneL?=
 =?us-ascii?Q?2PybK+9zU9n0fya4cNm9xLvZJPhn3TsvkM9mYf5+fyq6egTpm5CH3gOOKIqW?=
 =?us-ascii?Q?3Ux2JO9fFks6uxEmtKmXHqgKJ7pqj5D9kEw7snObLDESc7HPJPaEgruu3KdQ?=
 =?us-ascii?Q?q9bKK+b35NcTh2zIbD2FC9kUwJbjkxiiWyDyxbc3xeuNDFn07xRNz6n9WAYI?=
 =?us-ascii?Q?GDdqVfpCG4EsfiT8A98ENXVLn6004A482e2zEYAZM1dkX/KsECvrOldVXkhk?=
 =?us-ascii?Q?x7926lgpBQ+y5B9/riqai10hNFN0nGm+k9Khdqi1HwMAJiIjD7E3OYd510oT?=
 =?us-ascii?Q?SG5qdesRbnR+ZbfOlBPVOd/YQ+mKIyz/YuKWNMm2XpXqlgsrS1VCu3jnk+cS?=
 =?us-ascii?Q?85AxPpeiNO/uyqPeXQ9+AMMu0Vzvzxpe+y+FmytoQUl7u8hUzId0Fa+37GZ4?=
 =?us-ascii?Q?HnmGYVqnK27jLCl/O1C9ktBMZYlMhPmXOqNajbROvflI0qAH4ZQ2Yca3y/Lo?=
 =?us-ascii?Q?2fAgujM5eRczePR24BWDRTYCOjZsimG5Rc0MIZr6XTUBwBCWqThUTu9NW+DQ?=
 =?us-ascii?Q?TjSd0ZM8LyJdzp9kPCyCP61w1ZjaVJhvqw/7UaIrMTTMlqULD4bMC5oGP79l?=
 =?us-ascii?Q?zMijcsN3caqWmPVBmcDvwX75NBZb+e94DNy0Csc8DsWaS0apkyQ7vE9GkOEH?=
 =?us-ascii?Q?br63+9rUNAUjdGgkqkmvTfVZn0pnNX92CFBoXyW2FmgA4c4ipH0wHpHCXeAh?=
 =?us-ascii?Q?VAQ13uGzZOVw0jFj8IA3fAnh2hJwsBxo+sPUTcqinQlidKNEz0vfm/cDK0g4?=
 =?us-ascii?Q?ypOg2XyvdpCBhnLAvN/QHRakwri57h8XsMeSkHlHXVu+WwgmjIESuPW5j819?=
 =?us-ascii?Q?20TzVeqvaxwm3r/GZMSGaMiLlZuG1a/rR7yFQNu7nXhGGVB+1fpEQD9zaM+o?=
 =?us-ascii?Q?1l0Tlekw0v0NWHhYsOz1vsHUYUnQkUsJ+mQWy9nFiDN6wPLULr5koXjHV39E?=
 =?us-ascii?Q?RoSpjW4rhohVQMLDx3Cz40heYfwMIehWvw0F1xK6uXCRzQRq4pgrye034XiG?=
 =?us-ascii?Q?atPpGA3sbaW2FyUS+Bcb4o26NY0PlYMzwZ8uNze/eoZp/nd/hfvSW5DJC2mB?=
 =?us-ascii?Q?uG2zsThXqihrSuj1sb4jUXDVviNCdqhewQPulCznQE5exRSSL26tm7egTHxm?=
 =?us-ascii?Q?zaTLTj+5WLSCL/nVOOfGgT4ZlJGrrMvhKAyRLE2xlhBjDA6YoHnJvg2y8ifX?=
 =?us-ascii?Q?zqYHUSRUj3/oJIo5MpTZz5kFAefafttvfSZdDCUFbI/aQpibe4EDzcFtXgV4?=
 =?us-ascii?Q?7qZSyIC4sY/sj0jQddgQEkTgYWUyOUkGxIMQdE9jlVDdd4DtMDobDDrh4loF?=
 =?us-ascii?Q?28t7Mi6B2N11fGJ2JmJDjLeer1KiXDJ9USFBUzna3QCThe1zlYq86YVELctT?=
 =?us-ascii?Q?bJRFj+yeuHYftFTarIW4OL2btfvLMfRQyi91F4JNA744KT8++ylyywo1e+BR?=
 =?us-ascii?Q?p4jZBaViXeaUIRBRJrDrOGGDIijgnthNOV9If02YgORuchhhIPDsKfbzy6IM?=
 =?us-ascii?Q?VJkitdRjGUJd5SWpm0Bw4f+8ER4R1NnI3NAm2FssWG8BFIRSr01ScZCVx1NW?=
 =?us-ascii?Q?elaZuCmj7Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f0fcb0-75bd-4b03-9aa9-08df3653be71
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:02:21.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqLxK3AVwscJHyEEyFA29IOEgimCnveWZbwx4VSm2wiGOVqrpYl5kzRX48vSwRoGwaF3bKmgZIuJ9w6HogAxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854

On Thu, Oct 29, 2026 at 02:56:55PM +0800, Srirangan Madhavan wrote:
> Build register discovery with the built-in HDM helpers so PCI enumeration
> can use it even when cxl_core is modular. Export the interfaces used by
> cxl_core and preserve the BAR and offset in the register map.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/cxl/core/Makefile |  3 +--
>  drivers/cxl/core/regs.c   |  9 +++++++++
>  drivers/cxl/cxl.h         |  3 ---
>  include/cxl/cxl.h         |  6 ++++++
>  include/cxl/pci.h         | 13 +++++++++++++
>  tools/testing/cxl/Kbuild  |  1 -
>  6 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9971efb237fb..9a77e68d44ce 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o
> +obj-$(subst m,y,$(CONFIG_CXL_BUS)) += hdm_regs.o hdm_state.o regs.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
>  cxl_core-y += pmem.o
> -cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7..def3c20d1a7a 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_FOR_MODULES(devm_cxl_iomap_block, "cxl_core");
>  
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> @@ -285,6 +286,8 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  	}
>  
>  	map->reg_type = reg_type;
> +	map->bar = bar;
> +	map->bar_offset = offset;
>  	map->resource = pci_resource_start(pdev, bar) + offset;
>  	map->max_size = pci_resource_len(pdev, bar) - offset;
>  	return true;
> @@ -309,6 +312,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	*map = (struct cxl_register_map) {
>  		.host = &pdev->dev,
>  		.resource = CXL_RESOURCE_NONE,
> +		.bar = -1,
>  	};
>  
>  	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> @@ -339,6 +343,8 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	}
>  
>  	map->resource = CXL_RESOURCE_NONE;
> +	map->bar = -1;
> +	map->bar_offset = 0;
>  	if (index == CXL_INSTANCES_COUNT)
>  		return instance;
>  
> @@ -518,6 +524,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  
>  	return offset;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>  
>  static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>  {
> @@ -634,6 +641,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  
>  	return component_reg_phys;
>  }
> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport)
> @@ -642,3 +650,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  		return CXL_RESOURCE_NONE;
>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 688350c7c5fb..ad4e80be2bd7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -239,9 +239,6 @@ enum cxl_regloc_type;
>  int cxl_count_regblock(struct pci_dev *pdev, enum cxl_regloc_type type);
>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, unsigned int index);
> -int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
>  int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 341a7c52894a..206acf5845e1 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -27,6 +27,7 @@ enum cxl_devtype {
>  
>  struct cxl_region;
>  struct cxl_hdm_info;
> +struct pci_dev;
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> @@ -150,6 +151,8 @@ struct cxl_pmu_reg_map {
>   * @base: virtual base of the register-block-BAR + @block_offset
>   * @resource: physical resource base of the register block
>   * @max_size: maximum mapping size to perform register search
> + * @bar: PCI BAR containing the register block
> + * @bar_offset: register block offset relative to @bar
>   * @reg_type: see enum cxl_regloc_type
>   * @component_map: cxl_reg_map for component registers
>   * @device_map: cxl_reg_maps for device registers
> @@ -160,6 +163,8 @@ struct cxl_register_map {
>  	void __iomem *base;
>  	resource_size_t resource;
>  	resource_size_t max_size;
> +	int bar;
> +	resource_size_t bar_offset;
>  	u8 reg_type;
>  	union {
>  		struct cxl_component_reg_map component_map;
> @@ -168,6 +173,7 @@ struct cxl_register_map {
>  	};
>  };
>  
> +
>  /**
>   * struct cxl_dpa_perf - DPA performance property entry
>   * @dpa_range: range for DPA address
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> index 3e0000015871..b15d7e415e27 100644
> --- a/include/cxl/pci.h
> +++ b/include/cxl/pci.h
> @@ -4,6 +4,8 @@
>  #ifndef __CXL_CXL_PCI_H__
>  #define __CXL_CXL_PCI_H__
>  
> +#include <linux/types.h>
> +
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_EMPTY = 0,
> @@ -19,4 +21,15 @@ struct pci_dev;
>  
>  int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		       struct cxl_register_map *map);
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +		      struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map);
> +/*
> + * CXL r4.0 sec 8.1.3.1: a CXL.mem capable device reports one or two HDM
> + * ranges. 00b is illegal when Mem_Capable is set and 11b is reserved.
> + */
> +static inline bool cxl_dvsec_hdm_count_valid(unsigned int hdm_count)
> +{
> +	return hdm_count == 1 || hdm_count == 2;
> +}
>  #endif
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 2be1df80fcc9..e80500f457a9 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -55,7 +55,6 @@ obj-m += cxl_core.o
>  
>  cxl_core-y := $(CXL_CORE_SRC)/port.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmem.o
> -cxl_core-y += $(CXL_CORE_SRC)/regs.o
>  cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o
> -- 
> 2.43.0
> 
