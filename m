Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752367AbdCPTpC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Mar 2017 15:45:02 -0400
Date: Thu, 16 Mar 2017 14:44:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI: dwc: uninitialized variable in dw_handle_msi_irq()
Message-ID: <20170316194457.GB9739@bhelgaas-glaptop.roam.corp.google.com>
References: <20170217232618.GC26717@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217232618.GC26717@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 18, 2017 at 02:26:18AM +0300, Dan Carpenter wrote:
> The bug is that "val" is unsigned long but we only initialize 32 bits
> of it.  Then we test "if (val)" and that might be true not because we
> set the bits but because some were never initialized.
> 
> Fixes: f342d940ee0e ("PCI: exynos: Add support for MSI")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I applied this to pci/host-designware for v4.12.

I also applied the patch below based on walter's suggestion:


commit b67d3c69df8d6721f87bbc22a587914e0d4944a7
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Mar 16 14:34:59 2017 -0500

    PCI: dwc: Unindent dw_handle_msi_irq() loop
    
    Use "continue" to skip rest of the loop when possible to save an indent
    level.  No functional change intended.
    
    Suggested-by: walter harms <wharms@bfs.de>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 5ba334938b52..6cdd41f06dea 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -63,17 +63,17 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 	for (i = 0; i < MAX_MSI_CTRLS; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
 				    (u32 *)&val);
-		if (val) {
-			ret = IRQ_HANDLED;
-			pos = 0;
-			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
-				irq = irq_find_mapping(pp->irq_domain,
-						       i * 32 + pos);
-				dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
-						    i * 12, 4, 1 << pos);
-				generic_handle_irq(irq);
-				pos++;
-			}
+		if (!val)
+			continue;
+
+		ret = IRQ_HANDLED;
+		pos = 0;
+		while ((pos = find_next_bit(&val, 32, pos)) != 32) {
+			irq = irq_find_mapping(pp->irq_domain, i * 32 + pos);
+			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12,
+					    4, 1 << pos);
+			generic_handle_irq(irq);
+			pos++;
 		}
 	}
 

> ---
> Static analysis.  Not tested.
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> index af8f6e92e885..5bfc377b83e4 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -257,17 +257,18 @@ static struct irq_chip dw_msi_irq_chip = {
>  /* MSI int handler */
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
> -	unsigned long val;
> +	u32 val;
>  	int i, pos, irq;
>  	irqreturn_t ret = IRQ_NONE;
>  
>  	for (i = 0; i < MAX_MSI_CTRLS; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
> -				(u32 *)&val);
> +				    &val);
>  		if (val) {
>  			ret = IRQ_HANDLED;
>  			pos = 0;
> -			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
> +			while ((pos = find_next_bit((unsigned long *)&val, 32,
> +						    pos)) != 32) {
>  				irq = irq_find_mapping(pp->irq_domain,
>  						i * 32 + pos);
>  				dw_pcie_wr_own_conf(pp,
