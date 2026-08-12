Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020138.outbound.protection.outlook.com [52.101.229.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DC392C27;
	Wed, 12 Aug 2026 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507909; cv=fail; b=U+5sjQfLH8sj3Q+ttmcIcTsz08v+gF6ZBSsk/oV3PBU2sNHt/1eDGOl6toOlLty8x+B4Skfp+dAaiwK+GXRp/0azGq5kfOmr5lBC+4eUvlo9hZyS4k3psy8rR2agPviXz4w7D7/+FvpDJ2vLEu+SsR7Y4XkFqxeDKs7jUsPTEsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507909; c=relaxed/simple;
	bh=/CKfVIyntAvRL4byE+qNvouzl+nQsOBKBHdyfLRW5iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DBVxkKeAVoiuIP4kpjZ8ihsg7KJOjT3jSB5jyVGl/L8fjnMrHPHnD/l8L74+A33ipYAWvAJl3fA4qNVgSaDR+cvS0bG3xETFNNYW9mhHx13ubZ9jsHcKh+2iir9GyCOq2bdgl2cVh/K/IT0OXmKh3FvNq+hdBqWUvk0eB8+QanY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=HwRCnPwr; arc=fail smtp.client-ip=52.101.229.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="HwRCnPwr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJlVOxV+/4B9nSNr+9JB2lFbm8a6gocrlJWfIf9/YwGfjgjs+KVA1rZrDa9TKjtr6P6ELQeX57a99x8a/4YjM6mSg45oRzx/D/mAYGjGWBQ0ZBAjV19Vgp+JNYtt73778glnoF1edQiHtv92fPOyMLqeZB5IY5LTA3QbAndWv+wuoO0xbmjxEPShZVgm+YcYXUMCBDjMBeb2v+PY6WY3VQmpeLQyUZrq2x8/NOuOb+6GnjyHE7jmcf3NGOneVo6PdZZZlEJzu9arpHy1Izpat4V5M/7sDNfNfC5/RLJIrp+hhG/NNw5A8sELuDRCVPnU+MppvC8jEZTuUcmuaRNC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvRIPs37auWkPn94nttlC1t0/7DQz9DIMNc1N/P8zPg=;
 b=uWqbd0FDTYY46Lv8iWibzI09Qa6B5Ig4Pd5XXzbug+2MsbOnBqqnX6FUCxeDcvmK3wldhUeVp5eovYvldhhByfkj0aSewohGK8r4naS0LqM5psd1hosP7CneFg3gNLXogNF+6jfyJDwIAp/b6MMMg92ylk7tP/fd+FJT6AtCnMpQtIJHfhLYGMl5M0nwivabRGmVKyMusHB3aFHCYD+tUhbDVshQej7cZUeQlNZrWz3SckZvlXmfUmC7Cv9Sm+M58IgV2R0V16cHGjDsyiAfOU67BFqbiUXH+09cKPQAab0vMi2SXtCOyhivOX4m4isgU3rkrshn1wXyGOMUZ/Rpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvRIPs37auWkPn94nttlC1t0/7DQz9DIMNc1N/P8zPg=;
 b=HwRCnPwrpY8IwkYJcqJzBLzO36fwM0txXVlNZ4jYFwF/w5IsideiGrxWnWBSIJVs6o/SWG6sTl6dtSJ47NffPKSAj9vlYTpfNQjtKkM8Dwcm+qbnKtf7wDKl/L+m94qHd5VRmhmPVYyXku8++OZN5naZpRI7lU5HPxf3PJY2dhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2649.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 04:11:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 04:11:43 +0000
Date: Wed, 12 Aug 2026 13:11:41 +0900
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
Message-ID: <lm7tadnxsyrypu4mypptlkx5qkytex4qxsijdr5ydud2n3anvf@yakjfjg5ng4u>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-5-den@valinux.co.jp>
 <anISE4zj1odwT2aJ@SMW015318>
 <eu5iqhvvnpklaudcb7tkbjp3hpzecyzqxdbf4u7fnh6bjjgcqe@6hpimw5vu62m>
 <anOFUSDiDjD0jvei@SMW015318>
 <ni6sfv45mypgxncitlstnqxgpqwn5ocxkns6kv3nez6hnq4x5m@setbl5dlfqdr>
 <anpIJM5OligYsEK0@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anpIJM5OligYsEK0@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2649:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b7daaf-62ea-4c2b-f6f1-08def827d11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YGRM3HVIwmxw08aydhtTKVgynyO2lhh+Vz+jmEY3Oi+Dr/bN2LZIRWdZ9Ke2ZEJcRjdKjFR3xdc2445aTQcwiqlct5/KlM0fVIyDMNdZ24n8aXq3Rrt8AoYHmKXH89GblCSP18m6+Bk+NEOuTHhP/DAtnJ+zaoMtFeR9oU1NVrBi8T9rbTYuK8jFCzTprJFGlpchhelpkOf+uwM2rGp752Smyem5PZKQwndKnIPd2yZ+9+bSWGTlFVrwGI1RzTmKjhzcOw8rQWy34PMydNi4O1Moy4xPxbY24UrYQJDn/jnib+4EN+Lr8EgFoG/ndLLR+CVr7h8LgzlirbpjSWAhVo+/jNfAfe5SMwrG8JkeUdA6ZEhy2gSheXgbycknNkMBsEvJKJ837sLLxVJcZGmZojwHyjQu9Yf+5vdNm5rFETsx9vWYCkLzcORFfI1dOM9HXAhf/umHGBk4R6sTHpZMfXazVjMUqPp1VYv7J4TI0slvncmbHChIGSTqwhUe8QfV20aiM5D4spIy1l699rSZzoF+3XKBeYxTV56zSpdNNgGl160RC+CKMAAOFkm4Ou8HufMGvIIO9a9pR/AArFJ1nN6Hk0PcHN2vRR9cgo2KLV/aulMt24bnF3yLGSmImB5Sl415XHNehAxP1IRGeUXfsqbeLnFuyi1llK8wYDnFvJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y4F4/EsHNYMn3F73FxTzI2BvSGtA+MA7tsfYfYqiryDwtW5g8ANaI2v2hAah?=
 =?us-ascii?Q?Mf5dvxtyWftq5AvtEX4bA2c6JA06W1Gq2u54Qo3JlUIgwPOE8f2YMnQFBPYM?=
 =?us-ascii?Q?36FwhWu6Nk4MgdAPU4vTrsNCezgzlZ6As4vFwuTVXU6uV9fGZDgSfqbykF7w?=
 =?us-ascii?Q?1m147BaikuushhUv+AUaE9hv+BEC74Ck5qH6n+YFvcudwJGihsPDT3xv6/zz?=
 =?us-ascii?Q?pPBfKTwRVWqDU6cJih43GqnPg3+rbtL3T9q5pDkAvqzwJIEjK47Zo4AHuTY9?=
 =?us-ascii?Q?hytV6CwbDUTlzhg+GkC0QZQp8311G0MQIN5h66gs3uSP5KyIfnCBnzBs4e9P?=
 =?us-ascii?Q?UlMqMv8lEzWqd/FLU9Eu4gFM2jFIRp9Aq+M6hkBJoCLydXcjX3JlWyrMZzBL?=
 =?us-ascii?Q?1WB7Mi9sqSnWTTBS4vySWTY4VXHlWth/KcdGyisYzoD3DLExnD6v/7yozCre?=
 =?us-ascii?Q?DBEDhmjvZt49tTF1aEW3C9X+JJoR7V8bJdwGXHfAMAClUBNHpsGVUmMf313h?=
 =?us-ascii?Q?MUJRgBncEhj/yZniIudvIrP6/u1xX3iYh6e97fWCLMAc/eK5atlAB2Y0VzJ3?=
 =?us-ascii?Q?vlzCay4Qe2yyD/fhSNImu8W9NfwW4VORZ0whJ4SeF/ORs9ZU0kkOK6Il1kU1?=
 =?us-ascii?Q?AzlOirSy/JKaf1X50BfHQo+c9YY2yjVkbE0Ub4jXPlEkCGhF2xuDnZdGo5d1?=
 =?us-ascii?Q?5dGR5R8gkHN4yaxSCaTQ42xe2/JbS1kZd/aV59bLYdrso8VkFkp61JBYJf0p?=
 =?us-ascii?Q?4ivUgByxl7eMgRwah89EifBfLnmQGEO2udwm98xqe+OvrqxENaPuGTO0XECb?=
 =?us-ascii?Q?E5s6twKZxSFo1gE5KRNASRrMd7o1h/b7AdC0CscfvxR+cel+RtJPc5iflOYi?=
 =?us-ascii?Q?YlGartvNIqYwPPOSCKc2We9tOBqNuZtnStZ2U6ozNIjcWM0fo6xF3JY4i9KD?=
 =?us-ascii?Q?Jan377QnWOIkz/Hf4pDOijb3nBCYKy+2XKvX2xVcnQz1nU1G+QmDlOyo+HyV?=
 =?us-ascii?Q?dOlVOFKw9PaTFMiJd+Jhjtz1xeuTqzSFN0KH4JLvVkbSDjyaKMtgbZUX1vPZ?=
 =?us-ascii?Q?HfOLhTM5lxHZ+um0QI+JLuqXJeWU9qEgf7rmXiThxMh0Slux2V6tzT/NeNL5?=
 =?us-ascii?Q?Iint+8y6mOYETOdGiFWbB56ZImXfqx9XL7nymoRKnGmRvCVROTOUMxA5aYf6?=
 =?us-ascii?Q?2bHjFLp19ah/XesdsiG7vtx7KW4K4fueuThMwdgpg50Yts/+jlOngKf0hBiG?=
 =?us-ascii?Q?VyTygDyvRe/NaEgoVTgpZSr2x/xV/zZJ43KqCaCOKZCeSmMOaWZ3uYt1FKQc?=
 =?us-ascii?Q?bgfQvlwRbISLXe4vC0GqaUSTi1WDSU8maIhCQMxTYluVhpcyEVlG8WQ1R53h?=
 =?us-ascii?Q?d/riCTnTuB5i1IacqQWZn0m7Fs2E2bCyD0AzbPK2H2CYqCJaDFqlWBj1GHZu?=
 =?us-ascii?Q?PuKcpgI3KD6R4ev6KXHcSL2M+qmDgUZ2Nl2wOQwjJZzdPEkDhagaYyFFcjvb?=
 =?us-ascii?Q?NHY2YEVM2GtNSAZPVbdIWl4pl1pPKVkGc0NT+TSwSSnoJq4VvwpDRoqhxzjd?=
 =?us-ascii?Q?8wB9RMiic+XF8ARrvpEsfZKcdyxoBzca0gePsuEMZ1VJHB1iK1PKJaV+WCAs?=
 =?us-ascii?Q?C8G2EhZBwHL1rtqcoh5Ps6ZCA0DC6FphPbS5YSpqBiDYHwJn0mb7cpI0Qk+f?=
 =?us-ascii?Q?BgqFtBlq2FQ1UZPQY3vk0eXZh0JGGHQ96YBdH/zABrsBJydLPnG9HWhQdcTx?=
 =?us-ascii?Q?lVJ92CWyiObvv+xFHJ/luu7+K/ovXEaIyUK/w7lIO/MZpxLX9cDJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b7daaf-62ea-4c2b-f6f1-08def827d11a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:11:42.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qd23wEnelMOgiQ/RMvG5e5CYYYZSoJUvLVQ2u3W/DlgLejTZOhmW7yDjzt3dnupmNI6yZFyXrVp38AMWkL6XvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2649

On Mon, Aug 10, 2026 at 05:52:36PM -0400, Frank Li wrote:
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
> (d) is close to best solutin.

Hi Frank, thanks for sharing your thoughts.

> 
> There are chan_id in dma_chan, but have not implemented good enough.
> 
>   	/*
>          * When the chan_id is a negative value, we are dynamically adding
>          * the channel. Otherwise we are static enumerating.
>          */
>         chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
>         if (chan->chan_id < 0) {
>                 pr_err("%s: unable to alloc ida for chan: %d\n",
>                        __func__, chan->chan_id);
>                 rc = chan->chan_id;
>                 goto err_free_dev;
>         }
> 
> But there are not check for negative value eventhough there are comments
> for it.

I looked into the history. Isn't this just a stale comment left behind by
0821009445a8 ("dmaengine: fix channel index enumeration")?

> 
> It causes logic channel and hardware channel mismatch if dma-channel mask
> existting. If skip some channel register, it will be mismatched, which will
> cause confuse when debug.
> 
> To keep back compatible, we may use reverse logic for dynamically adding.

Just to confirm, by "reverse logic", do you mean keeping the automatic IDA
allocation from 0821009445a8 as the default, while letting a driver explicitly
set a static channel ID? (pls see my next comment below)

> 
> BIT(30) as static enumerating.
> 
> if (!(chan->chan_id & BIT(30)))
> 	chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
> 
> 
> Or we simple add hw_id in dma_chan. at debug fs can show hw id. but idealy
> chan_id match hardware sequency.

I agree. It would be nice if we could do without adding a new field. How about a
small helper such as:

    static inline void
    dmaengine_set_static_chan_id(struct dma_chan *chan, unsigned int hw_id)
    {
            chan->chan_id = BIT(30) | hw_id;
    }

then in the dmaengine core:

    if (chan->chan_id & BIT(30)) {
            id = chan->chan_id & ~BIT(30);
            chan->chan_id = ida_alloc_range(&device->chan_ida, id, id,
                                            GFP_KERNEL);
    } else {
            chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
    }

and for dw-edma as an example, use it like this:

    diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
    index 1f893dc54c79..d214df55da3c 100644
    --- a/drivers/dma/dw-edma/dw-edma-core.c
    +++ b/drivers/dma/dw-edma/dw-edma-core.c
    @@ -987,6 +987,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
                                            &dw->chip->dt_region_rd[chan->id];
    
                    vchan_init(&chan->vc, dma);
    +               dmaengine_set_static_chan_id(&chan->vc.chan, i);
    
                    dw_edma_core_ch_config(chan);
            }

Here, 'i' is a direction-flattened ID, unlike dw_edma_chan.id, which is
direction-local. It keeps dma_chan.chan_id unique within one dma_device.

> 
> chan_id match hardware instance will beanfit more. There are some code
> assume chan_id is that hardware id, such as
> 
> drivers/dma/dw/idma32.c:        value = readl(misc + DMA_CTL_CH(dwc->chan.chan_id));

Thanks for the pointer. I wasn't aware of it, TBH. The current semantics might
be a bit fragile.

Thanks again for the review, it's super helpful.

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
