Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011027.outbound.protection.outlook.com [52.101.70.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1BD37F317;
	Thu,  6 Aug 2026 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035058; cv=fail; b=eTnvICvQ5PRpFQkPaJJZIT5KqQ8P+edW6e+vLzqd991ZkPiukqIXFjK5gagvcg7OUh4gGBRRnuKQ4yjJFz1fLB/GCHw7y5tjrwbuIDPKZvccYmBgTJXv99NSjhXZ3VV80tJ8aL+AOb4qQVDKnLU2psfh5LGY5lgkuv4tdKwPcbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035058; c=relaxed/simple;
	bh=lHKN8ykqxqgmrsh5qdPMOgmSqUEYZSzleizGCBVCeoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FLZgFefdce/wyh6NhSnayHsstdx2ehaspoIXztQW67s+j/Tj0ukC3kgcjntNTyTkyA2URLhpeLC/nvdYeli/3i3Oh+s/yTfLiDqZZ/c/3rVY+Gnmucubmtq3BRYNbKkG/VgjdzKrsNhHA2BdBydhvSNKuwQNeWyQ3HMP7bsi+dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=l03iV8Jd; arc=fail smtp.client-ip=52.101.70.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l03iV8Jd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKUaCIdKC3oRFtmCw1yH7RPvim42HdnjizcFMxiVaRMPGbUX45yu5DfWm46bm7i0jzdd0NYhpXnlnP0qbbaRH6lyZ1tqVBQonrQY/PkzVs+kPsqbUozHPjjG25VANJtwZDFUFFQq6rBeZ3tI8BTKaS7wYLVW5FwNW3L6BJJFDr+bjnZZLxmMrxF1FMoO636fzWIF9aVtQ99SBMl/zoByr71h9iQTR7UWoSLrPjR/65u7KZI4UvEdvav7kX9JrZPDUq8yP27zvz/N7mJI8RF3y3yiRIwKVLucBM8+DykuFCnd2xxxPZS3Nf7dR0g/Vhm0C39EFxS46C6iGaO3l2nGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8SDgbWEwNhfawAEykhh//t6Xq3+o37OV3gcRWpZ0iQ=;
 b=nUTEsnSdCz8LamTEJmrdvbQMy0XCgN65Myd84FQKDcTi/PHpLEDpfmwxXhUJUN3j9zkQ36ZrJk6UsgSKU2AD4ZIRCnQtysOT70oLQX0UEv1QFgejBeZ2j4qxkrOJ1/SyR3Iq9Vu/AxlaMm6uTK2Bxulu2Ex5mymMhQ9QVhRpLZhOce0hIwgK/LfdoUEOha2R7BwbRUn3iVoi4/WacmUSrZ5pKTUMO5PyNcPIDMBRInlV0IWFHzPIwiOZOCKGQs/bC9qOiLx2EECjB8sKT5fGcyE3h9AHZtDqYg9z847b3Vd6Dft8P09J/K91OWchSqlyqiVYnkwTU2LEArUzwJBnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8SDgbWEwNhfawAEykhh//t6Xq3+o37OV3gcRWpZ0iQ=;
 b=l03iV8JdNyh9zuoVR42naUXs14uWvDEvx/srdBI1WV/MGYf+u0hEgZFFoBrAaUS0F1du/w/l23R2pE6Biz9ZAqXwanKQpo4rZCssDPHSTk6ifwZyu2f6jpQwFKBAw3b9wdDtAimdt3TqU9y0MS4zFP+LFcIOc+ycELfBQLa57T7TmO9ozE8PXX0dR+fJ6Jt3xtx6wgnAljsZ2urBkYtAVMG0BhsLNwrraGe5T+VVePfP8OtgTviTMqBzNHS/UonkbeTeuqTKUeaCeEmEsBGqajRORzjXcBCC8UBq4gaICF8WkXtB8tjORCy68q/QXrlEiTq0rzbQoyxtyXNk4PN5Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 16:50:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 16:50:42 +0000
Date: Thu, 6 Aug 2026 11:50:33 -0500
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
Message-ID: <anS7WQ-b4y1_wwY-@SMW015318>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <anISE4zj1odwT2aJ@SMW015318>
 <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
 <anOFUSDiDjD0jvei@SMW015318>
 <ni6sfv45mypgxncitlstnqxgpqwn5ocxkns6kv3nez6hnq4x5m@setbl5dlfqdr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ni6sfv45mypgxncitlstnqxgpqwn5ocxkns6kv3nez6hnq4x5m@setbl5dlfqdr>
X-ClientProxiedBy: PH0PR07CA0115.namprd07.prod.outlook.com
 (2603:10b6:510:4::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c1ba8c-c846-4d30-faaf-08def3dad9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|22082099003|18002099003|11063799006|56012099006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	30eDx330ioNZZt5ry4198Sm8oQt61InKNW0Y5eeaobilIq0qRExolKqqQmImVFmljAPQ3aVlzYeCD0bCdqqooK7l/kiTntjgsiyA5fhUtKyxuGdFdetWEjkIVzaYxzBsTYs1dmcz8/tOFajP11UAq9WMgyKi0cEoduZ1wQYDcGD2loh6+/TqKcQ9A5TjsiMTvYNTZclODF2MBAssMwVmH2dNplPG0yqzOdaNMExBgFBsP+sAdQurWwj88qhAUWoPuVzsvvzoB1yQ7jITyKsms5Oup6HU+Pay3XABfXWXKOoKH0vuuigiAPu9l5m5qo0vrYljjWd+ilh9CG2iAuO6VifTO5CUCRjGK6u2jjg34ZGaoLJCwQxxY6UAbo9tDX5tsQ6OxJujwjgpxdc29buLoxUfTjaIx7Z4wwaWCm0fMHeYw3XdhQBnMnHvP0WKiDrIegv7VUECqJbG/br33hTrEJPHKUpy9QRjDuZACTAHYNUiU/M4UVUF2RKrPZ1t1Tgl7gtF4v7ALfzH7LcXQOz4yNJYWdiTsoB8Iqc7CwabtXHvllN8NgbPCFVh0H5Rq3AiAyRWn8WRTPQKCLx3QX/PrnY6+17CUZTqVXqYDjRg5V27CQHSTHDgtKFvW+y4fhuz8/T6Xvhil+G4m1jup7nmAMA/FdvyPR3dtbRkg7hrYfU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHsZeJGHknYBUpeVZ5WqRv54Dz4M/O7iLogD1cXchCoeAEh0TMBmOBm8Bbor?=
 =?us-ascii?Q?66MDZ2JZdmZCiyYfxiscJ/eyjC1eMT09k1VWKLDnz3ytfnFYar5MoHp1LiQn?=
 =?us-ascii?Q?aXeP8mLaI/LxyF/uCKY0cvepRFjunkfpdkglr2nU763wfJaUFluJagIWOTpm?=
 =?us-ascii?Q?sZfqFYu8g3Wey5Cm2y3PjErmw/XYQLYvYAQRd5SN5HO9wOBQUlxPMmaAJ9oN?=
 =?us-ascii?Q?FMAxyBoUZOH3LeqTSe7OR1aXesqacUXREIczgjA5SJNEwNay5Wxx6vAb+Fl5?=
 =?us-ascii?Q?F+cZSSx6UX8q80TyHhcoXOwNBEFYETVvdEWtrUTUPkr1U/fS/lpqiZm+5K1T?=
 =?us-ascii?Q?EsHCmX6zVeJmPGYStaEHFNFEzT7apBXo6x6zlT8U2tBm6N3oqupaUt4v+Izo?=
 =?us-ascii?Q?0TKoMPRV5euuPXyOv+y9KJmfOS+fe1cPmekpg6IYoCQUcTgRP6K7p1JTILVL?=
 =?us-ascii?Q?b7HByEuEwgB063mtoF5D6cZZ5Q+baIdNeLDQlY0G36+GEoErR2Kr/v8zjB/b?=
 =?us-ascii?Q?qHioIqvCch8NbsDiBm9RG2bl2HIuS00c9jARKF3u6TgsesPLhOn6NzwHQY2v?=
 =?us-ascii?Q?OIKSPJVALMEqJw0xMCVsParArgE+9RiDqx9iRTSrBDkjZGbxFGi/IG0GePaF?=
 =?us-ascii?Q?xacJnBVdZi5c+dmOVPObiCJT/Clm6EMPLlzt6oKSKBvoaNSdK3hrC1LOErcQ?=
 =?us-ascii?Q?t002u6zPT3fwC0LEM/R7EOws4GOja4+A5P0X8LU8BDqtcgCLMLnT1+SdWuFW?=
 =?us-ascii?Q?nUtRknqphOPynvgE8D3XJqb/+uqh0OoVJktpnBgBq2Y6/GJxqqHpVt+dCXe9?=
 =?us-ascii?Q?/QEfT1qQhey5rCY/VciuAaWX1jJKIES/hgYJxGLEE9QDbk0hw1kyBDhCIVK+?=
 =?us-ascii?Q?DVu6E5OfGoJxsYcY0WtTv38UHQMFxGATGVDd3fMWD+CFxq1zLqGkKc3lKiLJ?=
 =?us-ascii?Q?L2zcbFLKZM+99sNeBPgk13jtP6VVB2o8iKS9HPeO11iND9aupSsfD1LbG8Ki?=
 =?us-ascii?Q?TcDhfJvj/IL9GPkAhDbEW+qH2G1dz9iECbsgm3cVFPIqKpCUNMH3gjg25WXA?=
 =?us-ascii?Q?d0urWGdM0Lbdi7xk88WVf5vsSN7eif5OJ5pM37eZse52MqEbi0mnmkQHMo0/?=
 =?us-ascii?Q?zNhc2b+1OG7zTBMyUJBPLNH/I12d5Z68zd4bUePAiuuA9ofgPva5pqROoucL?=
 =?us-ascii?Q?WYVInHc46yyq6BCLGgraAMlX2QMJJFRjmtZ0VakFmlXbnBJFJYNhU242+qiU?=
 =?us-ascii?Q?9WJ6ID1AZDSkGm2QAqYr526BoMTh65ucRHgq2LBpIS46XvFwDFA6ugUBd3gN?=
 =?us-ascii?Q?fEmVP4rt2UTa9rgx7kdejCsyicLusjVunE07Qj0e+e1etPThtMlFyCGXJ90v?=
 =?us-ascii?Q?YfXrylu0rWS5uxsDlQlINMLg9qsUKG6njLMdg35qsAr+aj0wnStUcSCHdHy0?=
 =?us-ascii?Q?b4PhgaH4McmIXfWbUdG0CgMw0JXFUEYzhRLYDaspBZVKBoOBrlWF3FUa6sLf?=
 =?us-ascii?Q?jzH6yz6wlauTn8QHq4iWwUCQYutw79XJ8Dh9MX3XzOFbHOqXahvQlm3eh5iw?=
 =?us-ascii?Q?55TmfMptniPTiQHJO+KR+FHPTpp2UlWUl19NDCcgMIhfgWsptQu0yW1C73qo?=
 =?us-ascii?Q?rRLFOhLw6R75k+UUkcZkeO6rbyWg3yjvleFGUPtVNfMMZhxIDm++KMiXH+Dv?=
 =?us-ascii?Q?wzDRUpl/GCTaE8TgAFXjRFMg9XpHtBsyvqGpVdm3l6tObyJ5vcimLADK+Jjt?=
 =?us-ascii?Q?1W0nJSqxGulfZuICHqEezYROgV+oYtj+t0yypJ8D8B9bMLGAkqWZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c1ba8c-c846-4d30-faaf-08def3dad9fe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:50:42.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEP27uxvJIL10+NGFf3Zn4KBs6RLX2ZKxriR+vlZqgLJxxqDdpsrXmotfy3oqdmNb0leG9raoWq4XtzRHG0KbisDlbYnfx5Q9XO0n67oDFmyK1A49dMwmZ7DpKf2SWpH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956

On Thu, Aug 06, 2026 at 12:45:13PM +0900, Koichiro Den wrote:
> On Wed, Aug 05, 2026 at 01:47:45PM -0500, Frank Li wrote:
> > On Wed, Aug 05, 2026 at 11:05:21AM +0900, Koichiro Den wrote:
> > > On Tue, Aug 04, 2026 at 11:23:47AM -0500, Frank Li wrote:
> > > > On Tue, Aug 04, 2026 at 12:38:53PM +0900, Koichiro Den wrote:
> > > > > Endpoint functions that expose endpoint-local DesignWare eDMA channels
> > > > > to a remote host need to reserve exact hardware channels and hand
> > > > > interrupt ownership to the remote side before publishing the channels.
> > > > >
> > > > > Add DW eDMA-specific helpers that request a write/read hardware channel
> > > > > through DMAengine, keep the hardware-channel filter private to dw-edma,
> > > > > and switch the selected endpoint-local channel to remote interrupt
> > > > > routing after the channel has been successfully reserved. The matching
> > > > > release helper can quiesce the channel while it is still remote-routed,
> > > > > then restores the channel's default routing before releasing the
> > > > > DMAengine reservation. This lets callers skip quiesce when unwinding a
> > > > > reservation that was never exposed to host programming.
> > > > >
> > > > > Release is best-effort because its callers cannot abort teardown. Report
> > > > > a quiesce failure locally, but always restore the default routing and
> > > > > release the DMAengine reservation.
> > > > >
> > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > ---
> > > > > Changes in v6:
> > > > >   - No changes.
> > > > >
> > > > >  drivers/dma/dw-edma/dw-edma-core.c | 91 ++++++++++++++++++++++++++++++
> > > > >  include/linux/dma/edma.h           | 14 +++++
> > > > >  2 files changed, 105 insertions(+)
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > index 1f893dc54c79..4c0d2bba755b 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > @@ -1302,6 +1302,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> > > > >
> > > > > +struct dw_edma_delegated_chan_filter_args {
> > > > > +	struct device *dma_dev;
> > > > > +	bool write;
> > > > > +	u16 id;
> > > > > +};
> > > > > +
> > > > > +static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
> > > > > +{
> > > > > +	struct dw_edma_delegated_chan_filter_args *filter = param;
> > > > > +	struct dw_edma_chan *chan;
> > > > > +
> > > > > +	if (!filter || dchan->device->dev != filter->dma_dev)
> > > > > +		return false;
> > > > > +
> > > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > > +
> > > > > +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> > > > > +	       chan->id == filter->id;
> > > > > +}
> > > > > +
> > > > > +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> > > > > +{
> > > > > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	guard(spinlock_irqsave)(&chan->vc.lock);
> > > > > +
> > > > > +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> > > > > +	    chan->request != EDMA_REQ_NONE)
> > > > > +		ret = -EBUSY;
> > > > > +	else
> > > > > +		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > > > +						bool write, u16 id)
> > > > > +{
> > > > > +	struct dw_edma_delegated_chan_filter_args filter = {
> > > > > +		.dma_dev = dma_dev,
> > > > > +		.write = write,
> > > > > +		.id = id,
> > > > > +	};
> > > > > +	struct dma_chan *dchan;
> > > > > +	dma_cap_mask_t mask;
> > > > > +
> > > > > +	if (!dma_dev)
> > > > > +		return NULL;
> > > > > +
> > > > > +	dma_cap_zero(mask);
> > > > > +	dma_cap_set(DMA_SLAVE, mask);
> > > > > +
> > > > > +	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
> > > > > +				    &filter);
> > > > > +	if (!dchan)
> > > > > +		return NULL;
> > > >
> > > > I forget, why need export delegrated dma channel to dmanegine? If EP
> > > > driver doesn't report delegrated channel to dma engine, what's happen?
> > >
> > > This just reserves the exact channel against any dmaengine clients before
> > > handing its programming ownership to the host. Without it, a local client
> > > could request the same channel too.
> >
> > why not epf function driver call dma_request_channel() to decide which
> > channel pass to ownership to the host.
>
> I actually tried that model in v2. pci_epf_dma called dma_request_channel() with
> a filter supplied through the EPC resource.
>
>   In v2, .filter_fn was part of the pci_epc_aux_resource definition:
>   https://lore.kernel.org/r/20260525063129.3316894-3-den@valinux.co.jp/
>   ... and pci_epf_dma_claim_channel() used it to claim the channel here:
>   https://lore.kernel.org/r/20260525063456.3317509-3-den@valinux.co.jp/
>
> I changed that in v3 after your comment about why the dw-edma filter needed to
> be public. The replacement kept the filter inside dw-edma, and moved channel
> reservation, IRQ ownership handoff and reclaim there too. The current EPC
> delegation API follows that model.
>
> Or is that v2 model what you prefer here?
>
> That said, dma_get_slave_channel() might be sufficient inside dw-edma here,
> since it already knows the exact channel from the direction and hw channel id.
>
> P.S. For clarity, the options tried or discussed so far are:
>
>   (a) Expose dma_chan directly through the EPC resource, then let the EPF
>       reserve it with dma_get_slave_channel(). This was v1.
>       (https://lore.kernel.org/r/20260521063405.2842644-3-den@valinux.co.jp/)
>
>   (b) Expose the hardware ID, direction and a provider filter, then let the
>       EPF call dma_request_channel(). This was v2.
>       (https://lore.kernel.org/r/20260525062420.3315904-2-den@valinux.co.jp/)
>
>   (c) Pass the hardware ID and direction to pci_epc_delegate_dma_chan(), then
>       let the backend reserve and delegate the channel. This is the current
>       v6 design.
>       (https://lore.kernel.org/r/20260804033855.2115817-5-den@valinux.co.jp/)
>
>   (d) Request channels normally and correlate them with EPC resources through
>       a generic dma_slave_caps.hw_id. I proposed this in a much older series.
>       (https://lore.kernel.org/r/20260204145440.950609-2-den@valinux.co.jp/)

Thank you for your great work, let me read and feedback to you, do you have
irc, discord or other instance message channel.

Frank

>
> Best regards,
> Koichiro
>
> >
> > Frank
> >
> > >
> > > Best regards,
> > > Koichiro
> > >
> > > >
> > > > Frank
> > > >
> > > > > +
> > > > > +	if (dw_edma_delegate_chan(dchan)) {
> > > > > +		dma_release_channel(dchan);
> > > > > +		return NULL;
> > > > > +	}
> > > > > +
> > > > > +	return dchan;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
> > > > > +
> > > > > +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> > > > > +{
> > > > > +	struct dw_edma_chan *chan;
> > > > > +
> > > > > +	if (!dchan)
> > > > > +		return;
> > > > > +
> > > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > > +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> > > > > +		dev_warn(chan->dw->chip->dev,
> > > > > +			 "failed to quiesce delegated %s channel %u\n",
> > > > > +			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> > > > > +			 chan->id);
> > > > > +
> > > > > +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> > > > > +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> > > > > +
> > > > > +	dma_release_channel(dchan);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> > > > > +
> > > > >  MODULE_LICENSE("GPL v2");
> > > > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > > > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > > index 3c8e2ef9dee0..944469258b8b 100644
> > > > > --- a/include/linux/dma/edma.h
> > > > > +++ b/include/linux/dma/edma.h
> > > > > @@ -153,6 +153,9 @@ struct dw_edma_chip {
> > > > >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> > > > >  int dw_edma_probe(struct dw_edma_chip *chip);
> > > > >  int dw_edma_remove(struct dw_edma_chip *chip);
> > > > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > > > +						bool write, u16 id);
> > > > > +void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
> > > > >  #else
> > > > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > > > >  {
> > > > > @@ -163,6 +166,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> > > > >  {
> > > > >  	return 0;
> > > > >  }
> > > > > +
> > > > > +static inline struct dma_chan *
> > > > > +dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
> > > > > +{
> > > > > +	return NULL;
> > > > > +}
> > > > > +
> > > > > +static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
> > > > > +						  bool quiesce)
> > > > > +{
> > > > > +}
> > > > >  #endif /* CONFIG_DW_EDMA */
> > > > >
> > > > >  #endif /* _DW_EDMA_H */
> > > > > --
> > > > > 2.51.0
> > > > >
