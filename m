Return-Path: <SRS0=A2IS=PN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC86C43387
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 00:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D74208E3
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 00:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfAEAcW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:32:22 -0500
Received: from dliviu.plus.com ([80.229.23.120]:58940 "EHLO smtp.dudau.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfAEAcV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 19:32:21 -0500
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 31F1E40F840A;
        Sat,  5 Jan 2019 00:32:19 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Sat, 05 Jan 2019 00:32:19 +0000
Date:   Sat, 5 Jan 2019 00:32:19 +0000
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION, BISECTED] pci: nvme device with HMB fails on arm64
Message-ID: <20190105003218.GG20342@bart.dudau.co.uk>
References: <20190104125735.GF20342@bart.dudau.co.uk>
 <20190104173446.GA24554@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190104173446.GA24554@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 04, 2019 at 06:34:47PM +0100, Christoph Hellwig wrote:
> Hi Liviu,

Hi Christoph,

> 
> please try the patch below.  Note that this is in top of mainline,
> as the commit you found already needed another fixup, which has
> made it to Linus already.

This patch does fix the issue with NVMe HMBs. You can add my:

Tested-by: Liviu Dudau <liviu@dudau.co.uk>

Now I need to go and try to figure out why the rk_gmac-dwmac driver gives this warning:

[   11.277363] ------------[ cut here ]------------
[   11.277800] DMA-API: rk_gmac-dwmac fe300000.ethernet: device driver frees DMA memory with wrong function [device address=0x00000000e7c21c02] [size=342 bytes] [mapped as page] [unmapped as single]
[   11.279348] WARNING: CPU: 0 PID: 0 at kernel/dma/debug.c:1085 check_unmap+0x720/0x840
[   11.280037] Modules linked in: pcie_rockchip_host phy_rockchip_pcie rockchip realtek dwmac_rk stmmac_platform stmmac
[   11.280989] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-10990-gda3599602d2f-dirty #1
[   11.281708] Hardware name: FriendlyARM NanoPC-T4 (DT)
[   11.282162] pstate: 80000085 (Nzcv daIf -PAN -UAO)
[   11.282592] pc : check_unmap+0x720/0x840
[   11.282947] lr : check_unmap+0x720/0x840
[   11.283299] sp : ffff000010003b90
[   11.283597] x29: ffff000010003b90 x28: ffff8000e7d74800
[   11.284075] x27: ffff8000f66fe410 x26: ffff000010f33370
[   11.284551] x25: 0000000000000000 x24: ffff0000111163d0
[   11.285027] x23: ffff000010f33000 x22: ffff000010f0d818
[   11.285504] x21: ffff000010003c48 x20: ffff00001110dd80
[   11.285981] x19: ffff8000f6657090 x18: 0000000000000010
[   11.286457] x17: 0000000000000001 x16: 0000000000000007
[   11.286933] x15: ffffffffffffffff x14: 5d32306331326337
[   11.287409] x13: 6530303030303030 x12: 3078303d73736572
[   11.287886] x11: 6464612065636976 x10: 65645b206e6f6974
[   11.288363] x9 : 636e756620676e6f x8 : 2073612064657070
[   11.288840] x7 : 616d6e755b205d65 x6 : 00000000000001d4
[   11.289316] x5 : 0000000000000001 x4 : 00008000e685f000
[   11.289793] x3 : ffff8000f774deb8 x2 : 0000000000000007
[   11.290269] x1 : d5f5206026126100 x0 : 0000000000000000
[   11.290746] Call trace:
[   11.290974]  check_unmap+0x720/0x840
[   11.291301]  debug_dma_unmap_page+0xc4/0xd0
[   11.291719]  stmmac_napi_poll+0x214/0x1088 [stmmac]
[   11.292160]  net_rx_action+0x12c/0x3d0
[   11.292502]  __do_softirq+0x1a0/0x438
[   11.292835]  irq_exit+0xcc/0xe0
[   11.293124]  __handle_domain_irq+0x9c/0x108
[   11.293500]  gic_handle_irq+0xb8/0x15c
[   11.293839]  el1_irq+0xb4/0x130
[   11.294127]  cpuidle_enter_state+0xbc/0x508
[   11.294504]  cpuidle_enter+0x34/0x48
[   11.294830]  call_cpuidle+0x44/0x68
[   11.295148]  do_idle+0x264/0x2a0
[   11.295445]  cpu_startup_entry+0x28/0x30
[   11.295802]  rest_init+0xd4/0xe0
[   11.296101]  arch_call_rest_init+0x14/0x1c
[   11.296471]  start_kernel+0x48c/0x4b4
[   11.296800] ---[ end trace c63a0054785f45a3 ]---
[   11.297213] DMA-API: Mapped at:
[   11.297531]  stmmac_xmit+0x4b8/0x1168 [stmmac]
[   11.297934]  dev_hard_start_xmit+0xac/0x290
[   11.298313]  sch_direct_xmit+0x120/0x330
[   11.298667]  __qdisc_run+0x140/0x6e8
[   11.298994]  __dev_queue_xmit+0x48c/0x718


I've seen you have provided some other net driver reporter with a patch to make dma_map_single_attrs use
dma_map_page_attrs, which I have applied, but that doesn't remove the WARN() for me.


Many thanks,

Liviu

> 
> --
> From a959cc1a8ee00dcb274922f9d74f6ed632709047 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 4 Jan 2019 18:31:48 +0100
> Subject: dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING for remapped allocations
> 
> We need to return a dma_addr_t even if we don't have a kernel mapping.
> Do so by consolidating the phys_to_dma call in a single place and jump
> to it from all the branches that return successfully.
> 
> Fixes: bfd56cd60521 ("dma-mapping: support highmem in the generic remap allocator")
> Reported-by: Liviu Dudau <liviu@dudau.co.uk
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/remap.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index 18cc09fc27b9..7a723194ecbe 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -204,8 +204,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		ret = dma_alloc_from_pool(size, &page, flags);
>  		if (!ret)
>  			return NULL;
> -		*dma_handle = phys_to_dma(dev, page_to_phys(page));
> -		return ret;
> +		goto done;
>  	}
>  
>  	page = __dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> @@ -215,8 +214,10 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	/* remove any dirty cache lines on the kernel alias */
>  	arch_dma_prep_coherent(page, size);
>  
> -	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> -		return page; /* opaque cookie */
> +	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
> +		ret = page; /* opaque cookie */
> +		goto done;
> +	}
>  
>  	/* create a coherent mapping */
>  	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
> @@ -227,9 +228,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		return ret;
>  	}
>  
> -	*dma_handle = phys_to_dma(dev, page_to_phys(page));
>  	memset(ret, 0, size);
> -
> +done:
> +	*dma_handle = phys_to_dma(dev, page_to_phys(page));
>  	return ret;
>  }
>  
> -- 
> 2.20.1
> 

-- 
           ________________________________________________________
  ________|                                                        |_______
  \       |  With enough courage, you can do without a reputation  |      /
   \      |                                  -- Rhett Butler       |     /
   /      |________________________________________________________|     \
  /__________)                                                  (_________\
