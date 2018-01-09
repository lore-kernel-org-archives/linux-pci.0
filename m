Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:60104 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeAIIx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jan 2018 03:53:57 -0500
Subject: Re: [PATCH v4 08/10] PCI: dwc: keystone: Reuse designware domain
 allocation
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <marc.zyngier@arm.com>, <Joao.Pinto@synopsys.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>
References: <cover.1514524551.git.gustavo.pimentel@synopsys.com>
 <886911bf51e149b1c739a26d514f93f874b2c3e8.1514524551.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <m-karicheri2@ti.com>,
        <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <svarbanov@mm-sol.com>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <16251731-8be3-438c-4907-acf2bea0b0ad@ti.com>
Date: Tue, 9 Jan 2018 14:23:19 +0530
MIME-Version: 1.0
In-Reply-To: <886911bf51e149b1c739a26d514f93f874b2c3e8.1514524551.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 29 December 2017 07:51 PM, Gustavo Pimentel wrote:
> Changes msi_host_init function content in order to reuse designware domain
> allocation.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
> - Didn't exist.
> Change v2->v3:
> - Didn't exist.
> Change v3->v4:
> - New patch file.
> 
>  drivers/pci/dwc/pci-keystone-dw.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
> index 76e73d5..0390478 100644
> --- a/drivers/pci/dwc/pci-keystone-dw.c
> +++ b/drivers/pci/dwc/pci-keystone-dw.c
> @@ -165,24 +165,8 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
>  int ks_dw_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
> -	struct device *dev = pci->dev;
> -	int i;
> -
> -	pp->irq_domain = irq_domain_add_linear(ks_pcie->msi_intc_np,
> -					       MAX_MSI_IRQS,
> -					       &ks_dw_pcie_msi_domain_ops,
> -					       chip);
>  
> -	if (!pp->irq_domain) {
> -		dev_err(dev, "irq domain init failed\n");
> -		return -ENXIO;
> -	}
> -
> -	for (i = 0; i < MAX_MSI_IRQS; i++)
> -		irq_create_mapping(pp->irq_domain, i);
> -
> -	return 0;
> +	return dw_pcie_allocate_domains(pci);

With this version "pp" should be passed.

Thanks
Kishon
