Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793458851;
	b=0Rg1ImggdkRXBjHUVM2xtYtUimrh1JBxbQ6GNPFZswAnaW851/uzcJohXymP3U0KZV1O
	 p2LZp7TemJaArtXWZu5/l5+5Nvr4qMqcTyc0mkAvI9AkcDoQoOmfzaFuF0E3r/0XWEFEr
	 3DZrZrqX7vru/r9FckpQOM/BN3KHBaX18TP/Y2bujoyzKDfrZvCcP2oWUKVNc6bVhgfWP
	 /KDdo0gK4UUCYiebP6Cwt5VgoQW0fRvE3dSFycq9W5j55NjbJCgc1wY2hEWGjq2Nop7kN
	 Mf8ryR4pZe5QkWtUVbKNeXtAFbwo9DaFdPoduIPmq+h7+Mx7fq7ha8i5geElIs+CUag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793458851;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=09+pBcrXi+iTTD3FgzSbL5gpjXpztADXxpLWc8Woroo=;
	b=wqr5aThAPNaGYd0TSMKoKNSZl/OX75VdBgIAtCofx4ZP0zbJhsrbVruNu4Oakcnl/BJu
	 cJeEJCRVMpMfYpxklKaw03x7tTXzJG2cJX3kR4gnf0uXFkhvKrr4a1uyY+LItV+FhgpAC
	 yMnfDJbiwkamyuLwCr+Umjt1fS2Pff8FtF/s3gFfwK0OS+cqXtRqzXV+9VdVShI0BO5DU
	 tqPYrEayZB3DpWgccqGvJgbJb0ZcWG4/PMYT85Dufxm2PtGiV3MtRX0IJmyloOFf5hKHR
	 pqWq6TNi4PKy3iRzS0ZC6gQxGYo5GL9LQ9JEHySKDPzsmQp6KD1Sjp5Mh8re8TF6Ilw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=J+Gj0tuk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.112
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4920F606A31C;
	Sat, 31 Oct 2026 15:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4920F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=J+Gj0tuk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7S8TXuySUWr3VCXGHkBwCv4jplaV7gttT/BHh3IM03OdZGey19Wp5Yw0p9gEHM7zy2WH8zSsmOZFLjh3hOTkAj45BoUj/1mw5FIgp8W/ciwIg9vHW7AsrAxGnF4ehkiUQyiA2z1uHnmd4BSZN8UA++TE97kHncLicWAR/6FqRaZcGhbEg8EJNTzrc9p8zxqZgJdFUW8SoX2WCob4E9xUb90EODdc8JuErmYTjG0XMVO5WU6+DRh60BJL65M8ZOjyO5s3QIXtjf2n7JKuV5+IWVSwLAMSTLHfVUSGi3yqYG6ymiCL2AWv3DFlAQymb2SbtK+J6q++CJB3URiq6ZIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09+pBcrXi+iTTD3FgzSbL5gpjXpztADXxpLWc8Woroo=;
 b=p5ptdTVOZEVDIHG7zUO1EbD8GpxcXzK8YciplTIqXh6Y8U22eGrNm0Sda7ZqXh3+eQwXLUw7rrlSYPy1qsATO4+eq8IukNyZAUsD902xKrHm4P2LrQhvz62EIdn+7QuLH9VLWZTMwi1cq5xh5F/hNMGSFJFW40UhVbfl4/CCfYOZfsUqRuENfOOfaGjAFum9CuZJ8hJcJvUr6/xpyG6ajQVBjLUpuNw9unLISDNm7wSsAGvZDq6ri51KoSuX1dCzVEbVt6taSTmpPh3Xnnzrj9YuRxH7elE3vP+vuCC7s694xx8pgSBm6KsV93RKjnhI/bFUEsxo+8DYROAjWCC+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09+pBcrXi+iTTD3FgzSbL5gpjXpztADXxpLWc8Woroo=;
 b=J+Gj0tukHXicsWWeoXiTiTcQvq0bDHHYFM4DBPKYzyJ0kV5i0baO6l382EcbQcCv2EHJsEZgl7RwK23wWowBUfFdK1ZlOa3Jz8m67g1wKJj1jZmHUIfkD7S7Y4qiDoD7RWEyZunuO+BVqQB7aG9ZRMFDjKkYu4pjm8N+4zCGPrA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY3P286MB2771.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:257::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 15:00:47 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 15:00:47 +0000
Date: Sun, 1 Nov 2026 00:00:46 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
	Niklas Cassel <cassel@kernel.org>, Devendra K Verma <devverma@amd.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 2/5] dmaengine: dw-edma: Reclaim LL entries from
 hardware progress
Message-ID: <rggq7a5lcvqshd6wu7qubo4f3b3qxgyp32qwiyytkrvpoat4vz@xcl3lbatl5hc>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-3-den@valinux.co.jp>
 <auTL2mHwCt20uhII@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auTL2mHwCt20uhII@SMW015318>
X-ClientProxiedBy: TYCP286CA0266.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY3P286MB2771:EE_
X-MS-Office365-Filtering-Correlation-Id: 636db6ff-254c-4134-c7ab-08df375fbeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|376014|7416014|4143699003|5023799004|56012099006|261009223027099003|261028144727099003|261026135527099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	e/IT61BNamTLeUWou5OgqHlbQ1H9NA0UeRq2u0MaP3wpXn1CzqGTZYmuGCWo7ac/ufMrQnMqouLqoRxUHddxTFRtiwEiQORZRzBcU6pKT2WKA9tNg94g1b4GdlCiUnrcF27+Y0gwjQ8BXVmghoHAci0hkUVVjkNGY1U9gvh+0WW6gXPFUBN9sVNILsIsHDLlRVzB+0vhZq28BJblfG5+dwQ8V9ITrgT1I5+BCDTXmt8RWd0dF0ayFaIP4kvunTPfhEZ1AP9C28loewQcw2i1IviV7ZFhgAk4jJWkpNg11vDGZIpMwY5pgu83bZAK088Kwadworw+R+8KvFT1/6einZ6IyxK4jSfjp4FI5dOYbFjUAX0ljIo+5kOfHGY5XEtoo+ibKFGnnAS5MJXN2thDpsYY5PhGtGXQbWT7PtkhoaIAbYIwtRErEotsezVWbHHxnam8QNRu2kazuMD7PO2aYm9+zxzDs+GpmAfegp72bKayVLNqao+0jmIPr6Fjm6KSZoA9kAAiI1gBZHQc7IbXcGCE9Kvtf0i3isPDbaqzgBGJWVyzboD/V8avr1H69sNNy9RGSzyJKHuRET39wV+dt/eWGKXlJUy3WJIBiv32yDifeHgBF83mV1suKnqFytC3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(7416014)(4143699003)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261026135527099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bplHqT13Qy7QyImCHlMfBiGbdVIYPL9fSmDna5rSyTSNNu1wCPUhNdjrBUEi?=
 =?us-ascii?Q?88uoL9CChZ5q9j43TLzs+haiEeM20olW6mFY8III0UMdpvhyDxnwtdeTQ/Zd?=
 =?us-ascii?Q?Hg/DKjMTMqX1mIpBcjDvHmt0DumbRzXbPVcD2f719WWd3d8zzVqrY8jr+bGH?=
 =?us-ascii?Q?xxMsrtMOACKiPOx1AnXg9SeHEGtWUiCLu4av/ZpeudqOFT0fKuXh0Wnqy0rR?=
 =?us-ascii?Q?hocy7D1VD3NsncTvSMzOqJAp+EmPdNRU/mzuEW6PFn/y7ZL2vXI8fY20zw+q?=
 =?us-ascii?Q?JT+5E+1bGS+lkJ45vEwbAKZ6xBKhwUfw+UWr5ipQz4te20ZRvQJp34lE4uzN?=
 =?us-ascii?Q?Qrb71uZAsHZJ+UUmuh+mVoUpZr+yut4iCqsB+z9AhVo8SLQqZtrwwspbBQFp?=
 =?us-ascii?Q?C3QV5B2GdjIKxGKBsbGmn4ntWHYhAX1+LOAWU8yQxDwvODX13r2ayE9Mdx3+?=
 =?us-ascii?Q?jv+PN1Ts3/1/WbG39hey2pASBQ0inaumC8QKxD2U7PCOG8U00cAAq2TfbC9d?=
 =?us-ascii?Q?sgqTakuGtsuiFNdDjZobDT41erE7vc81kvdXwjj02Y+FubYPaKlW5jPykWFB?=
 =?us-ascii?Q?Mbf7B1bgqOK97euhNB5T+pvMj+bMEL8SC/V8r6KlNJkwNLUQXRF4T6dufefX?=
 =?us-ascii?Q?vhB6BNzCLglmYJkBNEzuhVw1zZH8JbkoFHdpSrPBoFWi5bpk/sq0NF8V29/v?=
 =?us-ascii?Q?DFsVCWdiB3w+YHFpIqU+i9cVhkJQzefw/CWiO35ObJWDgfw1mtN4agYwUtC+?=
 =?us-ascii?Q?JrSf4SZmsCPE/pHSCujDIESXIEMZ6HNLFheyNQ9XYG9LPiintObO9++xgXp0?=
 =?us-ascii?Q?TU3zO099zRSC7ySIgNmMtu3chubtGWM2hcHeBro/z1UZKn9e9uVKMjiMq+j1?=
 =?us-ascii?Q?D8J03y3zeb0Gyvi4Rb6UuMT4zNW5VcLnM0O+G4n0mmjeXvb+vNNd2ejhL0xU?=
 =?us-ascii?Q?MID6UFg6vCO+bhhJ0QYWtRcgwhIyEcMguJKh1uzXeQPD/9ia2HQuFhmG1jv9?=
 =?us-ascii?Q?F90+NnMEOnenpsc4YtX9sf18xxBBCOgxA9OqQRiMyzlgpAJtacXBc9f7ZoS4?=
 =?us-ascii?Q?GipFv+tH+DZ8+KTtbDOnXVE5POhi0rxu97eGaY2COzPeE3p8vtfLJHUV//lz?=
 =?us-ascii?Q?yc2K6T9opf/tmskQ9B/QgT09MKHv6ziroxkEmJvl1XX9mQQC/XnOfKZcaqHY?=
 =?us-ascii?Q?lBJS6WnL1RItchXd7sCchdfgS2JxeI31XgxEVLR7k9I5D3MU6W5QpK92Qx3B?=
 =?us-ascii?Q?IMRgtFM0rmRKtOpEwqLbDjQI/kd0sFtQwzRFW2pbJIsqMNgDdDG377400FHk?=
 =?us-ascii?Q?3LTBRw9onXF4XZiSKVhhg+XRlN8q+US9Cm2VH941jNvYrfwDrxUVH9RRP3Wv?=
 =?us-ascii?Q?utFt+YLw+3lpuLptCFmRsp/7vH+M8+x6rS8Na/vr6SZnMD3VbV4PBRtEQdzi?=
 =?us-ascii?Q?pyBw8N8oSxFnN2kWnecdN58LRtvdGpfl87Z53REmn/hV8Oiq9Sgzo0T4Mytm?=
 =?us-ascii?Q?vWrLVCGvUs64YqS9MBiBzdRdd7IPTDSLQedTnRVnV9sBwGW1WuoSGvSj8fJs?=
 =?us-ascii?Q?vduQ1DTIy8ZaQoNXwIT4KuqsAQ4DHYlZgznIvnLdztt1PooWVTSS6ymH7EkX?=
 =?us-ascii?Q?S0lzXm5igAn8wbV5bOuOnxpjjFlZnFm6ql67zE9nbWF4ISUqtLbc5swJPtFG?=
 =?us-ascii?Q?X2AniyfjPPsm1BZoRKINFtVim9iw1WqIehCSTqSYyn8oRgEmwSHt2pPyrfKg?=
 =?us-ascii?Q?XafELEO0uRx02tIOE71QJqwV5TCQOEjN90oXr3gJULJ514UW4uyx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 636db6ff-254c-4134-c7ab-08df375fbeda
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 15:00:47.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/D+I9th7ZG5THQvihdCAt1CMmY/OSAqaMn7oxnahsS60V6xnKj+nUQdgIIYXXNuCPWSuNk+9AovR0aF77gd+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2771

On Fri, Oct 30, 2026 at 11:54:50AM -0500, Frank Li wrote:
> On Sat, Oct 31, 2026 at 12:07:39AM +0900, Koichiro Den wrote:
> > Once requests are appended while the channel runs, a DONE interrupt no
> > longer means that all published entries have completed.
> >
> > Use DMA_LLP to advance ll_done and complete descriptors in issue order.
> > Reclaim entries as they complete so descriptors larger than the ring
> > can be submitted in batches.
> >
> > DMA_LLP may advance before payload completion, so keep the running
> > completion boundary one entry behind it. Use DMA_LLP itself once the
> > channel is stopped with a zero transfer size. Hold vc.lock to serialize
> > progress with ring resets and doorbells.
> >
> > Refill reclaimed entries and restart a stopped channel if work remains.
> > Defer STOP and PAUSE completion until the channel stops.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Reworked v5 patch 13:
> > https://lore.kernel.org/r/20260812155721.2807506-14-den@valinux.co.jp/
> >
> > Changes since v5:
> >   - Read the registers in the progress handler instead of retaining an
> >     IRQ-paired LLP snapshot.
> >   - Allow index 0 to wrap. Reject running samples that would reclaim all
> >     pending entries, so an unchanged start pointer cannot look like a
> >     full lap.
> >
> >  drivers/dma/dw-edma/dw-edma-core.c | 140 ++++++++++++++++++++++++++---
> >  1 file changed, 126 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index b08bb31657c9..74613c95ae11 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -53,13 +53,6 @@ dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
> >  {
> >  	struct dw_edma_desc *desc;
> >
> > -	/*
> > -	 * For now, a descriptor that does not fit would stall the channel
> > -	 * forever: reject it up front.
> > -	 */
> > -	if (!chan->non_ll && nburst > chan->ll_max - 1)
> > -		return NULL;
> > -
> >  	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
> >  	if (unlikely(!desc))
> >  		return NULL;
> > @@ -146,6 +139,76 @@ static bool dw_edma_ll_pending(struct dw_edma_chan *chan)
> >  	return chan->ll_head != chan->ll_done;
> >  }
> >
> > +static bool dw_edma_ll_stopped(struct dw_edma_chan *chan)
> > +{
> > +	return dw_edma_core_ch_status(chan) == DMA_COMPLETE &&
> > +	       !dw_edma_core_ch_transfer_size(chan);
> > +}
> > +
> > +/* Return the first entry we cannot reclaim yet. */
> > +static int dw_edma_ll_boundary(struct dw_edma_chan *chan, int idx,
> > +			       bool stopped)
> > +{
> > +	if (idx < 0 || (u32)idx > chan->ll_max)
> > +		return -EINVAL;
> > +
> > +	/* After a stop, LLP points past the completed entries. */
> > +	if (stopped)
> > +		return idx == chan->ll_max ? 0 : idx;
> > +
> > +	/*
> > +	 * DMA_LLP can advance before payload completion. Keep the boundary
> > +	 * one entry behind it, wrapping at the start of the ring.
> > +	 */
> > +	return idx ? idx - 1 : chan->ll_max - 1;
> 
> use mod
> 
> 	(idx + (chan->ll_max - 1) - 1) % chan->ll_max - 1;

I believe what you meant was:

  (idx + chan->ll_max - 1) % chan->ll_max

and if yes, I agree. I'll update it in the next revision.

> 
> 
> > +}
> > +
> > +/* Must be called with vc.lock held. */
> > +static void dw_edma_ll_consume(struct dw_edma_chan *chan, int idx,
> > +			       bool stopped)
> > +{
> > +	struct virt_dma_desc *vd, *_vd;
> > +	u32 done, used;
> 
> lockdep_assert_held()

Will add it.

> 
> > +
> > +	idx = dw_edma_ll_boundary(chan, idx, stopped);
> > +	if (idx < 0)
> > +		return;
> > +
> > +	done = dw_edma_core_get_ll_dist(chan, chan->ll_done, idx);
> > +	used = dw_edma_core_get_used_num(chan);
> > +
> > +	/*
> > +	 * LLP may still point to the first pending entry. Subtracting one
> > +	 * can wrap the index and falsely mark all pending entries complete.
> > +	 * Reclaim them all only after the channel has stopped.
> > +	 */
> 
> Do you means !done for this comments?

No, it was about the last term (ie. "!stopped && done == used") only. In
retrospect I should've separated the if blocks like the following. WDYT?

    if (!done || done > used)
            return;

    /*
     * LLP may still point to the first pending entry. Subtracting one
     * can wrap the index and falsely mark all pending entries complete.
     * Reclaim them all only after the channel has stopped.
     */
    if (!stopped && done == used)
            return;

> 
> > +	if (!done || done > used || (!stopped && done == used))
> > +		return;
> > +
> > +	chan->ll_done = idx;
> > +
> > +	/* Match reclaimed entries to descriptors in issue order. */
> > +	list_for_each_entry_safe(vd, _vd, &chan->vc.desc_issued, node) {
> > +		struct dw_edma_desc *desc = vd2dw_edma_desc(vd);
> > +		u32 consumed = min_t(u32, done,
> > +				     desc->start_burst - desc->done_burst);
> > +
> > +		if (!consumed)
> > +			break;
> > +
> > +		desc->done_burst += consumed;
> > +		done -= consumed;
> > +		if (desc->done_burst != desc->nburst)
> > +			break;
> > +
> > +		dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
> > +		list_del(&vd->node);
> > +		vchan_cookie_complete(vd);
> > +	}
> > +
> > +	WARN_ON_ONCE(done);
> > +}
> > +
> >  static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
> >  {
> >  	struct dw_edma_chan *chan = desc->chan;
> > @@ -174,7 +237,6 @@ static void dw_edma_core_ll_start(struct dw_edma_desc *desc)
> >  		}
> >  	}
> >
> > -	desc->done_burst = desc->start_burst;
> >  	desc->start_burst = i;
> >  }
> >
> > @@ -283,6 +345,45 @@ static void dw_edma_core_ch_maybe_doorbell(struct dw_edma_chan *chan)
> >  	dw_edma_core_ch_doorbell(chan);
> >  }
> >
> > +/*
> > + * Must be called with vc.lock held.
> > + *
> > + * HDMA does not update LLP continuously. Only use it to track running
> > + * transfers when handling an interrupt.
> > + */
> > +static void dw_edma_ll_advance(struct dw_edma_chan *chan, bool event)
> > +{
> > +	bool stopped = dw_edma_ll_stopped(chan);
> > +
> > +	if (stopped || event)
> > +		dw_edma_ll_consume(chan, dw_edma_core_ll_cur_idx(chan),
> > +				   stopped);
> > +
> > +	if (chan->request != EDMA_REQ_NONE) {
> > +		/* Wait for the channel to stop before completing STOP or PAUSE. */
> > +		if (!stopped)
> > +			return;
> > +
> > +		if (chan->request == EDMA_REQ_STOP) {
> > +			dw_edma_finish_termination(chan);
> > +		} else if (chan->request == EDMA_REQ_PAUSE) {
> > +			dw_edma_set_request(chan, EDMA_REQ_NONE);
> > +			chan->status = EDMA_ST_PAUSE;
> > +		}
> > +		return;
> > +	}
> > +
> > +	dw_edma_start_transfer(chan);
> > +	if (!dw_edma_ll_pending(chan)) {
> > +		chan->status = EDMA_ST_IDLE;
> > +		return;
> > +	}
> > +
> > +	chan->status = EDMA_ST_BUSY;
> > +	if (stopped)
> > +		dw_edma_core_ch_doorbell(chan);
> > +}
> > +
> >  static void dw_edma_device_caps(struct dma_chan *dchan,
> >  				struct dma_slave_caps *caps)
> >  {
> > @@ -749,7 +850,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
> >  	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
> >  }
> >
> > -/* Must be called with vc.lock held. */
> > +/* Non-LL completion; vc.lock must be held. */
        ^^^^^^(a)
> >  static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
> >  {
> >  	struct dw_edma_desc *desc;
> > @@ -772,8 +873,6 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
> >  			dw_hdma_set_callback_result(vd, DMA_TRANS_NOERROR);
> >  			list_del(&vd->node);
> >  			vchan_cookie_complete(vd);
> 
> why not use dw_edma_ll_consume(), let vchan_cookie_complete() at one
> place only

With this patch, the existing dw_edma_done_interrupt_locked() now serves the
non-LL case only (see (a) above), so we cannot simply use dw_edma_ll_consume()
here, as it works on ring indices.

That said, avoiding scattering vchan_cookie_complete() around makes sense.
Would it be a middle ground to add a new helper like:

   static void dw_edma_complete_vdesc(struct virt_dma_desc *vd,
                                   enum dmaengine_tx_result result)
   {
        dw_hdma_set_callback_result(vd, result);
        list_del(&vd->node);
        vchan_cookie_complete(vd);
   }

and replace the remaining open-coded vchan_cookie_complete() call sites with it?

Thanks for the review!

Best regards,
Koichiro Den

> 
> Frank
> 
> > -			if (!chan->non_ll)
> > -				chan->ll_done = chan->ll_head;
> >  		}
> >
> >  		if (chan->request == EDMA_REQ_PAUSE) {
> > @@ -796,7 +895,6 @@ static void dw_edma_done_interrupt_locked(struct dw_edma_chan *chan)
> >  	default:
> >  		break;
> >  	}
> > -	dw_edma_core_ch_maybe_doorbell(chan);
> >  }
> >
> >  static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> > @@ -808,6 +906,16 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> >  	spin_unlock_irqrestore(&chan->vc.lock, flags);
> >  }
> >
> > +static void dw_edma_ll_interrupt(struct dw_edma_chan *chan)
> > +{
> > +	guard(spinlock_irqsave)(&chan->vc.lock);
> > +
> > +	if (chan->status == EDMA_ST_PAUSE)
> > +		return;
> > +
> > +	dw_edma_ll_advance(chan, true);
> > +}
> > +
> >  static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
> >  {
> >  	struct virt_dma_desc *vd;
> > @@ -838,8 +946,12 @@ static void dw_edma_irq_work(struct work_struct *work)
> >  	do {
> >  		events = atomic_xchg(&chan->irq_pending, 0);
> >
> > -		if (events & DW_EDMA_DEFERRED_DONE)
> > -			dw_edma_done_interrupt(chan);
> > +		if (events & DW_EDMA_DEFERRED_DONE) {
> > +			if (chan->non_ll)
> > +				dw_edma_done_interrupt(chan);
> > +			else
> > +				dw_edma_ll_interrupt(chan);
> > +		}
> >  		if (events & DW_EDMA_DEFERRED_ABORT)
> >  			dw_edma_abort_interrupt(chan);
> >  	} while (atomic_read(&chan->irq_pending));
> > --
> > 2.54.0
> >
