Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933625AbcIFP5o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 11:57:44 -0400
Date: Tue, 6 Sep 2016 10:57:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Vineet.Gupta1@synopsys.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH] pci: adding support for PCI_MSI_IRQ_DOMAIN in ARC arch
Message-ID: <20160906155739.GD1214@localhost>
References: <fdd37b0b995d178fddb34fdbdb5daf5981822f52.1470757628.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fdd37b0b995d178fddb34fdbdb5daf5981822f52.1470757628.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 09, 2016 at 04:49:37PM +0100, Joao Pinto wrote:
> To fix this, this patch adds ARC as a PCI_MSI_IRQ_DOMAIN supportive
> platform and adds the generation of msi.h in the ARC arch.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>

I added Vineet's ack and put this on pci/msi for v4.9, thanks!

> ---
>  arch/arc/include/asm/Kbuild | 1 +
>  drivers/pci/Kconfig         | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
> index 0b10ef2..c332604 100644
> --- a/arch/arc/include/asm/Kbuild
> +++ b/arch/arc/include/asm/Kbuild
> @@ -25,6 +25,7 @@ generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mman.h
>  generic-y += msgbuf.h
> +generic-y += msi.h
>  generic-y += param.h
>  generic-y += parport.h
>  generic-y += pci.h
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 67f9916..6555eb7 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -25,7 +25,7 @@ config PCI_MSI
>  	   If you don't know what to do here, say Y.
>  
>  config PCI_MSI_IRQ_DOMAIN
> -	def_bool ARM || ARM64 || X86
> +	def_bool ARC || ARM || ARM64 || X86
>  	depends on PCI_MSI
>  	select GENERIC_MSI_IRQ_DOMAIN
>  
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
