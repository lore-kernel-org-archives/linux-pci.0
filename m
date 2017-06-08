Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56443 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751393AbdFHSSX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2017 14:18:23 -0400
Message-ID: <1496945880.17240.20.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/9] pci: adding new irq api to pci-designware
From: Lucas Stach <l.stach@pengutronix.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: bhelgaas@google.com, marc.zyngier@arm.com, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org
Date: Thu, 08 Jun 2017 20:18:00 +0200
In-Reply-To: <35ad0ce714dbf613f32d1fd85af78540bdb68d32.1496677911.git.jpinto@synopsys.com>
References: <cover.1496677911.git.jpinto@synopsys.com>
         <35ad0ce714dbf613f32d1fd85af78540bdb68d32.1496677911.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 05.06.2017, 17:19 +0100 schrieb Joao Pinto:
> This patch adds the new interrupt api to pcie-designware, keeping the old
> one. Although the old API is still available, pcie-designware initiates with
> the new one.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
> Change v1->v2:
> - num_vectors is now not configurable by DT. Now it is 32 by default and
> can be overiden by any specific SoC driver.
> 
>  drivers/pci/dwc/pcie-designware-host.c | 291 +++++++++++++++++++++++++++++----
>  drivers/pci/dwc/pcie-designware.h      |  17 ++
>  2 files changed, 277 insertions(+), 31 deletions(-)
> 
[...]
>  static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
> @@ -279,11 +491,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource_entry *win, *tmp;
>  	struct pci_bus *bus, *child;
>  	struct resource *cfg_res;
>  	int i, ret;
> +
>  	LIST_HEAD(res);
> -	struct resource_entry *win, *tmp;
> +
> +	spin_lock_init(&pci->pp.lock);
>  
>  	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>  	if (cfg_res) {
> @@ -377,18 +592,32 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		pci->num_viewport = 2;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		if (!pp->ops->msi_host_init) {
> -			pp->irq_domain = irq_domain_add_linear(dev->of_node,
> -						MAX_MSI_IRQS, &msi_domain_ops,
> -						&dw_pcie_msi_chip);
> -			if (!pp->irq_domain) {
> -				dev_err(dev, "irq domain init failed\n");
> -				ret = -ENXIO;
> +		/*
> +		 * If a specific SoC driver needs to change the
> +		 * default number of vectors, it needs to implement
> +		 * the set_num_vectors callback.
> +		 */
No need for a function to implement this. The implementation glue driver
can just set up pcie_port.num_vectors to the correct number before
calling dw_pcie_host_init.

> +		if (!pp->ops->set_num_vectors) {
> +			pp->num_vectors = MSI_DEF_NUM_VECTORS;
> +		} else {
> +			pp->ops->set_num_vectors(pp);
> +
> +			if (pp->num_vectors > MAX_MSI_IRQS ||
> +			    pp->num_vectors == 0) {
> +				dev_err(dev,
> +					"Invalid number of vectors\n");
>  				goto error;
>  			}
> +		}
>  
> -			for (i = 0; i < MAX_MSI_IRQS; i++)
> -				irq_create_mapping(pp->irq_domain, i);
> +		if (!pp->ops->msi_host_init) {
> +			ret = dw_pcie_allocate_domains(pci);
> +			if (ret)
> +				goto error;
> +
> +			irq_set_chained_handler_and_data(pci->pp.msi_irq,
> +							 dw_chained_msi_isr,
> +							 pci);

So this breaks legacy PCI irqs on DWC platforms even more, as the IRQ
line can not be shared, even if the endpoint device doesn't support
MSIs.

Do we have any solution for that? In the worst case we would need a DT
property to enable MSI support and not register the MSI IRQ domain in
that case.

Regards,
Lucas

>  		} else {
>  			ret = pp->ops->msi_host_init(pp, &dw_pcie_msi_chip);
>  			if (ret < 0)
> @@ -400,14 +629,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		pp->ops->host_init(pp);
>  
>  	pp->root_bus_nr = pp->busn->start;
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -		bus = pci_scan_root_bus_msi(dev, pp->root_bus_nr,
> -					    &dw_pcie_ops, pp, &res,
> -					    &dw_pcie_msi_chip);
> -		dw_pcie_msi_chip.dev = dev;
> -	} else
> -		bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
> -					pp, &res);
> +
> +	bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
> +				pp, &res);
>  	if (!bus) {
>  		ret = -ENOMEM;
>  		goto error;
> @@ -579,11 +803,16 @@ static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
