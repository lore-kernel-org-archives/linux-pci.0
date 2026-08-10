Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D001A38F9;
	Mon, 10 Aug 2026 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398773; cv=fail; b=ouLOnUq4gcSirJPSR8K0MXAex8iIC+YLxXieH8mJU4oTswVRvQG/fIu4dA7k3bhX08fZTOHg/8adayj9n+93K78LVsm47SmxNBGxpyGm5HH24wOJ4AGVONlh8tvh+v1s34UUr36uNyHAGqW/TFivlHYeMuqDf/5lRleQam6XA2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398773; c=relaxed/simple;
	bh=+z2hFO41FqkoqTor5P749H1wSzTw1u2djmqbueOP9Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XNwL0EBtsIMrSQ5trhWYBfTkZuh80M2WjXIU8w8v2tcNH0SwfPlGUixIbNrX/jBp/4BV0EmYlKoTW+pgbGCYC4ON3R4BmNIG/eWXoLJga33M1nOHepsDs5YAgD8O4+tcnQczDM9Qxk67zBUB29uG9olEANzz1zOWPvPImA1E584=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tnPfkXFr; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tnPfkXFr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkvORJnTyk88rL0D9HKy0LaLP4WkYqR0+inhh4wxLeb4sYpxpyEifsiw3sMaD+OgSZCYGVyrDA+xLST2rdfD/u7fGZpQO41iJF57F7HeDHCwCSXZt6kKaSSBfOAwz0k7uIaWIFL0TBpStiq7yWHrPa9TX7UQ0bAWrPmkmBsmxufQQqGMAdMyDC+942l6PoyjDvrELZ78KojyHdJ+RQJmND6up/9UuozUdWL5UgNDFeE5d64CLhbHjX3uA/xh5yNLsWcskCj1gZUSDmngR/UBOYlWhMMVhPw5Dlfpm1tTdAJfh7Ad+SQQMWTw/XyGnyHRNk1wtS2SenVtnrRR7WZ7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNrekXznc+VvaeppbeeYmSNy+NP8mBpGZP4yhwWDPoI=;
 b=PEfsBwktkn+l7NjTa+G+0h4YJ+93/Sxa7i1Z/n0/mfz6lrfHLNaAqYcDEloKkgQd5YbMUqOEP/R0o7GFf/+/qW2+mglFGlHhCUZqnbMn4Qa3b9EVRp3YfGYa7LZtfsQC0VVa8RGSGw9ARIkMhPGEigHKQNVWzDAbnoykLtiBRiKbfzB1hyr+zA0xnJm7XabpXiMMrLLjWxrMR3lJy57nvoHzjBeRtuHwOe+Bisq/ryWgZ0au46QK8UJ1Bx6GH4HsFBOAdRQJArMSNqZ3Ls4k5U0YjFseE4crSEQ44Uaow3KM74oIfMpJtk7u92AwEgygMnl0QdaYclx2kOyI8iY6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNrekXznc+VvaeppbeeYmSNy+NP8mBpGZP4yhwWDPoI=;
 b=tnPfkXFrPMza70SEvX2BypYlLt2YJ/I0OC4Xp7Ec/gUcnEb/ViiHXUwvU4pguk31/82UZNYmOGX/iviPwNowSRESc0p356kJKoPjoKB8c0wPa4u5/WA/EqT0k5BUrSNcDdisChgGxYfbhlPXpqIldDNFkBIUJYAOVHp4b+zUm0wc0bUnIRs2XbFQriiBfqvXPeCsA4bZT+G0IwkKQWwrpnp6r15zF+3DM2JsjdAFQitmXxy0kcneOYSbby3y9EwFBu68R5QMqCHkBd0ikEILfUZIWmsSBolFEdr/H0BiHkHEvE9d412erUbNIPqgZ9trHFPS1XWullQuzxWz5XFxAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11923.eurprd04.prod.outlook.com (2603:10a6:150:2f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 21:52:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 21:52:44 +0000
Date: Mon, 10 Aug 2026 17:52:36 -0400
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
Message-ID: <anpIJM5OligYsEK0@lizhi-Precision-Tower-5810>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <anISE4zj1odwT2aJ@SMW015318>
 <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
 <anOFUSDiDjD0jvei@SMW015318>
 <ni6sfv45mypgxncitlstnqxgpqwn5ocxkns6kv3nez6hnq4x5m@setbl5dlfqdr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ni6sfv45mypgxncitlstnqxgpqwn5ocxkns6kv3nez6hnq4x5m@setbl5dlfqdr>
X-ClientProxiedBy: SA0PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:806:d3::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11923:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b3488f-0270-48c7-fd5e-08def729b5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|19092799006|366016|1800799024|4143699003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hNm5yM2PZzt7pklZDFqdZPzZFEM0Dhzg6MeSiMN4eMl1j1jvVu1R4J0nak3YdIjSvAQm8E4/TmW4kNa83FqR2Bw0ER6wjtMcv5UH6T5vj3slq9oeT+BA+pa6bJTOgREWsajeqj2laBb+CjIxG3HTeRIewgE36CUmfaBju4gKEVKgnBIHG5/dUQ8EpWeeTf6H8hKIrWGwujMqoDH+mbP57KlaFYcA2prOiVkzhAMKhrR+rK7ORwYNmquRnpEqBnhBd4mC7B1JgOAI96pOxE8nsn4sULOS3IXUSw8y+a0haD2E+XvU0Q23Gx/BL++K+WHtsKrfo/FOVXvwliCx2uHRcyPDNRj5PpcVyNNMXjRNI+6VA5CFIAKWJTDQTs4TzNbznM8J9lhUhos63CmEP3E6fybCLwRLRSIRT3OhOx7rE/uQvCA2NAMNkcOPCLkgotaDYYg7fWQsJNg6vTRLjhoDhtdvI7TpCKEtr62biHlkvbJak5PB6RIedXkb5mbMOfjrm0rMe9j1/iLbhjrprqhAF2p+EPFeNXQkuh65DSvB1zNjiWbpPUeZCTulVcXcGz+cbwO6bzRNB/r85Pw4DQGuQv7o2Z7qQsJdalBQVYF2YZPL/EWQiuOuhtx/uz1XGYk+asM51sDYeeVDYr5bsso7Z34LJ2535H4EVe3hVb9Ub5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(19092799006)(366016)(1800799024)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xEqGcP9w2ofD5bjX5nKVC8r61z2SSNk6QdBGfnGa5SFg4mIRgllXRfVuueup?=
 =?us-ascii?Q?lRc5ZCfI66DyN9HW6O9BYTs7CDO70OVXOdJbcJU3XQ5l+Mf8HqqoEXe8D5fG?=
 =?us-ascii?Q?4aFnNBBJoLa5xuEcSljOpCufDA9Otn/pU0+WYlU0px6CYcAHIdR8OUJSejJ7?=
 =?us-ascii?Q?SSHPfjbm4lHaSp872ETG4NelML16w/7sTbT6AMY7KQlLW/onsrAGcM8dR/uk?=
 =?us-ascii?Q?U4wbyi55TvWSKD4183Wtd0NMwLtWTSYYucpUK3chn6yWpXJzVPeKqsoqhRVh?=
 =?us-ascii?Q?AJlshQmnVIjUTqmSPlul4n2+OT2LI6oHWcG/wDSPW+Iw+jThmGrYbTWRfB+h?=
 =?us-ascii?Q?o/yJzHCKaJqlAQehJsr9e31qDZoLDx8EGu5a5p9MdL2aRSFEhdgWlKPTxjn/?=
 =?us-ascii?Q?gQ73Pcw2uOjLyZPEuQgDBm4uJxGkGwlNjztUS6l3RCypHNa9vId4VnxsPlKN?=
 =?us-ascii?Q?5+dOfZeH3eCQufcvqUD6CJhYrQNDL/nfnaXNmYfWQ3jyDYMMDjomV2vFx0QM?=
 =?us-ascii?Q?YYnm8DIcSWpvpqkImmXxDQPnKE4973iacwRC2mEAEgG8Ikcg3vs/W/oJAONv?=
 =?us-ascii?Q?z0cyBUF1sonAiuTxTUP6tti/p9HWmDI1zhDk/I3+8dHMRyxu9Kb4gULG3QPh?=
 =?us-ascii?Q?9IoAZMuiEBRrzNNgqrvuhUSqVhsiN2ceWvF8N4szY4uh5xMyfMxWBZReUslx?=
 =?us-ascii?Q?R0We6ZbRC15a/KLIwMPHBe18wCNvnb5UmzK+rkwwtAeuxU+aksJSZeufCI0P?=
 =?us-ascii?Q?u+o5GfcFmJL3MfM8JypJS2MYoDwl/UMWcLO6oDwXf4KwIUJ5nSSdTJNxCpsH?=
 =?us-ascii?Q?96Ga3nKK0zA04oYGhVQce8M+L23sWkpMU45p0L1ZoWw4RXrIpi9HTKkDwlgV?=
 =?us-ascii?Q?zQ7FbFRCxXS1/zpoN9x1pXFF63kscmmvmHMkp3pyTb5Sae3VyIMbvfXJe78X?=
 =?us-ascii?Q?qBRW9IgQz+U/xctxJZ6e4MrmPRr0wsdwi9BdQq3/skTy4JgjaG5j6TyaOCSw?=
 =?us-ascii?Q?Y7IQOKsPGxuc7os2MoqwMbzm68tj6obEkci4TAqhi9jL/7XRMj/+bwnPuLDj?=
 =?us-ascii?Q?1U/MDmbgisWfqPy9M9RvuzIQx8dmXBs1VxDgKmTjjajNljkQulvArwqohW4O?=
 =?us-ascii?Q?V/IMgBnMagjpAwN2FD+avXouasSE7FqW12wIGzpmS8SLcvANIZnbd2RWYcMX?=
 =?us-ascii?Q?KxNxojVJgDZ1F+jfM43mheH5gbCsPS2L4KN3yOF7gqb2mSvf2EsWX8fOnNzf?=
 =?us-ascii?Q?+wfFUBTqGy1hUQ5THAULgDdMqkqiacj+YXr4zsRTRZrm14gqzSiDRuVj8Aa7?=
 =?us-ascii?Q?cpN2BgnjWx2wCtHKGCO4iCbiiB3mPq8b5+hehm70fWgxT1B7rulS2oDTCi6Q?=
 =?us-ascii?Q?l8xVtXw3VivWPzdfeCXCfxdZ5fZC5wEYfDvep+WCGA6R1FdKumYy6jDzy4/o?=
 =?us-ascii?Q?6vQUiNg+oHTrxYRC7F4X881mOzdwxH5nU8b6iOOPsaMJ3OXuJJqk2FXoJG9I?=
 =?us-ascii?Q?F4TTIpVtQ3HVLNG5Z2zMNneupDEQg1uKgAvCV7Kzoqju7u0P9FsP/hLqQLNz?=
 =?us-ascii?Q?7NJFI1ZUTLAPcC+X1EnzenknDDYOGSqtB4GZpQFnGTjhwi56cj+FRDzhaLcj?=
 =?us-ascii?Q?PgjTYavxFqRdYJ2RK8Tatdm78JGeF7FINJEBpRND5BIAFgekJT2TshYNXplz?=
 =?us-ascii?Q?pjxHhVbLPimUzFqWu1l7V8OrAqKOJEAc6oXY0eV7ULL25NVmZdSUHIQT3p6X?=
 =?us-ascii?Q?3BAhPZQF0AmBHEqZLqUEcNflqsVr+VIVIegAdoaGfoHmKWFI4MBI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b3488f-0270-48c7-fd5e-08def729b5a4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 21:52:44.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60YfG7gdKFLtSrYaXpYBXWvFyJDkpzqhblrfYna7ENNOW+II+PIPqfDtHZ50LoNjmFdk8OsWRIwP3I2MNcT15JKT1y8PqGLFbXiYTVvvoHQ1ST7do9GgMhjfqfeJw9yy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11923

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

(d) is close to best solutin.

There are chan_id in dma_chan, but have not implemented good enough.

  	/*
         * When the chan_id is a negative value, we are dynamically adding
         * the channel. Otherwise we are static enumerating.
         */
        chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
        if (chan->chan_id < 0) {
                pr_err("%s: unable to alloc ida for chan: %d\n",
                       __func__, chan->chan_id);
                rc = chan->chan_id;
                goto err_free_dev;
        }

But there are not check for negative value eventhough there are comments
for it.

It causes logic channel and hardware channel mismatch if dma-channel mask
existting. If skip some channel register, it will be mismatched, which will
cause confuse when debug.

To keep back compatible, we may use reverse logic for dynamically adding.

BIT(30) as static enumerating.

if (!(chan->chan_id & BIT(30)))
	chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);


Or we simple add hw_id in dma_chan. at debug fs can show hw id. but idealy
chan_id match hardware sequency.

chan_id match hardware instance will beanfit more. There are some code
assume chan_id is that hardware id, such as

drivers/dma/dw/idma32.c:        value = readl(misc + DMA_CTL_CH(dwc->chan.chan_id));

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
