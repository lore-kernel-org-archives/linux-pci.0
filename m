Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021112.outbound.protection.outlook.com [52.101.125.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007C2EB0F;
	Sat,  8 Aug 2026 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786207340; cv=fail; b=asE2M+Lz90DUDlpwwk5JAlmlisH6nw53BEp02LCCwSsZFN+vjy+kQ1pcLWDD9Dg3MAaU159+HiuxPM8qFDx6kK/muCghiliXaeN8fgRXfaYODXE7miee+OYNXP99llrZY+xiVZHc2cRUHx5c1eRNZ58gr1M6EUBnLqFCouRbtyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786207340; c=relaxed/simple;
	bh=Bp+ZNNSMUKPEGJtNg1X1oeJlcdy08bi+EzeZVtUvDKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pf0Fpj/aaXOy3i/FBthR3il86QkRSPi7Fbs0UKVRZLv8qjzDRlHaIn/3/jjPYAru/Pnm7ws4Q6vIgPqT9wbKG+y+UNAUVDy/Kw5ljsCXqc5OZWTUAKxGGfUlh+/c39SJvj1hZgrJYlWR5ytG+C7etmHo3cR4rggyJE63k8XyFts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JpKy3Ool; arc=fail smtp.client-ip=52.101.125.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JpKy3Ool"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFlzVkKMyxWzTLjvykDNDm/H/gdqsM+1oE5a2gZNg+VHNCRSNj1V/RmPfKaSx9kk+jhLwDC42gYUYLNRgZSUMQtP1FhAdqkpKlHzojJdX7OFvp+aMWHptNmOpMgcD7crH4Ko788T02hvKpXaE8jm+RbUTyeVBFJ2XioBZZs/6h7f142LQjpv5B1xhK3sm16cWAqbTEjEYRom1LIjyiL1bMlA34qu09bf4MebS1fZ+LY8m0AF9BmhIiZCVTYHTeDfD/e12RaGL+QwDlcF3LDejdxBeKjq/qxalXOoJQktZjM3wTBI9mLicd0lPVi5DKLrcMlN3T9gny2Us5AnXQP16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eumZ4608PlKp2eCQmoo3y6m23LVZ3sk9VS6T8ML43vk=;
 b=tHSaUOVoNuOsRmrZCg/471X6m+RwrHXiuDiLRbUpuxqRDFJZv6UBolyrbU6q2VCHLmPh9LHKdnat2zP+NZQOhAc275/bFwBvQAab1UwujgiiMw0Pt0JaQaQ8k2EwH/vOHNhp8Qnpm8hWTdaibnfQcHrwhH1pHITX9AcQPWKIEoPZDMiBdRAtCGp6Nsyk0wBmuQjOUUUItLeImkZKYN3vl3w5UBB5+m2V207+fEOR2lBvTIp8rI/tQ6Bps5nBPw9NBKkE1DCPH8kIBtw50gAS88+Dj0/ZH5aIerWx8sETwt1o5zuulJJgtIDA17rkkBYr5nyHjs499FkN+49iV9Jbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eumZ4608PlKp2eCQmoo3y6m23LVZ3sk9VS6T8ML43vk=;
 b=JpKy3Ool5LRN454S+MhXk4mA2xKlkzq3GgfQhnZxVwYfez1fWLG30/6QzyGxgJMDsrYfbvuK9Xdm7bi4CNIBShv0jFAISSoUQ7Cyx9lk/1vA4Y7yO0VuCdR4n8E6ZV31EgpuDbm7RmasDQooc8kUm56UkMko+6ilfibz9h52xfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB3255.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 16:42:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Sat, 8 Aug 2026
 16:42:14 +0000
Date: Sun, 9 Aug 2026 01:42:13 +0900
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
Message-ID: <pzeysikhd2mdblpn3hbl3fsiehmgwcogbep6f4btr65he5jb4t@mdas7wsvkrtp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <anISE4zj1odwT2aJ@SMW015318>
 <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
 <anOFUSDiDjD0jvei@SMW015318>
 <ni6sfv45mypgxncitlstnqxgpqwn5ocxkns6kv3nez6hnq4x5m@setbl5dlfqdr>
 <anS7WQ-b4y1_wwY-@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anS7WQ-b4y1_wwY-@SMW015318>
X-ClientProxiedBy: TYCP286CA0361.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB3255:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e87f16-14eb-4b29-56d3-08def56c003e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10070799003|18002099003|22082099003|10067099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	S7P5cpl/DBSCNv4qhP8naW+gzzsfbiLcFIGlei4wlx/Nwcjp+1UCSI/Htujp9HaGOHJ8mq2tomC7X2ukG6wX19NPo19Zq0+KIrPKChdzbzdaPjdwfU4tpjUz/reJ3vtstP0XZZ/Mc1rp1QzTY1HG0nB31qgAk+kgIoOd094sgX/AUByn9y39NrAxRgeCG+GwIM0JRbfgWb0+rcT7eaqv+EI2pmhrjWHDNPyF0d+tguQjMuD+POVRY3zcYdq2nJD/uFGhQSzv3f23/jNTjr0A+Hx1HzCRn9mgnmw+niT2MjnrFn+Dv0e6jhhKdnBJAW0z3rzW67/RxY7YdnpxUDeayPgK6C9/32rdba30ILk33xth8uNJ+AAUkYL9x8yHii8uphOu58pzbzLAVhbYcS3S0emdlbyILeRO1lHTEEs6J0vhqFb8neWV9pHvas7H9cgLTIZakNQWjyxdWin6IyTP+fzD1golE38hYjnADPARanJgbEraXzC0CEDOThfEKqCvRyvsPaqWl+fG/3aS6f91CqlYlCGuDOYDDRw2oSXN3xs6Kwnz2PRCgxdeDiLIFSxKOm6uBaGfOWp+UH6gHgIrBrwamN0meWEvQxqKr6/29SbXop8gPKLthSNx2o/K78bcqX+J+3/+6doxSBM14vQDQppqsqbrX3eY1sdRNvybCBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RPtkxnjVd/RWWVulQa4PjOjYzmD50YjBu2od6jKAaohexLgynm9f+tD/p57i?=
 =?us-ascii?Q?Jwc24owRDh9RE0wq1kjD3jakMoSG6cGTrCjato9399JlkQzQRv19RvPN26JJ?=
 =?us-ascii?Q?xdmHFPPX+K/BF1AHIvyIERlORremsFuL4wWzn9DKREtk/rtj0pxr0yVCneuz?=
 =?us-ascii?Q?KVHpnEImukN432JcbXlfZNjoXvtJHgmSJd+nFUHKGIKH+NzaosKwUGF8Jy1H?=
 =?us-ascii?Q?+QDqjJKl/wP+y7qNjmnnIi1EvF3bef+y44qVvQjBJOWdAp02UKI802yakDlH?=
 =?us-ascii?Q?X/dclhTmwwAefAWg7te6RdbXw0Nk/nNhZFZsjf8QYUJy3PSA7yqB7rWUQSOT?=
 =?us-ascii?Q?3QxYb0QCAKHk+xVgVvsWKK99WRPbur+bJKBbuC5ndD8fywtTOH1FmJ21PT/f?=
 =?us-ascii?Q?eCBdjhSLmGPdMAPaSDFi2HXBlNuClCjiTskAwNlgLdPe72F3tS+pNq+k7i6I?=
 =?us-ascii?Q?hx0u6oXnecCrspJwbcP7Gb/jvk3USduvnTXzAnBtCsj5JEqYLeon+rnNIoRp?=
 =?us-ascii?Q?3jcdG+/K2A6U+z5IDRvFsYXT0tq3y53TPTeCcLydepjGbkD1QXnpwo/+7DxI?=
 =?us-ascii?Q?1eX0xoEA4Hplj0KJTvYJLPPZZrB4Yrq9xQ26ejeyk1Kjra8YlAwGqf23Fy1p?=
 =?us-ascii?Q?SvCnOV8WEKUcWVcodfpYFh4k8Ec3t5LgnpUVmmdgGK3hnfI7dy2IWZFfgBqr?=
 =?us-ascii?Q?LJ/o/rV7KvR3ClZiy/FzRdut9nP8sf6FB2oiIcIGvm9n20qPP+fEa5IQPUM9?=
 =?us-ascii?Q?DtAi+JS59P3lRRVYW7dhrtck31ZLP+0Xb9TDyA18ySsSKhCl+g+BDhHma/ie?=
 =?us-ascii?Q?0BnaC8MbnI7sKuMxpp4lxoEJtVrM3eZpISdVRNmDVwptkLeNR0cI/BPydx4n?=
 =?us-ascii?Q?JH59hM7a+JCjENPrukSXbF6KVc70t8a+EYiIUGL8DOBPyNrWucA5dfBMCc9p?=
 =?us-ascii?Q?UVdb3HKSWDUUhNc8f56n7SsdL4MnSU8V1HGH+7HXCS5SUJNCP4dpo9Mid6h4?=
 =?us-ascii?Q?X/+HNNsXGgFP/ybkae3ndMjQ2qXsWygQjjdCAyTPLDnByxbw59RJFXKB0G18?=
 =?us-ascii?Q?lgyPrWUurSFYbLAC6MUgGFmD6JxXC09l7pMLTeP0NUHfoom4R9Si6AqqurcI?=
 =?us-ascii?Q?5/Lky7cGuAEMqnfJxwHfPN4e3ayPSVXfN9qJm0SI3sLfK6LfSjazJSkl4dor?=
 =?us-ascii?Q?wAgmueb39kK/UhAfOBrgZDjnoEowOrxECUlo/TmFdd/Us+T/UVoXN6vG9W15?=
 =?us-ascii?Q?xrCSD2YadjUONCG11hvHd22/efbZsMGwpQyl7fZHlp86zxDHT9v9J1DzVjFg?=
 =?us-ascii?Q?CW/LtT9Com+oEaovQ2PW5jM1MywwCs4iNODKRHbUz1lo6u7Ebf95hypzXI/U?=
 =?us-ascii?Q?eKRQOOkujek09F+0GgGCog31ZTQXm6D5bdcnPvHnLzDiRZfZMxX6G2PSgrC2?=
 =?us-ascii?Q?U1H82sqIwYIsyg/3mzZkivUWAaBVZhwQ48uk3RVqF7lparjakp2Iu34XPxj3?=
 =?us-ascii?Q?0ZYR01z268Bow078hxgDDHXqX/HUkLqvEXtzzSTZuIeDh2goA9YN1KUWP9mJ?=
 =?us-ascii?Q?ZyADeUFLlxAAFrbn06Ctow5fst6J4h7CQJlPmhDuvOgqiQneaGWJ83H9kfhZ?=
 =?us-ascii?Q?eHdUotQtNXB1ICF83v00UxOTGY0AjWskiM2uowxo+xX46VlodT1ELghtals5?=
 =?us-ascii?Q?JqNvVUDL5rWZ937mn4Fbfipts5YXihto1x2oA/9F9uDB5BIb9XYv0DO3IsZm?=
 =?us-ascii?Q?IwoHvx30c8XxqcJr4O8aK3/av69QJEw6citN4XB0QjI20lQgBZX9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e87f16-14eb-4b29-56d3-08def56c003e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 16:42:14.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JaYAhhFRI3xRWCDRv9dOHHbY6voN7EdGIcVdzUOk7A6I8Wv1dPjkfMWk6oRBZJa6wcC1RT7nKS/h21bG5NIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3255

On Thu, Aug 06, 2026 at 11:50:33AM -0500, Frank Li wrote:
> On Thu, Aug 06, 2026 at 12:45:13PM +0900, Koichiro Den wrote:
> > On Wed, Aug 05, 2026 at 01:47:45PM -0500, Frank Li wrote:
> > > On Wed, Aug 05, 2026 at 11:05:21AM +0900, Koichiro Den wrote:
> > > > On Tue, Aug 04, 2026 at 11:23:47AM -0500, Frank Li wrote:
> > > > > On Tue, Aug 04, 2026 at 12:38:53PM +0900, Koichiro Den wrote:
> > > > > > Endpoint functions that expose endpoint-local DesignWare eDMA channels
> > > > > > to a remote host need to reserve exact hardware channels and hand
> > > > > > interrupt ownership to the remote side before publishing the channels.
> > > > > >
> > > > > > Add DW eDMA-specific helpers that request a write/read hardware channel
> > > > > > through DMAengine, keep the hardware-channel filter private to dw-edma,
> > > > > > and switch the selected endpoint-local channel to remote interrupt
> > > > > > routing after the channel has been successfully reserved. The matching
> > > > > > release helper can quiesce the channel while it is still remote-routed,
> > > > > > then restores the channel's default routing before releasing the
> > > > > > DMAengine reservation. This lets callers skip quiesce when unwinding a
> > > > > > reservation that was never exposed to host programming.
> > > > > >
> > > > > > Release is best-effort because its callers cannot abort teardown. Report
> > > > > > a quiesce failure locally, but always restore the default routing and
> > > > > > release the DMAengine reservation.
> > > > > >
> > > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > > ---
> > > > > > Changes in v6:
> > > > > >   - No changes.
> > > > > >
> > > > > >  drivers/dma/dw-edma/dw-edma-core.c | 91 ++++++++++++++++++++++++++++++
> > > > > >  include/linux/dma/edma.h           | 14 +++++
> > > > > >  2 files changed, 105 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > index 1f893dc54c79..4c0d2bba755b 100644
> > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > @@ -1302,6 +1302,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> > > > > >
> > > > > > +struct dw_edma_delegated_chan_filter_args {
> > > > > > +	struct device *dma_dev;
> > > > > > +	bool write;
> > > > > > +	u16 id;
> > > > > > +};
> > > > > > +
> > > > > > +static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
> > > > > > +{
> > > > > > +	struct dw_edma_delegated_chan_filter_args *filter = param;
> > > > > > +	struct dw_edma_chan *chan;
> > > > > > +
> > > > > > +	if (!filter || dchan->device->dev != filter->dma_dev)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > > > +
> > > > > > +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> > > > > > +	       chan->id == filter->id;
> > > > > > +}
> > > > > > +
> > > > > > +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> > > > > > +{
> > > > > > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > > > > +	int ret = 0;
> > > > > > +
> > > > > > +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	guard(spinlock_irqsave)(&chan->vc.lock);
> > > > > > +
> > > > > > +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> > > > > > +	    chan->request != EDMA_REQ_NONE)
> > > > > > +		ret = -EBUSY;
> > > > > > +	else
> > > > > > +		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > > > > +						bool write, u16 id)
> > > > > > +{
> > > > > > +	struct dw_edma_delegated_chan_filter_args filter = {
> > > > > > +		.dma_dev = dma_dev,
> > > > > > +		.write = write,
> > > > > > +		.id = id,
> > > > > > +	};
> > > > > > +	struct dma_chan *dchan;
> > > > > > +	dma_cap_mask_t mask;
> > > > > > +
> > > > > > +	if (!dma_dev)
> > > > > > +		return NULL;
> > > > > > +
> > > > > > +	dma_cap_zero(mask);
> > > > > > +	dma_cap_set(DMA_SLAVE, mask);
> > > > > > +
> > > > > > +	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
> > > > > > +				    &filter);
> > > > > > +	if (!dchan)
> > > > > > +		return NULL;
> > > > >
> > > > > I forget, why need export delegrated dma channel to dmanegine? If EP
> > > > > driver doesn't report delegrated channel to dma engine, what's happen?
> > > >
> > > > This just reserves the exact channel against any dmaengine clients before
> > > > handing its programming ownership to the host. Without it, a local client
> > > > could request the same channel too.
> > >
> > > why not epf function driver call dma_request_channel() to decide which
> > > channel pass to ownership to the host.
> >
> > I actually tried that model in v2. pci_epf_dma called dma_request_channel() with
> > a filter supplied through the EPC resource.
> >
> >   In v2, .filter_fn was part of the pci_epc_aux_resource definition:
> >   https://lore.kernel.org/r/20260525063129.3316894-3-den@valinux.co.jp/
> >   ... and pci_epf_dma_claim_channel() used it to claim the channel here:
> >   https://lore.kernel.org/r/20260525063456.3317509-3-den@valinux.co.jp/
> >
> > I changed that in v3 after your comment about why the dw-edma filter needed to
> > be public. The replacement kept the filter inside dw-edma, and moved channel
> > reservation, IRQ ownership handoff and reclaim there too. The current EPC
> > delegation API follows that model.
> >
> > Or is that v2 model what you prefer here?
> >
> > That said, dma_get_slave_channel() might be sufficient inside dw-edma here,
> > since it already knows the exact channel from the direction and hw channel id.
> >
> > P.S. For clarity, the options tried or discussed so far are:
> >
> >   (a) Expose dma_chan directly through the EPC resource, then let the EPF
> >       reserve it with dma_get_slave_channel(). This was v1.
> >       (https://lore.kernel.org/r/20260521063405.2842644-3-den@valinux.co.jp/)
> >
> >   (b) Expose the hardware ID, direction and a provider filter, then let the
> >       EPF call dma_request_channel(). This was v2.
> >       (https://lore.kernel.org/r/20260525062420.3315904-2-den@valinux.co.jp/)
> >
> >   (c) Pass the hardware ID and direction to pci_epc_delegate_dma_chan(), then
> >       let the backend reserve and delegate the channel. This is the current
> >       v6 design.
> >       (https://lore.kernel.org/r/20260804033855.2115817-5-den@valinux.co.jp/)
> >
> >   (d) Request channels normally and correlate them with EPC resources through
> >       a generic dma_slave_caps.hw_id. I proposed this in a much older series.
> >       (https://lore.kernel.org/r/20260204145440.950609-2-den@valinux.co.jp/)
> 
> Thank you for your great work, let me read and feedback to you, do you have
> irc, discord or other instance message channel.

Hi, sorry about late response. Would matrix work for you? I'm @koichiroden.
I'm in UTC+0900 (Japan Standard Time), by the way.

Best regards,
Koichiro

> 
> Frank
> 
> >
> > Best regards,
> > Koichiro
> >
> > >
> > > Frank
> > >
> > > >
> > > > Best regards,
> > > > Koichiro
> > > >
> > > > >
> > > > > Frank
> > > > >
> > > > > > +
> > > > > > +	if (dw_edma_delegate_chan(dchan)) {
> > > > > > +		dma_release_channel(dchan);
> > > > > > +		return NULL;
> > > > > > +	}
> > > > > > +
> > > > > > +	return dchan;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
> > > > > > +
> > > > > > +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> > > > > > +{
> > > > > > +	struct dw_edma_chan *chan;
> > > > > > +
> > > > > > +	if (!dchan)
> > > > > > +		return;
> > > > > > +
> > > > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > > > +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> > > > > > +		dev_warn(chan->dw->chip->dev,
> > > > > > +			 "failed to quiesce delegated %s channel %u\n",
> > > > > > +			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> > > > > > +			 chan->id);
> > > > > > +
> > > > > > +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> > > > > > +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> > > > > > +
> > > > > > +	dma_release_channel(dchan);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> > > > > > +
> > > > > >  MODULE_LICENSE("GPL v2");
> > > > > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > > > > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > > > index 3c8e2ef9dee0..944469258b8b 100644
> > > > > > --- a/include/linux/dma/edma.h
> > > > > > +++ b/include/linux/dma/edma.h
> > > > > > @@ -153,6 +153,9 @@ struct dw_edma_chip {
> > > > > >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> > > > > >  int dw_edma_probe(struct dw_edma_chip *chip);
> > > > > >  int dw_edma_remove(struct dw_edma_chip *chip);
> > > > > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > > > > +						bool write, u16 id);
> > > > > > +void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
> > > > > >  #else
> > > > > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > > > > >  {
> > > > > > @@ -163,6 +166,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> > > > > >  {
> > > > > >  	return 0;
> > > > > >  }
> > > > > > +
> > > > > > +static inline struct dma_chan *
> > > > > > +dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
> > > > > > +{
> > > > > > +	return NULL;
> > > > > > +}
> > > > > > +
> > > > > > +static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
> > > > > > +						  bool quiesce)
> > > > > > +{
> > > > > > +}
> > > > > >  #endif /* CONFIG_DW_EDMA */
> > > > > >
> > > > > >  #endif /* _DW_EDMA_H */
> > > > > > --
> > > > > > 2.51.0
> > > > > >
