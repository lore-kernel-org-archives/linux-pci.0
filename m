Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8D642A172;
	Mon, 27 Jul 2026 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187779; cv=fail; b=FWwz68fLhugjj1h8wOwYe5VGN2D67PCdSHTZCthRixQOnl9Oq7ihsMK4h/z+0rgKkt0IzldKCTbpbg6+U45YalcDda6tP2tKGSNiMEttoXhLpd5cndINmxugaYI0/yYccH2lkqo+5rv0/epLYEAU8/3VBuGo92wAsYbR1/4o8QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187779; c=relaxed/simple;
	bh=hzXOLOy2omLkpz9PsrWK29f/+uzUH8UZ50R6iw00fHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UrucHQ/bREGDMoMtgS6NF/6WK3VdYdJn5fjU5uFEPe4aRXD/V2ubRo01sL/OcZ7YPIh+n3+iv/0ZjEtB8UfiEZfn1ZZfHQkpWS2iwS/2oPOgU3ssGYfNEnN2Rjx0Z/5YWcbqVvMDiGf3vLW+ZIN/CsnCBNc3CPJ8oGr+CX/atzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CnXn2iVT; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CnXn2iVT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxq57BUCfrYpnKnBoDwBRZ76GV86Jt5IufpJvniFZxv0lOyaBA2/ndaGJ7pUrO9Uy+2INpwxvLkqZ7K7czNR8xV3J4s0KYGIzg7+wyekZ9Qwh+zEpvzpru7r78YtlgHYhrphFfpWlTIXIaJOadPH94tCm72GyKKJ+SW1yK9zAgHf6NHyT2//i4jYcd1403Ed4tvvMDtrBH+cRpJt9gAp+tGC5GmQVeGYeAKsYmHWE+epUwT7smgxgTYHJ2W38znls4tNruVX3h+rNDhcmzRmKngRbTkDC24V5MV4X0OeJJwJiO5H7pYl9CrPfqMsSnBKWWtA25fSoYvB0xN7GP2qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1nfsy5T8XkTXjCpEFLTEF6eHoRTxe3p3r6d2xj1wac=;
 b=G0PHDzlQLkU4GLn8vjcZNAramrhL4sHnBCq1zQP7Do6qLQUX89vjDwKJzHMsBafgoNVjrMDWKMPg/YSJSfwy6rVyBJ3CUq7Ub7Qly+nUpN5kiuG/IZR04y6PKpZZyIg3goWWpAsq4fWDef7zVekpP9vIpY7UCLA1hqT2zW60fAvACKMRSIG3umpXlFoSv7cmVhrC+Nf1a5Zk4vrWGjatv+vHFVbzPTzDUtZK4/3nuwY9Z1nvg2HgynTvJ8qkPVRJcJLvnUWTJk6pIozH0khspKpNwIbrt3otGAaVASxeINSxsNnWqgxGd/b84EDG8CzQX2bPnEbGZKtJvAjlYNqEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1nfsy5T8XkTXjCpEFLTEF6eHoRTxe3p3r6d2xj1wac=;
 b=CnXn2iVT1XEotpxoOHHBZyOeU+y7XXqRFheymipgnAydWBL+z1umHW2w56SUDqr36JxaZY4APydFstnEnBSdmNiu73DAkDT/otlGsINlMGsYHlfb+hC03wlRiEN6HAyZMjOHjLzflJa3jnCqQHKNSWkTl14ZUJLZ7baNt719RmwkboVckfAkG1H6MlXCgWQ8ovbqegzWNeLYAMDJ53U3GBvHg/Q+tWuoY1O9vWkrasjY0G1FJMqVzA20DDmXE+pC9MuPTG+er4lTaVdZxkKuYTiZ8CjC31dS4ed119kA6USVJGbHyucU5wLHlwjFyNSFkc9Nc/LkXUf4x7eB9f8w5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7811.eurprd04.prod.outlook.com (2603:10a6:20b:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:29:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 21:29:34 +0000
Date: Mon, 27 Jul 2026 17:29:26 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	George Ge <george.ge@microchip.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>
Subject: Re: [PATCH v3 11/11] dmaengine: plx_dma: fix NULL pointer deref in
 plx_dma_isr()
Message-ID: <amfNtg3NL_mlLNX9@lizhi-Precision-Tower-5810>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-12-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181526.9672-12-logang@deltatee.com>
X-ClientProxiedBy: SN7PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:f2::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 86acfc7e-0977-42bd-aa67-08deec262728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|19092799006|1800799024|4143699003|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZG3AqaoPrfdjY0nthVVJmJJpIaSjH2zq03ALgRZi+PE4FAeNbgIQPSOCN6ekW9GWNy1jc4+RQieenMbFyhqywtdL9f7qwBi+tIkgEW+RXl5SM6UFaWJ8O0i+XLO2AnW0xYwIo+dRGAtnB7fHlBHT+ebLXLXEiWsEjks6GK4LdxYEihbN0KAMV4aMMe0Rw1kMsX6PnfgBb7nYPo2xym/zlvPAqMEtNFMAsbNhBczsG9uWviwA6kyKrkYx00gBC0dpGqoBheQ8p2rMPfWWGAOHIB9NpjP9D96jnxyFFZy97TOMqpDHEupLleop2AO869pa7RxAobTXoUZ9l6kp8dPS243Tv2KpjWtCP0YmJ4QToL/uFEgiL5DdHQL215853wLWlPh0zlvc2Zero9I2j/rl0JlGYiosbKf9CN68Mqsq0PawcBDHp3UmGgBNajYvyNfzq6Z/Roqp85SP3locqSQtSbnFX85mE6cY8MOYNaxiSShrEI4lsD9d5234udR5bKytAW1OdqKpjCCd6y9YD64+5J49p0d2KdX9Y6uL4ARJGabgv4UMtTO80a4yxbtnmUie82mlHDxvh2qqjOj14mA7lp9LAkBDiRPFmkIGePFvjU2dpSMErW6CdAtcIQ4Ky0BN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(19092799006)(1800799024)(4143699003)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+LkGj2ESTOUYwA+84x5v2ygsJwCraQlBm+UORWHrWnfKO2DNIutmXPZZ86uM?=
 =?us-ascii?Q?GZsMPFv7CAofc/pUqsHYwxPXb1y+iH/sQl2THTq1wbQ6uGV/jjP+OjPEDcg4?=
 =?us-ascii?Q?sTagvHA6di08AQeEp2le5fycUIZImf1YggByqbngAKYbJF+fNhuH8cNyn5l/?=
 =?us-ascii?Q?9fb2fi6V4+FOAzxM+/2VvwOR5AV3ewP20w41KWY62FeKfG1eNhIbF2KSOxW1?=
 =?us-ascii?Q?yMogycGpjeXYUA6wp/2G+Kr25x7ur0l4J3Wx5t21S6fWaR2wgdiyMSKa2eBU?=
 =?us-ascii?Q?TD+15TU+DgpYRLKxqVL2aqTSpPMF4F8rb7u8mU8RYND2+TDjp0OVb85TLDzT?=
 =?us-ascii?Q?Nw4lu8uu8nY1lPw9zE+lGfkjhh8UjfSSXalZGhPXSbhwWvy1Y/BbNlN7wF+W?=
 =?us-ascii?Q?8YC1+Sq/KJ5dl8GzSjT745H7O9kIrv/B1ksw0QkUQmrYrXSHcLdnFf2ZbynB?=
 =?us-ascii?Q?0MMlq2yTRziLEIe+D4YXGdFxUIsHGeb05sc1A5XivRGzdIZ574Nep2i2PIiL?=
 =?us-ascii?Q?B1LH1dZyNQFK6LQtzcit1pC9zTmg1ombif92ztNk75wjGD7GwXIbIOVoiZ9t?=
 =?us-ascii?Q?XSBxWOTwQg+2l6cvPxzGVKFN+/WIoQVgldGielnSR6Rb9W5BWFdMJyRWe+Bp?=
 =?us-ascii?Q?TlD4OLnMOuQXMGLmw/m9KCNaP5beDVyZVYGe5SjB8pD8Pkg8LXYG3ZiAoWv+?=
 =?us-ascii?Q?ccXWdbrjRmlFArZAf+k2OdvaqO0TfmETe2SDTpHuxaP27m+W40UTJ/PVL3ow?=
 =?us-ascii?Q?Bf9WtnOCGy8kRI9ARdrKFSDHfgAmeD6MaGwbTo9cNXdTZZGokLLF/tyxsSFn?=
 =?us-ascii?Q?D4Hn0kXB6ros6S8toX0oxfLZ6fZZUvb/u3TklrxobII+npfgyDMvQGN2RZco?=
 =?us-ascii?Q?PYg7H0vSgF2iHqsd1mc1vMJndLrBIyaLc4YQXLRscmhKtDTC85PednMF7jec?=
 =?us-ascii?Q?PRpVzcpLEo2m/pm58NudQXK+fPjthSyIh2R3vPDzn3/FNFTxLqvFjCBUScDf?=
 =?us-ascii?Q?4Z9WIq3X5ode4hqa3j8scOKhjngHRhv56Dy43QtMh4FKzEf1xsYznSy/02+9?=
 =?us-ascii?Q?AWVzo7yEC8G81juqf8kU8kBtJczcpuB0y7Zi0FLs8RR3WZUNAj2wrP/Ucqx0?=
 =?us-ascii?Q?qRIJ94/rTc0gjSFdf7/z+thO5dIG0Di2KfeVPg4IarWRgY00/BDl5kdegDsE?=
 =?us-ascii?Q?hTjns4Y3Wf0Go+gkpEw4PDGpTgkqdQiVcOBYNiRcUnceB5XEbT7yxRrXlT2k?=
 =?us-ascii?Q?CaKdaqtKxav061cJlML2zacYGCfZ+7K9F3Hxb89P7snsReQiaiElVJpjd1TI?=
 =?us-ascii?Q?UkuMNxsRFMgyR+oUALwdAHwUK1saNSOFeWs0C2/PydrhjuzHb+uPmsW+sMwJ?=
 =?us-ascii?Q?kAgwmu5x4aNEqNnKR00ZFXEbGQVDWobNlZbA3iuY4Bsu6KkXySe+T2CHn6bK?=
 =?us-ascii?Q?KlSneREWmCiGY+jfm6Pgu6BcSQ7TQmuYvXlswWX+OMk1P9WUS6/U2FennDUZ?=
 =?us-ascii?Q?gr3XtJkfuWBKOEW5FTilpbvzAmmKqNohe+hrHAOWs6WThlFVYXC3vsuYzA0f?=
 =?us-ascii?Q?prEfC6KslvgUCYCqFCwZtcDp98McF/x8xFwgkg06Ue22MbI6e7qkkD/L5vCp?=
 =?us-ascii?Q?wkl5RME0lynzwIBXez1mCHGmlztwiMtC19NOsF0NfazyfDPgtPfJw+hWsbgv?=
 =?us-ascii?Q?3sOX4R3ftECsUwQ6wicCRdJJ7RCAocVoNEi3kFtHJQsj3QD55iSOSXxn+Gxu?=
 =?us-ascii?Q?/930grYa+0erjt6nqP6GGGyQb2HaxAcBUakMcMfgOUi6O7kEVGcS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86acfc7e-0977-42bd-aa67-08deec262728
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:29:34.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ix7J/7nSIOyc0wtzKaMqX3f+qrP0GS9WsJozesvCoySCRoimY6Q0VcGQwchfdy+/EkmfBstot+MPCAhLfzK+Ml3ch3N2DYbXTs4fYG+Zc+ojeykRpG0ba1xj/6LR59wT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7811

On Mon, Jul 27, 2026 at 12:15:26PM -0600, Logan Gunthorpe wrote:
> plx_dma_create() registered the interrupt handler with request_irq()
> before initializing plxdev->bar. If the device raised an interrupt in
> that window, plx_dma_isr() would dereference the still-NULL bar.
>
> Move the bar assignment ahead of request_irq() so everything the
> handler can touch is initialized before it can run.
>
> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
> Link: https://lore.kernel.org/all/20260610112121.676561-1-jjy600901@snu.ac.kr
> Fixes: c2dbcaa8c672 ("dmaengine: plx-dma: Implement hardware initialization and cleanup")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/plx_dma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index 84941a918b01..409898e92c32 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
> @@ -504,17 +504,17 @@ static int plx_dma_create(struct pci_dev *pdev)
>  	if (!plxdev)
>  		return -ENOMEM;
>
> -	rc = request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
> -			 KBUILD_MODNAME, plxdev);
> -	if (rc)
> -		goto free_plx;
> -
>  	spin_lock_init(&plxdev->ring_lock);
>  	tasklet_setup(&plxdev->desc_task, plx_dma_desc_task);
>
>  	RCU_INIT_POINTER(plxdev->pdev, pdev);
>  	plxdev->bar = pcim_iomap_table(pdev)[0];
>
> +	rc = request_irq(pci_irq_vector(pdev, 0), plx_dma_isr, 0,
> +			 KBUILD_MODNAME, plxdev);
> +	if (rc)
> +		goto free_plx;
> +
>  	dma = &plxdev->dma_dev;
>  	INIT_LIST_HEAD(&dma->channels);
>  	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
> --
> 2.47.3
>
