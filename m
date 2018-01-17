Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:39379 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbeAQNJF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 08:09:05 -0500
Subject: Re: [PATCH v4 01/10] PCI: dwc: Add IRQ chained API support
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <marc.zyngier@arm.com>, <Joao.Pinto@synopsys.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>
References: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
 <62de81d0e161294e7b9df64b079ba6644a384c32.1514524551.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <m-karicheri2@ti.com>,
        <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <svarbanov@mm-sol.com>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <e9c49d7e-235d-3f59-bbc5-be84210b0824@ti.com>
Date: Wed, 17 Jan 2018 18:38:23 +0530
MIME-Version: 1.0
In-Reply-To: <62de81d0e161294e7b9df64b079ba6644a384c32.1514524551.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On Friday 29 December 2017 07:51 PM, Gustavo Pimentel wrote:
> Adds a IRQ chained API to pcie-designware, that aims to replace the current
> IRQ domain hierarchy API implemented.
> 
> Although the IRQ domain hierarchy API is still available, pcie-designware
> will use now the IRQ chained API.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
> - num_vectors is now not configurable by the Device Tree. Now it is 32 by
> default and can be overridden by any specific SoC driver.
> Change v2->v3:
> - Nothing changed, just to follow the patch set version.
> Change v3->v4:
> - Moved Kishon's fixes (PCI end point error and a dra7xx warning) from
> v3-0007 patch file to here.
> - Undo the change of the function signature to be more coherent with the
> host mode specific functions (Thanks Kishon).
> - Refactor the added functions in order to used host_data so that getting
> pp again back from pci could be avoided. (Thanks Kishon)
> - Changed summary line to match the drivers/PCI convention and changelog to
> maintain the consistency (thanks Bjorn).
> 
>  drivers/pci/dwc/pcie-designware-host.c | 291 +++++++++++++++++++++++++++++----
>  drivers/pci/dwc/pcie-designware.h      |  18 ++
>  2 files changed, 281 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index bf558df..631d665 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -11,6 +11,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -53,6 +54,42 @@ static struct irq_chip dw_msi_irq_chip = {
>  	.irq_unmask = pci_msi_unmask_irq,
>  };
>  
> +static void dw_pci_ack_irq(struct irq_data *d)
> +{
> +	struct msi_desc *msi = irq_data_get_msi_desc(d);
> +	struct pcie_port *pp;
> +
> +	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
> +
> +	if (pp->ops->msi_irq_ack)
> +		pp->ops->msi_irq_ack(d->irq, pp);

just like below pass hwirq here..

Thanks
Kishon
