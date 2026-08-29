Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021082.outbound.protection.outlook.com [40.107.74.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D19348C52;
	Sat, 29 Aug 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020557; cv=fail; b=FJPad7R8+am7TRe5bFBpzv7F04nlQ7XJrBN5livw5nUJme4GoQx0tw6I9J6A+Km/rNXU9u+h6TW5xlDJEHZMGDh2drK6VedVUFljtZzCpKCf1QVz1c6nyupekrbAdm/NwIUXRBfQteARsJjp3ytX1+dJjIM6vC1fbOmbXwSA/Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020557; c=relaxed/simple;
	bh=kQEUlfPU6o72hro6t3lI/glYfy6TYS8Y1q4vpz0DA38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZK252KvgzU5QzEZ1rT68juHH60HUjczZBl0vy6PUAO7pouZrw2oQl2VAfxQzMkRHZtg3oSJsry6/zCPgkocEPgeHpb30hp5y0dT6ueQ+0iZi8MucUyoT92sGmZkcnOEpihE8TMrIEH9dMNntBCJoqEI9nojQL5sp6aeLh6pi3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gSMlJkZH; arc=fail smtp.client-ip=40.107.74.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gSMlJkZH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHazHSU5N8Qcuu2OPruIdvQvHKL7ADACSrKMgptxUWxlgDqFu7bQY0ZiELGtYZTzZU7JoO+hoWRDLoRy9Kask0vC7hVOjyhCS/nb4gGSZjFSM2HcRIUfrjanrbtJxoQOj8vJSA2yRB/nGtLyymaV20fQWD8FNxHs8D8aHa/jn+/TF5tbsElzbTKVOEsUG++zg1678RuF5PIXv/ejdK/+N9onsE0/9JYv6+6h6dJeSFleI+AgWn/NUJU6XIHMnxnd+Cj1Ox5bKvNRccyv4LadgB3dIx6zE/D9xfB1400Q8d5xm9tnJ/b1Pvk6N7GZVh0uu87lSen66+hqWUO+ZrEdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ibd00Xy0vx00jyVjQpswiKmaQeHolhb3L27BBxS5ip0=;
 b=ZIy8Ot/hfuLkcBci5txKgDCB8bw6muj87roK0i/si+5XBsB5ToxmLRImOT3O/0UHhPKSoTvehIlZbd8lc5LqOZlRlMawkrnlH9Flf4bVTBMWmqJWbOkag4LwWiwqhJUzLrcYXEcJtNJBSAYAV4olv8MnAs/2KgNGaAEvt1Xidueex2XV77dXJAx+7dcv/cdqkE5oI5TdshEWrT3YRoJpHKo7h/1ItCl3Qjq8i3FvEAbHv0mbw2UeM4IcRrQNQ9gio3veEF34GiVNASJ2dPg/Y392lDY1gmhClWLmpWUfnz55nvIUGVL3uclCCA2WA7Mc8sQ+WlLBpXIHsJmipe28nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ibd00Xy0vx00jyVjQpswiKmaQeHolhb3L27BBxS5ip0=;
 b=gSMlJkZH5cNscyTNNUgbvE53XGfLSojvw6f+oiC+88z3w04QaZiCiOT2MgjG7WqYhuw7T1g1KNfoMS5FgY80X4bnp2Ztx+HCLXiPdNrB11yb/Vt6vNyGtMqw7YYdfahVq+7zaieGK6FUwV1MsYQOpduOdkXDVPvtYmMbaXxDKuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7887.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 16:22:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 16:22:31 +0000
Date: Sun, 30 Aug 2026 01:22:29 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix BAR backing DMA address alignment
Message-ID: <nvgnu3enktslxuiv7kdapcotoaxlfqhivar4jbf2tqvrk4otz5@exapzemrq37q>
References: <20260827181757.1984374-1-den@valinux.co.jp>
 <apIAMJ98XJDsfjT6@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apIAMJ98XJDsfjT6@SMW015318>
X-ClientProxiedBy: TYCP286CA0355.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: c508ca3f-5bdd-40e4-a329-08df05e9b995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|23010399003|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BETp070lKVUPadu62+3KJBxU8M4awxNGr3KWkk8vCgoeTTSTe9G7egLvP/A77KAPGavzTi5c21Y2J6O3gLTX3n8YcIojvKB5yqqNMnTWMS51yFMvP+TlOKUOcaTceaBy3pXkEvcesUJUtMb4o0yX9cHqopJnYS21eNWSjjhGQzaSerftlmdWipKphU+vvbp067gGX4BG0mWPCLMGm42WIJSFA4JvXnEDu5V4DVpyVcFDZe+OKBKwK/MEnmysV3BT5uEPrHkHLsGhgcg5DRcZa9Ja76P6R6Xb5rKeN/2ANh6S6cOZTX6SJfzSF7kzzu2P/YuveFJty+j7Qg0eMgS4MV/G4HVE6TRoAup4HgTjyFoaW4gbRiTbyCX0w6s00/eMkcD9qMVRI/gE9ZAY5LnA4s175+KZ5o+cqfd73Lc4lajKNK31I19p/NqGYcsl2VTHPitFOEuRYBghtNpZ6+8T5I+IER5gsT0enh96s8+qayEMrwSeuZKU9Q1Y29a+xUXPhMAN9WwQAdZrKrs9eEji8azQwCBZI88zqf7uuC6O7FVuM0Kjc+MQpxCUt9Y/i453IQIPJbZx+mWT5ZcdYwXL2dQ+Rx55B5E3COnQXCkEbUMLHg4oYf8um9zEbY08zJwc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(23010399003)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OkoMF3Zvda0v/d3rYaEbmAOehSS069dVMvi5MJEBTl19FsS7O/kC+HdCSyhF?=
 =?us-ascii?Q?Xoo+s4hnmTnyh+yaCRnAb0AZSiNEWzyQmz1ilBpoDPhkdsO0aiZpwidyeKeS?=
 =?us-ascii?Q?h/7nuWc2P2MxApheS5AnSWe8/+L/vy0P2XrStcqbDpCjz+RFRAuO0sghjPjW?=
 =?us-ascii?Q?b8Paprem0aw3gjvZkfPF7EiMGi3vNWYMek6qqcZVoS25VE58iXeF6kHgD2sM?=
 =?us-ascii?Q?PTAFcn2wgQNZVvCom215X40xy5t0ct/FHA0LuzAEi3ExuHUgTh+zCQrOwSvE?=
 =?us-ascii?Q?qA+TmetJX6RKlpwcpVDwRHV5eGCRqFAU4xXeZf9ayNzmtMGq+0GfOUUQ3VXV?=
 =?us-ascii?Q?6wP85m8ClcwUjUktgzzWx2mat34evVHwgwByw1lvfys9E7nxloj+tLz+bRtR?=
 =?us-ascii?Q?iqDsUHHODDBH6A6A8CIFeQHhEB13xAtOJ7qpdbnHGId/8tQnW1g/285hbsbV?=
 =?us-ascii?Q?J+zOTE/ifnoYig/6tPNHgltT/SFAeMOEOx0biWS0T0oW88e0IqHt1hoa6lRY?=
 =?us-ascii?Q?mUw+4n6rmCQ21ofHFUWSy7i8Ai3MJy7YAe0uqpcL5lcsjR7/7IG6fDGOhL1k?=
 =?us-ascii?Q?iHs/rCyj9UthJef90zuxFihpBip8h30mNUSontG7tRyMOOsclfoWL8vEAa9A?=
 =?us-ascii?Q?O2Ti5F9EOwd7GOKztSq+pv0G0HSqW+0jpAew6ddirZf9pOA5IxBje830MD1z?=
 =?us-ascii?Q?xydvyE/7EbGJta0DHAXIcH86IkZVNzhUeuSg4VQspO+NVPmviRrB2+aPXtg8?=
 =?us-ascii?Q?zlq3GmA+9AaFvRx5jPZ4axZ97ljYF1N6+TQBNzVey8mJyWsGPl3Pw1LeJSq9?=
 =?us-ascii?Q?VpmelqgkCTOHOJ6ZrEM9HkdGXt4c4m8E0rNHdRBcBLZtc7VPw5lQ9efguk0p?=
 =?us-ascii?Q?0Bl9vqbEqwieSbeJwwq6RMRLcMBUP4T6oeoVpFX67VOpi3O8woyoVyi+oCIv?=
 =?us-ascii?Q?6EiQ+2BW+aaUeQ8CJIs/y9dLCqN+uXl2+sS3gmrJLDgrWSZIyyXW9A6HYhO0?=
 =?us-ascii?Q?YQrbtWiXm5HE3SkTDVfVgp7egT2VPu00YkY+6ZqaD2hn9/RwosZcLqLZ1IGi?=
 =?us-ascii?Q?CaqbdBOpfEsF/6gHt0KJdGZqrrZ83DW/flmNQa6FzyG501CjZOfD7bQ6Ze5v?=
 =?us-ascii?Q?PwyaegaS4RlLVEdocXpSgCN0r43+spkTgIL4r/Tqn+2rwYvve6XT/l/qVJm7?=
 =?us-ascii?Q?Uh9MllDMaKCDRskSGJU5uvKmKuQM61EVLAKs6IssOEbGmp/NL47qw3fb3tsN?=
 =?us-ascii?Q?pkwAMLymydmawoOlZBbFNbpSFT/QAKI21UfzvOYpbmlFEhEDFiGCiTQf0wgk?=
 =?us-ascii?Q?eVqf7TwmWa7vkXlwxcce6GyzoFDKaiHXQSm8k4wC+0ZQZiOdyYh7z+dT1ZF3?=
 =?us-ascii?Q?cKM+Xt+LRNkgTK/zaJLkjzhOjTRdORYwucWF//xaaQKbnn+eAYOJlwgaonql?=
 =?us-ascii?Q?B4gPscfrvf3R99qbuytm7iol6AyOl8NHZNVzUNhncS+lSSnW6rdovxN2qb1I?=
 =?us-ascii?Q?ZRb8pjpSngfZrcwArzveDiykFXR9auki66ykTO7HMLHDO1akiMig9/dtAaVA?=
 =?us-ascii?Q?RvjmcjquaySgOZpXckaTHQ0aPmNCM4yK3YAf7/Mm5ZnPZXBnxTRhR8HAUgAa?=
 =?us-ascii?Q?kcMXnLgUJWd2MwNV/7JIvZXg/LGAa03SlrLZq9t1f/MaOajfcVjDft9danVc?=
 =?us-ascii?Q?9d/iDImPkxktX8IHOLrucEp19rQYCTsD54XXWTl2+qipSYWqNvhzzBkjvRIe?=
 =?us-ascii?Q?i+FVgZirFj2GGz0DUVTPepbTiIcCpEl9AAFEvzhxvw2yoNMfJm1d?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c508ca3f-5bdd-40e4-a329-08df05e9b995
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 16:22:30.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PAkvlryrF4fLxFfmNJIlo6DIQL5hetp4G7FdlvpnRxgTX5XVnyCZ8JDX1JTZjYpPJtfLRMh13+Q++kmlWazAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7887

On Fri, Aug 28, 2026 at 04:40:00PM -0500, Frank Li wrote:
> On Fri, Aug 28, 2026 at 03:17:57AM +0900, Koichiro Den wrote:
> > DWC BAR Match Mode requires the target address to be aligned to the BAR
> > size. pci_epf_alloc_space() relies on dma_alloc_coherent() to provide
> > that alignment. For CMA-backed allocations, the guaranteed physical
> > alignment is capped at PAGE_SIZE << CONFIG_CMA_ALIGNMENT. With a direct
> > DMA mapping, 4 KiB pages, and CONFIG_CMA_ALIGNMENT=8, a 2 MiB BAR may
> > therefore receive a DMA address aligned to only 1 MiB.
> > dw_pcie_prog_ep_inbound_atu() rejects such a mapping with -EINVAL.
> >
> > If the initial allocation is misaligned, free it and retry with
> > mem_size - 1 bytes of padding. Select an aligned subrange and record its
> > offset so pci_epf_free_space() can pass the original CPU address, DMA
> > handle, and size to dma_free_coherent().
> 
> I understand this situation, but it mays waste memory, if 16MiB, it max
> waste 16M-1 space.
> 
> As workaround, this is good enough.
> 
> add dt memory node for pcie-ep
> 
> my_dma_pool: dma@42000000 {
>     compatible = "shared-dma-pool";
>     reg = <0x42000000 0x02000000>;
>     reusable;          /* <-- CMA: system CAN use these pages when idle */
> };
> 
> pcie-ep {
> 	...
> 	memory-region = <&my_dma_pool>;
> }
> 
> but if use "reusable", still meet CONFIG_CMA_ALIGNMENT. if use "no-map",
> dma_alloc_from_dev_coherent() will bypass CONFIG_CMA_ALIGNMENT. but it will
> waste memory if not use pcie-ep devices.
> 
> Maybe we try
> 
>  static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
>  {
>      ...
>      ret = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
>      if (ret) { ... }
> 
> +    /* linux,cma-force-align: bypass CONFIG_CMA_ALIGNMENT cap, align = get_order(size) */
> +    if (of_get_flat_dt_prop(node, "linux,cma-force-align", NULL))
> +        cma->force_align = true;
> 
>      if (default_cma)
>          dma_contiguous_default_area = cma;
>      ...
>  }
> 
> 
>  static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
>  {
> -    unsigned int align = min(get_order(size), CONFIG_CMA_ALIGNMENT);
> +    unsigned int align;
> +
> +    if (cma && cma->force_align)
> +        align = get_order(size);    /* no cap: align = natural power-of-2 for size */
> +    else
> +        align = min(get_order(size), CONFIG_CMA_ALIGNMENT);
> 
>      return cma_alloc(cma, size >> PAGE_SHIFT, align, gfp & __GFP_NOWARN);
>  }
> 
> I am not sure if DT team accept add "linux,cma-force-align", which desgin
> for specic device CMA region only, not for default cmd. No impact to other
> system.

Thanks for the suggestion. I think I should withdraw this patch for now. After
taking another look at my use case, I realized that it does not actually require
a large contiguous allocation, so this patch lacks sufficient justification. I
should have noticed it before sending this patch.

My use case was [1]. When usable BARs are scarce, DMA resources may need to
share a Memory Window (MW) BAR. Appending them after a 1 MiB MW makes the
requested range larger than 1 MiB, so pci_epf_alloc_space() rounds the BAR size
and backing allocation up to 2 MiB.

However, this layout does not actually need a contiguous 2 MiB backing
allocation. I believe this can be handled in vNTB instead of adding a generic
retry to pci_epf_alloc_space(). I plan to fold the fix into the next version of
[1].

I do not currently know of another concrete case that legitimately requires a
large, contiguously backed BAR and would justify a generic pci_epf_alloc_space()
workaround for the CMA alignment cap.

...

That said, if such a case comes up on a particular board, your per-pool approach
may be preferable to the generic over-allocation fallback. A dedicated reusable
CMA area would still have to be sized for all allocations that may coexist, I
suppose. On a system with limited RAM, choosing its size may be difficult
because enough memory must remain outside CMA for unmovable allocations. For a
board-specific kernel, raising CONFIG_CMA_ALIGNMENT may be another option,
although it is global and capped at order 12.

[1] https://lore.kernel.org/r/20260828170932.2735807-1-den@valinux.co.jp/

Best regards,
Koichiro

> 
> Frank
> 
> >
> > Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 39 +++++++++++++++++++++++------
> >  include/linux/pci-epf.h             |  7 ++++--
> >  2 files changed, 37 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 6987343c9e61..e8c3709d85c4 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/device.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/overflow.h>
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> >
> > @@ -278,13 +279,15 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> >  	}
> >
> >  	dev = epc->dev.parent;
> > -	dma_free_coherent(dev, epf_bar[bar].mem_size, addr,
> > -			  epf_bar[bar].phys_addr);
> > +	dma_free_coherent(dev, epf_bar[bar].mem_size,
> > +			  (u8 *)addr - epf_bar[bar].alloc_offset,
> > +			  epf_bar[bar].phys_addr - epf_bar[bar].alloc_offset);
> >
> >  	epf_bar[bar].phys_addr = 0;
> >  	epf_bar[bar].addr = NULL;
> >  	epf_bar[bar].size = 0;
> >  	epf_bar[bar].mem_size = 0;
> > +	epf_bar[bar].alloc_offset = 0;
> >  	epf_bar[bar].barno = 0;
> >  	epf_bar[bar].flags = 0;
> >  }
> > @@ -308,8 +311,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >  {
> >  	struct pci_epf_bar *epf_bar;
> >  	dma_addr_t phys_addr;
> > +	size_t alloc_offset = 0;
> >  	struct pci_epc *epc;
> >  	struct device *dev;
> > +	size_t alloc_size;
> >  	size_t mem_size;
> >  	void *space;
> >
> > @@ -326,16 +331,31 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >  	}
> >
> >  	dev = epc->dev.parent;
> > -	space = dma_alloc_coherent(dev, mem_size, &phys_addr, GFP_KERNEL);
> > -	if (!space) {
> > -		dev_err(dev, "failed to allocate mem space\n");
> > -		return NULL;
> > +	alloc_size = mem_size;
> > +	space = dma_alloc_coherent(dev, alloc_size, &phys_addr, GFP_KERNEL);
> > +	if (!space)
> > +		goto err_alloc;
> > +	if (!IS_ALIGNED(phys_addr, mem_size)) {
> > +		dma_free_coherent(dev, alloc_size, space, phys_addr);
> > +
> > +		if (check_add_overflow(mem_size, mem_size - 1, &alloc_size))
> > +			return NULL;
> > +
> > +		space = dma_alloc_coherent(dev, alloc_size, &phys_addr,
> > +					   GFP_KERNEL);
> > +		if (!space)
> > +			goto err_alloc;
> > +
> > +		alloc_offset = ALIGN(phys_addr, mem_size) - phys_addr;
> > +		space = (u8 *)space + alloc_offset;
> > +		phys_addr += alloc_offset;
> >  	}
> >
> >  	epf_bar[bar].phys_addr = phys_addr;
> >  	epf_bar[bar].addr = space;
> >  	epf_bar[bar].size = size;
> > -	epf_bar[bar].mem_size = mem_size;
> > +	epf_bar[bar].mem_size = alloc_size;
> > +	epf_bar[bar].alloc_offset = alloc_offset;
> >  	epf_bar[bar].barno = bar;
> >  	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
> >  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> > @@ -343,6 +363,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
> >
> >  	return space;
> > +
> > +err_alloc:
> > +	dev_err(dev, "failed to allocate mem space\n");
> > +	return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
> >
> > @@ -413,6 +437,7 @@ int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
> >  	epf_bar[bar].addr = NULL;
> >  	epf_bar[bar].size = bar_size;
> >  	epf_bar[bar].mem_size = aligned_mem_size;
> > +	epf_bar[bar].alloc_offset = 0;
> >  	epf_bar[bar].barno = bar;
> >  	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
> >  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 8a6c64a35890..749c6611d7b9 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -131,8 +131,10 @@ struct pci_epf_bar_submap {
> >   * @phys_addr: physical address that should be mapped to the BAR
> >   * @addr: virtual address corresponding to the @phys_addr
> >   * @size: the size of the address space present in BAR
> > - * @mem_size: the size actually allocated to accommodate the iATU alignment
> > - *            requirement
> > + * @mem_size: size of the coherent allocation, including alignment padding, or
> > + *            the required aligned backing size for assigned BAR space
> > + * @alloc_offset: offset from the coherent allocation's CPU and DMA base
> > + *                addresses to @addr and @phys_addr
> >   * @barno: BAR number
> >   * @flags: flags that are set for the BAR
> >   * @num_submap: number of entries in @submap
> > @@ -144,6 +146,7 @@ struct pci_epf_bar {
> >  	void		*addr;
> >  	size_t		size;
> >  	size_t		mem_size;
> > +	size_t		alloc_offset;
> >  	enum pci_barno	barno;
> >  	int		flags;
> >
> >
> > base-commit: 0a6f72eda328c773324555491e1ad7f0b0153155
> > --
> > 2.51.0
> >
