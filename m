Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCC47D936;
	Fri,  2 Oct 2026 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934616; cv=fail; b=Rvwccqh1WSEeg6V0yRjg4ydkMft4N/TLpeIA6PbKJdk7KtWOoMTL9s4neFRTPZCi5jAZqHMrtPZAcA7ObzlK822+sy4wycnmzeMooMSpgzrWjI+mUsrz8Y0BpwTl+H6AY39nPbv1WzODfo9kqLWinkjk14bDwQumP67iEM5zjXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934616; c=relaxed/simple;
	bh=ryfgiM+JuqKamXiKXRp0Lj4P6UJlKbOAUc2WPyFULx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dNVr3hWGaZ7SN+jiopCNpxywmJEmNrMvXQciATMc5njOvnWBH8Ge0dnpd7YW1K1aOAxIK06CSHEjr0gHabHpaLaE+90P1qJj8zOqj1KaL+Q5NiX/++pvm5HJrKOMpaX3RuzZr0n2VrLH38StWKUnuGYCYPhZiO9jzUAKyQOQ6No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DoSPcGEw; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DoSPcGEw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTL4tqbEN6XqmkRjVgpDNaFfapr7snnF/ybTsbv+SXmlxJ8cVR3UJ4g6nlpiUuISMa3IOMhcOVS5Yz6J1a9LZ6lO1AUOwiwZu5CYu2hJ4ipXXIAXRG3pipx251r71Gb9Gcw4YFh7HZ4L2aM7E8fI1L2I2ycXvypsoD40LX2ZFfFxYiUoK41TCc1LiXrd/mxyvxewXmJNLR01sPjknrs6QTD7NwUoWmhGrc7uq9n+g0h1F1iqYeoiFUvfSc3lvuv5U42x4uf/e5TTqusNVVXjwdIxAISjDc2EQyW3VpEGFJlLUBIcxH0MnQr8gSBpXqysCtLXjXElKyyPzmGhD7czbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut+/CPeYFI2lMhcdcnTkeqnTXCKCS72w/BloDYGtQVk=;
 b=B2nW570vD2ZnSIgx/MwSuZh69PRY/m4RjpzELPPfD9PI8tuOUvCTVIbmbDJ6uW0C0Chmg42QzeetjEc/2ibOemUfkaET9CrtBqZj/sfR6FvkgjQcE8Z+k0FmdzSyb2LS5BjaRDGF4xXppf3BOG95nZA7hLlAH0dZUQ13A4u7Lo/88gflNedlz5XfSkw5wnu4HLp1Z/QgKjnFeP1rX8gO5ujTQwiVUmqFgHBVGDYv7cnx+XLRuupdIM843WfijX85OkzJgUn1if3yL0OL9/qj47dPtQ/pgaFu9JkmtFsmAqmhCWrPSMnXBX0kRXYFyc9WVwGeuN1gsXtq1E1K/wkpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut+/CPeYFI2lMhcdcnTkeqnTXCKCS72w/BloDYGtQVk=;
 b=DoSPcGEwjdu6+wgmeYVamn53OhC6en4goGwk6bqU6l9rSIm9RYMG6LdktxV+J6O8+7qUJkaW0JrY7bDgrXNa22dKrynpFObFXoAgzTpMil8z7y1V0q82htIS4pSuh9tWwFVtnd4k8vAiEuRYmsSlwG5Q++zW7kb5YhdXOlNjU1C33MGTJ/5Fwu1biM6z+ox48NWXpe2egA4svR4doYtgoUFZF/XtD+jnm9xpB83H3sL5PrXiFXikkEik8691K9cRzgZGZagV6UIo1kw0qY0omZ0Iz/YbkQFkle21DKlYfqud+t5ecgiQOp2NEMAqNU739FdvCUKQ4smv7GJhfah14A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DSVPR12MB999260.namprd12.prod.outlook.com (2603:10b6:8:41d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 09:50:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 09:50:05 +0000
Date: Fri, 2 Oct 2026 17:49:58 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, 
	Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v14 03/16] cxl: Move decoder declarations to shared header
Message-ID: <ar9-M2xyv3Dd_bfG@MWDK4CY14F>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001092227.3004747-4-smadhavan@nvidia.com>
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DSVPR12MB999260:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b920bf-1259-429e-3d9f-08df206a88f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nOM+O3CuU7xIX67tDo09o3JS7Fk+ZQQj+hRSYSvPvKwHTpaNYncGdmmOVQgpBZ0YGtgpyd232fhr+GlmPRQP4FBG2aE7Yrz1q/6D8I86knIz+LizOSWsT8Sg6+vWpaXoj96KPn7OOJy8d2UdPSHyMrtuA4IFwgTg0FRcdReDKWYCCSbH0ybagn3sVz+2Xpt8EIjEb/mM5+g+mJGLwG3JEmeRjI8uWnmOpLmFyKWxHcY92Yu18ugAUoLAgN6p5Ow//vOBMmgrEEStFgJvsUN8DEfW/FVAUXmINy6wke9Phd8aehM0fPGfK63Y2A4OGGcaYUeA5eG/NIZdPX+Yz6UV0HQOvkKOQtKFXBmCyxxxk/3D8TNa3VcwCDaWst7Jt0DB8MbxZQFpRTLVioSzuMIDrkJMIeugaP86XADOW9zicX4KfiZQSVj/CIcYd7lia2HSQ2+CiIxrhfHwsUOJqzgcyEpkT7N4QFRUFkbj2O8gW8E7jfFPMgv5yZJqracUYAS4W0Mt8rT4waX9DyJxFf+EagGSl/b1P2/AvX8VUMyugVi+Qo3ugVRel57gjsht0Xh3d2IPA6KtROqKbsxNC7UNyRSJOMG342gOww4YsJfWK583xUxuBKTwyIDimK28me+CFhhLGml8IQyAwi/ELYQb0ra6+xoUzsTJB/3GebYgRm0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aef58faCdsraaJY0p9U35gNMXjdePwCidaw60FWSxkPWYEsJZbeUP5NIFzig?=
 =?us-ascii?Q?lCugDm6gFDUBuxkKX4qT9L/beQLZ+ylv8AXeYSS7jIzKzygJzJ2Rlfqzy+uh?=
 =?us-ascii?Q?4TM1IaIybp8Q7GvyzFZSnhUp4GhUbNn5uJmepseap6gmHP799IFGNuZNfwbb?=
 =?us-ascii?Q?Z6RFcPphoidzaY7eWhGvZWAW19N76wMPg4yw1zAnRr9W0i0SFkAdk2OH2v62?=
 =?us-ascii?Q?K7noko1hW88DSATuObP8n/xjxtOt4XhYs/L6Y4Q29Q5tTQ01BD8k4gr9kPkm?=
 =?us-ascii?Q?6a/YCkMXdNBMValbd/S6EUIeOLChJOrPSbi5+ZmnePgWTTGqlT9mBfoRWyiO?=
 =?us-ascii?Q?4VhbCQ976jrO23rB0LEY7T937kLWz7Xry/jcWwGvWIMlm2gJTbdd11IBF/06?=
 =?us-ascii?Q?XKGLFjqxn35q7xRMmc0Fahtuc8r3pYR8UVSLS1CNP8fvhjyixlDJAFK0+3GL?=
 =?us-ascii?Q?0/RPmIfZ0iACPoyw3LMj0KpcAazycNz1UzzLtnOGE0Hxl0G30pKCwf7uIzJW?=
 =?us-ascii?Q?M23AHsjvgRBUnBPGGoqJvjj3ODO2inLB51HtGBQulg8Pf7psoMBDdjTWwUSX?=
 =?us-ascii?Q?5u/Nc2dLmGtbDWU3MV3a0wwW4iyeILEtK/Jz/crTwzQ1zapvbw9tcla4+zRL?=
 =?us-ascii?Q?Jm+xVI4wNCGGt/F8GS661lv9H95MUGAFY85b1IHvAapoRp+i7mwiUMW87jOv?=
 =?us-ascii?Q?0b6SNYeAU1yozobB64q/8DkwUtroKZn1ksB3jxxMX75RXOjO/RGAXhpppImb?=
 =?us-ascii?Q?PH+2Q085DTZMpm/DdKekqszXnjnwhP1vTo3zTyxj1pRbL6KSR0vKENpFElqM?=
 =?us-ascii?Q?arhRxffWFLqKjcS95j1KSJF/1mLcwugyWtQh94HefZVASW1Na4ycj9wOqRYd?=
 =?us-ascii?Q?6K2L8RQJqY3uEBqmRNj5Efo1y/Vgxsk5EmNxUK7pi7UR6GuCjhS7RogSBk6V?=
 =?us-ascii?Q?brxp6CmWDAJMRJFRqQOWiloVkntqmucdrDdSd1EUUHfYOCfp0fYQwMM+4dyY?=
 =?us-ascii?Q?KA2UBq0fgKWP4UP9i6RWg4pKXeCXUJ7aeFwD2g4GSL2a6IjubFM1aePTT9fy?=
 =?us-ascii?Q?7IkhVbDiuUQQQNwYzqu91MKA1ooQUXsRsbcFCb6ZnY9ywThwPyTbB4B8xWS8?=
 =?us-ascii?Q?0Mfy6DCbdsjbU7SbuzdIbIv4GjlRk9SUC7AatcZW0XmaQXKKSmLVcCYS0Ki8?=
 =?us-ascii?Q?+2s+tanWRcoLildyfFS+HYyhC70VhSf7hVUmsYYp0ANfR9kwX96/HIWhXp+W?=
 =?us-ascii?Q?XqaQSQ43I5OLUBZCuhoouH7jsLupY4lgkmOeXninPtQvdfzgupfDbAHJCtlw?=
 =?us-ascii?Q?prr3ENgMtDTnzIC3bsOR/XqCPdHmS0MTfY8gtFuEAUlyvYdc3JpWU27br3UJ?=
 =?us-ascii?Q?0sQk4nvIMZTW/m/nPZE20BaHN2GPtNMR8b1pwpVOClaalqLEDrdv6vljpU85?=
 =?us-ascii?Q?IqX1YhWVEgirag+lWErAsxRJ45MTMXfkuvL6UliLFHyOo2dZLm3ZQnnd1ofu?=
 =?us-ascii?Q?tu3cRRSPHmOEeGHxO0b5VubuTYYorpll6VDtsORpYqIE8tugBR8BymxlzSEO?=
 =?us-ascii?Q?zTCQrIxcYRZzIFSnJhkJ7h9fsuG6dR+nlZYe+oAxKgbt1/Lrfv3L7MOE2Cye?=
 =?us-ascii?Q?YC4ue9AcuT8uyKQWGOtecIoxUyaZH89Y6iJgF1lYqdWAwiuRZWUYOzZY6CEy?=
 =?us-ascii?Q?7YlNVw16mY7o5QZx1RsUJDjBud/Vu7DIhyyGrTu4RGHYw/DDkeEMKI+v9l1L?=
 =?us-ascii?Q?arLZxo4vtQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b920bf-1259-429e-3d9f-08df206a88f3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:50:04.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzh107uVWucXzlSz1uTQS8PRPCSgSQwXec3Z7fjMybeWKH8Wi1Ypnkxp/6GhhvPEXXkqyXKTo/zk+dbuxAIwKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999260

On Thu, Oct 01, 2026 at 09:22:14AM +0800, Srirangan Madhavan wrote:
> Move the common decoder declarations to include/cxl/cxl.h for use by
> shared decoder settings. Preserve their layout and documentation.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/cxl/cxl.h | 37 -------------------------------------
>  include/cxl/cxl.h | 41 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9e0500d56866..44ff3334648c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -264,45 +264,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
>  #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>  
> -enum cxl_decoder_type {
> -	CXL_DECODER_DEVMEM = 2,
> -	CXL_DECODER_HOSTONLYMEM = 3,
> -};
> -
> -#define CXL_DECODER_MAX_INTERLEAVE 16
> -
>  #define CXL_QOS_CLASS_INVALID -1
>  
> -/**
> - * struct cxl_decoder - Common CXL HDM Decoder Attributes
> - * @dev: this decoder's device
> - * @id: kernel device name id
> - * @hpa_range: Host physical address range mapped by this decoder
> - * @interleave_ways: number of cxl_dports in this decode
> - * @interleave_granularity: data stride per dport
> - * @target_type: accelerator vs expander (type2 vs type3) selector
> - * @region: currently assigned region for this decoder
> - * @flags: memory type capabilities and locking
> - * @target_map: cached copy of hardware port-id list, available at init
> - *              before all @dport objects have been instantiated. While
> - *              dport id is 8bit, CFMWS interleave targets are 32bits.
> - * @commit: device/decoder-type specific callback to commit settings to hw
> - * @reset: device/decoder-type specific callback to reset hw settings
> -*/
> -struct cxl_decoder {
> -	struct device dev;
> -	int id;
> -	struct range hpa_range;
> -	int interleave_ways;
> -	int interleave_granularity;
> -	enum cxl_decoder_type target_type;
> -	struct cxl_region *region;
> -	unsigned long flags;
> -	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> -	int (*commit)(struct cxl_decoder *cxld);
> -	void (*reset)(struct cxl_decoder *cxld);
> -};
> -
>  /*
>   * Track whether this decoder is free for userspace provisioning, reserved for
>   * region autodiscovery, whether it is started connecting (awaiting other
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..69941f7fdb76 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -5,8 +5,10 @@
>  #ifndef __CXL_CXL_H__
>  #define __CXL_CXL_H__
>  
> +#include <linux/device.h>
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -23,7 +25,44 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>  
> -struct device;
> +struct cxl_region;
> +
> +enum cxl_decoder_type {
> +	CXL_DECODER_DEVMEM = 2,
> +	CXL_DECODER_HOSTONLYMEM = 3,
> +};
> +
> +#define CXL_DECODER_MAX_INTERLEAVE 16
> +
> +/**
> + * struct cxl_decoder - Common CXL HDM Decoder Attributes
> + * @dev: this decoder's device
> + * @id: kernel device name id
> + * @hpa_range: Host physical address range mapped by this decoder
> + * @interleave_ways: number of cxl_dports in this decode
> + * @interleave_granularity: data stride per dport
> + * @target_type: accelerator vs expander (type2 vs type3) selector
> + * @region: currently assigned region for this decoder
> + * @flags: memory type capabilities and locking
> + * @target_map: cached copy of hardware port-id list, available at init
> + *              before all @dport objects have been instantiated. While
> + *              dport id is 8bit, CFMWS interleave targets are 32bits.
> + * @commit: device/decoder-type specific callback to commit settings to hw
> + * @reset: device/decoder-type specific callback to reset hw settings
> +*/
> +struct cxl_decoder {
> +	struct device dev;
> +	int id;
> +	struct range hpa_range;
> +	int interleave_ways;
> +	int interleave_granularity;
> +	enum cxl_decoder_type target_type;
> +	struct cxl_region *region;
> +	unsigned long flags;
> +	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
> +	int (*commit)(struct cxl_decoder *cxld);
> +	void (*reset)(struct cxl_decoder *cxld);
> +};
>  
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
> -- 
> 2.43.0
> 
