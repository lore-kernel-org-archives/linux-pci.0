Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33618 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbbKEW22 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2015 17:28:28 -0500
Received: by pabfh17 with SMTP id fh17so99887366pab.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2015 14:28:27 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, panto@antoniou-consulting.com,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	grant.likely@linaro.org, robherring2@gmail.com,
	bhelgaas@google.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 04/50] powerpc/powernv: Cleanup on pnv_pci_ioda_controller_ops
In-Reply-To: <1446642770-4681-5-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com> <1446642770-4681-5-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Fri, 06 Nov 2015 09:28:20 +1100
Message-ID: <87vb9ghyij.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> This cleans up on pnv_pci_ioda_controller_ops struct to use tab
> instead of space indent of statement to avoid complains from
> scripts/checkpatch.pl. No logical changes introduced.

Oh, that was my code :/ Sorry I missed that, thanks for cleaning it up!

Reviewed-by: Daniel Axtens <dja@axtens.net>

>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 2e2bedb..aa3645c 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3064,17 +3064,17 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
>  }
>  
>  static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
> -       .dma_dev_setup = pnv_pci_dma_dev_setup,
> +	.dma_dev_setup		= pnv_pci_dma_dev_setup,
>  #ifdef CONFIG_PCI_MSI
> -       .setup_msi_irqs = pnv_setup_msi_irqs,
> -       .teardown_msi_irqs = pnv_teardown_msi_irqs,
> +	.setup_msi_irqs		= pnv_setup_msi_irqs,
> +	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
>  #endif
> -       .enable_device_hook = pnv_pci_enable_device_hook,
> -       .window_alignment = pnv_pci_window_alignment,
> -       .reset_secondary_bus = pnv_pci_reset_secondary_bus,
> -       .dma_set_mask = pnv_pci_ioda_dma_set_mask,
> -       .dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask,
> -       .shutdown = pnv_pci_ioda_shutdown,
> +	.enable_device_hook	= pnv_pci_enable_device_hook,
> +	.window_alignment	= pnv_pci_window_alignment,
> +	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
> +	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
> +	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
> +	.shutdown		= pnv_pci_ioda_shutdown,
>  };
>  
>  static void __init pnv_pci_init_ioda_phb(struct device_node *np,
> -- 
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
