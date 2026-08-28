Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198638F930;
	Fri, 28 Aug 2026 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953217; cv=fail; b=XAw0NRw3D6do3m9Nt8wnMzxUUast/RqJz/Jfvbyp26DpUXmHY6WSxamt9MLZjaNObDaJP1wHZ3bdQRunn5C+lv//pbTPd4ZGMVtW5UVgOPyJcACuShhfrfmrOVvJAnhU5pU6RzokzysBQAHRkeW9RvsmZsOI5RtA1ITLrNglMcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953217; c=relaxed/simple;
	bh=UHvXx713KhO2m4w/QJnXX9SjmmCT/G980ELh8Dm363M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WczxrtdM7J7WB5FN1ttzfo9Vkq6QEMMs1YqVPJONYfxyFcXWH2Veq86/xJ2Ft6L2wFpxh5JK8+C4UG1C2e/fm3PTx0RNmEyleLczooBlKAbz7OGnNh+WWGcxaqP3wa4/Ak29MpW8fY04uWTnb/w2cFb1s/Ed50pV+Xv8AH11ZlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KO0UVeWg; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KO0UVeWg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfaEnXWps+Y3F7iE+G93OjcZ7dIO2zUhjEtSb4RdB4e7TY+ISsSR2gRpoPzi2l0dyF31ufNHcm3fxf7uZ3MTq9dJFO5fztagDUDuzs896eWm9LAEJvJhPAql/0zL3Yilf5cI/lAt9iECGPMHzBNSd35sd2u+14pi8eieyhGH1hwjS/PpLEdXt2gxAnAdKpzmf4FmgSi1S4u5TS3MwT4yBKAcZpOjNuQCfgqCApqOF1+eRFxbP0Y4NStvftw9Xh+MAUhigGibeZCCBhNXSKV0jnQUsQPIm1bfedAbeKRD9uHC5GpsqrdxV0vgbrh4rTKc08Pgh81EdUsWhYet0p3rBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q2GPj2RRTmv6+xGPLCwvcA/b5BbPSJQr/IvfBu2VYA=;
 b=lqmHeXxxrMpFKUEb2OXtste5IeninI02WfVKUbeJuMcPOL1m2+Ccit8qbkaKzeIOL5cqxECWK+KHJx1pN49F4Z/7W/UIzSP7zGfe8TdvB6psfImI35xd7hYOAoIo/NfkmAnVP7SSObCFlhNn1pXhZ1/hqdMy37jFz5coJldeFFBdl2sbk0QbD/72RzHLyAhFFGst4bRTBrMb8tPgEBSb3blojurxKTQq3YNSwgecl12JbeT64kMzwH+K6ZDBMgv5yyQkBX0Q0Bno0r2smIo6+k//1Njw76/CXQ/V6QIcRef/En/Dlkam2nrqqDpOn01qkr83RKGeNqs7OxZim66K1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q2GPj2RRTmv6+xGPLCwvcA/b5BbPSJQr/IvfBu2VYA=;
 b=KO0UVeWgk24+sUC/VJvMPAlXOZ4/4nsHT4S8fyjWYxF/5sZvGNUi5tYEiiOr1Yzujv2KcQ8XswKfQpxcol9arintBvEAieHBkjBGhzmh7kx9y/g8nOsjl8F9MuFkeK5K1TmSXf0edZtuHiawX2w9XH07L4MAJK/By4RtLwrfdA/4Qbf+3Zra7vxTQWAZn6x1HJQmmNMT7uhBr3io/ZbNoMe5c72JXSUw+wPNgEGIt19LBkulgtgB1MKidM0icGHvzNHpSDqHYc43uIY87aUujD+Swke1C7dZkp6+1JXbNJ/732gpr598dZQunwnNO9OoTs2bW3rcZt4qVR6ZogkkwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 21:40:10 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 21:40:10 +0000
Date: Fri, 28 Aug 2026 16:40:00 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joao Pinto <jpinto@synopsys.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix BAR backing DMA address alignment
Message-ID: <apIAMJ98XJDsfjT6@SMW015318>
References: <20260827181757.1984374-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827181757.1984374-1-den@valinux.co.jp>
X-ClientProxiedBy: CYZPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:930:89::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: ac161300-bbe7-4134-6676-08df054cef1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|19092799006|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f8ZBS78zG8xycKfN9EbL8gvviHFapdWfJiht9DVUk77GXhFFMXTiGkYW7rFLp46ozVnj4hfMuXlpeytvKCDNAJ9HM0WN+JMhuYOGFKq5Qjk8y82uwlZZPnTyMpf33+ev4TzTMcUijJtDCI7QZZfe6n2bxghLJvPGAbk4auAcOoiEKj5vWcGKqKMgf/CEroCZSVL25Qzp/nT7DaTfUs4BDjM4gAwtUsKEKXzgVmTiiBAwzyJUthZXAFBi6zXNyJLX9VADnsbxX0oHGO1CusJzYuJ9s9Le6DlbIPFse+SISwSe3AzTOJeVPxeuNZ+OsrU1xcIMaytHUKDbjkc+gYuEv9x7j49ATpZ6FKtL3A5kwnwjM+RYoxDJMNX6yYUil5Xy7DdQWbbxmNao4WAi5aXs1Jj+97Ku3wNiBTR132QQi2cVSic11YVp+x/cg3Jrgs3KjG2FKEOwZ772engmXuQWgYTdXZM/BFF80PGFrT95CKbGALu2iFRR+HgExsKTSBQ93GbSeQRyRYsksOwukJb43GAds+jifBNhmxiGT+3lmwludJrWSrjy5WtBwzvPPtsiz3xVv/caUr4vIgHlBO5xYVRsTao9M2ij1BTuG+P7eExvNDLDSY/b5AjOoptZd80X+wiSehEJWe5J/DfUtnVR2SQzONyZA70OzfgLteVKtr8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(19092799006)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NrzA/g/nB92It1Fry/XbxM0Gg9JZ8MRTConODPr6MxoJT6cbUM7oxyCz+sM6?=
 =?us-ascii?Q?Gnl+WzRx5N4em66RcgUV5io6kVmUKi22cgeLQX17vRXEbrQ0wULBDIhz14lH?=
 =?us-ascii?Q?s7LLg7oqko3OYy7yCefPd1sPTxM+rg5xrHBZQU52nKP/aiPAM97Hvq7uKyKE?=
 =?us-ascii?Q?Ac06F37SWOY1jUZp72UvylzjJy/3GbefIGdl41yuJlYTwa3Fg/KfjIxqOSdB?=
 =?us-ascii?Q?WADvo+d5gvTJ7rjzVG6Wcq+/QSTid2pmXitUhhpdDlxitGBgc/Rb7XH3P9fk?=
 =?us-ascii?Q?voRNiERHn24tEiw1nvePwE5Ns2s29pjodR+LlasJ01rJPkzDhE1mYdDwhDKO?=
 =?us-ascii?Q?P+TpbI5touP191224qQigSpz4Wvq9vnPMuRk8NzPH+F/6lLVOpykfZNgQu83?=
 =?us-ascii?Q?+59FzoYd4X7IURQ4CduaTETQue1jwjEwh0TMFz3dNtHlzyZfuIHIDXlTCs/u?=
 =?us-ascii?Q?Vj+bX4UHQKt7W+aXuDj3D67q8/Ja7MH4PnikcO4ZlE9e2ljK0LpNqOB0nXLt?=
 =?us-ascii?Q?GVUwWRRjuhC/c2mHM5/2fY3jluPlBK/PZjyQcW5ymNiS2JKcXBv2IldQhSwf?=
 =?us-ascii?Q?1/VF+0z7s3+HWdnmbTQd8V0Q9IlDqiOR7Z028xNu7newc7zNBqUtKIKVmp2w?=
 =?us-ascii?Q?bP4umlR5ChQniqfIVrbeU97OHMczdMnNQXpEvGAIDahWuZvH89iFp5ORmDnE?=
 =?us-ascii?Q?96ILDr9oRJrgGU7ZsJFNR30JDIA2EAFZOnbxi5E4yuap+GQblbr2mjF5QVio?=
 =?us-ascii?Q?NVD/A9TfmOYkO3sgZ4XZO36GjEwjeDkAeThZeltWXkykM+kWFQTUAdy3y4v0?=
 =?us-ascii?Q?CuM5FPxdQ9dTLhqjqGPrNyXovMtTb+xH+r5iKkQgn94geWmyYwg3huqUG/C9?=
 =?us-ascii?Q?H4HcjtoWCkQn7B7c2KwR4gp1OG5Iwq0EzwNepkmTHwfRZFzF6jbjkBqPEwDA?=
 =?us-ascii?Q?Ue9FTD0luCmjzoXkpd2xm1YO23YyjOH0JSdQvk6PilTpMBeLClW3ujjqSskZ?=
 =?us-ascii?Q?4Lebxd/4776NZZimX3h7bLQJGAGfI3rVHN7hdW3e0Dk77oygz7VXTrmMaOKA?=
 =?us-ascii?Q?IClpk9IYoXFvHB87q3MQGiS2A5cY258Ohf2RyExWjzT4f/Xj66a+LluHWUlQ?=
 =?us-ascii?Q?3G8e6c39wkENlBZS0G7QOfERhzjnLYBruPT63E+d4TtPc2pjTINtiP57Wu4C?=
 =?us-ascii?Q?I1+ssfcTWuvNqnEAHLJLTFUkZHtAwR2kRxgWPM+31DvmU5S4pAVuAukga/yM?=
 =?us-ascii?Q?HNAGWBFRpcQ25lC357cWA4iPsHskO31ecXXAWjv0DR+Wk7OIM9LtkpIvP6VW?=
 =?us-ascii?Q?HIs49za7lZBMNN9SZKWVUOPvm6sgvMgdHogWHiHX3rAdxwbvBbRF0/XtVZsk?=
 =?us-ascii?Q?SYfjOPiOH+kidAXIi/fDb9nUyvYQKaGF5+2Yui8I1rXe6UfgVJaf3a+kkheN?=
 =?us-ascii?Q?wlLv+Tam4Rdoo3NZ9IfB//kX2CoM+w7s2lfcVhKsHYp+Z145M8by1fmem1Fu?=
 =?us-ascii?Q?bDf0yPESfFL+serOCyrE2x3J1zhVNeCc6XsHD4xs6U7QhH3PPji6+helv/a4?=
 =?us-ascii?Q?4A4E+l+zgbvXgOoLXgGfmquJ28DhZnxKxBoTXrOqFNYug9M5le6bpezF7Hit?=
 =?us-ascii?Q?Hu8VaV9gLFSuYRF0ocYSt77l0856d1mmd87whMXCM+JIA5Ul4gwU2f3pBHCo?=
 =?us-ascii?Q?OBZD5gRmIbFsgwmX49f5/VvCbLcx70KPH7AlprB8sYiKTEPDRlRZ+G+Z38Cg?=
 =?us-ascii?Q?OPB4NQQFw30Hqt6ygkr3c0F5LxJydRPmZcTYBr03xgVcTtS4Z13P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac161300-bbe7-4134-6676-08df054cef1a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 21:40:10.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qm8soG1hW69O/DK/yg7meRFf6nfRH9WdJu5eI+K+RLC6VvBlb3LZ4EkdAOyJCXQZhQro82AJj3KEUXG0237U3P0DrcxWPX7wfkIgeNAaz0x15A/YrjNc2LPd2wHCNwQI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200

On Fri, Aug 28, 2026 at 03:17:57AM +0900, Koichiro Den wrote:
> DWC BAR Match Mode requires the target address to be aligned to the BAR
> size. pci_epf_alloc_space() relies on dma_alloc_coherent() to provide
> that alignment. For CMA-backed allocations, the guaranteed physical
> alignment is capped at PAGE_SIZE << CONFIG_CMA_ALIGNMENT. With a direct
> DMA mapping, 4 KiB pages, and CONFIG_CMA_ALIGNMENT=8, a 2 MiB BAR may
> therefore receive a DMA address aligned to only 1 MiB.
> dw_pcie_prog_ep_inbound_atu() rejects such a mapping with -EINVAL.
>
> If the initial allocation is misaligned, free it and retry with
> mem_size - 1 bytes of padding. Select an aligned subrange and record its
> offset so pci_epf_free_space() can pass the original CPU address, DMA
> handle, and size to dma_free_coherent().

I understand this situation, but it mays waste memory, if 16MiB, it max
waste 16M-1 space.

As workaround, this is good enough.

add dt memory node for pcie-ep

my_dma_pool: dma@42000000 {
    compatible = "shared-dma-pool";
    reg = <0x42000000 0x02000000>;
    reusable;          /* <-- CMA: system CAN use these pages when idle */
};

pcie-ep {
	...
	memory-region = <&my_dma_pool>;
}

but if use "reusable", still meet CONFIG_CMA_ALIGNMENT. if use "no-map",
dma_alloc_from_dev_coherent() will bypass CONFIG_CMA_ALIGNMENT. but it will
waste memory if not use pcie-ep devices.

Maybe we try

 static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 {
     ...
     ret = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
     if (ret) { ... }

+    /* linux,cma-force-align: bypass CONFIG_CMA_ALIGNMENT cap, align = get_order(size) */
+    if (of_get_flat_dt_prop(node, "linux,cma-force-align", NULL))
+        cma->force_align = true;

     if (default_cma)
         dma_contiguous_default_area = cma;
     ...
 }


 static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
 {
-    unsigned int align = min(get_order(size), CONFIG_CMA_ALIGNMENT);
+    unsigned int align;
+
+    if (cma && cma->force_align)
+        align = get_order(size);    /* no cap: align = natural power-of-2 for size */
+    else
+        align = min(get_order(size), CONFIG_CMA_ALIGNMENT);

     return cma_alloc(cma, size >> PAGE_SHIFT, align, gfp & __GFP_NOWARN);
 }

I am not sure if DT team accept add "linux,cma-force-align", which desgin
for specic device CMA region only, not for default cmd. No impact to other
system.

Frank

>
> Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 39 +++++++++++++++++++++++------
>  include/linux/pci-epf.h             |  7 ++++--
>  2 files changed, 37 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 6987343c9e61..e8c3709d85c4 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>
> @@ -278,13 +279,15 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  	}
>
>  	dev = epc->dev.parent;
> -	dma_free_coherent(dev, epf_bar[bar].mem_size, addr,
> -			  epf_bar[bar].phys_addr);
> +	dma_free_coherent(dev, epf_bar[bar].mem_size,
> +			  (u8 *)addr - epf_bar[bar].alloc_offset,
> +			  epf_bar[bar].phys_addr - epf_bar[bar].alloc_offset);
>
>  	epf_bar[bar].phys_addr = 0;
>  	epf_bar[bar].addr = NULL;
>  	epf_bar[bar].size = 0;
>  	epf_bar[bar].mem_size = 0;
> +	epf_bar[bar].alloc_offset = 0;
>  	epf_bar[bar].barno = 0;
>  	epf_bar[bar].flags = 0;
>  }
> @@ -308,8 +311,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  {
>  	struct pci_epf_bar *epf_bar;
>  	dma_addr_t phys_addr;
> +	size_t alloc_offset = 0;
>  	struct pci_epc *epc;
>  	struct device *dev;
> +	size_t alloc_size;
>  	size_t mem_size;
>  	void *space;
>
> @@ -326,16 +331,31 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  	}
>
>  	dev = epc->dev.parent;
> -	space = dma_alloc_coherent(dev, mem_size, &phys_addr, GFP_KERNEL);
> -	if (!space) {
> -		dev_err(dev, "failed to allocate mem space\n");
> -		return NULL;
> +	alloc_size = mem_size;
> +	space = dma_alloc_coherent(dev, alloc_size, &phys_addr, GFP_KERNEL);
> +	if (!space)
> +		goto err_alloc;
> +	if (!IS_ALIGNED(phys_addr, mem_size)) {
> +		dma_free_coherent(dev, alloc_size, space, phys_addr);
> +
> +		if (check_add_overflow(mem_size, mem_size - 1, &alloc_size))
> +			return NULL;
> +
> +		space = dma_alloc_coherent(dev, alloc_size, &phys_addr,
> +					   GFP_KERNEL);
> +		if (!space)
> +			goto err_alloc;
> +
> +		alloc_offset = ALIGN(phys_addr, mem_size) - phys_addr;
> +		space = (u8 *)space + alloc_offset;
> +		phys_addr += alloc_offset;
>  	}
>
>  	epf_bar[bar].phys_addr = phys_addr;
>  	epf_bar[bar].addr = space;
>  	epf_bar[bar].size = size;
> -	epf_bar[bar].mem_size = mem_size;
> +	epf_bar[bar].mem_size = alloc_size;
> +	epf_bar[bar].alloc_offset = alloc_offset;
>  	epf_bar[bar].barno = bar;
>  	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
>  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> @@ -343,6 +363,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
>
>  	return space;
> +
> +err_alloc:
> +	dev_err(dev, "failed to allocate mem space\n");
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
>
> @@ -413,6 +437,7 @@ int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
>  	epf_bar[bar].addr = NULL;
>  	epf_bar[bar].size = bar_size;
>  	epf_bar[bar].mem_size = aligned_mem_size;
> +	epf_bar[bar].alloc_offset = 0;
>  	epf_bar[bar].barno = bar;
>  	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
>  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 8a6c64a35890..749c6611d7b9 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -131,8 +131,10 @@ struct pci_epf_bar_submap {
>   * @phys_addr: physical address that should be mapped to the BAR
>   * @addr: virtual address corresponding to the @phys_addr
>   * @size: the size of the address space present in BAR
> - * @mem_size: the size actually allocated to accommodate the iATU alignment
> - *            requirement
> + * @mem_size: size of the coherent allocation, including alignment padding, or
> + *            the required aligned backing size for assigned BAR space
> + * @alloc_offset: offset from the coherent allocation's CPU and DMA base
> + *                addresses to @addr and @phys_addr
>   * @barno: BAR number
>   * @flags: flags that are set for the BAR
>   * @num_submap: number of entries in @submap
> @@ -144,6 +146,7 @@ struct pci_epf_bar {
>  	void		*addr;
>  	size_t		size;
>  	size_t		mem_size;
> +	size_t		alloc_offset;
>  	enum pci_barno	barno;
>  	int		flags;
>
>
> base-commit: 0a6f72eda328c773324555491e1ad7f0b0153155
> --
> 2.51.0
>
