Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7830594E;
	Fri, 14 Aug 2026 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736754; cv=fail; b=AFeUAf1Ha6Y1utEmS672de0GXIsY5M/P2G5K4zfLTVDABDsK8JhaYiUdB/ZMXHrY0Myy4TrVCV9jiycDnQdnQK92tov9xsP7A3jn5kQv/TAlz8BKg6SKzhSrssCcebWm5/uCnvp6pw1PimV2Tls1EpqngCt05VVCX7bSaYEFzNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736754; c=relaxed/simple;
	bh=M6VE+1c9TvwCgEtwTvvIYc4QnVU78A4tZmzqx+NeAu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bJvNVH/u3123GpOhR+Z4g6kR2tPkhw54ydOXXvpwY+vV7muoQFY4WrQ4XStSL02A3hhJVncyxqtzPzH9gACBAMhGEVSzZPaIqTL0JUhHp+uIDUqsoGu3mVf/vXhjmEdo6ThZwW8QBh+qK3oPDgM42NowPd8i2ik55p4/RHdu35g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=myKCHg3J; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="myKCHg3J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTryyQPt3ZFREBqGIAvBYRgvr+4gBO3XhgogfYgu4zqZgO0uIjRMRDqXVDvaDaUayZnnIR+DtNfKG04ih+3BYd4ZgLFZBAECrt/26meiU83aAzUKnt3nGQE7TyneQ724Jq+7CmcvXbUGgXt3I+FehtQMq3aChsfDdxPFAFqei1OfMR70UTuhrX0rAnqd5SwxmFdliCMvJqZxeGEg6Pu7x8D8hFZJJHuSFhC2ho2sBJogu4E8TjzK14WZi4V3ILdwpCNHG5Od0PHoUW9qnTrVx+pN+b743z3vCt/XaDRqXs6duQ0lDdgXud3DAgEuj5U4nHOQTO+3nrz/u+wHitizRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJCO/PPi/ZHNrkE0x29vkfzVdh4+zxsAwI+6NqOZqDY=;
 b=Q35noUTbtzzQoPRersUiUHKEBlN/XyO93ubzm7VawxFxz1lUks+2xgq1BN7hzJ/IHA8oFxxYO745RzsLfiOWnxm19ZYzRCNOmQXSx9hubsHRmtq+93KsoNt1xLj8KLvtG0glheo4V56HNu3zTU9UKj9JLXu8n73oVrlfKINkWUSnpDRaVXblow0bwnVjRa/KBxRiFv0KjRoqe8PRVogYj27LvChp81xn4yJT2ws1dxbhnTSt+gCDpylJ1SmP23/o5V/KNyOliw8UjVPrtI4bU+gKPQdowh6BNFq3svB++lRgEbMT0Zv7g5Bx2HHO4XVFJM4zZNcVq/CROltLT21r0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJCO/PPi/ZHNrkE0x29vkfzVdh4+zxsAwI+6NqOZqDY=;
 b=myKCHg3JgpmImFbbfU+at11W1J5totNswv6ZUdmjkIh8iTqA7ybpz7Fwtc9O9lkJrRqwZEG7IgBsKLGFuKojs5WbY/E0FyE7sVDawaVz+Vl9VcV4K6Dv7lkhWj4AudRqLLbGOYpGlDIuQxzZX269xFGHHzHMGRs9gXU40tUsTZqOkGirvjXMKxS3bEt9HexA7qSDa2Rx3H5ZDiG8xaaYwxdXJjHSxEM4jxb1o3Q8h2llG28gmG2wAGFs3928WLru6AYnnFC+jh4+TGVChHcuWL7qC8RLtc4avediGWZi0jzZwHaIOa+fp1VinOuAEzpjcowFU7eg56n+tErVfcHZPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB11259.eurprd04.prod.outlook.com (2603:10a6:10:5dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 19:45:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 19:45:48 +0000
Date: Fri, 14 Aug 2026 15:45:40 -0400
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
Subject: Re: [PATCH v4 03/12] dmaengine: switchtec-dma: always clear DMA base
 registers on chan_stop()
Message-ID: <an9wZJiOXGa4q_Bz@lizhi-Precision-Tower-5810>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-4-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728171523.112244-4-logang@deltatee.com>
X-ClientProxiedBy: SA9PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:20::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB11259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4600d250-42f9-4a77-861e-08defa3ca33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|366016|376014|7416014|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cCLwgd+xC2AvD2vHvXd1T07RvvbGSqGqhzlGRViAiOT/HATjBvKWaD/1oh8iXUrPS3v65aqOPllQINPDN32Ry2ASjGv0Pjs/E7euR2RlONhl9deivqiH6EG/MZolp2BucwwLeWQERQndUhNcpyPstGs1y6NIAqcmrq5X2u7oD78tQ+rnj7Ijkuw9iNV76CihWXZVNjVruvwKjfq8gSdpytcLM5JbQkGfU81NSnvpu4xyVkEFVLFRaS+7UIbEUq0aGa5E2ju+4aDwTqYVKs6aUuAjgCD2HkL6p7txAVDeFIBQUXY7IEjgPc7fjgRxfnMItDHQh15vAusCqo6aUiD6Qf96GJxFA21Vrn1Px6yCa9nkNOUSfadHTNYGWBmSWI7Aug5gfT5e+XNeebxKk0nsPTyzJal4BInORNC26Oktvt4BHD5eCd6TIANKMutFlYEBX1EZUG3Gg1Yh5yFmWss/Jq6EpodxU/t1Qlshhe48VluiqSVHG6IxH9um6AjNkcfmcukFbhoDasWzOVyCmJ+U7ZB+8/6rww5c6sxe501jlTuXgWOsWSsxENOw2CAgC/9aZRWCnJVO7cgh6P/AXJTV8WnJu9V1jD8i98BR1X4Xi2PxNcZ1CQGgYE7a7D2J0dxH2/XErWZBl8YREwhuD0VqpsDupMBNn+7ZO5+FPcMwvxY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(366016)(376014)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hicXrkYYK9qD4qOVy10WH3YN7iV9ZcmHtyGMxKBzA1e2A8ABZWbn5jRTDD6R?=
 =?us-ascii?Q?97WByjysC+2xQKVRYt1cmJfBBpgVhMmrjBpThs0han8vpp/pNi3Y1RvDiWnx?=
 =?us-ascii?Q?dn3BdOk7CHeSWRY4DYEx2k5BXU4JaKdeGngdvSsm4Q/PQ33jLf22GhF3mSoI?=
 =?us-ascii?Q?ocPCY67Ezvx9obHbRtxh1OsAy2k1z6mfQ/iHFDYjV51jI9xkhlqoxAuF0Ngt?=
 =?us-ascii?Q?3u1M7mtfd++PAln0dcHLzluXqUnlIYFGUTYnkvLV1JVArjXnLIRzClzLqR0i?=
 =?us-ascii?Q?dwuLmiKF5Kf8Ah323rJC+fACRxdpIfPZ0unJMTtN/zbb45500ySiIuNJqI8n?=
 =?us-ascii?Q?0u2Y8CepsdaQOuBKJsS3E1zd6qb9P80rG5RXl0A3zXF5ysc2O4k+Pn1j89Bx?=
 =?us-ascii?Q?gYQArro/JWBZau/kl/FUmswf7OpZfujagnQx0k5001NQ3K4C5aurRstQP0w1?=
 =?us-ascii?Q?jCPjmolN/pATlftAw2RV+FHHhvLLn5YSF66z3SIA2b1faf5fHj+1ZJkNOQ2u?=
 =?us-ascii?Q?UWkxnYdvtsJuxzcH+rjKspTmUpQvGRAlIgThrs6nHPkrkX4X8u4egcjuLkTo?=
 =?us-ascii?Q?qp2bdFVAr71BfiresEaeIrTIJC0ZR9/EFz5knHCDhFpych1uPquk3Ru7VxuG?=
 =?us-ascii?Q?c1GdvzQpzy0XJfvrLvqgjLAnYgwFeyqLWeV3sHsjVLOI9cn+IyAOv37VGAEc?=
 =?us-ascii?Q?tzvE19Ku7bBiZKY5yRqlEdYvCMDFhoxbwLLGRlrtPtA+pnRCf+eyV664HFdJ?=
 =?us-ascii?Q?qgEk84cYxp4gM3B8Y+4tqjZsog0Mw5IiOQJYwrUrTiMvIBAgACF9KG4frjzK?=
 =?us-ascii?Q?l/OT1XbwcuaAKv58cODO6pOPQ9qrTuL4Upt5iKJvwlD/WsceboR30Z7iKIl3?=
 =?us-ascii?Q?cP1hgn96W3CjvUlyGClxsOR73+Wms6N0ZV41nMAE8fpYa/6V4CW3VY8nWQFv?=
 =?us-ascii?Q?dsFueUDpJnNogLR5XBUsjwZjwTQy5RFLaxw/SvN+r0KbMZm/BS1c1/BX8jZA?=
 =?us-ascii?Q?xwFg23llkL1mMj4y2omqBAHDR61NJ8ZAfo9uUkQH34MWdzxQNDFgIJJHB1Zu?=
 =?us-ascii?Q?f9GwKj/q2bKdn1LUBSEG8DzkqAgJyhwBHqqD80a5yWCEjS6gVefNHQLNVZwR?=
 =?us-ascii?Q?wpNHhY1S1Zc8FZz0IHpAMtJyVGLRM8tMJ5S9mZ/D94Z45KvPvgqbF+kflc3S?=
 =?us-ascii?Q?YrYL0oD/76C2b2CH2/8Ks58uYe8sRdhYWFX4CcjZPZaNvbSfd1kv48MxByNS?=
 =?us-ascii?Q?4TfDVEOzndm4vaHHm7MQ0K2ge8czMjwpvwj+ug21nmnzVl/n7ka7xWun87Ez?=
 =?us-ascii?Q?DvtDAPNoA1DSDmRL2eOpDvfpVOMq3gHkXtEDPqUHOnI4uXmwhYgTzJxsU/f1?=
 =?us-ascii?Q?9PgUa1AehHcMZXXH6GbeT+URwYkHnu0tBbFVMa/tkqNRQmAL4xcwJsrFehYj?=
 =?us-ascii?Q?9laqh7ghr/nx/k97DA2KDqUWQzN3mYlu9i7Sjc1f2KYbLEd85rjOlE/QotQe?=
 =?us-ascii?Q?TJe5Hrm+b2mbEOKeP/djwvV59QTxv9cW64IWa5HeG5jT8mz/TQR+pKwPqW1g?=
 =?us-ascii?Q?WbuMwr/vsUcQ4AoLrad+gNg7ash8t0Xa6wvCg5BYxUtPVr5fuwhhhCzoOuWQ?=
 =?us-ascii?Q?ksbCETMbwLJRg5VSBfAzkzumqIYs6bQIvLQ5FGcDPimSd6rkrx0ajkDIr02k?=
 =?us-ascii?Q?95GL/q70tWitC3n+KUGWXMtmlPKOqzIczUzPDSv2JY5/WXGANo+qiXHYMSm9?=
 =?us-ascii?Q?KI4gnQbGMyeBKC+qTHG6xS+1JnBOBRk5NRBkJ4G6ydZp7pKg7fwf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4600d250-42f9-4a77-861e-08defa3ca33c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 19:45:47.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Wmf5XL8IcREVggyI70jXgYcLt+scAjqqrepoaCUHpb5yeVFYi/rWJQSikjuYNRBNR+9JCNGTa9P/OGUIqRIuzJh7FkkMR/+/RFRIujIv0KAetKc0oaroX+wnkr55pFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB11259

On Tue, Jul 28, 2026 at 11:15:14AM -0600, Logan Gunthorpe wrote:
> switchtec_dma_chan_stop() returned early if halt_channel() timed out,
> skipping the writes that clear sq_base/cq_base on the channel, and
> gave its caller no way to tell the halt hadn't been confirmed.
> switchtec_dma_free_chan_resources() unconditionally frees the
> descriptor rings right after calling this function, so if the
> hardware failed to halt, it could keep writing into memory that had
> already been freed.
>
> Attempt the register clear regardless of whether the halt was successful
> and have switchtec_dma_chan_stop() return the halt result so callers can
> tell when it wasn't confirmed. switchtec_dma_free_chan_resources() now
> skips freeing the descriptor rings (leaking them instead) in case the
> hardware continues to write into that memory.
>
> But all this is hardening that is pretty unlikely to be hit in the real
> world.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260721162531.BA01A1F01560@smtp.kernel.org
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---

This common problem when timeout happen. Before we have good method to
handle it, I suggest leave it as it for now.

I don't want to introduce new problem by fix an unlikely happen problem.

Frank

>  drivers/dma/switchtec_dma.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index f77da31aeb65..cbbc9ad08247 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -543,26 +543,33 @@ switchtec_dma_abort_desc(struct switchtec_dma_chan *swdma_chan, int force)
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  }
>
> -static void switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
> +static int switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
>  {
> +	struct pci_dev *pdev;
>  	int rc;
>
>  	rc = halt_channel(swdma_chan);
> -	if (rc)
> -		return;
>
>  	rcu_read_lock();
> -	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
>  		rcu_read_unlock();
> -		return;
> +		return rc;
>  	}
>
> +	if (rc)
> +		pci_err(pdev,
> +			"Channel %d halt timed out, clearing DMA base registers anyway\n",
> +			swdma_chan->index);
> +
>  	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
>  	writel(0, &swdma_chan->mmio_chan_fw->sq_base_hi);
>  	writel(0, &swdma_chan->mmio_chan_fw->cq_base_lo);
>  	writel(0, &swdma_chan->mmio_chan_fw->cq_base_hi);
>
>  	rcu_read_unlock();
> +
> +	return rc;
>  }
>
>  static int switchtec_dma_terminate_all(struct dma_chan *chan)
> @@ -1050,6 +1057,7 @@ static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
>  {
>  	struct switchtec_dma_chan *swdma_chan =
>  		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	int rc;
>
>  	spin_lock_bh(&swdma_chan->submit_lock);
>  	swdma_chan->ring_active = false;
> @@ -1059,9 +1067,10 @@ static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
>  	swdma_chan->comp_ring_active = false;
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>
> -	switchtec_dma_chan_stop(swdma_chan);
> +	rc = switchtec_dma_chan_stop(swdma_chan);
>  	switchtec_dma_abort_desc(swdma_chan, 0);
> -	switchtec_dma_free_desc(swdma_chan);
> +	if (!rc)
> +		switchtec_dma_free_desc(swdma_chan);
>
>  	disable_channel(swdma_chan);
>  }
> --
> 2.47.3
>
