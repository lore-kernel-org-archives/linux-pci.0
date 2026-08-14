Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983463CA4A0;
	Fri, 14 Aug 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737094; cv=fail; b=Vx9vd25rFwszL6ffBa7Tsx0intz7XjxgHHGB+Yx6JuYyzrGD6nWlSajoAEOu8JJjd6vvKkL1OoBxIQFGpuDvrVL2e1dJGduLyrNE+REy0GVprPCjTVhq6BWpwNo6sBF0y91g6LuVRBUYw5gf1qFm6kE851puiiyRVRzsgfqTawI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737094; c=relaxed/simple;
	bh=MbZdOZxuwzrQXy06IGM0btjq9qEzmScs7BDBOgqQWzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nmfAns15FAOihi0OPr191ieSoux7DRA3KLVBMsvLhuYj0MWnvUXj4ekxWl8CLgU763/V8RpR2pbkatibdeoP2n/UosKvxSPkC8Pm+zGBEruFe3V2Yy1Cx85fHctpbbm6w3jBglkUxNHBD/1CmFWAMvPogMbxuMOg7yUV6CYLT/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Lopoiptk; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Lopoiptk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzuU3NqISN6F7QhCabGljzmkjlx9bDS99iYjrHidQqQTQtU25VFKmANSxShZ7Pyok63CNr3GxoNMIZKQwHHxSXrrS+9LdaBS/sYQBxVfp2SWk8yTG046e8duLS8+6dkwz0xj66DVGSZOTc6VL2GLKCnd69VqlO/xbv7qYiFTZpYL5jWWbmER2Iq+j/N4n8uaiaTcd2e0l1y/Mo9lXS1RziYabs7j2/5h66fWan1IzFKuHTCa67N+x5klIQCXDZ31ZpQZeiOYwFTsMmVc7A62ff70H055+Vm1eMi4DvX2YCyDZKnryBIN/w2PUlAI0N6oNJAGglQ09Jo7Qw9SZuir6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtyHTGxjuv+/g4M8hxkkerAdzj7ARIX7T1U88aSynbo=;
 b=YaPoRjMvL4oWIJPjsbFi0vAS+0OT3/qyE7WI14VAiMAiG2LfmXUNtdDmBFLnxQyew+UKT/qMNg+NIYowcEFATu/B2JfE0Gtmq8nQ/NLYFawe1wRJprKlTUDXAEGfdGiyiOc1xw0tzyScK8ABWl7lOm3x1dUb4OX6yx/jC1eWfM8MHKAWMpSIBporBZxesNM4b/xIZklcrp3QRnX4qReEHM0KIuK3vDjzqqABeveYBkTwHzx6NODKYboIHD4v3/G8BoeJ7FHi3x3qwaHvWoDajoyCVAsfVfZTQR1E13Ba/zfYEKXbMJQT836gJhCHtZIy2Aa32OJueOK+hkhk7hx7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtyHTGxjuv+/g4M8hxkkerAdzj7ARIX7T1U88aSynbo=;
 b=LopoiptkKErdnaW1wbvWd4a3ezsVcPrxr140zok+HQ14X31jVUhODbLiV5+Xqisp6TRoC7QSE+F4/H71vtXCHNO7PjZVfdl7CuUTLiVirhy5fNrG3/fb0hBxN1Kym+t4Be38oW3JWeNqGbT5lRLlDgvkdL9n67SezlEvQHIJm78lwg4UVqOOnvJf/AQuayxZtlmQ/d/oD0+3cq9YYK6axPk/DX/tRvNkgguz9jcGug9wgrIx7HULWK3bGMpwQeBK+vw3H5q3bvfI0I6EnD4Kdcx9ZS0w2YtvioVPn4bJHwo4qnrFWboWqRFSTMnllQvpBwn0uhq06IuraC1zTLdelg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by OSKPR04MB11463.eurprd04.prod.outlook.com (2603:10a6:e10:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 19:51:26 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 19:51:26 +0000
Date: Fri, 14 Aug 2026 15:51:18 -0400
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
Subject: Re: [PATCH v4 04/12] dmaengine: switchtec-dma: halt channel on
 alloc_chan_resources error
Message-ID: <an9xtp8SHJeaBmNF@lizhi-Precision-Tower-5810>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-5-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728171523.112244-5-logang@deltatee.com>
X-ClientProxiedBy: PH2PEPF00003857.namprd17.prod.outlook.com
 (2603:10b6:518:1::79) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|OSKPR04MB11463:EE_
X-MS-Office365-Filtering-Correlation-Id: 7151e4b5-f555-42a4-a905-08defa3d6d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	JCqfACumID2aXg+r6JzJq+eHTMXhaUBmZsjRwbeupf/MvrTEvZrYnxaFY7Tzl23IaCgG/jE2mlIoKTyqsNL9gi69radtsXyvyf3xNEQ4DgtSSe6kBEVeNsKbAq3X0PGhtdqhDOC0qTwKOkmE18VTZeCDKi04lGOqofQdXJA30f0E5L+gZY3ZOUzT2v8RT3MN6QjCzgVu5v6yaX1fCgN1wEIQKRQlFtotdAdgo84WKSmRHGeiL/9Dj8UgUxBlzmPy4XTiIyPqdeiAHUr8FBGYHQ9hJNlWAQbg2Iffgn6C0/eV4XvcdQLASE0ypCIYbWwbTOCM/mqTLgcAYsz2k5IUTFLH3FZzXj5rMBRZPiyYCeHj8ur0UyDsPSIb3DawLS3oHmRLgcKyWUaM5k/9pOh189wKkD0qF7dINEN5yUeF0Nw3IY3IatsE9s8zTIjZXS8BjeNMRDTycHlNAdZLm734S11k2nVoJY7b1zSit0ABEOSm9ve8laKhVFVx+gfMAiFWWN7hZB3Rtavg98JWUK03NXEj+oUz7gy4+4g4xQEPGW33eeG8NMYWmOggIyqAb38LqVLRmZ9DNI6v5cSsjsTg3TdzhG9MEr8bPBcAIXlCsRCY8zjBRGzgG/0tu5vgY+bwqV/o0/RQ+zp2hstFnObgx6R7w6oufw4gGyb56anPfMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DV4RssQ5AqdhtHR9rMdQyURmpnaIAuySAxk2VG7bNsw2nFUhoCMaD6vntam5?=
 =?us-ascii?Q?cqDc9Q9AWY0dTogWP+gFlLSsM5EfQDm3LzIn83RilAn0MKCH6+O7IpRi7YBv?=
 =?us-ascii?Q?XWoYF41FTCNFKZaauG/JeRXeR/zsXwTrdb4oOYvsBDFsR7m+79YuT0LWVn/D?=
 =?us-ascii?Q?h9OZhoo5RH1j/hoMLHEs08L2LRITug1qQBHxOg+pwnmnIgVeB4jl9ofY1T52?=
 =?us-ascii?Q?u7gv5rvsGntMMdILFloRBkD7cCreVkishy3QeFAEwKUhItkq6PY81l3KHhQl?=
 =?us-ascii?Q?1VOLSFvYwOjANg7yIvL58cXndB/uzLEuN1dN7+UZ0UgVMprqdcR/TBVxb4bA?=
 =?us-ascii?Q?t8/97lgB9+PldJiyXsEMwBBhvf710WjU6whmyuAZ6+1H4z17amwVTRCuooze?=
 =?us-ascii?Q?/ho0fnD2ODlYuEBuD9TsK71EkdWXSK6QWi37SrlCF5iG1W4UbtildMc22LhH?=
 =?us-ascii?Q?AmyLYrn+Smd/3ZWtKfJZFBfsPuz6A6HUTstZM+MZRmffawNh+KajlkJERm5U?=
 =?us-ascii?Q?itICNLkOLBVL6gCezCSErR0Yr8bcS3uvCIcVhrbIicNZieC/O4pjAOi1hAgO?=
 =?us-ascii?Q?fCYWfejJTozf45KaKfqoSR1FNwZNRxihczSUlYf0m6Qq2FNxm+JYrGpc9FqD?=
 =?us-ascii?Q?EO1DVKcnBW0yI2FaVZ958UG8wtgEI+npVHTrRw4vmC/ZtZ4XXX0teXHp32ao?=
 =?us-ascii?Q?0jSRZNkgPdGainVcJKqsxImHLX6QqyGGPz58kpYSJSrVkbT6KGWu5rHK9MDK?=
 =?us-ascii?Q?HGQspi0G7zsBRiFGzkJ9WbARqDNQsGA/Gdnzdd5kVfqk5e51L8VbR+XGooPS?=
 =?us-ascii?Q?WRJnYyuz6SphuJt1Aw7sifsbPZeJO82yphSMsSqhObyeUVM4Uh/16O+nv60p?=
 =?us-ascii?Q?ZtlzM0Ux1AP4SCPho6tlUhNXGD2GfEjj2Bj6KTNtxutGRfTOF00OK4XTfBDk?=
 =?us-ascii?Q?0KxjC+QrLeAg9FDp0j50kArp+MgBkJrodj3EdhaYsrfXgotGson4nMpEE3fc?=
 =?us-ascii?Q?+fdcQt6nKXTmyWNKDggEA1L4lxoN/LHUTXKk7UvLznB+Qdeto+gb+8lOq5i1?=
 =?us-ascii?Q?gm6xqlBC4wSlgY6f/VIb3vlVJu6+K4aO8Vdbfi1fYMamr/wolZHQB7ifVjtg?=
 =?us-ascii?Q?xEfFQep7i+OYx2AcubGWuuJ3kU257sO0+R8P2HKVolwrs50FJ4YYGccWPi4D?=
 =?us-ascii?Q?JX0bo6XUeJqUGVgQkOgK1zk+8whSTwSgZmckmPo6ct8La0qYzqmsv7DLMSgx?=
 =?us-ascii?Q?IuqOnZCaw6yIowtehjKYi13JY61efloyrff4XQSnzkgdvYxiE3cvkkAV+/3p?=
 =?us-ascii?Q?pO+W42vG6c5yvV/RjQcOVMhkC3MPWCrzAruFYDs/11P22+NvD+KqyEiUq84b?=
 =?us-ascii?Q?WeFzDnwHVkMvjHOlXANNbv4dTY7SO5DgXHNnATADdvN/bRVFpca2NS9+u2O6?=
 =?us-ascii?Q?5pqPvm8Rlxx0HP7RGjSnL0BEDqeZkg2XDN6N5Kv8ZSDSYt9IX069su7Pez2Z?=
 =?us-ascii?Q?AjajZUmU7YqrJT+T8FhxmCFu07XUBBSAqJOxxffa3iI9ZeKnYjkP3Euvikwr?=
 =?us-ascii?Q?cDXL2HgtP2z1B0sp0wgFZ8fgtfevQzdQhKbWxqWniQ2uU7kJlOf6Hl871RJC?=
 =?us-ascii?Q?zM19g9vZlxzECCz5Ggqf9zCbo5ExUqxZ2h5pzCP453K7Q+QAE389NlzQ2Fo5?=
 =?us-ascii?Q?7fL91hGx5yTGYNCGNRAgJbi+xMCx0ivfDVx5NG+HVj8h4cXS3wO75D7gHYAB?=
 =?us-ascii?Q?sIZiVSJqOZOk4ubCtZAcypnCVqOeR2Dzx0IEEW0OpLE403/uJsI/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7151e4b5-f555-42a4-a905-08defa3d6d3a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 19:51:26.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD1nf7fO+q0fgzercla7V3WSS8mNXOF6zuuLUuNlwQwfu9ScCMuJXRSBsjrAG1WHcZwPrzjmSq6wfiB4R402maZ+tY1E4RFtJrq1W8WB4bkauEDj42Zv2fKivUg3bmjw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11463

On Tue, Jul 28, 2026 at 11:15:15AM -0600, Logan Gunthorpe wrote:
> The error-unwind path called disable_channel() before freeing the
> descriptor rings, but that only clears the enable bit with an
> unflushed write -- it doesn't halt the channel or clear its DMA base
> address registers. If unhalt_channel() timed out, the channel's actual
> state is unknown at that point, so nothing guarantees the hardware
> isn't still touching the rings when they're freed.
>
> Call switchtec_dma_chan_stop() first, matching what
> switchtec_dma_free_chan_resources() already does before freeing
> descriptors on the normal teardown path: it synchronously halts the
> channel and zeroes the DMA base registers. If the halt itself can't be
> confirmed, skip freeing the descriptor rings (leaking them instead).
>
> Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260717223647.F0A051F000E9@smtp.kernel.org
> Link: https://lore.kernel.org/dmaengine/20260727185101.D221C1F000E9@smtp.kernel.org
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

Like patch4, leave it as it now utile we found go method.

You'd better post new patches, which just include my review-by tags, so
vnod can handle easily.

Then continue work on two sashiko report unlikely happen problem.

Frank

>  drivers/dma/switchtec_dma.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index cbbc9ad08247..25b988e9b4af 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1047,6 +1047,10 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
>  	swdma_chan->comp_ring_active = false;
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  err_disable_channel:
> +	if (switchtec_dma_chan_stop(swdma_chan)) {
> +		disable_channel(swdma_chan);
> +		return rc;
> +	}
>  	disable_channel(swdma_chan);
>  err_free_desc:
>  	switchtec_dma_free_desc(swdma_chan);
> --
> 2.47.3
>
