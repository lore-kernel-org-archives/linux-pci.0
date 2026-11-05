Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.125.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793855553;
	b=g25OxfUIMwMiuzDMuKkaxjayu/P75bD+LbKME78XUwZTO2Q2pImGwExXrIMWEw/FnwuF
	 jS/NSZNBfk65LXM+TQkB6tTcuqvfChBOprVbvP3bbAXxYD6QFwbCzhQ6cLvmahQDCwcC2
	 rlihk7zmZifLG8z/CA/XEsCQ/RI5GGH7Cz5W/QpuqjafpMBBM5HFmeO7k5+B3sFypUpCL
	 ZofpPe7Rtos+SZsLRAG5eNzgyJhYYsn+0U3tIkeloQL3hR4YbUKzfxo32S18f78nWbmrm
	 kK6W1LQviJGi30vzGPMZwY/vBovESxWXATX9LG1/yX6ht2lrwVLNciBMCkcZuuNJtBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855553;
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
	bh=aUaH/PLtODf9O6D+XO84kVc+XBZWfCLruSrpc3a5e3Q=;
	b=pNOBkntNF+SWUbvXWsWyllFGQ+Scbh9tPuxa9hi0p/pXgRXnkxrgtRhDqRghTbFgxUmz
	 NrA7hHHwSCbNHbG6qeK2jXoLhMtKretGx7yTqwWBBow9/8h99QeA6X3413bHL3AqmD1sI
	 +lz6n0q1mtWe1zHDidEowbpTtQ6bS5B+1Elk6ZbM7mF77PWFL37SBQh156scMtT7GhrI9
	 DVKvM3zXVORhifGMnI9KydSLbURfFM5Hmh1+eZItqXe6pKDZ5/CKQj3YewCAE/TGXvSE+
	 zs04IK0Zcev/57yQBv/bhVvNGnpoKgLqUXC+Uo98yWk64WMyz5OPKVOGD6Luo6lnPvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=fail reason="signature verification failed" header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=V5XQKJ2H;
	arc=fail smtp.remote-ip=52.101.125.134
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021134.outbound.protection.outlook.com [52.101.125.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BC606A326;
	Thu,  5 Nov 2026 05:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 677BC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=V5XQKJ2H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXl2Tq62Yw7Yrvgft7Td8OKSbQHXn3l4YkpAy9UiMdBc69KriJ7YMoFOPh4xQnUhQ1W2SoB3kDMzqx5wSf6pRChGUfaHbmjadw4m2PKw+ErZuXaevKKjyROiY4YzbAKWUTjHrMBn7GeX4/FKz33pN4qAuBZrQmc0/Ewkkv0ZzLd2Ihaxha6psId2oPAZov0nk76t1GPbbDo68Iei/8/xzAFRux/ymJdr/D3Cg9ZFuJm8FL7KzG9+wgsDWjJDD6BGHs8QP6cbqOpvi2yINZS+Pg4S9W5wd5WTYHoQ2Cb1mtcBUmw/6gxhNOvkiKOgmGCmACnKmye2HBrR9GYTdVZFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6RCvVAF7Ko01mgoi379g+ki1PHAdncyavlMG5wX+Is=;
 b=iMkG3O2Oz0vx5LreS/grB19KaWd0KNlVjaLOtzJWCdGB08BvkkpjydpWNUp0a2UJaSa/4AR+ZiUyyqVGV+neFLfmavozmZwwiQiodNsaxkaAGT/rj401egAm5IJtLGKfg7BAcsl4/gMXvBI1uYh3qmxCay2ivQa5C5zb+GIxfGXdrPawbM1YRVYcp/0xzByLjZr93Gqx12VSvs53KwxLnUG5fbdMYN7SnIGd8qrhfyxObGD1LThma+A215sdbFgtSE99462yeMTXnaLL/O9i15S8GAJyqUtCBR02eFl+MJ0YPyIFEyhhVCGpPEYEf6Em4WfQY9OWBn/kV83Zv2aTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6RCvVAF7Ko01mgoi379g+ki1PHAdncyavlMG5wX+Is=;
 b=V5XQKJ2HkMHv6GbmrP7ElIzZjwywlQmX7hLOXnAX/izr/x/CrrtZoEO7UuYJAnyT+fcBzebd5tgqc/GYNcZ2k/atAe3EA8QjYCVdcjcNHZSQhyAGkjosAloEbPUjdTUXdy9/iQmrijVjLOc1A0GhAjH8s3S47N1blIWxRyuULp4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB2500.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 05:12:27 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 05:12:26 +0000
Date: Thu, 5 Nov 2026 14:12:24 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, 
	Frank.Li@kernel.org
Subject: Re: [PATCH v7 6/7] dmaengine: dw-edma: Dynamically append requests
 while running
Message-ID: <rtfjvblptmdez2znjgx7t4v5fumj6wabp2ft6zmnsm353nsves@vow63wcrnpol>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-7-den@valinux.co.jp>
 <sashiko-outbox-197681@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-197681@kernel.org>
X-ClientProxiedBy: TY4P286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB2500:EE_
X-MS-Office365-Filtering-Correlation-Id: b6220430-95be-4016-5c34-08df3afb61b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|366016|1800799024|10067099003|6133799003|18002099003|22082099003|5023799004|4143699003|261022105027099003|261022075727099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261026135527099003|261009223027099003|56012099006|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	V3mEbI8BvCgEB8c/c4TynSvX9BdudglxxQTrf7vC+h++ZOiVyhz8sUaBJwFSFCeMMCqFWAkXr9T+sgd7GB9rImJxFifQMnxmeYqr2Dr2odUDXTnCHKDjlxLIzUsLNV8f1n6LEMFb3nV2c+f5Bws71TnZ35XPfnHQj4seNBfa6Amh7NqoOyDvKCu1N2oMw8l28gj5ot6xh4BJuFvKaNbxqcesLjs6wyVG/LPDdA7ePI/ASYjDkXHuWAmgespTxI5GYIddRJg4t45EaUFt1Q2DMpjwcuxfZr1kjtJCxK6bSKSx+AcrH00rIzMtlvonvBFm9TCydnbE+/HjCtP3ueGkclTaIzHvujcmM78CBx1kWqwxLzCysyAGCeMkhkM7LhqqoT9cJO1GVTHstZdx4NA+oI8qa8kLbdMXDcVzvRu2JUKOYqJjgACDHpoHkT/FMvp4FcGOGC91moPYgNceCSXlXxl2Gf9rlHU1ECv5t7xW8zcJL6HIq7f640V69DyKda/3otW46o8eFin7H44hozUVTu+h4CmU+Ms0J62KpE9E1PeBPHOFpDo7a1YOrGg18e5U7uP8v9RfGa2ActB0z7ZRiEt0wgjQ6EvRXxHe8jv5XyE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(366016)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(5023799004)(4143699003)(261022105027099003)(261022075727099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261026135527099003)(261009223027099003)(56012099006)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?mbhubgF918Y41hZea3SjzYOe5uwofWxxGNELvwEx3BoE0agZRFBWruHl6L?=
 =?iso-8859-1?Q?DX82h2mnSMQrkxOHEcHFeqok2w7KZW5R2K1WKRAzHQrwF/Rue8kUi0Jtky?=
 =?iso-8859-1?Q?EWLF91vqQ0ulw2S/eBWgA483ib9nct+hViZ8mB+XLqMl+94wc0xXqCy2PQ?=
 =?iso-8859-1?Q?bIersavlaHDD6g8Ls42osqyWUWKnwvi00+obhzitMRdInTuFcdJnrg0y+g?=
 =?iso-8859-1?Q?Rsps0etbfkLUqgS78c7Jrwj/NExt0iVJi2yPgJPGsril1g12uAtJZBUID2?=
 =?iso-8859-1?Q?UJtepG6uqH/ujU4X6M52cChEPU9NdMSN6+l+ZM9TFHsrhnHIxkjzXseYPe?=
 =?iso-8859-1?Q?CUc8gDT23YDjJ+ZB4fX7qE86sy5cTDwVW8qX3AuUQ0NrOD/lNYfZ0eoxvv?=
 =?iso-8859-1?Q?2c3DAvVt0l15zMY5DD3aDmLOztFDWkMihPpxihmSM/AIWxC7PDP4Di0F0v?=
 =?iso-8859-1?Q?KFqXSVeZe6Ehog/3JgHPgciY6iOp1CzcrVQCs8dxhT/yWfpaePMlgrTyt7?=
 =?iso-8859-1?Q?voTDw82zx2S37KfrsyO0n969Dy8JEF+LLhfupEpqodfQbqPLNloViPspth?=
 =?iso-8859-1?Q?5RWz7q8eUrEGz8HxSqYyZTQU2StNh27NEc53Bl6GfD+LXW5Rj6yF+1e28X?=
 =?iso-8859-1?Q?Nn0mDlnoFgEeHQNNNdQ8f3Zgd0gyPGMKjoDGfLUuE+8t5GEeWVPVpr1wPJ?=
 =?iso-8859-1?Q?VFNb9D5TptL2XExaB8wkM0w0e9sB5puqrZLz0p3GwCDnSLRcsykQZZzGi3?=
 =?iso-8859-1?Q?OoWodshc4f7/s6W4NVxKduOn72+Y23THugPVR6B6De0E2p8eo2xUmjUAgb?=
 =?iso-8859-1?Q?F10i0pwDOcP4dUADtHcyLlgYEcrR0w/E9N9uugHzNc/acwsQh+A4k4hE0M?=
 =?iso-8859-1?Q?t1vCPDNWZ/q61CiyLYvZvbNaRbUQ0iIjuOIpcfgDsxu91/VK5kNc1MQFxX?=
 =?iso-8859-1?Q?59wzwRcfWxDnht7HCYDkr3MAOdBnUSrtiiZB1St7rJSx00FHo8G9MZ2SnK?=
 =?iso-8859-1?Q?wZKnFNQZiH5EF4K0GDnNe56YGcrhW0aeqrPoQZZptKv2MoHV7HoaGt8TmY?=
 =?iso-8859-1?Q?V/j9IcgB65eK0JXgwxBf77As/FHNooJekp0rnNjBi4Rs9PXLzPUMoSli4u?=
 =?iso-8859-1?Q?NVH27XOx1u6RzEqsov2sKxTmQzOB+lXFCHlUhysDeFLUfxw6imU2Sm0qK2?=
 =?iso-8859-1?Q?/FTUnzN33zGZFx9nJ3XbjVibkAPv/VaPHPeCbyJNRdbGiaqGYV4Q4Pgvj8?=
 =?iso-8859-1?Q?Hlrmiaf724Myp5KxC7GdzLVYqlbqjFdgwK8PW6pwnwT5j1vhUlY04hR7Bh?=
 =?iso-8859-1?Q?MHqn1/AYrnQrN3Y+Tic2Uf2e+4ZPJJd8+4tz8TCDLZBpAbHF0ESbE9/3CI?=
 =?iso-8859-1?Q?T3tj0qFjG7yK7FsAPZlPtzrrCZRxH8TthCEkK+MG500SiMxUnvp8xJ/hOh?=
 =?iso-8859-1?Q?plcfSu4W+EpN+x6opcYJXE4cKG7qACi1KJYqn5by3LrX/i4U34lH9jITnF?=
 =?iso-8859-1?Q?08sOoNFjxjEPqfrBTl2WFEkb6134ffvPyjtJC2ExVYihQ1CAQaMQojTSKF?=
 =?iso-8859-1?Q?1GskQUQxqteFaBW3tTF+3qQA19ymMQdxW2hrkjASL4AZOUUNsZqsXqEKNs?=
 =?iso-8859-1?Q?QIAt7tpi8TmDpzjrGMjzmDVlLY79hhHmBWaKsf/4SaeXglFpJhC+6m715r?=
 =?iso-8859-1?Q?C+0dwwEu0ftQatIqoMVIudFy20hUZQlYieTEKTvJf8Bv4T+NHaBopwoEce?=
 =?iso-8859-1?Q?FEnVclJ0+2XyMVHYYLRWRdKK6y0/PAfz4vwPEZ+rxJIw+1r1XWaRec9KCL?=
 =?iso-8859-1?Q?hL/jdpSQBeoMb+PPGirWbGS0P7MmXbI82x50NBnPM4W4+0qE2mD5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b6220430-95be-4016-5c34-08df3afb61b4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 05:12:26.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiZTvRO0a5LVSfoecy1hAHFKHXDjVLyRc6DTEQpi595LY9JIlOrxJeZgGuZwk9u0Ls5mN3FBBAokFS/r8ODpfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2500

On Wed, Nov 04, 2026 at 04:47:13PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] dmaengine: dw-edma: premature completion in dw_edma_ll_advance() on append
> - [Medium] dmaengine: dw-edma: stranded or aborted queued descriptors on LL reset
> --
> 
> commit 09d38b6dc815a996191d342c3fb4a8c29aef4401
> Author: Frank Li <Frank.Li@nxp.com>
> 
> dmaengine: dw-edma: Dynamically append requests while running
> 
> This commit updates dw_edma_start_transfer() and
> dw_edma_device_issue_pending() to append descriptors into free LL ring slots
> while a channel is already busy, and updates dw_edma_core_reset_ll() and
> dw_edma_device_resume() to handle multiple pending descriptors in the LL
> ring.
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index e2f2a535d5ad1..69b5488282de3 100644
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
> What happens to unstarted descriptors that remain in chan->vc.desc_issued
> when a hardware abort occurs?
> 
> When dw_edma_device_issue_pending() moves submitted descriptors to
> chan->vc.desc_issued and dw_edma_start_transfer() fills the LL ring, any
> trailing descriptors stay in chan->vc.desc_issued with start_burst == 0 and
> done_burst == 0.
> 
> If an abort occurs on an earlier in-flight descriptor,
> dw_edma_core_reset_ll() skips those unstarted descriptors because
> desc->start_burst == desc->done_burst, leaving them in chan->vc.desc_issued.
> However, dw_edma_abort_interrupt() then transitions the channel straight to
> EDMA_ST_IDLE without starting them:
> 
> drivers/dma/dw-edma/dw-edma-core.c:dw_edma_abort_interrupt() {
> 	...
> 	if (!chan->non_ll)
> 		dw_edma_core_reset_ll(chan);
> 	dw_edma_set_request(chan, EDMA_REQ_NONE);
> 	chan->status = EDMA_ST_IDLE;
> 	spin_unlock_irqrestore(&chan->vc.lock, flags);
> }
> 
> Won't those remaining descriptors stay stranded in chan->vc.desc_issued on an
> idle channel unless the client later issues another transfer?

Yes, and this has been long-standing behavior since commit e63d79d1ffcd
("dmaengine: Add Synopsys eDMA IP core driver"). It's orthogonal to this series.
I think this should be handled in a separate fix.

> 
> Also, if an earlier descriptor in the ring raised DW_EDMA_DEFERRED_DONE
> before a subsequent entry raised DW_EDMA_DEFERRED_ABORT, dw_edma_irq_work()
> processes DW_EDMA_DEFERRED_DONE first:
> 
> drivers/dma/dw-edma/dw-edma-core.c:dw_edma_irq_work() {
> 		if (events & DW_EDMA_DEFERRED_DONE) {
> 			if (chan->non_ll)
> 				dw_edma_done_interrupt(chan);
> 			else
> 				dw_edma_ll_interrupt(chan);
> 		}
> 		if (events & DW_EDMA_DEFERRED_ABORT)
> 			dw_edma_abort_interrupt(chan);
> }
> 
> In that case, dw_edma_ll_interrupt() -> dw_edma_ll_advance() reclaims the
> completed slots and calls dw_edma_start_transfer(), publishing the waiting
> unstarted descriptors into the LL ring (setting start_burst > 0), only for
> dw_edma_abort_interrupt() -> dw_edma_core_reset_ll() to immediately abort
> them in the same work pass.

Yes, but I consider this an acceptable trade-off for keeping the error path
simple.

> 
> [ ... ]
> 
> > @@ -610,11 +638,16 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
> >  
> >  	spin_lock_irqsave(&chan->vc.lock, flags);
> >  	if (chan->configured && vchan_issue_pending(&chan->vc) &&
> > -	    chan->request == EDMA_REQ_NONE &&
> > -	    chan->status == EDMA_ST_IDLE) {
> > -		chan->status = EDMA_ST_BUSY;
> > -		dw_edma_start_transfer(chan);
> > -		dw_edma_core_ch_maybe_doorbell(chan);
> > +	    chan->request == EDMA_REQ_NONE) {
> > +		if (chan->status == EDMA_ST_IDLE) {
> > +			chan->status = EDMA_ST_BUSY;
> > +			dw_edma_start_transfer(chan);
> > +			dw_edma_core_ch_maybe_doorbell(chan);
> > +		} else if (!chan->non_ll &&
> > +			   chan->status == EDMA_ST_BUSY) {
> > +			dw_edma_start_transfer(chan);
> > +			dw_edma_ll_advance(chan, false);
> > +		}
> >  	}
> >  	spin_unlock_irqrestore(&chan->vc.lock, flags);
> >  }
> 
> [Severity: High]
> Could calling dw_edma_ll_advance(chan, false) immediately after appending new
> LL entries here cause an in-flight descriptor to be completed prematurely?
> 
> When a first dw_edma_device_issue_pending() call transitions the channel from
> EDMA_ST_IDLE to EDMA_ST_BUSY and rings the doorbell, the hardware channel
> status can briefly continue to report DMA_COMPLETE with transfer_size == 0
> before the engine begins fetching the entry at ll_done.
> 
> If a second dw_edma_device_issue_pending() call runs during that window,
> dw_edma_start_transfer() appends a second entry (making used >= 2) and calls
> dw_edma_ll_advance(chan, false):
> 
> drivers/dma/dw-edma/dw-edma-core.c:dw_edma_ll_advance() {
> 	...
> 	stopped = dw_edma_ll_stopped(chan);
> 	/*
> 	 * HDMA updates LLP at watermark events while running. Use running
> 	 * samples only when processing an LL interrupt.
> 	 */
> 	if (stopped || event)
> 		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
> 				   stopped);
> }
> 
> Because dw_edma_ll_stopped(chan) and dw_edma_core_ll_cur_idx(chan) are
> separate MMIO reads, dw_edma_ll_stopped(chan) can observe the stale
> post-doorbell stopped state (stopped = true) just before the engine starts
> processing the first entry at ll_done and advances DMA_LLP to ll_done + 1
> while the payload transfer is still in flight.
> 
> Passing idx = ll_done + 1 and stopped = true to dw_edma_ll_consume() then
> uses the stopped boundary (idx instead of idx - 1) and bypasses the
> (!stopped && done == used) check:
> 
> drivers/dma/dw-edma/dw-edma-core.c:dw_edma_ll_boundary() {
> 	...
> 	/* After a stop, LLP points past the completed entries. */
> 	if (stopped)
> 		return idx == chan->ll_max ? 0 : idx;
> 
> 	/*
> 	 * DMA_LLP can advance before payload completion. Keep the boundary
> 	 * one entry behind it, wrapping at the start of the ring.
> 	 */
> 	return (idx + chan->ll_max - 1) % chan->ll_max;
> }
> 
> Wouldn't that advance chan->ll_done past the first entry and complete the
> first descriptor with DMA_TRANS_NOERROR while hardware is still transferring
> its payload, as well as ring a duplicate doorbell at the end of
> dw_edma_ll_advance()?

Really good catch. I'll fix this in v8. The fix may require additional MMIO
reads, so I'll need to rerun the performance tests. I want to keep the fix
reasonably small and avoid restoring dw_edma_ll_recheck_work from v3-v5.

Best regards,
Koichiro Den

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261104161227.1742005-1-den@valinux.co.jp?part=6
