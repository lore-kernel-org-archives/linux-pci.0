Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588945;
	b=Ffgtwq4H2bY/WxzAmOsthronkVBtn0rG5XAH3VCCoUm1V4RNoiS5Xik4tZ77ca9QcwER
	 h5oKPpsmdxgASBkkRL27R/Ao9KGo/cKhBTxIt10eRS84idbuheIMftwalq9BeAFvLNCCy
	 bF+rhExhvX46dbrhr2OcQAJ0F2KFfW+8gyv2Qmbotz8IQsEC2OTdrTie0kFLmSuZexXNp
	 WihpW/3qQfEqj+WYaT6g8SAi92FPdRwwktAsSx7VKoEAmgnsrPbtaVigTdAdia5WBzDGr
	 XtyJCo26wuFI7fWdwh1kpPJNHZ4VuEXpJ+jpoJotyLs3oNQntphXcp1kIH61+AUn6FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588945;
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
	bh=JWBil+fWcdvuTyW2MhTfWQR4I93IYTQnS43aQSZakwI=;
	b=5DHCjTbR2bl0RYDsbhxRmV9OkKX4BuaPkbnis0b/kAv2R/++zvfyAG7lXJB0mgz65jAp
	 fRWFSIolw46MDp943vi49Fmrfz/BK342wHzYuSYeMb4qBIEeVaRqy0wO7nVQhI/a8UubK
	 cJwZoyFflp35I1Tbf7ks4ND3UauLT6gHuhQngQgmsFmlD43ZeFmxs0T0sxBy8WCgCgHGY
	 t05AFY3bJmqKgXOJdioMF8NXDl+/ArIHfZxiJvLz+VFAjVeaxhShmJ+gmkKRSGWZ7xnJ+
	 dEIbMNDg2GHAKzFbBcaI4TLy463IONGFiCLSFkBpNceSpnMqrpwoqKpTSLe1HMX12OQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=T2zxH0rX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.68
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D46606A333;
	Fri, 13 Nov 2026 16:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D46606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=T2zxH0rX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y62KbfBVuUZtHkJntfGGmrlTNX48K4+wC7sU5w1jLuzDUejAtr0Z1iyOaciS6sTUZg6XVpBGaxpNRXT7K4C0DROmvD+cusrVDCmEpEWrlYYOG24eU4uuX2mr58q0MW1MQoDeJfzshT2T/uCYxKHbsg+nuj8FSrdmcKQglvcO0PhICf72Zm+9dyGhFRIz3F2mWhvVIICrbPeGDrqdJawV0vQ6PobfYpltf4rmysmrwjrH+Jg+htj67wTuSXWpiaZzWy8RnBM+i93HoAzNtEXbSUB48kIuZC9NEgZZBYYGOyLnAgYv3MAGHkn+hVxYrj+KZd0cT72qASVZDDzK1mUKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWBil+fWcdvuTyW2MhTfWQR4I93IYTQnS43aQSZakwI=;
 b=pekNRsT6ydOApclsszupc+4jY7MU2138CoD2tO+37QOBP5cCWcJ0h5z5mX91xQ8vfu1anTl8tkqc7/0o8Hgc4PEQgsbvuzEOEPElKQt+xaByGxeDxLY7sc/7Io644PjWhPytNkFuAa9wk40zEZAZVQhvrmXddUYGJi5qM8t2rMjayE94kvvTyE5Z6dyeFSliwfRQYeMDQNgiu5WtYc003rQh+8qN/7apWW/7QMeffEv4VUJiUkXLvySk07+80E0NuLek1pi4FeFuA8qpjcRVzPD1/kmeLauHMptw6l34P8GnIOCyI30e+2ARLzX2q13GtFg7XPE1AJrlRFxiPxTSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWBil+fWcdvuTyW2MhTfWQR4I93IYTQnS43aQSZakwI=;
 b=T2zxH0rX+IPIgkQC6Ygih7jgJ/WvW4udyuyPq/004r2iP8oCuZSCcjxr5wDn+50FvOJE2mqa6ZMQzoWOBKaN1OUDUvSamWJEUeEtNtW8Bvohod5zJilGPIECRnaKIMTvIUF3t9yQM8gahnyTDXnQTYAWtI2En9sEoeX16lVmGfVe2gyIJ5PUeGA39Ph3laaPEE7pOstiqiN+sRqHxoGbP/Vrt0upH98adB/cQt9qudNDHyBmz7e8Wh4692K53yUWqqw1m1eWZT1DU8lA8/NEkmO1b+BbVIa/U++8eYS8HA23dUzlYpiYYyELC2FKFhTgWfLPOWuORFEYsZ66Y/IN3Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB11816.eurprd04.prod.outlook.com (2603:10a6:10:626::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Fri, 13 Nov
 2026 16:55:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:55:41 +0000
Date: Fri, 13 Nov 2026 11:55:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Tycho Andersen <tycho@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 15/25] dmaengine: sdxi: Per-context access key (AKey)
 table entry allocator
Message-ID: <avdBBeK30h1caE-L@lizhi-Precision-Tower-5810>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-15-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sdxi-base-v4-15-3668ccc7aab8@amd.com>
X-ClientProxiedBy: DS7P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:25e::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB11816:EE_
X-MS-Office365-Filtering-Correlation-Id: 220a77f7-0d05-4bf0-38c1-08df41a6f370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|19092799006|22082099003|18002099003|4143699003|56012099006|261009223027099003|261022105027099003|261021121427099003|261026140227099003|261102123227099003|261028144727099003|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	27AmWR/43n6LsPABuISJD6fCftNCWWH9OqZj2Tc2F/AhWalFGIP0oL56vO6mJV0brHn1yzKjI+9i1dIJ2xrY7nN0/BUHICSKC5Xprn7D6/6Dj3Lxtx1DuP7JtxazM9cGx3TkVnJsSS2nTD/DVVdvPNBP1Lr1WbFK6X5FkZmVXCWdCpNTu1SEGGJDo8c4+cEBXdddelbYX7plFHhXRNM/KLhsHdn4CBuevgqCsRjp6QkQoFgDUM2QZ5CiWqrkcptiQ2Ou5afeIpo4rZHQ/K0kVqY5h6+2M1EdSZTbpZt827W8bzOIK3FrqLK5/i+BSJ61AYBnOmO61FrDDG4MvVJz5NJojzMcGRSeCdfi/RfcNe0fvx6yjZJDjfDwS3zj62cvzxj/psiwMJBN1yx/sJo3lA9MlzXdCqAYXR8gItnN1YEfgyrtzzcFaTbFzcF02YO4Sn9BH/sxvkAm3KaMYqansoJRqKVawjz47Z66X+8Rd5nTZkh0oKCElCm6jkX3EzZ6XZsGgmsuwMBYIhcZytjhzpp5K0NmLRrHD368vOjezNnz6F8L4pG7TgQ0txmckkK8PjexctKt0WtDErxjFJMSAAwzdYC3iqWvKKCD2yBOUWDiK7luzPRij1xHzcUJ/WW0UeOlQeHJLavKULDiX+EJNb+jWkdyvwrdAx9j8QLhh7I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(19092799006)(22082099003)(18002099003)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261028144727099003)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wdJiBsbLewE4ZahFDByw124OZDVlOJ/Z0ydP8Puoq2lbPysCkE6IiiRJDXpR?=
 =?us-ascii?Q?1jOQcwgJ18exqJS+QXyP5GeEBFX4YF02+GU2mylj0X00vQhRtmoLzf3PTBSY?=
 =?us-ascii?Q?UcYfsqDTDLTxu+qM9JkCmsNSjFHz79DC+RjJkjf7xNmQ7su9r/7t5+lpfa/O?=
 =?us-ascii?Q?4MWwpNoycTClOnXwDO3GKg67WU/3XVciqJImXPAu8/W3D16NSeHaKMR+88ok?=
 =?us-ascii?Q?1/6tCguesNIX3wh4wcGcsCsEHtCyeodrO6iq5n3vfpgWI6aMi9AwNoWRfSLp?=
 =?us-ascii?Q?GtTe1ULaZa1mMjr9xHX8NSmrRP7t2dB2mG2KKpRZzzLsTmQrFvsqp5SfRzzk?=
 =?us-ascii?Q?nO2OS3xCg/uh1B38DnYXiudQ/2qDcE8WUKENWHRrgVZ7QfTppNOI+rntfMhK?=
 =?us-ascii?Q?fyjmQ8LqTnJph7JzsL/2uMZJSCqYCTGjz4oLPkoqaQ40x6ona0RLqKXMgnf0?=
 =?us-ascii?Q?X9Fge6PcCUq8dt9mw8/PC2PgyLJeH/hPZ/CmHsnSK+hKx5sJgGcDZDB0pnGr?=
 =?us-ascii?Q?LUlVX2EYd2EmUheeLt7eViQrhKH/3NgxKQSEi0PvriAyzdF8jW/D6WDKtSL6?=
 =?us-ascii?Q?TaUArH5oOCGPPQPRZC2Q/FxSKM30horFuQZmFWR20BBqoTUiG5fthLrTQ+Ib?=
 =?us-ascii?Q?4RyLE3tKhVCEGSLhlUk95EFOVSRZ2VMm+HrNZV8t6vB5SymYgnc3xnpWlRZk?=
 =?us-ascii?Q?Jz/EQuGqoNA2QX2aduxdmkKVYQvurfhkf1GsVgh9nBKkYGu8ZZykQfpIbvbC?=
 =?us-ascii?Q?iErHMCfJcFaXjzRK7rjYjUcazNB2UD7dNWIL4dHWjEgN0cdUPfn784+YWHtQ?=
 =?us-ascii?Q?Rqe+0c062Tm42eGIHi81yjBuYdZelsY/OyFMQ/qUrRBphcTzDrdwvFrgwDyE?=
 =?us-ascii?Q?tVSR7MQQdN9Ks/iuGBXkCKkXTAzs2/Lp8YB8888eMimJ+5tRyXVPsVqF4Gv8?=
 =?us-ascii?Q?+YmmSqQJG+fz+itTOM1n18JPZ3MrZ2H3fg8ilg5Co4Eh3aSZLFRAN6iUpFvH?=
 =?us-ascii?Q?2ykP54MmbtM9A+/n1M5Q25KzX3bTvpwCuw56SDPdo8S8wjyFKAyc7zBU04Lb?=
 =?us-ascii?Q?Wc8dSB4RDDzuyE/ZRuT1nX1K+Gn/pdC9QBjn3TsbpJVuhESPjfXS9Q69Z/52?=
 =?us-ascii?Q?4sNp/+aO5kdX8uR88Kvh78xXuyM9n4qqzwJAqgsW3zoPYkdssO/fsUegoHlf?=
 =?us-ascii?Q?oZ5vVOtDFVQbDzQKrHxbfuQqwDJS94/iPH8d/eJrs65eGDJVTi1AqqY+ylWJ?=
 =?us-ascii?Q?jXkpyUiEmcw7FI93yPjcmXZA4Uau1lUA6++NT18z926scL9Vu1BY5Dp7QZdk?=
 =?us-ascii?Q?7G2r5Tr54r/AavPXew2BUDFsp4onBoOV9pZ+sEULnx2ZmtnHDMYnBpbzT7t9?=
 =?us-ascii?Q?MamI3BXNQVF/UYq5a60PjPAw5NOnojTmWBaTHvX/fsQHRZtH/SYOSoJpJaea?=
 =?us-ascii?Q?Gj7WzPh7OxaKnZMGXJDB5Ymc9rU1xC+IARo7+1NV1flGosTjcSbZMhP7d2jt?=
 =?us-ascii?Q?Ub7U0SSRcLLWbviDHmMZuWnLbJuxP4iXOabpvekeEM7UgEMjyt2tSRQuxWFH?=
 =?us-ascii?Q?/SvcrCobukAernwBUuFbR1FQOgxgL/Iej7x0V3FFhQqWwmzEXJIStBTR7xJf?=
 =?us-ascii?Q?yC057xe1EzS6T25q/yjN99Otx6l3oLxs4UKXtNnF5ewMTGL1hYFbp35TjyHU?=
 =?us-ascii?Q?UWPS682JKNsbHtMUjjZyUSG2twy8x812QfeeO3nPSUOpf//ZpTMBl6+2QGFY?=
 =?us-ascii?Q?+ZgsQCwEu2vJMyNGdBi6HQF1YhXoPQp30/t4mOMV066/XXCWVXl9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220a77f7-0d05-4bf0-38c1-08df41a6f370
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:55:41.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnnEqOO4cVRMBH0+8hzc2C/5nkHeDEJH5y9UPUSsXveKPq0ZORIUEAsOPI2HXVcyCqOavN+hJQufCt967I3VOTykTeK6dJIFgTMqpE1sZjF+QsgZO4KY2FYXcopz6KHi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11816

On Tue, Nov 03, 2026 at 08:49:56PM -0600, Nathan Lynch wrote:
> Each SDXI context has a table of access keys (AKeys). SDXI descriptors
> submitted to a context may refer to an AKey associated with that
> context by its index in the table. AKeys describe properties of the
> access that the descriptor is to perform, such as PASID or a target
> SDXI function, or an interrupt to trigger.
>
> Use a per-context IDA to keep track of used entries in the table.
> Provide sdxi_alloc_akey(), which claims an AKey table entry for the
> caller to program directly; sdxi_akey_index(), which returns the
> entry's index for programming into descriptors the caller intends to
> submit; and sdxi_free_akey(), which clears the entry and makes it
> available again.
>
> The DMAengine provider uses one AKey for copy-buffer access and completion
> interrupts.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/context.c |  3 +++
>  drivers/dma/sdxi/context.h | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index b26eec3805fb..956bb06f9499 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -15,6 +15,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
>  #include <linux/errno.h>
> +#include <linux/idr.h>
>  #include <linux/iommu.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -57,6 +58,7 @@ static void sdxi_free_cxt(struct sdxi_cxt *cxt)
>  				  cxt->akey_table, cxt->akey_table_dma);
>  	if (cxt->sq)
>  		sdxi_sq_free(sdxi, cxt->sq);
> +	ida_destroy(&cxt->akey_ida);
>  	kfree(cxt->ring_state);
>  	kfree(cxt);
>  }
> @@ -73,6 +75,7 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
>  		return NULL;
>
>  	cxt->sdxi = sdxi;
> +	ida_init(&cxt->akey_ida);
>
>  	cxt->ring_state = kzalloc_obj(*cxt->ring_state, GFP_KERNEL);
>  	if (!cxt->ring_state)
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index 14ce4f5f9b74..cad5a153ec22 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -6,7 +6,10 @@
>  #ifndef DMA_SDXI_CONTEXT_H
>  #define DMA_SDXI_CONTEXT_H
>
> +#include <linux/array_size.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/idr.h>
> +#include <linux/string.h>
>  #include <linux/types.h>
>
>  #include "hw.h"
> @@ -32,6 +35,7 @@ struct sdxi_cxt {
>  	struct sdxi_cxt_ctl *cxt_ctl;
>  	dma_addr_t cxt_ctl_dma;
>
> +	struct ida akey_ida;
>  	struct sdxi_akey_table *akey_table;
>  	dma_addr_t akey_table_dma;
>
> @@ -54,4 +58,24 @@ static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
>  	return cxt == to_admin_cxt(cxt);
>  }
>
> +static inline struct sdxi_akey_ent *sdxi_alloc_akey(struct sdxi_cxt *cxt)
> +{
> +	unsigned int max = ARRAY_SIZE(cxt->akey_table->entry) - 1;
> +	int idx = ida_alloc_max(&cxt->akey_ida, max, GFP_KERNEL);
> +
> +	return idx < 0 ? NULL : &cxt->akey_table->entry[idx];
> +}
> +
> +static inline unsigned int sdxi_akey_index(const struct sdxi_cxt *cxt,
> +					   const struct sdxi_akey_ent *akey)
> +{
> +	return akey - &cxt->akey_table->entry[0];
> +}
> +
> +static inline void sdxi_free_akey(struct sdxi_cxt *cxt, struct sdxi_akey_ent *akey)
> +{
> +	memset(akey, 0, sizeof(*akey));
> +	ida_free(&cxt->akey_ida, sdxi_akey_index(cxt, akey));
> +}
> +
>  #endif /* DMA_SDXI_CONTEXT_H */
>
> --
> 2.56.0
>
