Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020097.outbound.protection.outlook.com [52.101.229.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6C4AA00A;
	Thu,  3 Sep 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451759; cv=fail; b=Z1G6+W5gd5/y3v/yk6X3m+jYuSczvc6ePOnjlo7KB4jU5T45kfVDkobnaeh5URPtylF9MA4nmY44ECxaX95Get0Ni0yCaYLl0wv7h7+frtwNoeYKkGZKlK6wkBuHZqg/dcW5DQ+lh5pKAtMy9+mc/UKmVLXhEhjrMrMAnPBnyfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451759; c=relaxed/simple;
	bh=AZCZlLnvvyUKKTK563OtRgmweb1RQr40WZb/Jd7oOl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZEiux4aaRgEGJaGrW/fGdYW7SGW5gwJ60tYgR5xmIOlCmygYSXlvmjJiRxFRIYI3YjqwzA9QetVpbmMsSWBRdxhFhQQF8GMJe2EuBdkzzK8OIpl15NUrmz8oMjbJonKjos4MUsp/FBGrnzhx50Gviggp+Qii6z2fYhn8iXm4Wno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=H0uk78iL; arc=fail smtp.client-ip=52.101.229.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="H0uk78iL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7NojOEa6WnfNR2jjQBtIWX6tn/d5vaELhTx2Vh43WEBNgXsjF4Ne758EzjW/+MYwrd7j1JN0y7otHVVUjGXAf1JrG3Fr+Of8FOFEvKeIOR3NJpunzrh7LUOuLq91D4os+TRGX7Ymv4twpk1oBg+FOjF0JHBeAgZrGyQzFdOBT4lLbG0prgRQ3l3NJoFZdTa0At4o1NhUXAqxgPQYG2SSm0b77S1T7qOpL05VK3MNcyc9iMx60DcU5BRmiHJNdkLJOtICHX6FIEnBfWHaLwRiSGLd9LGmnVgO4XUO3R3BhHwkvRiPX57GQ0v/cKTajClVWva047AY8EXBDuWABPUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8yBKgc4GoxTt/K3HTCojYpj3zVtdbgzckKfoAUO5W8=;
 b=cAqDZiu18E0hLjuUCZ0T1Qm4U2vnDN594haofi4p6SajOmpX+53Z9VUYhOkQoOltu/M2mSerYoGCA86F/d2s1Ebx/rrbq5N55lLTxK+bJ3x6GWQhvVsROWeRw13qRcNCl09xz8kFOikoL/Dqvcv7cd+VJOp531ArB7FDdUdiL7/rF23KFDRJE2wuEGfwdEw7sTS1MPOorf8Oz7gDiXXd7Q+ps/s04mumd741sXmci3VvSB1zDjaRvs97AtCmHoNpEGYs6Yg/wJ9WOZVjJRTmcrwq+qLlIjiFLuY55gZwbsN52k/EFcjs5/gm1b5ae3g/52FvyuPIlnfLXoj1x/ICDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8yBKgc4GoxTt/K3HTCojYpj3zVtdbgzckKfoAUO5W8=;
 b=H0uk78iL80BKGCFRY6drJC3ESQJfpBpVuO2ecVktiR1Vh1/6W04OvSXhiiIkrDN4EJ3dliUaXsF22KLxwqo7ZSIX43xKbtHoLJtPvMSZWGlN1Q+Gcre4i9HbCWOJ6RXuwSWc1U789WC9XEXqlh7qRD4wDoTDr3DMjifdt8v431s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB4810.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 16:09:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 16:09:13 +0000
Date: Fri, 4 Sep 2026 01:09:12 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/15] PCI: endpoint: Add pci-ep-dma helper for exported
 DMA ABI v1
Message-ID: <liix6im6iqrmbxby4jlxfx427p66dzylvad6mkm2wbk5l3upid@e3ro4lzb2nl5>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-10-den@valinux.co.jp>
 <3ef3b7wdwpf364teperxcjc2leycxwke77cejjfzd5w4pnbmik@vlcbizvbxv4m>
 <bgzesn4sqdlqdb3n3djkyed6g7l3ebi6ljbteqhirk2ip2ieou@t4xsvdmcjhdv>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bgzesn4sqdlqdb3n3djkyed6g7l3ebi6ljbteqhirk2ip2ieou@t4xsvdmcjhdv>
X-ClientProxiedBy: TYWPR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB4810:EE_
X-MS-Office365-Filtering-Correlation-Id: 1124e12d-641a-4ff6-9456-08df09d5b260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|23010399003|366016|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hP7IcpagPWxi64EHSTKaCD1JtilGmvcmHEQbme/KCOpE4B6cKgTyqW4q64igb7k2wcupMxHsZVPwD+XBMO86CS9UgfpAoyMf1p48WAPrSEPJ5tvc37W3904m7Du27nSaWG7tyA8YQgyI+7RSVaj+SmRfABLgNdAAERmHqMKpusDp/nRE1b/Rbjmb3Wk+b6nq2csIv3hRDpSE4SnOXfhR6rD3es/DCY1zEu44EuDV9flCMGmLy8me9klEhcWgTU/o68KtlOrI6/onb9nGZH76KdFyHN2fhkXJ2X5vWVPX3dbzH5m/+mD3WjXw89JQ1RpAfcDx8W2hbZIGA3RtkS73RMHG5wr4FYuTa53rLnG8SQmiWh9Y6pIijc22L/ff9LfMiwoJbKhSJK8BFIaYRJtgavxNVD+caiG8WBHT1qR0S0FGz45Ligb3m4/Mlx/CHLvkjznaviEriFrzW+n3zwhPk9HJFvfwB4HTzi/qVs4f7IJvvV6jkY6Kthq+eF59zr+GUPxppAg9Q5R4ByLGy9l6c3LTM3kBcoSjgfNVM21OGsF1vxJr9EmqqONUyeQwi4Wy27yvqYn7BMIdU55YHJ7ot2thCcrJdLurkumDfSm4/aab/SMYsBVguLhdkrmgE4Xi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1Ird0dxUHc0RFl0N2FTeGxCeWt6U0RVL3dRUStSU242b2ptcSsvNnBpaXZ1?=
 =?utf-8?B?YmlUS1V0YTdjMjhCWnVMWXFoQzFYRFUycktqbVMyUmxrYkxVOGtQc2Y2Y3lW?=
 =?utf-8?B?TzhrWkpoUDh6VXJ5eXFqU1p4bmtTempXaDlwT1FuZmlSV25YbDRLbmZaU2tS?=
 =?utf-8?B?T2Voc05sOGxTMWpremkvVk5sZ2VqSWFtQ1Uzc085TytTQWlGVnN1Z2lhSnph?=
 =?utf-8?B?bVVxZnlsTENnbzFJcnpRa0JuSGZjMzhFTTBYTGRLdnJyOE1IMTJIQW5vbitV?=
 =?utf-8?B?cW16dUtHaFBFQWZ6NW1VOFQ2bmxMeHpwT2luQ1JsNU5lRk4zaUw4dlFLTVNW?=
 =?utf-8?B?QWhuNWJycko3Y253QVNoQk9GWUhGUzkyYTgweXNKTkcyMnpqalUzeTBWRWNl?=
 =?utf-8?B?Y2kxMW1DTTJwOVFZa1hFcm1FSy9od2JhWnQyMzc2OVliYk5YS2QvS3BqaDVl?=
 =?utf-8?B?V0ZiNFFxQVNJT3BaUkxYTk1oQ1RPWDNmK3cxNi8xcG9lbEFpWkxXd2RadkVp?=
 =?utf-8?B?c3FGM2RIaFJLcU45OWZkMUhIMXU2aWErNWkybzBqS1g2Uy9UQXA0VFZUTkZs?=
 =?utf-8?B?WVAwYzkrWjhVSjRydW00b2ZUTXpuQk03ZzRwVHRLMGRmK2s2ZXEwTlM5eC82?=
 =?utf-8?B?SXFYY3NIY2YvRWNkUDhaMHVhTmVtM3NjSlUwdi8xL3BoemZMelRIVUl2MVBn?=
 =?utf-8?B?cFB2SnVyZkM3VUFkeis5NTVQangvbnBNdm1WaUdTNnJ0b2ZWNmNKbkR1UDB6?=
 =?utf-8?B?ZWRMZHVjNUpMa2RFSjFMM3ArVW9MUmFLUGM3bkJsWnNBWEJLSXZzanVvR1d6?=
 =?utf-8?B?Umx6WmNIS2NBNGI0NWliL2RiUXlzRlR2eGlSTUJJcDZuSjIvR002a1hWYjZK?=
 =?utf-8?B?ZVppUzZMMFU3QU4rV0wyU3N6RTNBaVpHMEQxa1I3M0lDam1OOWNLMkV3d29a?=
 =?utf-8?B?NjRLbDllOTdJeUdHKzFRbXI0OXFheDEwM1VnZlZoSnNwNTZRaDVza1BqSkk3?=
 =?utf-8?B?TVBHNkN4M0RrK0tUTVI1U0dhQW5sOGRzNjhwYi9MQis1WTVRYjdOM1lZdDRX?=
 =?utf-8?B?MFVzL1BRSDdYQVczc3pYVWtrWi9GT3RwbHpyREhNSGZJdjN2d1Z2bklLbU5o?=
 =?utf-8?B?SFkxK0Q0dFFEa3VEdHllTWFZVks2bXRpeVZXMjVKZ3JCOWVtVWNFZEZVOWVX?=
 =?utf-8?B?OFpmbTU4MXlScldEYURwdTFyYVZ5Q045U0VZZ1RMZEYvOWNOU09ZOTQ0Vnk2?=
 =?utf-8?B?RVN4VWJVbG5HNFZ2czBWQUE2TkVIZzM4ZmZnZ1liVTB1UjhxT0FwMlhYMUo0?=
 =?utf-8?B?Z2w2RllwblRQaFNjY0tuL0wzNy91LzUxaXVBVFRSelhtNWVWckdYL1BOWi9C?=
 =?utf-8?B?NFBUNWpQeUZuTzBPRk5iUDF1akluUUdwNXI1dWtQaWJhclBuRGdReEM4ak1q?=
 =?utf-8?B?a2Q0NTgxUlFUcGRYTmM5M01qVFV3SEpDTmw4NEpBUTBicjZ2OC9QU2dOWHhM?=
 =?utf-8?B?UzZNVFBDcVhDeVE3VzFmZVlycmhMNzNyWFBFeWZyZDJoSFhnM3E4bHNIVmtV?=
 =?utf-8?B?SnhHdnh5M0x1NjR4UkRFcUMybk9OZkhwa0JWRVB5bEwxMVpXVWNydDMrdkEx?=
 =?utf-8?B?V25zdEk1ekJWZDU2T2NjMHRXWW5taGdaS3o5OVNzMGpGb3pUcVF6bnBXaEJa?=
 =?utf-8?B?dHg3bS9HK3lEUVlxcFFyN3lKUVJNK2I4YlM0c0JHbEpPamszZ1NEdzYvdlV2?=
 =?utf-8?B?dmdROWxIZC9FT0RicWxnTHNDSE9BcElKOFc0NXdNQUlRSUwrNzVsWmFzYzlB?=
 =?utf-8?B?eEJnM2xZdG1zbndGdHNIamdTWkd0TWJQUWpzU0RFandiY0cxQzd5aDVwNUYx?=
 =?utf-8?B?TTZ0cW4xelJyZ0djOUdKZ0FrRnVocFcyYjB1dDV4MmFjVHUzZUl6VFRVTHgw?=
 =?utf-8?B?RXdvdGI4RjdUWWIycklYOE9jbW9EK2JzeDJYQWdSd2xSUGlBQjBnQjZrMjdP?=
 =?utf-8?B?Zy9ZMExxOXN5cHRVY0YyTGpIYndKRmpPUThpOTdLc1F2My82MVp5b1lqTU1x?=
 =?utf-8?B?UEhCUnZyekVJYk5kS082VFlmSzlBSk5HNXFYSEJHcUQxbUpQOGN4Z0FpYWhj?=
 =?utf-8?B?eUNDSGhFQ1gzZVpUOTdsM1I5S0ZpdTJKT2ZHRXVDMm1CUGQxMSt6YVZ0T25K?=
 =?utf-8?B?a3pCQzlHUkh1Ny83UGxXRUlzaWthL0p1SzNkVldDWE53d0VKTDJydjJPUVZO?=
 =?utf-8?B?Y0RteTBUWnU4cmM1aUZpeE5SSEdCVlhEVVFWN1Jud08zeWdDV0dkdXVGVzlz?=
 =?utf-8?B?UlUwbTBIQjFGZWJZOEEzNUYvUE11aU94b1IyNXZOQnhiTC9EcVhlK1k2WUhO?=
 =?utf-8?Q?RVHfsufk4KlTvapPQMgTgtDR5W4xijoP2NnEc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1124e12d-641a-4ff6-9456-08df09d5b260
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 16:09:13.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tyC4Ub0iz96iIyCEl014hYzr53SHl6tWBZ0qo43EOWorZqYLyZNVx9OqgOMN1bPnu3UmbELu8KwDIL26q+sOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4810

On Tue, Sep 01, 2026 at 04:35:18PM +0200, Manivannan Sadhasivam wrote:
> On Sat, Aug 22, 2026 at 12:41:32AM +0900, Koichiro Den wrote:
> > On Fri, Mar 13, 2026 at 01:49:59AM +0900, Koichiro Den wrote:
> > > Add a generic helper that packages controller-owned DMA resources into a
> > > peer-visible BAR slice described by exported DMA ABI v1.
> > > 
> > > pci_epf_alloc_dma() queries EPC auxiliary resources, delegates the
> > > requested DMA read channels, builds an ABI header in coherent memory,
> > > and assembles the BAR region list covering the header, controller
> > > register window, and per-channel descriptor windows. If the controller
> > > control window is not already BAR-backed, map it into the exported slice
> > > so the peer still sees a self-contained layout.
> > > 
> > > The first ABI is designed based on the DesignWare unrolled eDMA model,
> > > but it is intended to be vendor-neutral. It exports delegated READ
> > > channels only, which are the channels the host uses to send data from
> > > host memory into the endpoint.
> > > 
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/Makefile     |   2 +-
> > >  drivers/pci/endpoint/pci-ep-dma.c | 342 ++++++++++++++++++++++++++++++
> > >  include/linux/pci-ep-dma.h        | 130 ++++++++++++
> > >  3 files changed, 473 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/pci/endpoint/pci-ep-dma.c
> > >  create mode 100644 include/linux/pci-ep-dma.h
> > > 
> > > diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
> > > index b4869d52053a..94824f3ed5a1 100644
> > > --- a/drivers/pci/endpoint/Makefile
> > > +++ b/drivers/pci/endpoint/Makefile
> > > @@ -5,5 +5,5 @@
> > >  
> > >  obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
> > >  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
> > > -					   pci-epc-mem.o functions/
> > > +					   pci-epc-mem.o pci-ep-dma.o functions/
> > >  obj-$(CONFIG_PCI_ENDPOINT_MSI_DOORBELL)	+= pci-ep-msi.o
> > > diff --git a/drivers/pci/endpoint/pci-ep-dma.c b/drivers/pci/endpoint/pci-ep-dma.c
> > > new file mode 100644
> > > index 000000000000..2a996f9b1424
> > > --- /dev/null
> > > +++ b/drivers/pci/endpoint/pci-ep-dma.c
> > 
> > ---[snip]---
> > 
> > > diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
> > > new file mode 100644
> > > index 000000000000..0ef6f9eb8593
> > > --- /dev/null
> > > +++ b/include/linux/pci-ep-dma.h
> > 
> > Hi Mani, (Cc: Frank, Niklas)
> > 
> > Perhaps it's time to reincarnate this series, with much of it reworked.
> > 
> > Following the discussion here:
> > https://lore.kernel.org/r/fg7cma2ccvdgjgcref7qa4q7ocvvume5dteekedikszebkq7rd@uhrjfp3nmmwh/
> > I am now thinking of dropping the generic pci-ep-dma helper and
> > include/linux/pci-ep-dma.h altogether, as I understand the direction is to keep
> > the DMA export within the vNTB/ntb_hw_epf path *as much as possible*.
> > 
> > The old wire layout was consumed by pci-epf-vntb.c, ntb_hw_epf.c, and
> > dw-edma-aux.c (see patch 13). That is why I put pci-ep-dma.h under
> > include/linux/. For the rework, I am thinking ntb_hw_epf should decode it and
> > pass only the resulting resources to dw-edma-aux. This keeps the wire format
> > between pci-epf-vntb and ntb_hw_epf. At that point, defining the same small
> > layout in both files might even be preferable to adding another shared header in
> > include/linux/.
> > 
> > Mani, does this direction look acceptable to you? I would also appreciate your
> > view on the linked discussion when you have a chance.
> > 
> 
> Sounds good to me. My only concern is exposing the remote DMA functionality as a
> new EPF driver. As long as you keep the changes within the NTB drivers, I'm fine
> with it.

Thanks for the confirmation!

Note: the latest (as of today) is v4:
https://lore.kernel.org/r/20260903082327.2345602-1-den@valinux.co.jp/
The series title is unchanged.

Best regards,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
