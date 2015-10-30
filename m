Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 30 Oct 2015 14:15:09 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<michals@xilinx.com>, <sorenb@xilinx.com>, <bhelgaas@google.com>,
	<arnd@arndb.de>, <tinamdar@apm.com>, <treding@nvidia.com>,
	<rjui@broadcom.com>, <Minghuan.Lian@freescale.com>,
	<m-karicheri2@ti.com>, <hauke@hauke-m.de>, <dhdang@apm.com>,
	<sbranden@broadcom.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	"Bharat Kumar Gogada" <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH v6] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Message-ID: <20151030141509.537ac361@why.wild-wind.fr.eu.org>
In-Reply-To: <1446207428-1217-1-git-send-email-bharatku@xilinx.com>
References: <1446207428-1217-1-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 30 Oct 2015 17:47:08 +0530
Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:

> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Changes for v6:
> Removed repetitive code for msi handlers.
> Corrected typo mistakes in device tree documentation.
> ---
>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 ++
>  drivers/pci/host/Kconfig                           |    9 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pcie-xilinx-nwl.c                 | 1025 ++++++++++++++++++++
>  4 files changed, 1103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
> 

[...]

> diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
> new file mode 100644
> index 0000000..bee1bee
> --- /dev/null
> +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> @@ -0,0 +1,1025 @@
> +/*
> + * PCIe host controller driver for NWL PCIe Bridge
> + * Based on pcie-xilinx.c, pci-tegra.c
> + *
> + * (C) Copyright 2014 - 2015, Xilinx, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/irqchip/chained_irq.h>

[...]

> +
> +struct nwl_msi {			/* MSI information */
> +	struct msi_controller msi_chip;	/* MSI domain */

NAK.

I've mentioned it clearly when I first reviewed this patch: There
should be no new msi_controller structure added, and definitely none
for arm64.

So please get rid of this cruft. Select CONFIG_PCI_MSI_IRQ_DOMAIN, and
everything will be taken care of for you. No populating of bus->msi,
just have your own domain field for the MSI domain.

> +	DECLARE_BITMAP(used, INT_PCI_MSI_NR);	/* used: Declare Bitmap
> +						for MSI	*/
> +	struct irq_domain *dev_domain;
> +	unsigned long pages;		/* pages: MSI pages */
> +	struct mutex lock;		/* protect used variable */
> +	int irq_msi0;
> +	int irq_msi1;
> +};

[...]

> +#ifdef CONFIG_PCI_MSI
> +static struct irq_chip nwl_msi_irq_chip = {
> +	.name = "nwl_pcie:msi",
> +	.irq_enable = unmask_msi_irq,
> +	.irq_disable = mask_msi_irq,
> +	.irq_mask = mask_msi_irq,
> +	.irq_unmask = unmask_msi_irq,
> +
> +};
> +
> +static struct msi_domain_info nwl_msi_domain_info = {
> +	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),

So you cannot support MSI-X? Why? The spec seems to say otherwise  (it
also says you could support multi-MSI, but I'm not sure it is worth the
hassle).

> +	.chip = &nwl_msi_irq_chip,
> +};
> +#endif
> +
> +static void nwl_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct nwl_msi *msi = &pcie->msi;
> +
> +	msg->address_lo = virt_to_phys((void *)msi->pages);
> +	msg->address_hi = 0;

Do you know for sure that this page will never be above 4GB? Given
that this IP can be synthesized, I seriously doubt this is the case.
Please properly populate both fields.

> +	msg->data = data->hwirq;
> +}
> +
> +static int nwl_msi_set_affinity(struct irq_data *irq_data,
> +				const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip nwl_irq_chip = {
> +	.name = "Xilinx MSI",
> +	.irq_compose_msi_msg = nwl_compose_msi_msg,
> +	.irq_set_affinity = nwl_msi_set_affinity,
> +};
> +
> +static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				unsigned int nr_irqs, void *args)
> +{
> +	struct nwl_pcie *pcie = domain->host_data;
> +	struct nwl_msi *msi = &pcie->msi;
> +	unsigned long bit;
> +
> +	mutex_lock(&msi->lock);
> +	bit = find_first_zero_bit(msi->used, INT_PCI_MSI_NR);
> +	if (bit < INT_PCI_MSI_NR)
> +		set_bit(bit, msi->used);
> +	else
> +		bit = -ENOSPC;
> +
> +	mutex_unlock(&msi->lock);
> +	irq_domain_set_info(domain, virq, bit, &nwl_irq_chip,
> +			domain->host_data, handle_simple_irq,
> +			NULL, NULL);

I'm sure irq_domain_set_info will enjoy being passed -ENOSPC as a hwirq.

> +	return 0;

And let's ignore the error case, they are usually overrated.

> +}

I've stopped here (after all, I'm still on holiday).

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
