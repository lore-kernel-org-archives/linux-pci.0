Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021082.outbound.protection.outlook.com [40.107.74.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E639934C;
	Wed,  5 Aug 2026 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895527; cv=fail; b=DU3o5AH9wDwoBdObYMNnPhROtQ5qzo6aCpFRID0d83srRkmFmNlB+tX/HOrVClkm7b61RnTFFFf8YPbASK4qG0HfyNGHp5wxao7UQPPBPv0XkTrzJNXrWxZoPwYAekXgnL3/Rx8E2tZWpCHAonL7sCsFts5ShX7elVjgKl/6P8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895527; c=relaxed/simple;
	bh=jfVhlQJfzPPa0wZaGwmDkZatPnunjjswkxoXidYiavk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pLUAupY0mJcxSiW0snyGi+1y9D5PJWJTHuckuK/zpWpFBP5HxyEx6vbcOLeqV+nflxs1BwlK/ot4EnUNCM9UnpIkpVcdYw1Mv2+LZiPSyxOsU42oIOk+/uKR37Z3sK9VvPuNvagh1vcfEyEjvbiYKNTcGRGFD9Ef1qATdKjfs5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OwWKmnvx; arc=fail smtp.client-ip=40.107.74.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OwWKmnvx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSledEdlLTDM8Th2L3z3Cciof33qIrVRv4mgbYaN5dEfyTOGYkTZTCchK25qEDFqIQMrYGEgvJIzWwqxdyASgoXs+d9fMBNnTBA4wg0E1hiO4KNLLQQCftidBylyQOekFFKmyYTeWGavC3bQBeyNFOQ/jipf4jHN2NWmsGTQGZA2KSovPEVnAOGbrhdwxDg4YARITVYDKpUTwmRDCJPdrqqrBRilPdyfy1atk9B0wy01nMOGlG+K2EZ83A99SqU1Zn4oedjk0Tlt127ORWGdYSd/t3K117Lxh8AiUCRPIwOJgrLXxEdI2jUydf4rDKOSTaa6DNAuqAtmdz8P9X1tQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuEh+xAokU2zcZ77mAJBY4GWdGh8U6T70NQS1Hl+4BQ=;
 b=trQ2lns0H/QrCKKI9/x4Ax7mxgosQRk8EN5AtTDYTpj8EVKjhic6XgHoOVn2ePj9skpGKWUhR4WeDA+f9uJ+1OiPVU+l18EdXHZDHJl8SpMrCsTrCCanoqwBj0qt94FI+Gti/K9N7iEn9ZlyiwxfAHTzF10T8af4cys5aaCZKUg/ZgyFMY8k6oQWXKr6L68fEo1EAxzmvXbhxg0Bd/otHx7aRYg5NWCnvaIu+1PcMhmYmVf0D2zt91l4hbZPfS+w6KNUF7UcByBaJ9K1JwndqE8NaxR0+86OGLstmqGovht6zOFOl87ef0+QglGjxgU7WMisHke1HAOhScZVVxLHAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuEh+xAokU2zcZ77mAJBY4GWdGh8U6T70NQS1Hl+4BQ=;
 b=OwWKmnvxeYItT9MipWMGaOiEMm/TcS3pe8kLZZFrjNw+MK3Stq7e6Kq4D5/V2ra3GhIMEvljRCcvT4v2NJwTZJqtcW0Nu3b2O1+vFefOXva7t/V1W38NTwbR27fz/7BmldcBnc0kGygl4lkk9nzHlxt8wJ+bC85gJVwHtjxh3bQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5363.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 02:05:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 02:05:21 +0000
Date: Wed, 5 Aug 2026 11:05:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] dmaengine: dw-edma: Add delegated channel request
 helpers
Message-ID: <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <anISE4zj1odwT2aJ@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anISE4zj1odwT2aJ@SMW015318>
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d91ce1-d449-4a6d-d645-08def296016d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lsP5j4VYxyKjEXeSjxUHbkpNqGf3FG/z8sUvPo6AX4v45eT0trqmsO2CsJMDz1VcyVCnt4x47TqSXJdEFpwQNnXHvylWgthY+uZIs8mWp36yLd81IPmHZoHJqUedJxgy8z/QtAZ3fPSrdHxlU7wkL2q4292tATk+S4KW2/5NVzFiwcaOJfpCHdneN/P6aI3m0O5/CMv0WS9jELDWZg89Ttk4D/fe3vaytOL1t1GIQYY1vI86NNsjK4JgT7GRJ4wmVkp+lrom/NTPuUMIk2lsI/NVTB+dk8kTMn5PvTdol1BsCNYMZ3V0tXB+xJ0nNv89qgK2AW+kax1XLax1iTSS4ZdlAMqW9WvUDwEXH25Id+rsYXSn2DBWGYIQKnXIX4TREoMmWu0U73h5jerHFtgxUzIw0GWBRULAloeIvt2b1bMVr60f322S8pfm0wsbS0DRHeJ/GejyFLHNQhRzkmTI6GCxis3mTs6/t1I1EE4oPoqyuxYiyibbkIJMybsZCZnpx7FKBCCriX9NIr0cBjUyF7NR51Lyr3et9PSdZzG57ip/daaOQO8ilEQeDjOo42SXZcB9robx2kM6ezS3HLAfOccdkmvijFsfS1u9Cnt7EGDPuJgo6UxcoJcTRXK0xbJwJPPGltsPfM4VboZk7HjxPflFAVog+4sArwTAuYm4avY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?get/E+8pVSFi5XIFASsxh4khMr1/ZlOIBjVBI/TKhyI6Ujubgj2bLDx4Uk4E?=
 =?us-ascii?Q?GjaJTE3o0b9C2bMlNIDSusC89gOLM4bCUlPcO2YZJ5ob66yLqYil/s08781g?=
 =?us-ascii?Q?KZ1naMh/7PMm3M37lwf7ZTRPfGAG9oJOmND2++Wtv4q3aNA+y0sYLVU4A2KK?=
 =?us-ascii?Q?n3IIWPbRnPTJUTxiVOiPhZg19oXhfI2tUB+9fHaqESzO8bKPMZc+tV3lZ0iz?=
 =?us-ascii?Q?F9O6GtkhhhrA1VQ4XoNXS4uX6hxrnMi+TV4/56ED/zL0+ionOb7BZNB8tKMo?=
 =?us-ascii?Q?T4BYN0fxI4Yeeyp0Z2fFEqeTgkDpv7kWC39zCozVsscJrLwN+LQR7ppMnLqJ?=
 =?us-ascii?Q?yb7LqpLEZNW6FG1ZgVGxkbxSAML1PEcoNXqoHw3cXetwmteMIkHB8wQtw1AA?=
 =?us-ascii?Q?NDRlYsOwla/9WO7LPm6Evx3hyHWnmRIBIu10yM0qLHl6xAwJfmA8wFErdLOy?=
 =?us-ascii?Q?BdglWXbu6lAhOzY/+dkLRMI8fmA+OGCxxnW9VHrYFBMSHp2izjuaMdmRi91k?=
 =?us-ascii?Q?7oxPNi+sipzcpJJHk5qK4gSjvDMRD8XRevg5Mvoauox4IQyNPQQLPTXi0hRD?=
 =?us-ascii?Q?m/XeFGupYopNScZkx0LmjHPaOcEgIELbZr+RQl6PSEVc2MB6wF6AKulexVXo?=
 =?us-ascii?Q?yinNaX1lN3WwSzC+togkbvX9isoyEsBVjy//8S15cndDC/n5m9J04atkw2yv?=
 =?us-ascii?Q?jPTk1A7OSgNOPNz/EK3kNJvjh0ka2wq/rEPUBmY4dhzdfHbjKV+RcabxoHUY?=
 =?us-ascii?Q?1Vyf0gc6n8YryYxRPcWp3SBz5bTs2UyY34Qg3NESnjQeBxvUZSQVcgDwQECr?=
 =?us-ascii?Q?9tp6evibeMnkkSSwJ2iG7NkgTLYHtokIYmy5eCuEg4A+kQ1NlpzbVWIZc/6r?=
 =?us-ascii?Q?5m6adGKjI91PMRKKIpejEDtcVlMYtMAUTowJ1o+oRIb11iWk0Wyam7BgU0GR?=
 =?us-ascii?Q?Jl+FVK7EdLmzoKT9o5MD2LXnSU3+Z1rDcI4xoD1g72zBA5njxO2voQVx4t0h?=
 =?us-ascii?Q?jeqHmuuimsyJPNZcwX0+wNus7gUuwzCz2cBVfpq/VbTTZYp+WXaUuqKhiyWp?=
 =?us-ascii?Q?3KQjXA16ukK9MpCb9F6HnWdRCmh+LB8WgLbhFpMg8cm8ZG+5g78UIBTlOyHR?=
 =?us-ascii?Q?FnsWLAAdR2s74u59yPv+okOaaG13IMXVnwdd5/cnz8KBVH5o/2yES9Xqog1i?=
 =?us-ascii?Q?69l4qMUa8iIYgKRn8PH7a54wSqDMBEkEbFAizNWp+G5PaY+9SnTPyTeOLBGZ?=
 =?us-ascii?Q?8x6LxkryObGfcjQX41X/riams8Bh6Yn1qbe7O6uhpsyGNh+fc8qA7xc6DQN5?=
 =?us-ascii?Q?cMXz1e+mTIkqiQCVwLzHCqNFYZ+tLeRQwQLIxBo5zErhXfk8FHkJRTLi6mtw?=
 =?us-ascii?Q?s3dBd0Pr6eG4bzNFzfo9KbcXdcgKJJes5+5N3Y/jV/1deMS1IcQBJh9Eydrb?=
 =?us-ascii?Q?5zotymtLoITSGyC0uoLHwavBtU1eayR6bw5OjYKcxHjRfSwM1hy/cipvUZh8?=
 =?us-ascii?Q?g5BDweTvI4wHksMccEzD6sB2OsvG2OeY6yq6gtCGGngXgKsC8BQPqnTmRZGs?=
 =?us-ascii?Q?41gXewxmwHPs7a2kJ1x5lnyyME4267XLVsmMWb6aOOFHFkFVz9oFjDjttFO/?=
 =?us-ascii?Q?JxvzCrm4/JUFxoYger+ZFvrbzqt2d8XSb1RGY+CCkOnJUWUm5ZwXbZZo1old?=
 =?us-ascii?Q?wIoxCsVMqWoACOhXYRSMBo0LR7mmhSEABWkQj6c2OqIn3KsdOzbcoiI1qtZI?=
 =?us-ascii?Q?usXEKw0IzDzBVAboTEdyBrEXTFHEXaEwz7iMyRMWyvUrLlEWburq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d91ce1-d449-4a6d-d645-08def296016d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 02:05:21.7800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fnTpkeszT7MAttb2NVfSFJPDtaca3ruf9exB6MAN476cHNDfZcmQCXeLw89tGDx3LmK+fXAcz5Ccwps1x55Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5363

On Tue, Aug 04, 2026 at 11:23:47AM -0500, Frank Li wrote:
> On Tue, Aug 04, 2026 at 12:38:53PM +0900, Koichiro Den wrote:
> > Endpoint functions that expose endpoint-local DesignWare eDMA channels
> > to a remote host need to reserve exact hardware channels and hand
> > interrupt ownership to the remote side before publishing the channels.
> >
> > Add DW eDMA-specific helpers that request a write/read hardware channel
> > through DMAengine, keep the hardware-channel filter private to dw-edma,
> > and switch the selected endpoint-local channel to remote interrupt
> > routing after the channel has been successfully reserved. The matching
> > release helper can quiesce the channel while it is still remote-routed,
> > then restores the channel's default routing before releasing the
> > DMAengine reservation. This lets callers skip quiesce when unwinding a
> > reservation that was never exposed to host programming.
> >
> > Release is best-effort because its callers cannot abort teardown. Report
> > a quiesce failure locally, but always restore the default routing and
> > release the DMAengine reservation.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v6:
> >   - No changes.
> >
> >  drivers/dma/dw-edma/dw-edma-core.c | 91 ++++++++++++++++++++++++++++++
> >  include/linux/dma/edma.h           | 14 +++++
> >  2 files changed, 105 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 1f893dc54c79..4c0d2bba755b 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -1302,6 +1302,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> >
> > +struct dw_edma_delegated_chan_filter_args {
> > +	struct device *dma_dev;
> > +	bool write;
> > +	u16 id;
> > +};
> > +
> > +static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
> > +{
> > +	struct dw_edma_delegated_chan_filter_args *filter = param;
> > +	struct dw_edma_chan *chan;
> > +
> > +	if (!filter || dchan->device->dev != filter->dma_dev)
> > +		return false;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +
> > +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> > +	       chan->id == filter->id;
> > +}
> > +
> > +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> > +{
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +	int ret = 0;
> > +
> > +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +		return -EINVAL;
> > +
> > +	guard(spinlock_irqsave)(&chan->vc.lock);
> > +
> > +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> > +	    chan->request != EDMA_REQ_NONE)
> > +		ret = -EBUSY;
> > +	else
> > +		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> > +
> > +	return ret;
> > +}
> > +
> > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > +						bool write, u16 id)
> > +{
> > +	struct dw_edma_delegated_chan_filter_args filter = {
> > +		.dma_dev = dma_dev,
> > +		.write = write,
> > +		.id = id,
> > +	};
> > +	struct dma_chan *dchan;
> > +	dma_cap_mask_t mask;
> > +
> > +	if (!dma_dev)
> > +		return NULL;
> > +
> > +	dma_cap_zero(mask);
> > +	dma_cap_set(DMA_SLAVE, mask);
> > +
> > +	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
> > +				    &filter);
> > +	if (!dchan)
> > +		return NULL;
> 
> I forget, why need export delegrated dma channel to dmanegine? If EP
> driver doesn't report delegrated channel to dma engine, what's happen?

This just reserves the exact channel against any dmaengine clients before
handing its programming ownership to the host. Without it, a local client
could request the same channel too.

Best regards,
Koichiro

> 
> Frank
> 
> > +
> > +	if (dw_edma_delegate_chan(dchan)) {
> > +		dma_release_channel(dchan);
> > +		return NULL;
> > +	}
> > +
> > +	return dchan;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
> > +
> > +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> > +{
> > +	struct dw_edma_chan *chan;
> > +
> > +	if (!dchan)
> > +		return;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> > +		dev_warn(chan->dw->chip->dev,
> > +			 "failed to quiesce delegated %s channel %u\n",
> > +			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> > +			 chan->id);
> > +
> > +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> > +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> > +
> > +	dma_release_channel(dchan);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> > +
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 3c8e2ef9dee0..944469258b8b 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -153,6 +153,9 @@ struct dw_edma_chip {
> >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> >  int dw_edma_probe(struct dw_edma_chip *chip);
> >  int dw_edma_remove(struct dw_edma_chip *chip);
> > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > +						bool write, u16 id);
> > +void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
> >  #else
> >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> >  {
> > @@ -163,6 +166,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline struct dma_chan *
> > +dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
> > +						  bool quiesce)
> > +{
> > +}
> >  #endif /* CONFIG_DW_EDMA */
> >
> >  #endif /* _DW_EDMA_H */
> > --
> > 2.51.0
> >
