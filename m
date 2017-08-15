Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752203AbdHOVoc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Aug 2017 17:44:32 -0400
Date: Tue, 15 Aug 2017 16:44:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>, linux-pci@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] PCI: keystone: Use PCI_NUM_INTX
Message-ID: <20170815214430.GO32525@bhelgaas-glaptop.roam.corp.google.com>
References: <20170815213724.8111.96859.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170815213724.8111.96859.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 15, 2017 at 04:37:24PM -0500, Bjorn Helgaas wrote:
> Switch from using a custom MAX_LEGACY_IRQS macro to the generic
> PCI_NUM_INTX definition for the number of INTx interrupts.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  drivers/pci/dwc/pci-keystone-dw.c |    4 ++--
>  drivers/pci/dwc/pci-keystone.h    |    1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
> index df60f48716d9..3b0f206590f9 100644
> --- a/drivers/pci/dwc/pci-keystone-dw.c
> +++ b/drivers/pci/dwc/pci-keystone-dw.c
> @@ -251,7 +251,7 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
>  {
>  	int i;
>  
> -	for (i = 0; i < MAX_LEGACY_IRQS; i++)
> +	for (i = 0; i < PCI_NUM_INTX; i++)
>  		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
>  }
>  
> @@ -557,7 +557,7 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
>  	/* Create legacy IRQ domain */
>  	ks_pcie->legacy_irq_domain =
>  			irq_domain_add_linear(ks_pcie->legacy_intc_np,
> -					MAX_LEGACY_IRQS,
> +					PCI_NUM_INTX,
>  					&ks_dw_pcie_legacy_irq_domain_ops,
>  					NULL);
>  	if (!ks_pcie->legacy_irq_domain) {
> diff --git a/drivers/pci/dwc/pci-keystone.h b/drivers/pci/dwc/pci-keystone.h
> index 74c5825882df..69fc60129f45 100644
> --- a/drivers/pci/dwc/pci-keystone.h
> +++ b/drivers/pci/dwc/pci-keystone.h
> @@ -12,7 +12,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#define MAX_LEGACY_IRQS			4
>  #define MAX_MSI_HOST_IRQS		8
>  #define MAX_LEGACY_HOST_IRQS		4

BTW, Murali, what is MAX_LEGACY_HOST_IRQS?  Is that something we can
replace by PCI_NUM_INTX also?

(PCI_NUM_INTX is a new definition in include/linux/pci.h for the
number of INTx interrupts: INTA, INTB, INTC, INTD).
