Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58661 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbeCFOYd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Mar 2018 09:24:33 -0500
Message-ID: <1520346258.4095.21.camel@pengutronix.de>
Subject: Re: [PATCH v10 1/3] PCI: dwc: Move MSI IRQs allocation to IRQ
 domains hierarchical API
From: Lucas Stach <l.stach@pengutronix.de>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        marc.zyngier@arm.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        jingoohan1@gmail.com, kishon@ti.com, lorenzo.pieralisi@arm.com
Cc: linux-pci@vger.kernel.org, m-karicheri2@ti.com,
        thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, niklas.cassel@axis.com, shawn.guo@linaro.org,
        jesper.nilsson@axis.com, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, svarbanov@mm-sol.com, nsekhar@ti.com
Date: Tue, 06 Mar 2018 15:24:18 +0100
In-Reply-To: <5feaf8a1308325a3d07f4380413061a63e156ec2.1520336185.git.gustavo.pimentel@synopsys.com>
References: <cover.1520336185.git.gustavo.pimentel@synopsys.com>
         <5feaf8a1308325a3d07f4380413061a63e156ec2.1520336185.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 06.03.2018, 11:54 +0000 schrieb Gustavo Pimentel:
> Implement a multiplexed IRQ domain hierarchy API in the pcie-designware
> host bridge driver that funnels all MSI IRQs into a single parent
> interrupt, moving away from the obsolete struct msi_controller based
> API.
> 
> Although the old implementation API is still available, pcie-designware
> will now use the multiplexed IRQ domains hierarchical API.
> 
> Remove all existing dwc based host bridges MSI IRQs handlers, in that the
> hierarchical API now handles MSI IRQs through the hierarchical/chained
> MSI domain implementation.
> 
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Tested-by: Niklas Cassel <niklas.cassel@axis.com>
> > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
[...]
> +static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
> > +				    unsigned int virq, unsigned int nr_irqs,
> > +				    void *args)
> +{
> > +	struct pcie_port *pp = domain->host_data;
> > +	unsigned long flags;
> > +	unsigned long bit;
> > +	u32 i;
> +
> > +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
> > +	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
> > +				      order_base_2(nr_irqs));
> +
> > +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +
> > +	if (bit < 0)
> +		return -ENOSPC;

bit is an unsigned variable here, so this condition will never be true.

> +
> > +	for (i = 0; i < nr_irqs; i++)
> > +		irq_domain_set_info(domain, virq + i, bit + i,
> > +				    &dw_pci_msi_bottom_irq_chip,
> > +				    pp, handle_edge_irq,
> > +				    NULL, NULL);
> +
> > +	return 0;
> +}

Regards,
Lucas
