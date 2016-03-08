Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49681 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbcCHR6b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 12:58:31 -0500
Date: Tue, 8 Mar 2016 11:58:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] unicore32: Remove unused HAVE_ARCH_PCI_SET_DMA_MASK
 definition
Message-ID: <20160308175823.GB21278@localhost>
References: <20160308174238.20498.35018.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160308174238.20498.35018.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 08, 2016 at 11:42:39AM -0600, Bjorn Helgaas wrote:
> HAVE_ARCH_PCI_SET_DMA_MASK is unused, so remove the #define for it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied this to my pci/misc branch for v4.6.

I think it's pretty innocuous, but let me know if you have
any objections, Guan.

> ---
>  arch/unicore32/include/mach/hardware.h |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/unicore32/include/mach/hardware.h b/arch/unicore32/include/mach/hardware.h
> index 9e20b5d..2514623 100644
> --- a/arch/unicore32/include/mach/hardware.h
> +++ b/arch/unicore32/include/mach/hardware.h
> @@ -28,11 +28,6 @@
>  #define PCIBIOS_MIN_IO			0x4000 /* should lower than 64KB */
>  #define PCIBIOS_MIN_MEM			io_v2p(PKUNITY_PCIMEM_BASE)
>  
> -/*
> - * We override the standard dma-mask routines for bouncing.
> - */
> -#define	HAVE_ARCH_PCI_SET_DMA_MASK
> -
>  #define pcibios_assign_all_busses()	1
>  
>  #endif  /* __MACH_PUV3_HARDWARE_H__ */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
