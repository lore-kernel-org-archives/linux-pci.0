Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D7474261;
	Tue,  4 Aug 2026 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860642; cv=fail; b=e5oJUt+RHf8V4OfVh+d+g7DRRQPQDOKVGmgvDTR0ezXjb8+Jj0qf5VuzRRA6wiqV3mB0uEsgrfrwMzTeEVn0w+gItWB9Q+FmTvEbkgvyr7CEqOQK2f4Fuleiz1+UIaqPLTR9gKtIEvrtPGSfhW0c/aa82X1UvkDM6ib1AZ2m4cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860642; c=relaxed/simple;
	bh=eydRNqe8TLIQGDOlqLcNe2Qc93thsqcTrAMdjhO6lBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jI8Vvq2mXo9Ifx9P9PJtWqbWHysYEh/PfJbKghSHcj/GrMJH5k4EeWU7B8qwWzzd/fyB4M2A7JVOHmgJPO99p57NyBzZwGefXtnboWyuHVk7lkgHwktdk0pMbtVaSXa6pqm3z8a0ZcM0toMpV9b9XRcXe6hon3B6HDa0POf2Q20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bPSVijUz; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bPSVijUz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rybBUhhurW7VeH/TdRzqQsgPJUtcIb3pfqU69uZ1MSN7R/U8u2kE2vjTEUfoUZR0KjjiDZOgv6idI4vbregcEPsxQ45/UXvnAvxfhWkkzx/4cPGbvsLmHGjHoYmPxm2MsWgJdK3G3EF3u/K0A92SCoeWfLTiCmAUFqaT3hugjYsUJyDV2VhuXke4adyP4jxvWuFttSj6SFKfeeXNMkJbjfgcAgf3wnWobaZfyWLDb+FprcZZy0ds+TzRY28H3RWBNPYfLuIdPY5uBTB2ARmZN1quR9mCVL6JRvBxPA/IdiOhsAPxrmzFS42u8LYeOffD4Jnciry3tZ3/Hem8eoxYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29k0D9g3N50kndX4AaKvwO/kXxZrDrYk7s5BMSI/YdE=;
 b=waozzt5bY1ilsHOBU5zgcqLWl5Z9UfulhP4HoSib2g7y5oRj8lBGjVfNuSLlAW5AyUvvO3wK3YCrspkrgMnPz8pFMYgizyKI2Yywv+gPxyK6sJHm/TSDXlDA/2c5p7PxYpxx9+IzlQokbk/K0f+Xk3ZTScNYszLHCnWGVrn6JY5CzK27BCdiFhzl+cJ0BunmMsanHT3EuRpl924KzOzEweWiPwV4+GhLP6InZNX1L7mfiXRvh8JPRt+6Ae1X3PYrv8sbflZpTMbbwCNixCmKIqUcWNGgBJWpkD1UGUJi3YLMhwZdCs1uAyuXj7WukFYJ9jlHEUIfi5cZULhpTcVsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29k0D9g3N50kndX4AaKvwO/kXxZrDrYk7s5BMSI/YdE=;
 b=bPSVijUz7EHMDP01lw8TyPaLR+ezjt8NBbXj2QZSM4zJO9UWeHU1rLMiRubPqFroi/bcF5z/vO4x/hn9ZdwCY637ELRxGd0AVNzpcS1J3pR7B59i75dFSQmpVVXZefFXAVRR3KYvO8iQGGuJVHgvCAr+BE2daWiBbxW9uTlYgObrhm2O0jt9m7+RpjdPhEWY7/iUsji182YtFsZB55TUaZc0w/+M20v0BVVrlOg03P1kWlOeAipucbBS7EWHdREXkJ56zH3E+A5i4W7cCY0HHx8zr3bAlsZKF2C7cuqhY4HKf+pHRu7EMzllUIIz41eyCXIa3MwolpA0M4z7kIWegA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB12025.eurprd04.prod.outlook.com (2603:10a6:10:640::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 16:23:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 16:23:57 +0000
Date: Tue, 4 Aug 2026 11:23:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] dmaengine: dw-edma: Add delegated channel request
 helpers
Message-ID: <anISE4zj1odwT2aJ@SMW015318>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033855.2115817-5-den@valinux.co.jp>
X-ClientProxiedBy: PH7P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB12025:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d9e1ad-773b-4431-0568-08def244c89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|19092799006|366016|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CfriXbA7uAoKIjZKfGtiqJQ6ogWdK/Pxe3cP7yEVstw68MdluVOkPS/lPSvncmQOQW+1XOvvPuiqJ3ot1MZ/CakBDO3+ukI1KtMibUl1/EeNRnyYWMA1FxhP2TbweAWoMiA0EDmm6xyY59+wcG4wm6hORlruw0WZIpMVQ/fpGY/BwIbA6OJB0mq/7VyjKzXm0GQDRzR/WnWfl34xxC5hS++TLaKU8MfXFSrFkajLJN5VaOLU5StKWlP5C0LwVfXMK/G8uBda01MaOUtMYPpugs+QabxogfqBKYC3iJ7Ci3Uf1EYRHkO547FSrP9Azn+jL5OhUCeZ5ciS1HMKq5Yq0aa0GdVFBRIv5kgfllR1L4UXjYWuYCOh4hm2lkxSQ6TjUq+bpzJEXfVgNzlZKNzehli+bkvlESUBbjfMH/8UfbqLyion/eOGQvjIGVF8RoUPM7wcbLdn5jVmydHJ/2DzVnmwrt+YpgckMJbDAR9jZsxdHVzXp2OjTlYq7JbpSuEIdR61tSXnO0Ay+4nGOg1D81/gs5hUDZR5mj6FvYeT97AME+cMP/Ri+6wWZAkRXoB5s/Y8gqCi1azCqvtN7qV4Q0ejIWlEXHEYmLtviQAKSNUgkI9WVOdA4A+WZ5QhrKrs7N7UoQfH2EmzDqRFVSN7UHQDintlkCFIlm0qS9SyOzg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(19092799006)(366016)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TR97+gbWrMUM0G0CTJ7chkazMRiRcwNtsggxDyFuvNI5RaHA4wgpSohVVA2s?=
 =?us-ascii?Q?G6rDmt3LnMYMxjtfijqTqrdeMR+8YUoFpqGD8uJ4x2I4aJguo0/x/X/aC0zC?=
 =?us-ascii?Q?p8+Mw34kjK3ZHJHiGAFjENso4R2ow5m5mniNwXNlFShbevppI2dRyUNb7odr?=
 =?us-ascii?Q?pFCttd3OmYAkLcrQoDnxdDggNad4YNJZOUdeFXVFsFJRCOf4KP5VniAmB1X1?=
 =?us-ascii?Q?3Lu75e+FVh6pp5VEfnxPyLJ+7ZOx9qngnDh5rGknMgU+Stjp/9jhUyDE7/SJ?=
 =?us-ascii?Q?6iGNWjC6+9wQt1hOvTDaXpr3EJ56EjyD1/LmIEWYtGzda9iWFdamVAgX4UN6?=
 =?us-ascii?Q?6NtunqENWz5Wgzm7f/ijEamSmZ8ZBfU4b83G4nFMNy3SAzaZ+C8cJYx1D6EJ?=
 =?us-ascii?Q?266WEKW//aZBp3gwM7aEaYyNaU4wW0J6lDvQBeOTzBFez+flBTC+t91Y9FoG?=
 =?us-ascii?Q?c/QI/mV5ehR1vWI6iutkDYdTiyNKXfmDUlovVlcUIQWu+B79ter86oJV00KC?=
 =?us-ascii?Q?5HS/+kWv+tNekX7bDaUDjt0TcnQUXx9nSSVvpmabGrYQ6MngIZoin96AUUvg?=
 =?us-ascii?Q?r/9GRaEtww4xOG4un9dLQmuuJkLn4Fgqeo0mGo5rR+UUt9IM8BW5z0sV4Dc4?=
 =?us-ascii?Q?zHZQ1sVctV1fZ/IMRBzRccjNx9PuajWZ5r7AFd9IXyilZmMCrrdQQ/0MqJC8?=
 =?us-ascii?Q?1dkyjN6SiktPpGgWSYTv0jLBu6JEL45aCyuTlmDpFGgDJo8z7XBkXmkvRolN?=
 =?us-ascii?Q?i5lFxS/sgPT0QEpuggXf28HMLrB0Qv06UWmzEv3mnyDU9IZeRZ+dGi3AVkwy?=
 =?us-ascii?Q?6rHJbRXkzG8AV4H29WG4EwNfwWF42AsvNHzJFc4N0VlupYSXlZe7ogFkIcMK?=
 =?us-ascii?Q?4BfOr9qd9XJRYDAXi1SdNeFRh1tdM/dmLXs/r/aE8OHP0J23q51JTrbOQ3Fp?=
 =?us-ascii?Q?/SdhxAjhOS8sGXpSJerWc8/Edv3YU2ZEieHZuX5laqLmTFSTE0oIczyrMLZZ?=
 =?us-ascii?Q?zvGDB8bVOGkh9hPXsRtfXajM2zgPdkSNX/VeoKS9+Usb9kjs7TaqqjXpwaMj?=
 =?us-ascii?Q?S/sQHecMVsb7rDUFJ5mMUYEHMbXy3GUkiCXEpBLnqHPPxBg7bD9YxZmB7jTF?=
 =?us-ascii?Q?3YJpAQQYNy+/olbs0JFICOK36XNNTIOM6XAYe45JHXhkT9sMv2k5ScT+3YjR?=
 =?us-ascii?Q?Hy2t/fQQi44cVp9GhMxQMwP9wgyS65378FFUT4hR2ttX/NjCYB3rIezwomex?=
 =?us-ascii?Q?QB72Vcdt1QW1qrLRPW+Pb3GUhgAd9vpMHiYfqpappRqbM4LJQNw+gELqWJAX?=
 =?us-ascii?Q?GlHu6Kv4Fwc92Q/sGNkZAa8YwXNomBkI7RhfK6+qY9kVkRmWiALkV22VVZyo?=
 =?us-ascii?Q?fVPF4BISo/O3tADeCRrW1UJ+VIxB4BxspVYH4FNLgFG3EQNgEH9Q14GfJHQ2?=
 =?us-ascii?Q?SJ44rKX0z/Gd1PXhliuiKtnMEAXX3MrEizYP2z2wQLOLLLVTJ9X3mzWGVanF?=
 =?us-ascii?Q?AC/CWUUCNKN3ZHTA7ICZkADGFN2VhJuoe/qj6YOyJENWmpgxNFWhS6+Wmj2w?=
 =?us-ascii?Q?BeKfZ0PGm6SlLYA7749Ss3z9yvGuNqR7su52ea/xzCyTEkmdpMgBTwGQy9j7?=
 =?us-ascii?Q?Z/lc46sVXUzRE3m5WjHlC39ytVaLcI53bHBM0AEuiRhxB27v89L5TTLJUlmI?=
 =?us-ascii?Q?aO0KxmZB8l+sD4VxNwwI69SJCXOxw4LBo8hTxTx5Q4G2gfsiMUxCZhCNopcZ?=
 =?us-ascii?Q?GEqgiah+0GPT9pA4fkRgu0R74oS20WF+AldNsR9QQ4+sWCW3PKPl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d9e1ad-773b-4431-0568-08def244c89d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:23:57.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rafxm4V9OBn/7ve8IPWdg5oaPnO1J5yLsEDuUlc5vJG9glEq7wLs5BRCDODMGJL8bwXDYoBD872qdIIPPCg2ZVL+UJqaNJ0jcuQ1hojcr/uVa9zNqGZLb5XzAQM2CU+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12025

On Tue, Aug 04, 2026 at 12:38:53PM +0900, Koichiro Den wrote:
> Endpoint functions that expose endpoint-local DesignWare eDMA channels
> to a remote host need to reserve exact hardware channels and hand
> interrupt ownership to the remote side before publishing the channels.
>
> Add DW eDMA-specific helpers that request a write/read hardware channel
> through DMAengine, keep the hardware-channel filter private to dw-edma,
> and switch the selected endpoint-local channel to remote interrupt
> routing after the channel has been successfully reserved. The matching
> release helper can quiesce the channel while it is still remote-routed,
> then restores the channel's default routing before releasing the
> DMAengine reservation. This lets callers skip quiesce when unwinding a
> reservation that was never exposed to host programming.
>
> Release is best-effort because its callers cannot abort teardown. Report
> a quiesce failure locally, but always restore the default routing and
> release the DMAengine reservation.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v6:
>   - No changes.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 91 ++++++++++++++++++++++++++++++
>  include/linux/dma/edma.h           | 14 +++++
>  2 files changed, 105 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 1f893dc54c79..4c0d2bba755b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1302,6 +1302,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
>
> +struct dw_edma_delegated_chan_filter_args {
> +	struct device *dma_dev;
> +	bool write;
> +	u16 id;
> +};
> +
> +static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
> +{
> +	struct dw_edma_delegated_chan_filter_args *filter = param;
> +	struct dw_edma_chan *chan;
> +
> +	if (!filter || dchan->device->dev != filter->dma_dev)
> +		return false;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +
> +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> +	       chan->id == filter->id;
> +}
> +
> +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	int ret = 0;
> +
> +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		return -EINVAL;
> +
> +	guard(spinlock_irqsave)(&chan->vc.lock);
> +
> +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> +	    chan->request != EDMA_REQ_NONE)
> +		ret = -EBUSY;
> +	else
> +		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> +
> +	return ret;
> +}
> +
> +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> +						bool write, u16 id)
> +{
> +	struct dw_edma_delegated_chan_filter_args filter = {
> +		.dma_dev = dma_dev,
> +		.write = write,
> +		.id = id,
> +	};
> +	struct dma_chan *dchan;
> +	dma_cap_mask_t mask;
> +
> +	if (!dma_dev)
> +		return NULL;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
> +				    &filter);
> +	if (!dchan)
> +		return NULL;

I forget, why need export delegrated dma channel to dmanegine? If EP
driver doesn't report delegrated channel to dma engine, what's happen?

Frank

> +
> +	if (dw_edma_delegate_chan(dchan)) {
> +		dma_release_channel(dchan);
> +		return NULL;
> +	}
> +
> +	return dchan;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
> +
> +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (!dchan)
> +		return;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> +		dev_warn(chan->dw->chip->dev,
> +			 "failed to quiesce delegated %s channel %u\n",
> +			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> +			 chan->id);
> +
> +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> +
> +	dma_release_channel(dchan);
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
>  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3c8e2ef9dee0..944469258b8b 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -153,6 +153,9 @@ struct dw_edma_chip {
>  #if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
>  int dw_edma_remove(struct dw_edma_chip *chip);
> +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> +						bool write, u16 id);
> +void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
>  #else
>  static inline int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> @@ -163,6 +166,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
>  {
>  	return 0;
>  }
> +
> +static inline struct dma_chan *
> +dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
> +{
> +	return NULL;
> +}
> +
> +static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
> +						  bool quiesce)
> +{
> +}
>  #endif /* CONFIG_DW_EDMA */
>
>  #endif /* _DW_EDMA_H */
> --
> 2.51.0
>
