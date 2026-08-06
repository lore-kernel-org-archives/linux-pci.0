Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021119.outbound.protection.outlook.com [52.101.125.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3F342CB2;
	Thu,  6 Aug 2026 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785987920; cv=fail; b=I2UNMFbUu0khgJrXwc97utjoGfdQk1crEv7WAjgED/qiKJJmpf+sbPYh+ZEqz1KaPShYKeqnnsKazhSWqubTh1YNAANU+vCo392VgtrsFdoWnuuYydPoYLM4UyKCpSovBPA54/elg/dScZyMaQW2q4hDFk9DrN5OMi1rMcqeM4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785987920; c=relaxed/simple;
	bh=cDIMLH6NXtPB/TitSfD7g/OxH9lt3ubakRe+EaoopB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hOynBlug0reEsVX5R1SQKlRWVg6+MAOupM4IcKZnk76qWHJ1ZMMUGjk89ktusTYjwS59RTllusdN8S9vHyBF9U9J1Oe39NJ5h7UZAFH0n+Y1swHXb4GS+0OXxrPFdbhz9Iv3MQjg6fdmCQZFREDLxhblOBCHN0YKHWrWpzoWt7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hV8HN/0F; arc=fail smtp.client-ip=52.101.125.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hV8HN/0F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6Foit3q8yxoDciaGj6NsxE+WEPgpZHzVaGkDX2jwN9sumeSBb5GHDvBfveWsWr/iRqRcf7GLayh380iBUBRVzS94rh6GtS94g15jPg4lqr3j4xI2UESZH2FUkNbY731gw03v8ejverREuM387CxdxJz0dzy7k8xpPlCVE91E2BGhLuMECMO7mABNt1sFVk9VvsbYjBybVwtrxy8/DUUX8LGgK5ckTQUCWzmNOPc3Q591n9mUIllAq9+HxWw20p5/L95UZIjIRIV7BzZpb9PY/3IJEtwLY+XuDHelXxkz+DeAZHQN8fxdUNx+7cNmujdLakBXvUUkWviPWBFi9flGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8Jta9eKocU21mSwutxfJyU4mWFa+coooM23RZsTq8k=;
 b=dMZ0kGC2W4ydzMKyq5DtzgW5G3NG52LOz0JaQzUYGFPLC/APq78mhpRwvXN7PT+D06hxzS66FVwtU+aRd5cyEK+QFzJETVP5SqZs5f6esLMvxqSxWVeaGbcBZeBWALbENakcSpXrArwA+m9sW0wyxlLbR1pIG1OKpp+iWibyTByhUG4xw2tczOhugYgMS67MHQdqjETSW90STsLsO0ru3GX180RhRd0pNUAaWBaDdXD7CPXDbQkfjfH9v50uItjcTsZcAxTLCpuSH49akgGDwbXztfEl8emAI0sPshMBMpJAxW+g4tXUZkeA/daz0ey/oyd8FdJViT06A01PJbGRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8Jta9eKocU21mSwutxfJyU4mWFa+coooM23RZsTq8k=;
 b=hV8HN/0FlZZve87oTgokPxJyCx596rcu+kwC8mZ0l+8C6vIpUcZMWo66Vy8GSh2ZaAl/HZPFzxTxnLwtn47DNZBUM5RYXpFruIfOPEKYL9OvuEoJfPsJnAkdRwsHM47nlN8tR6s+kChbmq4L3kMTnCxFFA2DibU/WPbsZR7+6YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5709.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 03:45:15 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 03:45:15 +0000
Date: Thu, 6 Aug 2026 12:45:13 +0900
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
Message-ID: <ni6sfv45mypgxncitlstnqxgpqwn5ocxkns6kv3nez6hnq4x5m@setbl5dlfqdr>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <anISE4zj1odwT2aJ@SMW015318>
 <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
 <anOFUSDiDjD0jvei@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anOFUSDiDjD0jvei@SMW015318>
X-ClientProxiedBy: TY4P286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: e49268e7-8e39-4f71-66ab-08def36d2011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|23010399003|4143699003|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VilOg3biKNO8Vb2oDZt5ifmJLHsdvi9Rpcr0+YEf3d7dinxyW/J+t4Etc5kvMRVl5qKtxIMXvUW4oST0ras2+F9SQRBoslTNLFjvyRaGSHPZdpbJGlKyvG93w5W7dgcRQNgftF5aE0KQGWcjcFxtiT8TnicdT+6pseFXYK17hjUeX4xBf/LICvENFCQiHBKx9R5NHvlgOFU4Bo8saBcSbNWM4dxLFPvs9BEL42wYg9pve7lcqEmq4jifXF1DHzahgQsyZ4S+qK8Thsv/DC73ve5SDzD5hhyYiMk7Iy9sdM8kpEdsI0ZPocEBEK4tk5HzwT5fz0WIHEScXj8Aw5lvDoU1ADZyaitwnL5sPK2X1jtZxBShc3mQsZM91XWJahEcCe2bsqp1Mh9VyqIL6DwzbcXEZeTGFjreXxpOKc06oIWgIRTBWuhtQ5+n9nQ9hXpQJg4ZSllDhdVzMwW3F0137Lg2SuSSf7UNRUNOnsZVFLyeJsRCcw9I4MSjS4KmlUufo5KgQZuGmBedtY1c/OO+b1e59SQR2VV+UoTYi688JR1EdBdYAyDzXefKzOkgZaUDTcnf8FIp4+paLoFzE0+SkG/ZP6Jv2qVWU9dTS1SyyzP0ARWWcf2Ttmak+kGmhS3/ZE57Gm4kFalhhaKVpEWdEzcHqekKmzcz8do+16cs2bM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(23010399003)(4143699003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Tss4gjGQxR87hVBcLR4qe9vIT32qNeVlv6nxWDBi4Bj1QMl6mxxXAF7qcpr?=
 =?us-ascii?Q?Iaolw4VC7GtZ4H3oKc7+PSKO4GuDV+1AZkw6hI2n23fDWIIx3ZsGsDTMK/i8?=
 =?us-ascii?Q?RGt2bSqOdeuOMTqcRWN2yik5lwAsBw3oQI84rtpfoVqqiKOeJ9mPIp1TACeO?=
 =?us-ascii?Q?a2JyY/6Bf3g9YGFPPaz+RO65VnWeddnzrkjOcGlJRvRIj4ePkAxcoXYHwO15?=
 =?us-ascii?Q?VXFBlspRr8KVcUWoM3tvr/tL1A4i0CS8i6T6VgIhCJyVqI/xm1gGNDgJRn0V?=
 =?us-ascii?Q?jRIdOgS24ywhLPN3nhs1mGwLzpVnXx5radbQbx+AI89k/wPOuWty6nG0HGGL?=
 =?us-ascii?Q?qbsIgme5z8ujna9jVDey9/gCSGgcg/HAJnbSXFEONWujXZ+EEXcqohm4l1os?=
 =?us-ascii?Q?lXkZw4WMwNAVzPAs4lGmArKBcjFb6szD0Ctkv4/6YvPAMcUeJYvDepNPSGk9?=
 =?us-ascii?Q?TlDum5+gzK4HGn2KNbK5kTlEgH2mGyhzXEGpTVCPIyBnZeYT03YXA2AUFKhX?=
 =?us-ascii?Q?kUWtmLyq1ttAdz2REKnA6Z4NlI/2j+kiwzcYL/mtFhq7OxZEhPTflcSYB0aQ?=
 =?us-ascii?Q?GInPwRJNPQRsfuASvg3Y8kBTHwKufYbtqMV7OF7RZiQBRrPAliGcr4DgCbMh?=
 =?us-ascii?Q?hpiRuThimzPWYPOcM/dKcGrOiW1sbtBwrDqXSmbX5d4fKH9UDrS9pxfpqXAG?=
 =?us-ascii?Q?iK75+GnnJIaqG92cSxAh7v92FByDuLckktQY9ft9RBX9ZssXWJDF5wLAzfMj?=
 =?us-ascii?Q?EtyYkXTgZ2eWJlFeGUB37FppGhDJmCSyZ00Ep+caoUEhPOpk5wiu3oDg/kgh?=
 =?us-ascii?Q?hU1ODKEglTP1LEWnALkiTh9ege2i55Vxp7IYFPc1hQKvqR4QzXmv0FGzDyhk?=
 =?us-ascii?Q?nYrxdBmV7zEoUXoz2tncMPKgVwRPIbViIP+ykYdLNXckejENaY1y/tBcneEO?=
 =?us-ascii?Q?PL9lBoihQgBW7wVDF3baRsnDYEh96C59ATy+BZ2d7wcFmP/xeWNet768Hs0w?=
 =?us-ascii?Q?zdUKmNoPMwP0rbUEuEuIy9waGSEJocZdOltLkx7jL4bdy/w1CfJ/UC+MlIvc?=
 =?us-ascii?Q?zez/QpGUS/UE6BYrvuu1bfQdsAY4lWgXwieg1TBJ3ZKxs8FTwkB7eHs62Dti?=
 =?us-ascii?Q?di6eQvKdlTB8UQMsEwtVDRzbYBnjENvV55w8vkPZJK2D7A5PmaJQRAt52q0x?=
 =?us-ascii?Q?emESzm+A7SF32GHGKMZcqr5+1axih+nZwKJo0SUzsOnUQzHXq7+mq/yH3MHO?=
 =?us-ascii?Q?qMXfd2T/AFRrNwS6km42n3WZt/DA24ApxQEiat7Tsm9cvc2s3VVPyJLYcY/I?=
 =?us-ascii?Q?mXjpKbgV7fFOr9JkAiMdIOaoyHf/iaQ7OfE9ljiRZHgQ/Nz2mihBlkVeomVs?=
 =?us-ascii?Q?Jr2kopnvOVYp7yJG6W122lt/hwVeZZhlfEEgdUuEgn/uiN7FIKoVSOZMDj2N?=
 =?us-ascii?Q?sqrXAu+GZLAH0mRzwi0jGr4Xvs4QmCXCpw5VUCAelMgrmc8sVDOBv80iZwgw?=
 =?us-ascii?Q?fOlNrwm5n5arXgIcTtDGyeWKJ3MlpN8eCHJfNWM0u9vlPsqXEzS237T2O9Q/?=
 =?us-ascii?Q?NXMqoPKLkdBNwCfvBHdsuMbNclr5NoXQvXV4wXNbI2Xc1yeHlz+ct7+a8UAj?=
 =?us-ascii?Q?mtzTPwl9F3AMUrSbQLoRKRiQYmt2wrswFkczn8x6x3k2hIeKX+X3TKSQNwZb?=
 =?us-ascii?Q?tNqnb8jOdYOQcHoM2eFcbOeSRE1p5jfh7ufUmFhm55QF3hev8vH2HT2Pbwvj?=
 =?us-ascii?Q?mkYonhgOhODbqxugrMIVgTWQkSgxKdaG0iaWzkyRb6XHgVa3I7QL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e49268e7-8e39-4f71-66ab-08def36d2011
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 03:45:15.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCm16TXHt9MxKQ9em+8qJJL1JpqUoSZDJFoX+Qn54lo3T/KF+ZpPJ+1wftr0/AFx5tO6bq0xVhQ4/g98z3NdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5709

On Wed, Aug 05, 2026 at 01:47:45PM -0500, Frank Li wrote:
> On Wed, Aug 05, 2026 at 11:05:21AM +0900, Koichiro Den wrote:
> > On Tue, Aug 04, 2026 at 11:23:47AM -0500, Frank Li wrote:
> > > On Tue, Aug 04, 2026 at 12:38:53PM +0900, Koichiro Den wrote:
> > > > Endpoint functions that expose endpoint-local DesignWare eDMA channels
> > > > to a remote host need to reserve exact hardware channels and hand
> > > > interrupt ownership to the remote side before publishing the channels.
> > > >
> > > > Add DW eDMA-specific helpers that request a write/read hardware channel
> > > > through DMAengine, keep the hardware-channel filter private to dw-edma,
> > > > and switch the selected endpoint-local channel to remote interrupt
> > > > routing after the channel has been successfully reserved. The matching
> > > > release helper can quiesce the channel while it is still remote-routed,
> > > > then restores the channel's default routing before releasing the
> > > > DMAengine reservation. This lets callers skip quiesce when unwinding a
> > > > reservation that was never exposed to host programming.
> > > >
> > > > Release is best-effort because its callers cannot abort teardown. Report
> > > > a quiesce failure locally, but always restore the default routing and
> > > > release the DMAengine reservation.
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > > Changes in v6:
> > > >   - No changes.
> > > >
> > > >  drivers/dma/dw-edma/dw-edma-core.c | 91 ++++++++++++++++++++++++++++++
> > > >  include/linux/dma/edma.h           | 14 +++++
> > > >  2 files changed, 105 insertions(+)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index 1f893dc54c79..4c0d2bba755b 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -1302,6 +1302,97 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> > > >
> > > > +struct dw_edma_delegated_chan_filter_args {
> > > > +	struct device *dma_dev;
> > > > +	bool write;
> > > > +	u16 id;
> > > > +};
> > > > +
> > > > +static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
> > > > +{
> > > > +	struct dw_edma_delegated_chan_filter_args *filter = param;
> > > > +	struct dw_edma_chan *chan;
> > > > +
> > > > +	if (!filter || dchan->device->dev != filter->dma_dev)
> > > > +		return false;
> > > > +
> > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > +
> > > > +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> > > > +	       chan->id == filter->id;
> > > > +}
> > > > +
> > > > +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> > > > +{
> > > > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > > +	int ret = 0;
> > > > +
> > > > +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > +		return -EINVAL;
> > > > +
> > > > +	guard(spinlock_irqsave)(&chan->vc.lock);
> > > > +
> > > > +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> > > > +	    chan->request != EDMA_REQ_NONE)
> > > > +		ret = -EBUSY;
> > > > +	else
> > > > +		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > > +						bool write, u16 id)
> > > > +{
> > > > +	struct dw_edma_delegated_chan_filter_args filter = {
> > > > +		.dma_dev = dma_dev,
> > > > +		.write = write,
> > > > +		.id = id,
> > > > +	};
> > > > +	struct dma_chan *dchan;
> > > > +	dma_cap_mask_t mask;
> > > > +
> > > > +	if (!dma_dev)
> > > > +		return NULL;
> > > > +
> > > > +	dma_cap_zero(mask);
> > > > +	dma_cap_set(DMA_SLAVE, mask);
> > > > +
> > > > +	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
> > > > +				    &filter);
> > > > +	if (!dchan)
> > > > +		return NULL;
> > >
> > > I forget, why need export delegrated dma channel to dmanegine? If EP
> > > driver doesn't report delegrated channel to dma engine, what's happen?
> >
> > This just reserves the exact channel against any dmaengine clients before
> > handing its programming ownership to the host. Without it, a local client
> > could request the same channel too.
> 
> why not epf function driver call dma_request_channel() to decide which
> channel pass to ownership to the host.

I actually tried that model in v2. pci_epf_dma called dma_request_channel() with
a filter supplied through the EPC resource.

  In v2, .filter_fn was part of the pci_epc_aux_resource definition:
  https://lore.kernel.org/r/20260525063129.3316894-3-den@valinux.co.jp/
  ... and pci_epf_dma_claim_channel() used it to claim the channel here:
  https://lore.kernel.org/r/20260525063456.3317509-3-den@valinux.co.jp/

I changed that in v3 after your comment about why the dw-edma filter needed to
be public. The replacement kept the filter inside dw-edma, and moved channel
reservation, IRQ ownership handoff and reclaim there too. The current EPC
delegation API follows that model.

Or is that v2 model what you prefer here?

That said, dma_get_slave_channel() might be sufficient inside dw-edma here,
since it already knows the exact channel from the direction and hw channel id.

P.S. For clarity, the options tried or discussed so far are:

  (a) Expose dma_chan directly through the EPC resource, then let the EPF
      reserve it with dma_get_slave_channel(). This was v1.
      (https://lore.kernel.org/r/20260521063405.2842644-3-den@valinux.co.jp/)

  (b) Expose the hardware ID, direction and a provider filter, then let the
      EPF call dma_request_channel(). This was v2.
      (https://lore.kernel.org/r/20260525062420.3315904-2-den@valinux.co.jp/)

  (c) Pass the hardware ID and direction to pci_epc_delegate_dma_chan(), then
      let the backend reserve and delegate the channel. This is the current
      v6 design.
      (https://lore.kernel.org/r/20260804033855.2115817-5-den@valinux.co.jp/)

  (d) Request channels normally and correlate them with EPC resources through
      a generic dma_slave_caps.hw_id. I proposed this in a much older series.
      (https://lore.kernel.org/r/20260204145440.950609-2-den@valinux.co.jp/)

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
> > > > +
> > > > +	if (dw_edma_delegate_chan(dchan)) {
> > > > +		dma_release_channel(dchan);
> > > > +		return NULL;
> > > > +	}
> > > > +
> > > > +	return dchan;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
> > > > +
> > > > +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> > > > +{
> > > > +	struct dw_edma_chan *chan;
> > > > +
> > > > +	if (!dchan)
> > > > +		return;
> > > > +
> > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > +	if (quiesce && dw_edma_core_ch_quiesce(chan))
> > > > +		dev_warn(chan->dw->chip->dev,
> > > > +			 "failed to quiesce delegated %s channel %u\n",
> > > > +			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> > > > +			 chan->id);
> > > > +
> > > > +	scoped_guard(spinlock_irqsave, &chan->vc.lock)
> > > > +		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
> > > > +
> > > > +	dma_release_channel(dchan);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> > > > +
> > > >  MODULE_LICENSE("GPL v2");
> > > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > index 3c8e2ef9dee0..944469258b8b 100644
> > > > --- a/include/linux/dma/edma.h
> > > > +++ b/include/linux/dma/edma.h
> > > > @@ -153,6 +153,9 @@ struct dw_edma_chip {
> > > >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> > > >  int dw_edma_probe(struct dw_edma_chip *chip);
> > > >  int dw_edma_remove(struct dw_edma_chip *chip);
> > > > +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> > > > +						bool write, u16 id);
> > > > +void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
> > > >  #else
> > > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > > >  {
> > > > @@ -163,6 +166,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> > > >  {
> > > >  	return 0;
> > > >  }
> > > > +
> > > > +static inline struct dma_chan *
> > > > +dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
> > > > +{
> > > > +	return NULL;
> > > > +}
> > > > +
> > > > +static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
> > > > +						  bool quiesce)
> > > > +{
> > > > +}
> > > >  #endif /* CONFIG_DW_EDMA */
> > > >
> > > >  #endif /* _DW_EDMA_H */
> > > > --
> > > > 2.51.0
> > > >
