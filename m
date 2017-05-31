Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49101 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751011AbdEaMdm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2017 08:33:42 -0400
Message-ID: <1496234001.30073.19.camel@pengutronix.de>
Subject: Re: [PATCH 1/8] pci: adding new irq api to pci-designware
From: Lucas Stach <l.stach@pengutronix.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: bhelgaas@google.com, marc.zyngier@arm.com, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, niklas.cassel@axis.com,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com,
        linux-pci@vger.kernel.org
Date: Wed, 31 May 2017 14:33:21 +0200
In-Reply-To: <e0ab2d597306a9df4c955f7761273f4538657e26.1496142978.git.jpinto@synopsys.com>
References: <cover.1496142978.git.jpinto@synopsys.com>
         <e0ab2d597306a9df4c955f7761273f4538657e26.1496142978.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 30.05.2017, 12:32 +0100 schrieb Joao Pinto:
> This patch adds the new interrupt api to pcie-designware, keeping the old
> one. Although the old API is still available, pcie-designware initiates
> with the new one.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
[...]
> @@ -378,17 +593,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		if (!pp->ops->msi_host_init) {
> -			pp->irq_domain = irq_domain_add_linear(dev->of_node,
> -						MAX_MSI_IRQS, &msi_domain_ops,
> -						&dw_pcie_msi_chip);
> -			if (!pp->irq_domain) {
> -				dev_err(dev, "irq domain init failed\n");
> -				ret = -ENXIO;
> +			ret = of_property_read_u32(np, "num-vectors",
> +						   &pp->num_vectors);
> +			if (ret)
> +				pp->num_vectors = 1;

This adds a DT property without documentation. That's a strong no-go.

Why do you even need this property? The number of vectors available can
be inferred from the compatible, so there is no need to push this into
the DT. A fallback of only 1 vector if the property doesn't exist is
also pretty limiting. The old implementation allowed for at least 32
vectors, with most of the core implementations probably allowing much
more in hardware.

Regards,
Lucas
