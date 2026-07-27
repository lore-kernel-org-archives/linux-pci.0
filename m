Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B14A37B00E;
	Mon, 27 Jul 2026 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187662; cv=fail; b=N9eGtFCd/mplA/XScYjJqklqDA6nSYi7aP4fDVOSKzXa+l8XxhOg/zvG7vpq9Vb1Lfz/rZbsVN9u7zvVD4oOewZ9skyUES1+pDJM+SmXzVhAY6Qu5KWB/ZyAT6UBpQIf0dAS9719Nq1vrhcSQ3x8cF5QVN/2adKBh1ulaKDYJgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187662; c=relaxed/simple;
	bh=Y2sxXLoXf0+fWrpdJXOR04gakpi4UplkL3L7AjP7V7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jdWR8fTGjFKf9RWVp1iPbUX9ZUj27TOIAgOJO/nKs4peKaQbfRhtGVH90JSRu+speH4oqkLMiePd2P65ZgOFtDhhDSb11aLsGj2DaMkYBfm7sYxWvKhyT/2hEYnEzrXgz4Kzu+Ed3DrXyjVF4M8uA6NhYfpGkKcO6TtPoGshzQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KRd81+mM; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KRd81+mM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUINDWJ6Wy5AvjLbMB2FQjsoLq0uKsGQzzIKpmd4kshQ2HxuyWo3cRU1WFn0B37GsTXBpkj4wZdsS8YnmwVp00V4IkNEjmRCSkk0hCk2KqeiYLF56HO3TdGQoxvxj4CRj4CLcdRSig83H+LENxpUtzXouv0CbuMF+JoKAj9hkt/Z0sTD9JJNycBC+465pEMbo5jAMv3ab6IqzvUnlNwxssg7yAysKyZI3DfMalLvuTvyZkSOXxg3by8450QFlkrVYWDHgbB2ONsiiXrzuXcdLc1y2xnrhMvsKQQckH8CFmBnok4tnwbjQAlIvCcHT1zYif6OgJAxZsybIxvt6PV4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Y75/wk9Mf3ksGr6opY2hDUC0dfldkMC5v8gGeqYNoA=;
 b=J4muDrMtcmx+BqlmKWfnXsOiAkMbdafObfaMyYFqayzJSlxGYSTPlT2nV6cVXTltGEXCmg3QDxgpCy8L3oQmIixyMHX1ExhQi7ZKSOW7TlYoyt6xCer+6y46KisqyZuQtYTNK/lclmm9NZoXx51i+dDcE5+kiQXlT6TAe1jbgGEOaZSvOkSKM8fdNCI0zigWoKKtOLpSsTmJjn/QoWeKkhlg7RK1ejvIE42nW+omiMtGNHuTXAt9PYSDE/7F2KSsZQ5v3QATwa626VGhCp2ZdtL5JRMF+E6t37j3VNkjs+tDBeaqAXO9mIvZrgpdXeNaKdLYCQpezv0aGDFGEnf5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y75/wk9Mf3ksGr6opY2hDUC0dfldkMC5v8gGeqYNoA=;
 b=KRd81+mMD8WOCUxCks/OME7uFYRECC1vYnlPonhsmFxUXO8CpMAzzEJq1iHvNJse6FinaPxlhQYsnAdBWzw25NiOdgHO4IcHdmjhK7032qNNsyot4L/UupzrwWMvbTrSfYEM9YuPNzyFiwojqacGCzBXVNiRLMYHCIEp0FbQ8Vv+5qqcwBgnhZdRKabg1eFhN5vGffNkks7nAQJqDLB3f6bow2g0m8inIpVyC1JuOY6Q31ff0cIYAPX+Taz5BCvjBMwIgGQ7PHbpUjQrYw9QoFryC7+ZE53CWacpojpnEjnjlfb4pIdyTzAHJiHi60LEu+QblOptbl/3Sk4+KDqlQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7811.eurprd04.prod.outlook.com (2603:10a6:20b:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:27:37 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 21:27:36 +0000
Date: Mon, 27 Jul 2026 17:27:28 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	George Ge <george.ge@microchip.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 09/11] dmaengine: ioat: disable relaxed ordering
 before registering the device
Message-ID: <amfNQFfuoAE-FRjQ@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-10-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-10-logang@deltatee.com>
X-ClientProxiedBy: PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ade9b4-f4d6-4243-019d-08deec25e0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|19092799006|1800799024|4143699003|56012099006|5023799004|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XR62awX48OGv6g5FehXT4QWX2VYqIM1/Fsso+08SDytprRJJLqUIaARZ3RSUTB0DQRorjz2isqfkQusXPuuGghftdPhhqzGeygWLNVc9DkvdOrPOIdIdZO4e07awYG+a8Y/deb/TZ4/qNd0SwZH40T9A79C7NkbtdGt2Fb3pR0+r5W0FRR0OGD6Y7nZnArO04qcKwYKlDee2HCROLj6Xaz+V5K/PMiqLpLeFQSHw3o3zD6lj5FO9Fuz1FQffqlQLmtUbYYw1beVGhlBIX6gVArMRJJSvnJycL74pxzpPLIN6YSyLMN76oJkV0LIgf5RPWWeBgRb1Q4OhgaxQ8s/eq22KFtfK3F1bmgU+SO5vBkhaG0RFohRuoZyhKtfRblMQ9ERBtsvcUbQSKa5dtEMXlZwZDHs21NxJ/jiN/r4dMJhjlmmYkXQdoHyAb+3/sV1kLD6ttBq9i7x8sq+IbcvvTFY4BFmT2ivS4HDDArAuuW7z/jiiKexL2LEUjUF3HVwrhoD5ohpCShXKYzDc2vNLSC/c/XODWPSSkZDKDiJ52vZSCM9+QGS+0Ds5pXwA/znF5a6z0eJlZ0mc5oXrCq7q8kt8zyNCgIVuXn19Trkr+/rhc7c3aC37Ewzv1zf0MjGh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(19092799006)(1800799024)(4143699003)(56012099006)(5023799004)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcCRFpyVMg5OiV68Z8ZpU62reey9hxlgmWAdhmBZM+K5bGatyxeVeQTWQdzX?=
 =?us-ascii?Q?NXwKMQPQxV4QrAWhHVyoAxMtD/fwYZuU2/17mtL4G+UMQuybjq1RAcAVYcWs?=
 =?us-ascii?Q?nKvPa0hmfpv7Wu704bssslhLUHaDOCjMp4bivDi45YeIYXwoSMSCKbIwr1WL?=
 =?us-ascii?Q?bASSGhXCubf8OmuP2M6ynv/ajoVTK79W3PlzzPNrvR3Js0+NgSwXxtdkaK8C?=
 =?us-ascii?Q?GbxoJHbjeQzD6CWs9iptZSOzTM/JiH/CXr+tq8kxKsI7KgwkrFz5d5tUDNtZ?=
 =?us-ascii?Q?cNnUdX5fgQv8R+Sn9p74S08o54VTXwZD5gW1pBKMX51c87t7iprdZTTR5h+E?=
 =?us-ascii?Q?qw4UlDCTBCTPGImysII7iH3eM/abZ12ntBmb4qIV2GmPYZLyWvy0RewuVJPX?=
 =?us-ascii?Q?keT+rCprFa3A3Mqdwp+sUJlUAkSaOIIgVC5rQhdSKdV+g4+jjG1Gb7t4SPjz?=
 =?us-ascii?Q?sm5kqQkA3Dx+xcEoO7f/o51GCmeUXFU1V1uEQXLNh20g+K8MQdOf3Ni9GwBG?=
 =?us-ascii?Q?gMpIZ51o0txP583PjgG6l8u30JbJUwFb6bt2yF0wv4LKPRS9DdO41d7sOuOA?=
 =?us-ascii?Q?f5vaJykgKvtSwKPgY8FFukHQoXoDfhMGsCgnrn4pvdqlmJNedx3GzFegeJwv?=
 =?us-ascii?Q?iqKp1nmR3QlRr4oaoKEwcagdotT+s+rlu5FGB/mT78HlQbWxr++VGVVWSbJU?=
 =?us-ascii?Q?Yf8hfRSgAI5Q1QqTJf9FJtbCUuiiAMcZmj34m1L63+TX3CpLPqqCrjMCBslY?=
 =?us-ascii?Q?E88g3nj6WTB42lfMB+F/tpJ9879IuMyWa1uSz9P20DmlVIxwUtBopovtPF+e?=
 =?us-ascii?Q?+iN5sDnS89PmJzwW3tIJYmN0LvyhCghIkdQ8RKNpMbc82Ne/mT9UdfEV40jc?=
 =?us-ascii?Q?pd43MJsO/A/+6nscwr6LDKeWewzXgeFTf/Phf1V6wSZpWnWbXPCP3lKQ7Tr5?=
 =?us-ascii?Q?SDzprZp7zmtbm9wKIoD6lnwCSNsBPKeeRkHTlKK+yR1Gl7JWAtGb7hx62d+n?=
 =?us-ascii?Q?HbvRYlgJ/zUvM6SP86Z+qjRA0EaaZwyCCwjQw8qTyeAAosdHm6N1GmmAwRB1?=
 =?us-ascii?Q?xCu74+ANhr5kORFumxV3BYgxsN589wCfX2TujpZ3qftBCY+BRMxv9IhmJFu4?=
 =?us-ascii?Q?hxqE9RZBxxHCgq4T4dBpaThr30V0p/qWRR+hJTmcDUhHUIudD12VjW4mWAvn?=
 =?us-ascii?Q?LqPgBJY9SyYIuAtfbRaF47ueP3Ijhr479Xeg/IfBbT5lc8aiWaf69NvwYtED?=
 =?us-ascii?Q?LJKnGtGeoxg5PnzMlCyPqY8T0SpYZo+VcuqC9KyhRtr04vBTN6bWR9yE4ro7?=
 =?us-ascii?Q?+UCFLCQJSH8EHGEX6wlfdgG8rjPsxh7/3D2m3vAslFlAYo/4QOdk2vBxwRzz?=
 =?us-ascii?Q?05YEBzt47er8fQRTPue6ZC0wJ0pc4nPcmj/25GfOwlMAv4ur8kRs4hKRiydw?=
 =?us-ascii?Q?/2GgS185zcJWi++cdKUX4pPsRte2hYuQ6CuVj4pu/oR34IovoOcdz2F+4CKY?=
 =?us-ascii?Q?/7KzTm3D4clsvI5U7EPRgf7D9BYX6+LUIEw7H7Wi6HZYLaktscMQldWmxYj8?=
 =?us-ascii?Q?yusMv7dJ22FTMSQxF/rzv2/r7D5sWx3cXO7IHo/1veStUtm21DmhOiy0EWKv?=
 =?us-ascii?Q?rDHsXMRcxRcC9zkfU9zTggCHnC5cYQDMU9DG7MlbV0Tz75xkr3kGUoE6C7PJ?=
 =?us-ascii?Q?Kjp7cEQPs3Kb3yGracxbZBXh0ofLCjrFRJOhZDatCMiBlk6VNzPwdseFb0eP?=
 =?us-ascii?Q?h4mMR9KgQ4iwACJ6RXzqIFJ67eQSSneI+/ctyAQjFXni4TUzi+IW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ade9b4-f4d6-4243-019d-08deec25e0a0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:27:36.1291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDyGvgzGIK3//+o0NBxqIuXtyxKpfenaosw0spZya7DQgkV4QV+EmmrfRgVotswLgu97GvixhUcIYWJk/9GsyfDyMCsaEQLX/PMWs6dJc0F+HKPo6le5m4qLhIgvvRes
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7811

On Mon, Jul 27, 2026 at 12:15:24PM -0600, Logan Gunthorpe wrote:
> ioat3_dma_probe() disabled PCIe relaxed ordering after calling
> dma_async_device_register(), so if an error occurs and the code jumps
> to err_disable_interrupts, the function returns with the device still
> registered in the core's dma_device_list while the caller frees the
> ioatdma_device struct, leaving a dangling registration that anything
> walking the device list can dereference after it's been freed.
>
> Move the capability read/write ahead of dma_async_device_register()
> instead. Nothing after registration depends on relaxed ordering
> already being disabled, and nothing before it depends on the device
> being registered, so this is a plain reordering. It also means every
> remaining step after registration can't fail, so there's no need to
> ever have to unregister the device once registered.
>
> Fixes: 511deae0261c ("dmaengine: ioatdma: disable relaxed ordering for ioatdma")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.kernel.org
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/ioat/init.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 737496391109..a57024c4b066 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -1170,15 +1170,6 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
>  		       ioat_chan->reg_base + IOAT_DCACTRL_OFFSET);
>  	}
>
> -	err = dma_async_device_register(&ioat_dma->dma_dev);
> -	if (err)
> -		goto err_disable_interrupts;
> -
> -	ioat_kobject_add(ioat_dma, &ioat_ktype);
> -
> -	if (dca)
> -		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
> -
>  	/* disable relaxed ordering */
>  	err = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
>  	if (err) {
> @@ -1194,6 +1185,15 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
>  		goto err_disable_interrupts;
>  	}
>
> +	err = dma_async_device_register(&ioat_dma->dma_dev);
> +	if (err)
> +		goto err_disable_interrupts;
> +
> +	ioat_kobject_add(ioat_dma, &ioat_ktype);
> +
> +	if (dca)
> +		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
> +
>  	if (ioat_dma->cap & IOAT_CAP_DPS)
>  		writeb(ioat_pending_level + 1,
>  		       ioat_dma->reg_base + IOAT_PREFETCH_LIMIT_OFFSET);
> --
> 2.47.3
>
