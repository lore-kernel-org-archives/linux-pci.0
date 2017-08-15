Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751460AbdHOVw3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Aug 2017 17:52:29 -0400
Date: Tue, 15 Aug 2017 16:52:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] PCI: dra7xx: Use PCI_NUM_INTX
Message-ID: <20170815215225.GP32525@bhelgaas-glaptop.roam.corp.google.com>
References: <20170815213838.8231.59214.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170815213838.8231.59214.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 15, 2017 at 04:38:38PM -0500, Bjorn Helgaas wrote:
> Use the PCI_NUM_INTX macro to indicate the number of PCI INTx interrupts
> rather than the magic number 4. This makes it clearer where the number
> comes from & what it relates to.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index f2fc5f47064e..30131ecaadea 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -238,7 +238,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
>  		return -ENODEV;
>  	}
>  
> -	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
> +	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
>  						   &intx_domain_ops, pp);
>  	if (!dra7xx->irq_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> 

Oops.  I think this patch is OK as far as it goes, but Kishon
confirmed [1] that INTD was broken in dra7xx, and AFAIK it's still
broken, so maybe we need to also use pci_irqd_intx_xlate() as in the
following?

[1] https://lkml.org/lkml/2016/9/14/241



commit 569f29aa4ff0ab4bd4d1782b3a806a7561fe9db5
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Aug 15 16:28:27 2017 -0500

    PCI: dra7xx: Translate INTx range to hwirqs 0-3
    
    The pci-dra7xx driver creates an IRQ domain of size 4 for legacy PCI INTx
    interrupts, which at first glance seems reasonable since there are 4 possible
    such interrupts. Unfortunately the driver then proceeds to use the range 1-4
    as the hwirq numbers for INTA-INTD, causing warnings & broken interrupts when
    attempting to use INTD/hwirq=4 due to it being beyond the range of the IRQ
    domain:
    
      WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:342 irq_domain_associate+0x12c/0x1c4
      error: hwirq 0x4 is too large for dummy
      Modules linked in:
      CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc6-01351-gd4fcf3d-dirty #15
      Hardware name: Generic DRA72X (Flattened Device Tree)
        (unwind_backtrace) from [<c010c264>] (show_stack+0x10/0x14)
        (show_stack) from [<c048f3ec>] (dump_stack+0xac/0xe0)
        (dump_stack) from [<c0138a74>] (__warn+0xd8/0x104)
        (__warn) from [<c0138ad4>] (warn_slowpath_fmt+0x34/0x44)
        (warn_slowpath_fmt) from [<c01a9944>] (irq_domain_associate+0x12c/0x1c4)
        (irq_domain_associate) from [<c01aa158>] (irq_create_mapping+0x64/0xcc)
        (irq_create_mapping) from [<c01aa848>] (irq_create_fwspec_mapping+0xac/0x2fc)
        (irq_create_fwspec_mapping) from [<c01aaaec>] (irq_create_of_mapping+0x54/0x5c)
        (irq_create_of_mapping) from [<c0668b04>] (of_irq_parse_and_map_pci+0x24/0x2c)
        (of_irq_parse_and_map_pci) from [<c04ea578>] (pci_fixup_irqs+0x44/0xb8)
        (pci_fixup_irqs) from [<c04eb8dc>] (dw_pcie_host_init+0x234/0x3e4)
        (dw_pcie_host_init) from [<c0b38fa4>] (dra7xx_pcie_probe+0x418/0x5c4)
        (dra7xx_pcie_probe) from [<c0557260>] (platform_drv_probe+0x4c/0xb0)
    
    Fix this by making use of the new pci_irqd_intx_xlate() helper to translate
    the INTx 1-4 range into the 0-3 range suitable for the IRQ domain of size
    4, and stop adding 1 to the hwirq number decoded from the interrupt FIFO
    which is already in the range 0-3.
    
    Whilst we're here we switch to using PCI_NUM_INTX rather than the magic
    number 4, making it clearer what the 4 means.
    
    Based-on-similar-patches-by: Paul Burton <paul.burton@imgtec.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Kishon Vijay Abraham I <kishon@ti.com>

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index f2fc5f47064e..55f16fcf701d 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -223,6 +223,7 @@ static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 
 static const struct irq_domain_ops intx_domain_ops = {
 	.map = dra7xx_pcie_intx_map,
+	.xlate = pci_irqd_intx_xlate,
 };
 
 static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
@@ -238,7 +239,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 		return -ENODEV;
 	}
 
-	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
+	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 						   &intx_domain_ops, pp);
 	if (!dra7xx->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
