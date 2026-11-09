Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.228.99
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794190948;
	b=qafl37rOHJLfhRs0IWIlobjQsqGe7DASUN00vfJMplImShAyLspblQBwXBmqJIjkAgt4
	 BbiwUy2duTowJf7f+7dIpAvi4xZjXgX3xwWh8LaabW0Ce3s4ZgKpzTy8fo/o36G3G2c/k
	 BuJppYxBoWsuOX7k/ZWBoG+y/Lb2Rk/A/KFk09uw0AFcdh59D9cChaC3+YEe2Pa+vFHjB
	 cV0MiJwxYu+kir3OWS5GSz+bTnnh8sOUQW8j0/DTEOdfSy+gHB0H3zdzLPxc+s+cI3qLh
	 kqgoeZxwzwV5wtAI/XWzQJXaemBbODFK09qDAbJMVBjiU2Kk3D8U0GuPIGdICPS95SA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190948;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=85IkSqN7JkVYTx4blSrTX9ObNi1697lJ9OKA4wJJ8vs=;
	b=YdjlYR5rihxIOTEJyTlLKrZ7nYzX7nqq/bG0bgbFOd3wNuqQqQ0D97CpofWAJRaLgv5P
	 fPjfd85NY4OqpWV6eZXnehnAiQnEli2ThVtdDJ41XO7TZRzFpEssNZW5h5Q6i3T5AAF/k
	 c/NYpP10Az1+PLI8+7X9RGHYyYWctykIK4gxsuXLzkflJKJDqHabCCk/skniyzFbjBbf3
	 yW63XAWDRLDjYV1QvQVjq0L+iVHeScJbZ8rdKhcdRYBJXiRXy7WPhVQlCtm71PtmTzAhi
	 ZUD5m8OJt6rPVMzuh/kMRRnbSxRORBSDBFwVOereuO1I9fAu/9YD5797WxrX1YQ/uMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=fail reason="signature verification failed" header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=dCSNpDlr;
	arc=fail smtp.remote-ip=52.101.228.99
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020099.outbound.protection.outlook.com [52.101.228.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD7606A31C;
	Mon,  9 Nov 2026 02:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60FD7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=dCSNpDlr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGwvzzU8kS9vLUwMVCcmSqIOtzj8u7ZN8UThUuh/UmlafcMfyGwjf3sX+yGJjthTPQbETMn0dHqHXjOq+A77U6JaA/ftQ/kYg4UlSFIpUSzyzejUhRTCFTuTryMMQ26F4KsKkkkRSD1UKDMoaJ3Za4gvNcBBpSG2pGJXva9tCtKNUAMklH5tWF53X490oRvzd0HXDJigFbVhzrzOI9eN6+8cpTosTr7x0Rm9Jfl4MU/v/dHOP/TriRR71vPgwD0A6CVZL7qANtr79lp24oX1ifaWiyLEksil8n15ia0SpmoLr0QZSp9qn9JReELucenMGEVzspdJeHfr4gCJ/5dlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D+wdGlJbT/LP6rpoj8z9g7I/5H6rsnor9k+JV0AA3U=;
 b=iYX1Xzmlfxv2AP0wiV8z7mdr41mdy844kVxvg+YBbrKtaSueE1awpGfiVmFzSP+AfS+kkcchdbOJImMZSwnygshfKxAr01kd3V0C2o47rNsX91bI97i2KCjYZP/HP/qZqIThUiTyFsUnF6idiZC/dK7HxqHJDiPJf3CDgUlM0fv2MPPsfop+KiN79jSpcMD9zvYCK73JnsFJXw2tuaQNuFuYR47giHYqNhebqe7FSHqzsEwAv9ykmY8wC2Y+KFTxmsIDVWk5c2xizKk2v5c7cm6WH2v23gCG3+khh+VKnCbPfoCb6BTaLkV28tWZJWE3JhXak1/izSKnXp83stOWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D+wdGlJbT/LP6rpoj8z9g7I/5H6rsnor9k+JV0AA3U=;
 b=dCSNpDlramIaDK9Totdi4//Gslw4o4+vfPYH+EUB9N6n87mVkg1rUEPiUyoZWAL+OG5RQ5y2IHMiCyTk10fbCp2jJVJbqp0lsGWCgNl21bGm4nTipbvHYeaIN3EB6doUH0u7nNlKwn/6qbs90TyQ8mYBu8BYJIk2MvS5VQLvBbs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6999.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:413::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 02:22:22 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 02:22:22 +0000
Date: Mon, 9 Nov 2026 11:22:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, 
	Frank.Li@kernel.org
Subject: Re: [PATCH v8 6/7] dmaengine: dw-edma: Dynamically append requests
 while running
Message-ID: <v6oar76kmbnuqtascq6eunjy4uszbuzogxp5etoxsl7v2nmbfu@vv322u7ohp2t>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-7-den@valinux.co.jp>
 <sashiko-outbox-202935@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-202935@kernel.org>
X-ClientProxiedBy: TYCP286CA0214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dc3ccc-1155-49e5-e56c-08df3e084984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|366016|1800799024|4143699003|56012099006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GkAK5Ccoz+cjICcU8eLDvdrt8Ivr3PqXSXZE+DsTe+eaJaSRBFqx6Zt/qWheZvyM+rmKgSeB9W93gXAWlY9CTy9rn2zJTCc3VX4OIXWVmEqG7MpaBBpXZSq/thw/mBlheU7RokAhHxxdlYtPKiau9c8E+eU5aDUWQE/4Z78Hgzeqx8T0d8JmCP5TIlgQz4F1gJ3rdTNhN4WLhNGgfkIPPZKPysA2o9trlXtZswgY75cpCOdISJqi/DNW3UFw1y9Og2Cuq4XK9z+HWtVqxweQVmallZeCvKJUUi8jbbz6NwvATqzpQxDzk5kuqqPAq1oRN6pxjlt4e2P4/ihq557XZ0S/USr1cz7SxlkJdSaT2a0LSG5PJPq0rkECwhm2YVSYk/qB9SzU3qI1G9RroRrRSnTY/Q3S+KYovSQAJYFreaGJWC/AajrUlaxeryvQUJIX658PhSNERzBWDqoTJkAdtjfJwbVWmtkDERaW3Qa1CMg59Do9l91cy3SX6kTSP9Cknx/znmTgs3MOYmesI0tf45mXDiBb5uqCUGaEStZfMZkJ/Atdjtt006TQtlm1CuHoiS/pY95kmc870m6rLMAimZjuhxnjo4B5Kk9i5HweLTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(366016)(1800799024)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?t2FFzfRmJkavXvkpl8sk1/0KlizBmSie568CwFmqY5h3JmmWI6ilbKYqgD?=
 =?iso-8859-1?Q?ASSTGotqspZQq4ObTg+XO3LzRMIeOFVktjx12H6G8DUqh/YNBXH3KrQgA9?=
 =?iso-8859-1?Q?e8dOmYXZUrdw+bgvhct2AZQLNopbAn4qDjfOnK3yRxlPQQqRPIhq0njsiM?=
 =?iso-8859-1?Q?2EmcXJToxMmeneHdITQbRzmSVUqM+xE1tYSfmkbGRq0ZuwBCRXm9ZBMTch?=
 =?iso-8859-1?Q?WoGqfnFxr2rwv82irRSUVuibRuZfXHX/4WuJbrkDj5odKKjiZx0ZU3Zf5V?=
 =?iso-8859-1?Q?lBeoSyyzKN/dzlYs1iSiVTyAt9H5a+fQpU8ipSuqieQgeCFg8gc/maKY+Y?=
 =?iso-8859-1?Q?+a+R27M8PZCmmcNO5Qj+4X3n9ClQu4LTZF8tewTnOAIT6xY7x65Z1Mgn4f?=
 =?iso-8859-1?Q?EdSJB1qws3MBKtT61TqdwHLkwm9zClmPvR7Yns0+EnWMIviyXFs9mLQCBM?=
 =?iso-8859-1?Q?AbbgZDcytxMvDc0Cv+AeN/86vMEraNiNfcqcsTQMTUm2R5DIKDmjm2EYMH?=
 =?iso-8859-1?Q?AZx9SFhSA/JzkocXslF7lFtgomzyLzxoIMR+osS7BFbw3ppb58tCPWaviQ?=
 =?iso-8859-1?Q?DE7Bu4xUx174ch04Wm6cFG2hTmy2y8im8xVbqTxswhSMeHlJEz5ppF1snH?=
 =?iso-8859-1?Q?qgIfcj4hE4NHI5Rr8ZBOsGDn6QJDdRRgvKkm+yIgNakj2ht+U7WBF2A9J6?=
 =?iso-8859-1?Q?vq0XmrQYbt8cwYsia+RE5w4EcVZu9EE74TDhHqY8hBh1t9xzgLCsggujg0?=
 =?iso-8859-1?Q?y64dmMystBSOqY9wE3yl4o3poubBpFdWIrtRLhtr7IS1j4D6GJSplD8DRn?=
 =?iso-8859-1?Q?BRxQXx7Q51RFG58NH5mLifO5TB8OmgkLvZm2ZIPrSw+1WIHaW7l6udiDyj?=
 =?iso-8859-1?Q?NpGb3IatO6x2m28kwjIT5tu2H+KvoygUWbAg3xuLMg/W1dgndq2LQe2sfQ?=
 =?iso-8859-1?Q?9QZAY4PAT/2qY0hJiATRle4L+YcMdVPvEv2qr3qQkUf4vCMKUS4kEFCugN?=
 =?iso-8859-1?Q?rnH/9/Jkb4d142jP+ujaB7FFjGG1N+ycJOL/zJHXPVk4U8G51jEKNtg+Dl?=
 =?iso-8859-1?Q?A7u8XvbIebIpGH3DAHKyez544qrlEgFcHU9X+unDrleKsPLJe3l5q/cUGr?=
 =?iso-8859-1?Q?dG74Vfzp0oH7FimznOMklIl6KxKlrSIuRR1IvShWo49wCteiA9VA/Igtyn?=
 =?iso-8859-1?Q?fVWPobqgKFV4JfhUDmAFM52W6oeMunlFRZENDa1eNUJ8BTyhMhYWWNdGqK?=
 =?iso-8859-1?Q?t1OmrJbjtOLfLNL/j61+ukpC6aMHRIhhuPCq0OfdIoNovX5C11F396DjNV?=
 =?iso-8859-1?Q?/XgbIAw3i0icE+EmIOqwdJMu0P0dB3hYaxMkTjhhl0kgCIw/PcTjn+fuXJ?=
 =?iso-8859-1?Q?koqECqDCWrhI6xO2uCbpVR7N9OzIwE9jLwPCYal6OOh2HNz9iBN/SVnHYC?=
 =?iso-8859-1?Q?LqEhoIb4nz5wW1Eg3Qw4BpIJAjwC+wOqCTObMJODKIM2OymMiZnXTudSpG?=
 =?iso-8859-1?Q?sdaLKlLksWS/LJVXOB2lyQ5kDRQIhCUoL0s++48QpCpnT5a8PbQSi9xupQ?=
 =?iso-8859-1?Q?0znOl3NjweHj5ETZKDTJHUnWiLjTrjnKt5DaTLmcadCU9G92DEl8wLrm5L?=
 =?iso-8859-1?Q?tQyJDI1z07YEpITcfMbCFyp0jR5rLstlVByX1SDjZ2BKSqYPepi5KJcwUS?=
 =?iso-8859-1?Q?fQJpw0tnVrZQzfa52BzWwfGGqSdte0GqXSwb6P5kpVkc6X73OaDJibS6cT?=
 =?iso-8859-1?Q?UIaCGvsCGHVoi3vmBDNgllYwcvd0M25FyrZrAfq0t6I3n2BsM7UBg7zzA5?=
 =?iso-8859-1?Q?EgcnNh2JMNy93qaCC8GHjIC8s/W6LieDoBcw/zBsCaTBeCdsVFYk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dc3ccc-1155-49e5-e56c-08df3e084984
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 02:22:22.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDfx87qI46Ey/odlXU7+Eirx3ZEyNH9XUxnVgFwWmoagNawI6YqO4hr4qpl7/6v86fx0O9m6V9dBJ4hG1nnBGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6999

On Sat, Nov 07, 2026 at 01:59:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] dmaengine: dw-edma: stranded or aborted queued descriptors on
>   LL reset
> --
> 
> commit a60bb88e6010e30a59b85799859be8d9e37e8b49
> Author: Frank Li <Frank.Li@nxp.com>
> 
> dmaengine: dw-edma: Dynamically append requests while running
> 
> This commit allows dw_edma_device_issue_pending() to append new linked-list
> entries while a channel is running and aborts in-flight descriptors when
> resetting the ring.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 1d13a25663eff..bcf4fca345914 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -111,8 +111,22 @@ static void dw_edma_complete_vdesc(struct virt_dma_desc *vd,
> >  
> >  static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
> >  {
> > +	struct virt_dma_desc *vd, *tmp;
> >  	u32 i;
> >  
> > +	/*
> > +	 * We cannot tell which pending entries completed before the reset.
> > +	 * Abort their descriptors to avoid repeating a transfer.
> > +	 */
> > +	list_for_each_entry_safe(vd, tmp, &chan->vc.desc_issued, node) {
> > +		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
> > +
> > +		if (desc->start_burst == desc->done_burst)
> > +			continue;
> > +
> > +		dw_edma_complete_vdesc(vd, DMA_TRANS_ABORTED);
> > +	}
> 
> [Severity: Medium]
> Does this leave unstarted descriptors in chan->vc.desc_issued stranded on an
> idle channel after a hardware abort?

Thanks, Sashiko.

I replied to this point in the v7 thread:
https://lore.kernel.org/r/rtfjvblptmdez2znjgx7t4v5fumj6wabp2ft6zmnsm353nsves@vow63wcrnpol/

 "Yes, and this has been long-standing behavior since commit e63d79d1ffcd
  ("dmaengine: Add Synopsys eDMA IP core driver"). It's orthogonal to this series.
  I think this should be handled in a separate fix."

> 
> When issued descriptors exceed the free LL ring capacity, dw_edma_start_transfer()
> stops once dw_edma_core_get_free_num(chan) reaches zero, leaving trailing
> descriptors in chan->vc.desc_issued with start_burst == 0 and done_burst == 0.
> When dw_edma_abort_interrupt() runs, dw_edma_core_reset_ll() skips those
> unstarted descriptors, and dw_edma_abort_interrupt() then sets chan->status to
> EDMA_ST_IDLE without starting them:
> 
> drivers/dma/dw-edma/dw-edma-core.c:dw_edma_abort_interrupt() {
>     ...
> 	if (!chan->non_ll)
> 		dw_edma_core_reset_ll(chan);
> 	dw_edma_set_request(chan, EDMA_REQ_NONE);
> 	chan->status = EDMA_ST_IDLE;
> 	spin_unlock_irqrestore(&chan->vc.lock, flags);
> }
> 
> Because the client already called dma_async_issue_pending() for those
> descriptors, they never execute or complete unless another transfer is issued
> later.
> 
> Conversely, if both DW_EDMA_DEFERRED_DONE and DW_EDMA_DEFERRED_ABORT are
> pending in dw_edma_irq_work(), dw_edma_ll_interrupt() runs first and calls
> dw_edma_ll_advance() -> dw_edma_start_transfer(), which publishes those
> waiting descriptors into the freed LL slots (setting start_burst > 0) right
> before dw_edma_abort_interrupt() -> dw_edma_core_reset_ll() aborts them with
> DMA_TRANS_ABORTED.

Same here too (from the same reply):

 "Yes, but I consider this an acceptable trade-off for keeping the error path
  simple."

Best regards,
Koichiro Den

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261107133027.364237-1-den@valinux.co.jp?part=6
