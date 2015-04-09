Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Apr 2015 15:11:15 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Duc Dang <dhdang@apm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>
Subject: Re: [PATCH v3 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
Message-ID: <20150409201115.GN30967@google.com>
References: <20150408084448.5f0793b7@why.wild-wind.fr.eu.org>
 <cover.1428564115.git.dhdang@apm.com>
 <7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7923ef6ffd60a7c3de3c8c04fe746bbd3c15b5ac.1428564115.git.dhdang@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 09, 2015 at 10:05:03AM -0700, Duc Dang wrote:
> X-Gene v1 SoC supports total 2688 MSI/MSIX vectors coalesced into
> 16 HW IRQ lines.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> ...

> --- /dev/null
> +++ b/drivers/pci/host/pci-xgene-msi.c
> @@ -0,0 +1,407 @@
> ...

> +static void xgene_irq_domain_free(struct irq_domain *domain,
> +				  unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct xgene_msi *msi = irq_data_get_irq_chip_data(d);
> +
> +	mutex_lock(&msi->bitmap_lock);
> +
> +	if (!test_bit(d->hwirq, msi->bitmap))
> +		pr_err("trying to free unused MSI#%lu\n", d->hwirq);

I'll let Marc comment on the substance of this patch, but I'd sure like to
see more information in this and the other pr_errs below.  The text "failed
to create parent MSI domain" in the dmesg log is not enough.  Ideally it
would identify the relevant host bridge.

> +	else
> +		clear_bit(d->hwirq, msi->bitmap);
> +
> +	mutex_unlock(&msi->bitmap_lock);
> +
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc  = xgene_irq_domain_alloc,
> +	.free   = xgene_irq_domain_free,
> +};
> +
> +static int xgene_allocate_domains(struct xgene_msi *msi)
> +{
> +	msi->domain = irq_domain_add_linear(NULL, msi->settings->nr_msi_vec,
> +					    &msi_domain_ops, msi);
> +
> +	if (!msi->domain) {
> +		pr_err("failed to create parent MSI domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi->mchip.of_node = msi->node;
> +	msi->mchip.domain = pci_msi_create_irq_domain(msi->mchip.of_node,
> +						      &xgene_msi_domain_info,
> +						      msi->domain);
> +
> +	if (!msi->mchip.domain) {
> +		pr_err("failed to create MSI domain\n");
> +		irq_domain_remove(msi->domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void xgene_free_domains(struct xgene_msi *msi)
> +{
> +	if (msi->mchip.domain)
> +		irq_domain_remove(msi->mchip.domain);
> +	if (msi->domain)
> +		irq_domain_remove(msi->domain);
> +}
> +
> +static int xgene_msi_init_allocator(struct xgene_msi *xgene_msi)
> +{
> +	u32 msi_irq_count = xgene_msi->settings->nr_msi_vec;
> +	u32 hw_irq_count = xgene_msi->settings->nr_hw_irqs;
> +	int size = BITS_TO_LONGS(msi_irq_count) * sizeof(long);
> +
> +	xgene_msi->bitmap = kzalloc(size, GFP_KERNEL);
> +	if (!xgene_msi->bitmap)
> +		return -ENOMEM;
> +
> +	mutex_init(&xgene_msi->bitmap_lock);
> +
> +	xgene_msi->msi_virqs = kcalloc(hw_irq_count, sizeof(int), GFP_KERNEL);
> +	if (!xgene_msi->msi_virqs)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static irqreturn_t xgene_msi_isr(int irq, void *data)
> +{
> +	struct xgene_msi *xgene_msi = (struct xgene_msi *) data;
> +	unsigned int virq;
> +	int msir_index, msir_reg, msir_val, hw_irq;
> +	u32 intr_index, grp_select, msi_grp, processed = 0;
> +	u32 nr_hw_irqs, irqs_per_index, index_per_group;
> +
> +	msi_grp = irq - xgene_msi->msi_virqs[0];
> +	if (msi_grp >= xgene_msi->settings->nr_hw_irqs) {
> +		pr_err("invalid msi received\n");
> +		return IRQ_NONE;
> +	}

Bjorn
