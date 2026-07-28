Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE303AEB5F;
	Tue, 28 Jul 2026 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277641; cv=none; b=HJZM4KHev7Z2NIBHlWaxxbuWAA4GIOXb2MLdBFMOuL1YD+b3jxoHQgDrihnto2zi7vI2LjECxqkG9fGQOs/nX2/rLVueT1WShZ/DHIVlKCJOH8f+mxhcwWm6pS2M7zA+w/Y39s7WM83O0AsKprRvdkObxKyROKXll0vqlW8zGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277641; c=relaxed/simple;
	bh=SCd0UWlwmW7I1bXpXzK2ZkRypcokvv9WehiwN8zsgIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jcJVtljV1v4J2x4iqbALk4dIHfFN3HJD6VbUlRdeGs1OpI5MG6GUbjWdweZFmMXiKtW4U4NjBGd/CJalYJkJr1SPXN5ASCxy0PmOp2xxhUTHc7RpI9CXuPtdS9WEom2DkAcEdRP2t4zhkcNpzAsE5JhCms8cCS8LmDeo7sWMzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQkU2WP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQkU2WP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A74D1F000E9;
	Tue, 28 Jul 2026 22:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277639;
	bh=E+DgmexqD9eZlyPhzBt/KTZnReSqy0DooXntLcufN3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=bQkU2WP+4j0eIwF24nG3mGyWH3WvI088Vmf2jiww2FpjucmK+DkJR6DM67yCh6J+v
	 Up+yMzrd5Q4D/3QLSIPRNODdPcveVx85WPGFhc8NHXnpoyapvPuuvsi87aZ53XFb2E
	 FWYWUHgvM0k0CLu5JZ7OG50XqNxOrOWhCx3PGazaxfThGkF5lH9j17KSOvccmEBjpC
	 5UJUSQVaHKhi+9t7IXqWawUhifDGppfBRG6dcPZ54LW2b0aVk1GsGHfKiq29pJmHKE
	 1cHTBy9pMMcd8f0vcQ4zKLQHtpmvNJYFKnmpPPjwBhSMiNyjXp+S6WhlvPexirpETX
	 W9URPDcRKATzw==
Date: Tue, 28 Jul 2026 17:27:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com, pranav.sanwal@amd.com
Subject: Re: [PATCH v2 2/2] pci: AMD: Add CPM6 host controller support to AMD
 MDB PCIe driver
Message-ID: <20260728222718.GA1404656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728202044.1785986-3-sai.krishna.musham@amd.com>

Replace subject with something like this to match history:

  PCI: amd-mdb: Add CPM6 host controller support

On Wed, Jul 29, 2026 at 01:50:44AM +0530, Sai Krishna Musham wrote:
> Extend the AMD MDB PCIe driver to support AMD Versal2 CPM6 variants
> (amd,versal2-cpm6-host and amd,versal2-cpm6-host1). Like MDB5, CPM6 is
> based on the Synopsys DesignWare PCIe controller and reuses the existing
> DesignWare host support; only the interrupt architecture differs:
> - The per-controller interrupt registers (MISC_EVENT, PCIE_ERR) are in a
>   dedicated "intr" region instead of the shared SLCR
> - The aggregation layer (MERGED, PS_MISC) is shared and sticky; it
>   requires an explicit W1C-clear after servicing to prevent IRQ storms
> - The completion timeout is reported via PCIE_ERR instead of MISC_EVENT
> 
> Add variant-specific register layout and implement aggregator clearing
> that, after every interrupt pass, clears this host's contribution from
> the MERGED register and the corresponding bit in the PS_MISC severity
> register.

I don't know if it's worth it, but I think this part could be split
into a preparatory patch that just reworks the MDB5 support, e.g.,
moves the _IC stuff, adds the register layout pointers and mdb5_host,
sets up pcie->variant and tests it for "== MDB5", etc.

Some of the generic things Sashiko pointed out could also be fixed in
separate preparatory patches where they would be easier to backport to
kernels where only MDB5 support is needed.

Then this patch would be purely CPM6-related things.

> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes in v2:
> - Add CPM6 host controller interrupt support.
> 
> v1 https://lore.kernel.org/all/20260402180006.486229-3-sai.krishna.musham@amd.com/
> ---
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 351 +++++++++++++++++++---
>  1 file changed, 305 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> index dee295f281a3..dbf36ce9902c 100644
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -21,6 +21,23 @@
>  #include "../../pci.h"
>  #include "pcie-designware.h"
>  
> +/*
> + * On CPM6 the per-controller PCIe interrupt registers (MISC_EVENT and
> + * PCIE_ERR) live in a dedicated region ("intr"), separate from the CPM SLCR
> + * region ("slcr") that holds the MERGED and PS severity registers they feed
> + * into. Each has a sticky W1C STATUS, a read-only MASK, and write-1
> + * ENABLE/DISABLE register.
> + */
> +#define AMD_CPM6_PCIE_ERR_STATUS		0x500
> +#define AMD_CPM6_PCIE_ERR_MASK			0x504
> +#define AMD_CPM6_PCIE_ERR_ENABLE		0x508
> +#define AMD_CPM6_PCIE_ERR_DISABLE		0x50C
> +
> +#define AMD_CPM6_MISC_EVENT_STATUS		0x514
> +#define AMD_CPM6_MISC_EVENT_MASK		0x518
> +#define AMD_CPM6_MISC_EVENT_ENABLE		0x51C
> +#define AMD_CPM6_MISC_EVENT_DISABLE		0x520
> +
>  #define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
>  #define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
>  #define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
> @@ -30,7 +47,22 @@
>  
>  #define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
>  
> -/* Interrupt registers definitions. */
> +#define AMD_CPM6_MERGED_STATUS			0x648
> +
> +/* MERGED input bits for the MISC_EVENT/PCIE_ERR sources this driver handles. */
> +#define AMD_CPM6_MERGED_PCIE_ERR_HOST0		13
> +#define AMD_CPM6_MERGED_MISC_EVENT_HOST0	14
> +#define AMD_CPM6_MERGED_PCIE_ERR_HOST1		16
> +#define AMD_CPM6_MERGED_MISC_EVENT_HOST1	17
> +
> +/*
> + * The PS_MISC severity register feeds the misc/OR GIC line. The MERGED
> + * aggregator appears as bit 21 within it.
> + */
> +#define AMD_CPM6_PS_MISC_IR_STATUS		0x340
> +#define AMD_CPM6_PS_IR_MERGED		BIT(21)
> +
> +/* MDB5 interrupt register definitions. */
>  #define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
>  #define AMD_MDB_PCIE_INTR_INTX			16
>  #define AMD_MDB_PCIE_INTR_PM_PME_RCVD		24
> @@ -39,6 +71,9 @@
>  #define AMD_MDB_PCIE_INTR_NONFATAL		27
>  #define AMD_MDB_PCIE_INTR_FATAL			28
>  
> +/* Completion timeout lives in PCIE_ERR_STATUS; give it a dedicated hwirq. */
> +#define AMD_CPM6_PCIE_ERR_CMPL_RADM		20
> +
>  #define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
>  #define AMD_MDB_PCIE_IMR_ALL_MASK			\
>  	(						\
> @@ -51,10 +86,58 @@
>  		AMD_MDB_TLP_PCIE_INTX_MASK		\
>  	)
>  
> +/* CPM6 hwirq mapping (hwirq == MISC_EVENT status bit). */
> +#define AMD_CPM6_PCIE_INTR_FATAL		17
> +#define AMD_CPM6_PCIE_INTR_NONFATAL		18
> +#define AMD_CPM6_PCIE_INTR_MISC_CORRECTABLE	19
> +#define AMD_CPM6_PCIE_INTR_PME_TO_ACK_RCVD	20
> +#define AMD_CPM6_PCIE_INTR_PM_PME_RCVD		21
> +#define AMD_CPM6_PCIE_INTR_INTX			22
> +
> +#define AMD_CPM6_MISC_EVENT_MASK_ALL			\
> +	(						\
> +		BIT(AMD_CPM6_PCIE_INTR_FATAL)		|	\
> +		BIT(AMD_CPM6_PCIE_INTR_NONFATAL)	|	\
> +		BIT(AMD_CPM6_PCIE_INTR_MISC_CORRECTABLE)	|\
> +		BIT(AMD_CPM6_PCIE_INTR_PME_TO_ACK_RCVD)	|\
> +		BIT(AMD_CPM6_PCIE_INTR_PM_PME_RCVD)	|	\
> +		BIT(AMD_CPM6_PCIE_INTR_INTX)			\
> +	)

Line up the backslashes as in AMD_MDB_PCIE_IMR_ALL_MASK.

> +/* Sources handled in the PCIE_ERR register. */
> +#define AMD_CPM6_PCIE_ERR_MASK_ALL	BIT(AMD_CPM6_PCIE_ERR_CMPL_RADM)
> +
> +enum amd_mdb_pcie_version {
> +	MDB5,
> +	CPM6,
> +	CPM6_HOST1,
> +};
> +
> +struct amd_mdb_intr_cause {
> +	const char	*sym;
> +	const char	*str;
> +};
> +
> +struct amd_mdb_pcie_variant {
> +	enum	amd_mdb_pcie_version version;
> +	u32	misc_status_reg;
> +	u32	misc_mask_reg;
> +	u32	misc_enable_reg;
> +	u32	misc_disable_reg;
> +	u32	misc_mask_all;
> +	u32	intx_hwirq;
> +	u32	intx_mask;
> +};
> +
>  /**
>   * struct amd_mdb_pcie - PCIe port information
>   * @pci: DesignWare PCIe controller structure
>   * @slcr: MDB System Level Control and Status Register (SLCR) base
> + * @intr_base: Per-controller interrupt register base. On CPM6 this maps the
> + *             "intr" region holding the MISC_EVENT/PCIE_ERR registers; on MDB5
> + *             the interrupt registers live in the SLCR block, so it aliases
> + *             @slcr.
> + * @variant: Interrupt layout data for the matched platform compatible
>   * @intx_domain: INTx IRQ domain pointer
>   * @mdb_domain: MDB IRQ domain pointer
>   * @perst_gpio: GPIO descriptor for PERST# signal handling
> @@ -63,12 +146,62 @@
>  struct amd_mdb_pcie {
>  	struct dw_pcie			pci;
>  	void __iomem			*slcr;
> +	void __iomem			*intr_base;
> +	const struct amd_mdb_pcie_variant	*variant;
>  	struct irq_domain		*intx_domain;
>  	struct irq_domain		*mdb_domain;
>  	struct gpio_desc		*perst_gpio;
>  	int				intx_irq;
>  };
>  
> +#define _IC(x, s)[AMD_MDB_PCIE_INTR_ ## x] = { __stringify(x), s }
> +
> +static const struct amd_mdb_intr_cause mdb5_intr_cause[32] = {
> +	_IC(CMPL_TIMEOUT,	"Completion timeout"),
> +	_IC(PM_PME_RCVD,	"PM_PME message received"),
> +	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
> +	_IC(MISC_CORRECTABLE,	"Correctable error message"),
> +	_IC(NONFATAL,		"Non fatal error message"),
> +	_IC(FATAL,		"Fatal error message"),
> +};
> +
> +#define _IC6(x, s)[AMD_CPM6_PCIE_INTR_ ## x] = { __stringify(x), s }
> +
> +static const struct amd_mdb_intr_cause cpm6_intr_cause[32] = {
> +	_IC6(PM_PME_RCVD,	"PM_PME message received"),
> +	_IC6(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
> +	_IC6(MISC_CORRECTABLE,	"Correctable error message"),
> +	_IC6(NONFATAL,		"Non fatal error message"),
> +	_IC6(FATAL,		"Fatal error message"),
> +};
> +
> +static void amd_mdb_pcie_clear_aggregators(struct amd_mdb_pcie *pcie)
> +{
> +	u32 merged_mask;
> +
> +	if (pcie->variant->version == MDB5)
> +		return;
> +
> +	/*
> +	 * Clear this host's serviced contributions (MISC_EVENT0 and PCIE_ERR)
> +	 * from MERGED.
> +	 */
> +	merged_mask = pcie->variant->version == CPM6 ?
> +		      BIT(AMD_CPM6_MERGED_MISC_EVENT_HOST0) |
> +		      BIT(AMD_CPM6_MERGED_PCIE_ERR_HOST0) :
> +		      BIT(AMD_CPM6_MERGED_MISC_EVENT_HOST1) |
> +		      BIT(AMD_CPM6_MERGED_PCIE_ERR_HOST1);
> +
> +	writel_relaxed(merged_mask, pcie->slcr + AMD_CPM6_MERGED_STATUS);
> +
> +	/*
> +	 * Clear MERGED in the PS_MISC severity register so the misc GIC line
> +	 * de-asserts.
> +	 */
> +	writel_relaxed(AMD_CPM6_PS_IR_MERGED,
> +		       pcie->slcr + AMD_CPM6_PS_MISC_IR_STATUS);
> +}
> +
>  static const struct dw_pcie_host_ops amd_mdb_pcie_host_ops = {
>  };
>  
> @@ -81,14 +214,17 @@ static void amd_mdb_intx_irq_mask(struct irq_data *data)
>  	u32 val;
>  
>  	raw_spin_lock_irqsave(&port->lock, flags);
> -	val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> -			 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> +	if (pcie->variant->version == MDB5)
> +		val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> +				 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> +	else
> +		val = pcie->variant->intx_mask;
>  
>  	/*
>  	 * Writing '1' to a bit in AMD_MDB_TLP_IR_DISABLE_MISC disables that
>  	 * interrupt, writing '0' has no effect.
>  	 */
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> +	writel_relaxed(val, pcie->intr_base + pcie->variant->misc_disable_reg);
>  	raw_spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> @@ -101,14 +237,17 @@ static void amd_mdb_intx_irq_unmask(struct irq_data *data)
>  	u32 val;
>  
>  	raw_spin_lock_irqsave(&port->lock, flags);
> -	val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> -			 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> +	if (pcie->variant->version == MDB5)
> +		val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> +				 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> +	else
> +		val = pcie->variant->intx_mask;
>  
>  	/*
>  	 * Writing '1' to a bit in AMD_MDB_TLP_IR_ENABLE_MISC enables that
>  	 * interrupt, writing '0' has no effect.
>  	 */
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> +	writel_relaxed(val, pcie->intr_base + pcie->variant->misc_enable_reg);
>  	raw_spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> @@ -148,42 +287,34 @@ static irqreturn_t dw_pcie_rp_intx(int irq, void *args)
>  	unsigned long val;
>  	int i, int_status;
>  
> -	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> -	int_status = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);
> +	val = readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg);
>  
> -	for (i = 0; i < PCI_NUM_INTX; i++) {
> -		if (int_status & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> +	if (pcie->variant->version == MDB5) {
> +		int_status = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);
> +		for (i = 0; i < PCI_NUM_INTX; i++) {
> +			if (int_status & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> +				generic_handle_domain_irq(pcie->intx_domain, i);
> +		}
> +	} else {
> +		/* CPM6 exposes only aggregate INTx indication, not per-line status. */

Shorten or wrap into a multi-line comment that fits in 80 columns like
the rest of the file.  Omit the period at end if that helps.

> +		if (!(val & pcie->variant->intx_mask))
> +			return IRQ_NONE;
> +		for (i = 0; i < PCI_NUM_INTX; i++)
>  			generic_handle_domain_irq(pcie->intx_domain, i);
>  	}
>  
>  	return IRQ_HANDLED;
>  }
>  
> -#define _IC(x, s)[AMD_MDB_PCIE_INTR_ ## x] = { __stringify(x), s }
> -
> -static const struct {
> -	const char	*sym;
> -	const char	*str;
> -} intr_cause[32] = {
> -	_IC(CMPL_TIMEOUT,	"Completion timeout"),
> -	_IC(PM_PME_RCVD,	"PM_PME message received"),
> -	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
> -	_IC(MISC_CORRECTABLE,	"Correctable error message"),
> -	_IC(NONFATAL,		"Non fatal error message"),
> -	_IC(FATAL,		"Fatal error message"),
> -};
> -
>  static void amd_mdb_event_irq_mask(struct irq_data *d)
>  {
>  	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
>  	struct dw_pcie *pci = &pcie->pci;
>  	struct dw_pcie_rp *port = &pci->pp;
>  	unsigned long flags;
> -	u32 val;
>  
>  	raw_spin_lock_irqsave(&port->lock, flags);
> -	val = BIT(d->hwirq);
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> +	writel_relaxed(BIT(d->hwirq), pcie->intr_base + pcie->variant->misc_disable_reg);
>  	raw_spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> @@ -193,11 +324,9 @@ static void amd_mdb_event_irq_unmask(struct irq_data *d)
>  	struct dw_pcie *pci = &pcie->pci;
>  	struct dw_pcie_rp *port = &pci->pp;
>  	unsigned long flags;
> -	u32 val;
>  
>  	raw_spin_lock_irqsave(&port->lock, flags);
> -	val = BIT(d->hwirq);
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> +	writel_relaxed(BIT(d->hwirq), pcie->intr_base + pcie->variant->misc_enable_reg);
>  	raw_spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
> @@ -226,13 +355,39 @@ static irqreturn_t amd_mdb_pcie_event(int irq, void *args)
>  {
>  	struct amd_mdb_pcie *pcie = args;
>  	unsigned long val;
> +	u32 ev_raw, err;
>  	int i;
>  
> -	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> -	val &= ~readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_MASK_MISC);
> +	ev_raw = readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg);
> +	val = ev_raw;
> +	val &= ~readl_relaxed(pcie->intr_base + pcie->variant->misc_mask_reg);
> +
> +	if (pcie->variant->version == MDB5) {
> +		for_each_set_bit(i, &val, 32)
> +			generic_handle_domain_irq(pcie->mdb_domain, i);
> +		writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
> +		return IRQ_HANDLED;
> +	}
> +
> +	val &= pcie->variant->misc_mask_all;
> +
>  	for_each_set_bit(i, &val, 32)
>  		generic_handle_domain_irq(pcie->mdb_domain, i);
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +
> +	/* Clear handled + any unhandled sticky bits to avoid IRQ storms. */
> +	writel_relaxed(ev_raw, pcie->intr_base + pcie->variant->misc_status_reg);
> +
> +	/* On CPM6 the completion timeout is reported via the PCIE_ERR register. */

Shorten, e.g., drop "the".

> +	err = readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
> +	err &= ~readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_MASK);
> +	err &= AMD_CPM6_PCIE_ERR_MASK_ALL;
> +	if (err) {
> +		dev_warn(pcie->pci.dev, "Completion timeout\n");
> +		writel_relaxed(err, pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
> +	}
> +
> +	/* Aggregation bits are sticky; clear them each pass or the level IRQ re-fires. */

Shorten or multi-line.

> +	amd_mdb_pcie_clear_aggregators(pcie);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -245,29 +400,67 @@ static void amd_mdb_pcie_free_irq_domains(struct amd_mdb_pcie *pcie)
>  	}
>  
>  	if (pcie->mdb_domain) {
> +		const struct amd_mdb_intr_cause *intr_cause =
> +			pcie->variant->version == MDB5 ?
> +			mdb5_intr_cause : cpm6_intr_cause;
> +		int i, irq;
> +
> +		for (i = 0; i < ARRAY_SIZE(mdb5_intr_cause); i++) {

It looks wrong to use ARRAY_SIZE(mdb5_intr_cause) in these loops when
"intr_cause" might be cpm6_intr_cause, which may be a different size
than mdb5_intr_cause.

> +			if (!intr_cause[i].str)
> +				continue;
> +			irq = irq_find_mapping(pcie->mdb_domain, i);
> +			if (irq) {
> +				disable_irq(irq);
> +				free_irq(irq, pcie);
> +				irq_dispose_mapping(irq);
> +			}
> +		}
> +		irq = irq_find_mapping(pcie->mdb_domain,
> +				       pcie->variant->intx_hwirq);
> +		if (irq) {
> +			disable_irq(irq);
> +			free_irq(irq, pcie);
> +			irq_dispose_mapping(irq);
> +		}
> +
>  		irq_domain_remove(pcie->mdb_domain);
>  		pcie->mdb_domain = NULL;
>  	}
>  }
>  
> -static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
> +static void amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
>  {
> -	unsigned long val;
> +	u32 misc_mask_all;
> +	u32 val;
> +
> +	misc_mask_all = pcie->variant->misc_mask_all;
>  
>  	/* Disable all TLP interrupts. */
> -	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
> -		       pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> +	writel_relaxed(misc_mask_all,
> +		       pcie->intr_base + pcie->variant->misc_disable_reg);
> +
> +	if (pcie->variant->version != MDB5)
> +		writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
> +			       pcie->intr_base + AMD_CPM6_PCIE_ERR_DISABLE);
>  
>  	/* Clear pending TLP interrupts. */
> -	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> -	val &= AMD_MDB_PCIE_IMR_ALL_MASK;
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +	val = readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg) &
> +	      misc_mask_all;
> +	writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
> +
> +	if (pcie->variant->version != MDB5) {
> +		val = readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS) &
> +		      AMD_CPM6_PCIE_ERR_MASK_ALL;
> +		writel_relaxed(val, pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
> +	}
>  
>  	/* Enable all TLP interrupts. */
> -	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
> -		       pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> +	writel_relaxed(misc_mask_all,
> +		       pcie->intr_base + pcie->variant->misc_enable_reg);
>  
> -	return 0;
> +	if (pcie->variant->version != MDB5)
> +		writel_relaxed(AMD_CPM6_PCIE_ERR_MASK_ALL,
> +			       pcie->intr_base + AMD_CPM6_PCIE_ERR_ENABLE);
>  }
>  
>  /**
> @@ -327,10 +520,13 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
>  static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args)
>  {
>  	struct amd_mdb_pcie *pcie = args;
> +	const struct amd_mdb_intr_cause *intr_cause;
>  	struct device *dev;
>  	struct irq_data *d;
>  
>  	dev = pcie->pci.dev;
> +	intr_cause = pcie->variant->version == MDB5 ?
> +		     mdb5_intr_cause : cpm6_intr_cause;
>  
>  	/*
>  	 * In the future, error reporting will be hooked to the AER subsystem.
> @@ -351,15 +547,19 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
>  	struct dw_pcie *pci = &pcie->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
>  	struct device *dev = &pdev->dev;
> +	const struct amd_mdb_intr_cause *intr_cause;
>  	int i, irq, err;
>  
> +	intr_cause = pcie->variant->version == MDB5 ?
> +		     mdb5_intr_cause : cpm6_intr_cause;
> +
>  	amd_mdb_pcie_init_port(pcie);
>  
>  	pp->irq = platform_get_irq(pdev, 0);
>  	if (pp->irq < 0)
>  		return pp->irq;
>  
> -	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
> +	for (i = 0; i < ARRAY_SIZE(mdb5_intr_cause); i++) {
>  		if (!intr_cause[i].str)
>  			continue;
>  
> @@ -379,7 +579,7 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
>  	}
>  
>  	pcie->intx_irq = irq_create_mapping(pcie->mdb_domain,
> -					    AMD_MDB_PCIE_INTR_INTX);
> +				    pcie->variant->intx_hwirq);
>  	if (!pcie->intx_irq) {
>  		dev_err(dev, "Failed to map INTx interrupt\n");
>  		return -ENXIO;
> @@ -439,6 +639,20 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
>  	if (IS_ERR(pcie->slcr))
>  		return PTR_ERR(pcie->slcr);
>  
> +	/*
> +	 * On MDB5 all interrupt registers live in the SLCR block, so the
> +	 * interrupt-register base simply aliases @slcr. CPM6 moves the
> +	 * MISC_EVENT/PCIE_ERR registers into a separate per-controller region
> +	 * mapped by name as "intr".
> +	 */
> +	if (pcie->variant->version == MDB5) {
> +		pcie->intr_base = pcie->slcr;
> +	} else {
> +		pcie->intr_base = devm_platform_ioremap_resource_byname(pdev, "intr");
> +		if (IS_ERR(pcie->intr_base))
> +			return PTR_ERR(pcie->intr_base);
> +	}
> +
>  	err = amd_mdb_pcie_init_irq_domains(pcie, pdev);
>  	if (err)
>  		return err;
> @@ -483,6 +697,9 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  
>  	pci = &pcie->pci;
>  	pci->dev = dev;
> +	pcie->variant = of_device_get_match_data(dev);
> +	if (!pcie->variant)
> +		return -EINVAL;
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> @@ -514,9 +731,51 @@ static void amd_mdb_pcie_shutdown(struct platform_device *pdev)
>  	gpiod_set_value_cansleep(pcie->perst_gpio, 1);
>  }
>  
> +static const struct amd_mdb_pcie_variant cpm6_host = {
> +	.version = CPM6,
> +	.misc_status_reg = AMD_CPM6_MISC_EVENT_STATUS,
> +	.misc_mask_reg = AMD_CPM6_MISC_EVENT_MASK,
> +	.misc_enable_reg = AMD_CPM6_MISC_EVENT_ENABLE,
> +	.misc_disable_reg = AMD_CPM6_MISC_EVENT_DISABLE,
> +	.misc_mask_all = AMD_CPM6_MISC_EVENT_MASK_ALL,
> +	.intx_hwirq = AMD_CPM6_PCIE_INTR_INTX,
> +	.intx_mask = BIT(AMD_CPM6_PCIE_INTR_INTX),
> +};
> +
> +static const struct amd_mdb_pcie_variant cpm6_host1 = {
> +	.version = CPM6_HOST1,
> +	.misc_status_reg = AMD_CPM6_MISC_EVENT_STATUS,
> +	.misc_mask_reg = AMD_CPM6_MISC_EVENT_MASK,
> +	.misc_enable_reg = AMD_CPM6_MISC_EVENT_ENABLE,
> +	.misc_disable_reg = AMD_CPM6_MISC_EVENT_DISABLE,
> +	.misc_mask_all = AMD_CPM6_MISC_EVENT_MASK_ALL,
> +	.intx_hwirq = AMD_CPM6_PCIE_INTR_INTX,
> +	.intx_mask = BIT(AMD_CPM6_PCIE_INTR_INTX),
> +};
> +
> +static const struct amd_mdb_pcie_variant mdb5_host = {
> +	.version = MDB5,
> +	.misc_status_reg = AMD_MDB_TLP_IR_STATUS_MISC,
> +	.misc_mask_reg = AMD_MDB_TLP_IR_MASK_MISC,
> +	.misc_enable_reg = AMD_MDB_TLP_IR_ENABLE_MISC,
> +	.misc_disable_reg = AMD_MDB_TLP_IR_DISABLE_MISC,
> +	.misc_mask_all = AMD_MDB_PCIE_IMR_ALL_MASK,
> +	.intx_hwirq = AMD_MDB_PCIE_INTR_INTX,
> +	.intx_mask = AMD_MDB_TLP_PCIE_INTX_MASK,
> +};
> +
>  static const struct of_device_id amd_mdb_pcie_of_match[] = {
>  	{
>  		.compatible = "amd,versal2-mdb-host",
> +		.data = &mdb5_host,
> +	},
> +	{
> +		.compatible = "amd,versal2-cpm6-host",
> +		.data = &cpm6_host,
> +	},
> +	{
> +		.compatible = "amd,versal2-cpm6-host1",
> +		.data = &cpm6_host1,
>  	},
>  	{},
>  };
> -- 
> 2.44.4
> 
