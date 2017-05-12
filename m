Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44355 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757932AbdELRCf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2017 13:02:35 -0400
Message-ID: <1494608535.23969.11.camel@pengutronix.de>
Subject: Re: [RFC 1/8] pci: adding new irq api to pci-designware
From: Lucas Stach <l.stach@pengutronix.de>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: bhelgaas@google.com, marc.zyngier@arm.com, jingoohan1@gmail.com,
        m-karicheri2@ti.com, thomas.petazzoni@free-electrons.com,
        minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
        tie-fei.zang@freescale.com, hongxing.zhu@nxp.com,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, linux-pci@vger.kernel.org
Date: Fri, 12 May 2017 19:02:15 +0200
In-Reply-To: <d9664b857b0b9fe9cba6b8de5f0b6d365fe86f36.1494606911.git.jpinto@synopsys.com>
References: <cover.1494606911.git.jpinto@synopsys.com>
         <d9664b857b0b9fe9cba6b8de5f0b6d365fe86f36.1494606911.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 12.05.2017, 17:56 +0100 schrieb Joao Pinto:
> This patch adds the new interrupt api to pecie-designware, keeping the old
> one. A define was added to toggle between the two apis (for testing purposes).
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
>  drivers/pci/dwc/pcie-designware-host.c | 241 ++++++++++++++++++++++++++++++++-
>  drivers/pci/dwc/pcie-designware.h      |   5 +
>  2 files changed, 244 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 28ed32b..6810ea10b 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c

[...]

> +static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
> +				    unsigned int virq, unsigned int nr_irqs,
> +				    void *args)
> +{
> +	struct dw_pcie *pci = domain->host_data;
> +	struct pcie_port *pp = &pci->pp;
> +	unsigned long bit;
> +
> +	mutex_lock(&pp->lock);
> +
> +	WARN_ON(nr_irqs != 1);

So the new API doesn't support multi MSI, where we need more than a
single contiguous MSI in a range? If this is the case then this change
is breaking real use-cases that work today.

Regards,
Luvas
