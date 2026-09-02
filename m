Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021095.outbound.protection.outlook.com [40.107.74.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1372F6565
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788316810; cv=fail; b=D3D2pE9yWrZTTkT6jp6oqos2XWZ29520fJRQW8jOz3nqXehdIvhbg3w+Z5snR/1EzEh2NuYAOkgxwVgg1YWtYUZw/sN3aknsWgaFfuL5RtdHm/eeZKVHMONFVziL3mlDMNyiXiSR0mnJHhcbc/FuCu76PeK4U5bLpqfB21B4gig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788316810; c=relaxed/simple;
	bh=eka2Mi3qvJNGHmKetbJJ7Pdgs7AzFOfIv6MTirfdy0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X6tBGomPtioRgpU2p1/4DxzPc7bmh+NonE+xXgjGNjhyVsZ7+6YTUhGdVqSpbMuCH5KqzvXfxdy0BViXQQfdREqMPGx0lqm7LCq+e1NZRLFRnetPo/Q8xlGv5zJiPxwRsDFQtSJ2iuiSxqt+yNiifvlI4ZOTQKOi2UZcbRReOxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uc79COum reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uc79COum"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnTJPN6jHsTaH+JapvBZDG9OrjVWkGpqKGbFxj4Do9TH4I1HwnjOXC+S2dGSxZ6G67sfoEctLPfiHNj957WW7Y93XaGLv6EgmVqw2/2NU1MMezEjL4IILdmxCt7j4DHDQ7J6YjRG+bZzcpRffsIgh31/ZKSG7K6p7m/Qef0fNilLSIAK7xTGmd63O1pp+WUvyOHOlyr2jGGVy8ANet5WsQW+T408atRQNyJGULvbw8xHDNUKNUJUqKrNiyDp44/bnwe0czjaV5dcYYgfosH++2ACvAXSaUZlDDe7s9OViMe8zzMV7fJtjBtj7OMNX40oslIKuXEcjV8TbRw/lf4ZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSvaniITY8VlXe2egqeg9fCNofbQnaVnojVhv3u/aOg=;
 b=Nbss7zduG9BoXe84WK0zEdJJQYgnmGtLpWUlIXdpEUsJedRjzzUuEr+e3norpzppxgRNJwut4A8FMl59caDhq4KFg5lVcqezc6h5IMGKuIpUA0fLNc5oPhcQVSGB8P0xflqxbWbrG/x/OnKGSE9wJFaF9gmk0p2YrBH/ZKorx1ti0MKJRmiYBAP/MY3EyjkOED1o3JjD0qpKPdyMKE/sXFT/kqO5cvGtt6CD5IjB6NzA9YM5iMTHQ8xnHTZ9WlKSiYESOMQ8BVxDVLBA0fySt/FjZD6pUSsXG1fbPD+fLamjKYyebA/BlhiINgwQA8/WTU2p1I512cx+lpp7g+Z6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSvaniITY8VlXe2egqeg9fCNofbQnaVnojVhv3u/aOg=;
 b=uc79COumgLqzZsorL3eRxNW0TSLzvk0zSx1DC0e7rlzKKdgglrNzVSmQmbjMVilowLjOISV09mvF9M/sqGyzzCMbTyJifYeOkc1R+Kxw6vXqMsSR5RQ4JAelL4RZ+wtU/oTtgY2Eb17eASjc0daxAmSoJuXk3gzzRyzJuqRmMWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6927.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:40:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:40:03 +0000
Date: Wed, 2 Sep 2026 11:40:02 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 5/7] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to
 share a BAR
Message-ID: <5zkxmgcxmzubimiftjdwpjuggphwn3ygc5dv45llnn2w6g57cj@7a6vzluyjws3>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <20260831182657.329614-6-den@valinux.co.jp>
 <20260831210549.30AC31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831210549.30AC31F000E9@smtp.kernel.org>
X-ClientProxiedBy: TYCP286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 08866936-4d0f-44de-9b18-08df089b7dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10070799003|3023799007|6133799003|4143699003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	mD/NEY4OnIRxFE2+YhhGD1Ypd1SXTz6v+uSNJDxIb8kr7+RXBqlnzgYx13ota8zWWAt9rEl8ysQ4j3NwJ3AviAUa6fgp1UmAuMbnixdUf2nBXnp7Mhg9c+MrJd1FDe9rRoq/c8yhwhBhY3lqiVqAZNOiEFgO5VznNYzoexeBQS6muKeVwhMWYMXG5VA+7lTb6d5YHjdeWvPhpb2YoQeDRcsJFNgAtz/LtnO0FIVJPMT8dKJ2UMucbXFthAm8EktDSbWMTTkA5U1kD3g/BoC+xglbFOrPAu9+JYVzNiFrcniwDLcAX3KCsl8z7Jw54n2N6Hwmb/cK3VujYKzcxNeKDMkjZ0cqI//lw7Q4ioaU2tzKqQ0MbNDStoShelopvtyAV0/PTk8SYETnyVsj9Ma5tyAX2X+byXhd3xs4PGh+I1fkZIMRET+GkStF58jlFsv54pOGPnJ7jZk+7ZcvF7cpom1cZOHxm+AvC31O5PhENEKEEX9ItdFwI0e8zYGiCyDmhh1M+JOp/udWGNIb/5zj98+MQzoGJemU8RDyxxpq+2a7vSVnJM87IglkPZCti0vc748osDp2EjnJhmmLERwhJRMGwSutWlbsEYxMJwq5PHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10070799003)(3023799007)(6133799003)(4143699003)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?TvJQ2ZaRR0aS9Dt56+kX983vC0yBfqRtWD37CLNELa+fIH/RYxfmroNWXT?=
 =?iso-8859-1?Q?nUP/Ns5LaltalUAo1inD7GYhfT+InKS8PvPl8kOyz5JREGLYWoZLKYoUQ7?=
 =?iso-8859-1?Q?RijvGAwvcmE8gsk6VsEr7uGgLagxK4K2yn06B4u0r459ezTolTXSKlyaAY?=
 =?iso-8859-1?Q?oMZ3DiGIJ4OVDFvPtrSOyLQyY9zhzbKwGRbqO3wQz6Nhkok4elC+xIlbHZ?=
 =?iso-8859-1?Q?Mq+B5MM5PT8Fm8YMSCkN5BKqjIe4jBt15gWxRPlmPY6gIcxrHfnqtXCYGO?=
 =?iso-8859-1?Q?W12BSuOwyuX4H5voB3NGtr7VHbZ3I7YrcYSYFarl3l+N2dWqpcbD4Y2kNS?=
 =?iso-8859-1?Q?JY60K11eN+5ciZK8pVoujlCsv9kI5UWXmM6sdBCav+QwN3dOjcGpPWU3Ck?=
 =?iso-8859-1?Q?o999gEWZeAn0Y6r9noDUvxV22obybvjVdqQXnwRJJlLPVbbI92DcuLS3jN?=
 =?iso-8859-1?Q?GX7vlQndC4X1cG+/Y5YkV/jV2fRcxSkPRICodeYX3U791q9NKpt73Nt/XR?=
 =?iso-8859-1?Q?ZSUEXsacU+A1sf3BDuUYHzWuyd00B9cXpI944u51W+fA0y9lE9a58LTzJ1?=
 =?iso-8859-1?Q?jsfqEvSvdINua7sc7ZVLmP78+7bljko++aFOwBvx4un9c3Jpfx+diigP7U?=
 =?iso-8859-1?Q?r56eOJJi/7G8vnDqyxV2A7v25KUL9ODlr1Ux0E/X7eeICKmtYTe3BrcF3P?=
 =?iso-8859-1?Q?XLKX/NFgdVwCEyYsnUXjFzyMy7SBshAeTN9/jq53pzH2EoRG1cbosDFEc9?=
 =?iso-8859-1?Q?VkxfNs9JTSEx6Mt2stnokwGdaSVVBkKLgVPHm1/mPlcaLSp7tT1oW81sb4?=
 =?iso-8859-1?Q?Zd+SwcYUrG24a9HbCQmLMNzfpU3S7AD6VGhNHbRJhjg10DRvghFABX8SE4?=
 =?iso-8859-1?Q?2N0mB9jeKz6vDPqSMiXXOmYSk0GqEIgxdhU1EB7GB7hAqVBe+XmxDLVRAw?=
 =?iso-8859-1?Q?nDISfKQ3FaW8MUHFaZepwN/cDEvTFPYEArEo3Swkz2BpZsaENgUelBRyLW?=
 =?iso-8859-1?Q?9iLMTI9AP55eiSdJGLEvHatJK1sQQOCnYO5xctgK1vGQYoOlhQ1AH4nWf2?=
 =?iso-8859-1?Q?+xHSwqPx28ZWsUX8UqLwo2fEigGwevXgWJySgh1YaMVOHGs59qffrf9AFX?=
 =?iso-8859-1?Q?fmdMRhaLHKXvvKQrSIEH2nOImdoqCPBt+86br+Bcimf4/uycrEkGOWamaM?=
 =?iso-8859-1?Q?cHxBH6sKlxHrfhKfMAgi0fhl2U3V1d5d3704JHo5hccDYsVs5QYDKzf+fB?=
 =?iso-8859-1?Q?uaxbAhIagzy2hSV1xysECZbGdS8XfRwhJZ3l9G+hPAPhLvKdU3jXZUcHox?=
 =?iso-8859-1?Q?hC1Je0f8VVr5E8Z6we/dahIDxNw8MxHYyMtjilkWdwOtJ7YEYOJdnbSjSC?=
 =?iso-8859-1?Q?1kvKFybJ3ZcXOMWhdX6hTySqKEIAcY1a8xzHP9s8g4TLd2AjLYbRpWwfJN?=
 =?iso-8859-1?Q?u9JXv5wi6Bmk80df5gLabCzZkkF356hyOTjxs/j2V7lsrbYgMphXLB0P2w?=
 =?iso-8859-1?Q?OLYwEGsCMxstAauIYPP/JiyW3rdZ9jAKtVpt/CamqylVpUdBamHbJfakvu?=
 =?iso-8859-1?Q?LvkBQOcIHDXCzB3KACwkJqosbbzrdgzinyBMtNk7LyBG8nBAqeVHeAur7F?=
 =?iso-8859-1?Q?oLKefZ9YaYzwExz26T9/wQV3N27lRck1aCunle2yjnCwww3HZv8g3K4f6N?=
 =?iso-8859-1?Q?mNgulKdTPTpFTLdwlfc3vC+sov7/5GYVNXI3pgtPISEM/KklHzezcCp0Aq?=
 =?iso-8859-1?Q?leh7tCSl4e8SnVhkI6iaE1/CCWYQJujVOss76OXROucHeCsf3+ZsI+fw4y?=
 =?iso-8859-1?Q?x1HhupbvxbV7V5r+JIJnmS5glq1G0/Jbjpx/l7Pv/GTCDNtky77g?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 08866936-4d0f-44de-9b18-08df089b7dea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:40:03.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbPqFHX9m4m1dc7Zpz64ECPqGDj6G80ZiJYjLDw/zHZm9C1qWecV41y1IMoZ1hESbQenJjjHfxCZGSLxV+X0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6927

On Mon, Aug 31, 2026 at 09:05:48PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Deactivating a shared DMA BAR unconditionally clears all submaps, breaking the active Memory Window (MW) mapping and causing severe memory corruption.
> - [High] The `ntb->dma` structure is freed in `epf_ntb_unbind()` before the driver is unregistered, allowing concurrent NTB subsystem operations to use a freed pointer and its lock.

Both are valid, thanks for the catch.

The second issue comes directly from the pre-existing vNTB lifetime handling. I
posted the prerequisite fix series here:

  https://lore.kernel.org/r/20260901063238.631166-1-den@valinux.co.jp/

That fix also gives the DMA BAR mapping a clear lifetime. The EP owns the DMA
resources and their BAR submaps for the whole EPF bind lifetime, so a
host-driven TEARDOWN_DMA is unnecessary and, for a shared BAR, unsafe. I will
drop it and rename CONFIGURE_DMA to SETUP_DMA_BAR in the next revision.
(The CONFIGURE_DMA naming was misleading even in this v3. Unlike CONFIGURE_MW
and TEARDOWN_MW, it installs an EP-side inbound mapping rather than managing an
outbound mapping.)

Best regards,
Koichiro

> 
> Pre-existing issues:
> - [High] The virtual PCI driver `vntb_pci_driver` lacks a `.remove` callback, causing the NTB device and virtual PCI bus devices to leak and potentially use freed memory.
> --
> 
> commit 4680cfd6b651b64bf9225e9233e1d66310c8b0da
> Author: Koichiro Den <den@valinux.co.jp>
> 
> PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
> 
> This patch modifies the PCI endpoint vNTB function to allow a DMA BAR to
> select an MW BAR and place DMA ranges after it. This enables configurations
> that have no spare BAR for DMA resources to share one.
> 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 1842493c33b02..aa659ec62d931 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> [ ... ]
> > @@ -621,17 +648,25 @@ static void epf_ntb_dma_release(struct epf_ntb *ntb, bool quiesce)
> >  	ntb->dma = NULL;
> >  }
> >  
> > -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb, bool active)
> > +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, bool active,
> > +				      const dma_addr_t *mw_addr)
> >  {
> >  	struct pci_epf_bar_submap *old_submap;
> >  	struct epf_ntb_dma *dma = ntb->dma;
> >  	struct pci_epf_bar *bar;
> >  	unsigned int old_num_submap;
> > +	dma_addr_t old_mw_addr;
> >  	int restore, ret;
> >  
> > +	lockdep_assert_held(&dma->lock);
> > +
> >  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> >  	old_submap = bar->submap;
> >  	old_num_submap = bar->num_submap;
> > +	if (mw_addr) {
> > +		old_mw_addr = dma->submap[0].phys_addr;
> > +		dma->submap[0].phys_addr = *mw_addr;
> > +	}
> > -	bar->submap = active ? dma->submap : NULL;
> > -	bar->num_submap = active ? dma->num_submap : 0;
> > +	bar->submap = active ? dma->submap : NULL;
> > +	bar->num_submap = active ? dma->num_submap : 0;
> 
> [Severity: Critical]
> If the host sends a COMMAND_TEARDOWN_DMA while a Memory Window is still
> active, epf_ntb_dma_set_active() will call this function with active set to
> false.
> 
> Does this unconditionally clear all submaps on the BAR, including submap[0]
> which covers the MW prefix? 
> 
> Since pci_epf_assign_bar_space() used address 0 as the fallback base physical
> address, clearing the submap would cause pci_epc_set_bar() to map the entire
> BAR to CPU physical address 0 on the endpoint. Could this corrupt memory when
> the host subsequently accesses the MW?
> 
> >  
> >  	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> >  			      ntb->epf->vfunc_no, bar);
> [ ... ]
> > @@ -1974,6 +2019,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >  	dev = &ntb->ntb.dev;
> >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> >  	epf_bar = &ntb->epf->bar[barno];
> > +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> > +		/* DMA submaps follow this MW, so its extent cannot be changed. */
> > +		if (size != ntb->mws_size[idx])
> > +			return -EINVAL;
> > +
> > +		guard(mutex)(&ntb->dma->lock);
> 
> [Severity: High]
> Can this lock be accessed after ntb->dma has been freed?
> 
> In epf_ntb_unbind(), epf_ntb_dma_release() is called, which frees ntb->dma
> via kfree(). However, pci_unregister_driver(&vntb_pci_driver) is called
> after this.
> 
> If a host MW configuration command runs concurrently with unbind, could
> vntb_epf_mw_set_trans() check epf_ntb_dma_shares_bar() and then attempt to
> acquire this mutex on the freed ntb->dma pointer?
> 
> > +
> > +		return epf_ntb_dma_set_bar_locked(ntb, true, &addr);
> > +	}
> > +
> >  	epf_bar->phys_addr = addr;
> >  	epf_bar->barno = barno;
> >  	epf_bar->size = size;
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed that vntb_pci_driver lacks a
> remove callback:
> 
> static struct pci_driver vntb_pci_driver = {
> 	.name           = "pci-vntb",
> 	.id_table       = pci_vntb_table,
> 	.probe          = pci_vntb_probe,
> };
> 
> When epf_ntb_unbind() calls pci_unregister_driver(), it unbinds the driver
> but ntb_unregister_device() is never called because there is no cleanup
> function. 
> 
> Since the struct epf_ntb instance is allocated via devm_kzalloc() tied to
> the EPF device, it gets freed when the EPF device is removed. Does this
> cause the NTB device and virtual PCI bus devices to leak, leading to a
> use-after-free if the NTB subsystem makes subsequent calls?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260831182657.329614-1-den@valinux.co.jp?part=5
