Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549315;
	b=KtBIj30v04YPMgYo9C02jwzfpEpg0cExG1gs8HO4MMSVV/6ozqnGyqV1bSSzojL/tMUr
	 l1zn4rSnYzvRTg+KbzuZIMCHShmbKIMJsNLUxkQWdOaAE6+LCAcMdA1J/kWj50oMXOOxZ
	 MONhL6Pi/lMCWiMnlFyORN7HoJ179eMRaBHN/wQUeV8eIcxs9S9FlGrTFzITy+GkTATNk
	 AlpfI19kt/32Hv0bQOP0i7fohtskYeUog6lwbSYPJ5pT5Ex47iAcbvoPdWytQOdsaTRqB
	 z3dpFvQbThyadWkKDVKjNVPIsX8nw4T/GU9J0ZPq09IiQlKvGXXARbvNHkLfsZG6BlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549315;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
	bh=Kt/kKs7mRJzpqThsCL29ovxNo4HgqgzLd9RpLzowLNU=;
	b=E6nUydjS4DzOpvfhOkO/ObxFxt7WAyMEXeISSGgOiJ+liZSVEd12VbmGR+Og11IgszqE
	 TSmBOMECIx98VTov+R3XhgUDwyVtKLsVf/hHFVN9X0yTHzBNM7VLmgRbf+OGbQW9dcCi5
	 2cYKyhivcmwb0Z+9QNdfWsd6kmkre6RlEHZhcDKkVbucCs8KQ/R1dhdWpSkF5rb/ob0mX
	 8KGVe0/ILsANuHciA37X+PRN0HmrMLu3r6ILk0NxhXcldUNduRlUSU1z+pK4k6TeywbKM
	 tjCP8zoCV11Az+is63JqLBVcKDdXTWSRn0AA6nj0Yn2K3l10ZoFNfJKN2ZhAj5di9fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cxZRH6a8;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EBB606A319;
	Wed, 21 Oct 2026 02:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80EBB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=cxZRH6a8
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j8Y270PbdzKnSx;
	Wed, 21 Oct 2026 04:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792549311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kt/kKs7mRJzpqThsCL29ovxNo4HgqgzLd9RpLzowLNU=;
	b=cxZRH6a8JgFJ7tGvb6yB26tPngM5JpQeggeCMNBgLs8w7YCNwdequrA+zL5NdcZvnHs+fU
	P4YQtTN16UwfvKfNQt0wAheVgllw4ziux4jjNu6KVNEwyzxTRhffu7BVfhMj/m2GqlEF5o
	6vKR7x6HFU33SoN9bUvO+E6tehydGTamb+3HV/ISJ58W/jx5W1gEKpQO/oanM7yXCAQEIa
	j5ZSZynw/K67VI/jOQHOHm+CAKB5Vvky0oCp0VFvo+EhyjtznU5ME6YSoyj46/VUl7AeiP
	TjJFYkPmisD8a/EyHBaBFxMauQOQrJyjjvd2Hwz49q6cRTbaFSxQqxZzUo0FKw==
Message-ID: <33e7f153-9dde-4bf7-8ab4-d128b256239a@mailbox.org>
Date: Wed, 21 Oct 2026 02:19:46 +0200
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/17] PCI: rcar-gen4: Route Root Port AER to a virtual
 Root Port IRQ
To: Koichiro Den <den@valinux.co.jp>, Manivannan Sadhasivam
 <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Shawn Lin <Shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-14-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261020031049.969895-14-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 93beee897e2d6021d40
X-MBO-RS-META: s8byibs3e3nz1dcaamjqsrdzui1rqwty

On 10/20/26 5:10 AM, Koichiro Den wrote:
> On R-Car Gen4 SoCs, the APP block exposes the Root Port interrupt
> signals in PCIEINTSTS0 and routes them to platform IRQs: AER to
> intreq_pcim_lperr, and PME and bandwidth notifications to
> intreq_pcim_sub. On an R-Car S4 with GIC ITS, a link retrain set
> LnkSta.LBMS and latched PCIEINTSTS0[23] (cfg_bw_mgt_msi), but the Root
> Port's MSI never fired while endpoint MSIs worked fine. With iMSI-RX the
> Root Port MSI capabilities are already hidden, but its INTx maps to
> intreq_pcim_sub. Note that even before this driver took over the IRQ
> with rcar_gen4_pcie_msi_irq_handler, the port service was unable to
> request it, as the DWC core used that IRQ for its chained MSI handler.
> In either case, iMSI-RX or an external MSI controller, Root Port
> interrupts are not delivered to the port services.
> 
> Hide the Root Port MSI/MSI-X capabilities so the port services use
> INTx regardless of the MSI controller. Do this in the R-Car host setup,
> which also runs on reset and resume. Use a virtual IRQ to deliver
> notifications from separate platform IRQs to the standard handlers.
> Route AER from the optional "aer" interrupt. DTs without it remain
> supported, but Root Port AER stays unavailable.
> 
> The APP block may still receive MSI-form notifications because hiding
> the Root Port's MSI capabilities does not clear MSICAP0.MSIE. Handle
> these alongside the INTx-form level signals. Clear the MSI-form latch
> before the AER handler clears Root Error Status, so a late APP clear
> does not erase a new notification.
> 
> Check for reset requests before dispatch: on S4, DBI accesses from
> the port services can hang the host immediately after link down.
> 
> The next patch also feeds PME and bandwidth notifications from "msi"
> into this IRQ, so both parents may dispatch concurrently.
> handle_level_irq() calls irq_ack() before checking whether it can run
> the handlers. Keep the APP latches set while the IRQ is in progress or
> disabled, so the level parents can retry through the reset checks.
> This avoids losing notifications without a raw lock around port
> services that take regular spinlocks.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes since v4:
>    - Hide the Root Port MSI/MSI-X capabilities in host_setup() instead of
>      adding a no_rp_msi flag to the DWC core. (Shawn)
>      https://lore.kernel.org/r/bi3rvyqpdu4iq6pfyrqvx7eplyim6gmg2ijal67mpateobmtlq@gec7zewfm76r/
>      I did not carry Marek's Reviewed-by tag over due to the change.

Bjorn/Manivannan, can you please have a look at this patch and the MSI 
handling, to be sure this is OK ?

(no further comments from me below this point)

Thank you !

>   drivers/pci/controller/dwc/pcie-rcar-gen4.c | 213 +++++++++++++++++++-
>   1 file changed, 210 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 50d4b74e63b0..b0440f2c5329 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -14,10 +14,12 @@
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
>   #include <linux/irqchip/arm-gic-v3.h>
> +#include <linux/irqdomain.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_irq.h>
> +#include <linux/of_pci.h>
>   #include <linux/pci.h>
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
> @@ -59,6 +61,11 @@
>   #define SMLH_LINK_UP		BIT(7)
>   #define RDLH_LINK_UP		BIT(6)
>   
> +/* Root Port notifications routed to intreq_pcim_lperr ("aer") */
> +#define AER_RC_ERR_MSI		BIT(29)
> +#define AER_RC_ERR_INT		BIT(27)
> +#define RP_AER_MASK		(AER_RC_ERR_MSI | AER_RC_ERR_INT)
> +
>   /* PCIe DMA Interrupt Status Enable */
>   #define PCIEDMAINTSTSEN		0x0314
>   #define PCIEDMAINTSTSEN_INIT	GENMASK(15, 0)
> @@ -68,6 +75,7 @@
>   
>   /* PCIe Interrupt Status 0 Clear */
>   #define PCIEINTSTS0CLR		0x0340
> +#define RP_LATCHED_MASK		AER_RC_ERR_MSI
>   
>   /* Port Logic Registers 89 */
>   #define PRTLGC89		0x0b70
> @@ -133,6 +141,12 @@ struct rcar_gen4_pcie {
>   	struct work_struct link_down_work;
>   	/* Allow Root Port event handling after enumeration and until teardown. */
>   	bool rp_events_armed;
> +	/* Virtual Root Port INTx shared by the port services */
> +	struct irq_domain *rp_irq_domain;
> +	unsigned int rp_irq;
> +	bool rp_irq_enabled;
> +	/* intreq_pcim_lperr ("aer"): Root Port AER notifications, optional */
> +	int aer_irq;
>   	/*
>   	 * The controller needs reinitializing; the APP interrupt sources
>   	 * stay masked until a reset succeeds.
> @@ -565,7 +579,7 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
>   	lockdep_assert_held(&rcar->app_lock);
>   
>   	val = readl(rcar->base + PCIEINTSTS0EN);
> -	val &= ~MSI_CTRL_INT;
> +	val &= ~(MSI_CTRL_INT | RP_AER_MASK);
>   	/*
>   	 * Note that rcar->rp_events_armed is not checked here because device
>   	 * removal may still need iMSI-RX interrupts after Root Port events have
> @@ -573,6 +587,8 @@ static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rcar)
>   	 */
>   	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
>   		val |= MSI_CTRL_INT;
> +	if (rp_events && rcar->rp_irq_enabled && rcar->aer_irq > 0)
> +		val |= RP_AER_MASK;
>   	writel(val, rcar->base + PCIEINTSTS0EN);
>   
>   	val = readl(rcar->base + PCIERSTSTSEN);
> @@ -675,6 +691,15 @@ static bool rcar_gen4_pcie_handle_link_down(struct rcar_gen4_pcie *rcar)
>   	return rcar->reinit_pending;
>   }
>   
> +static void rcar_gen4_pcie_rp_irq_dispatch(struct rcar_gen4_pcie *rcar)
> +{
> +	/* Recheck reset requests after the parent's status read. */
> +	if (rcar_gen4_pcie_handle_link_down(rcar))
> +		return;
> +
> +	generic_handle_domain_irq(rcar->rp_irq_domain, 0);
> +}
> +
>   static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
>   {
>   	struct rcar_gen4_pcie *rcar =
> @@ -769,6 +794,162 @@ static void rcar_gen4_pcie_rp_events_disarm(struct rcar_gen4_pcie *rcar)
>   	cancel_work_sync(&rcar->link_down_work);
>   }
>   
> +static void rcar_gen4_pcie_rp_irq_mask(struct irq_data *d)
> +{
> +	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
> +
> +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
> +	rcar->rp_irq_enabled = false;
> +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
> +}
> +
> +static void rcar_gen4_pcie_rp_irq_unmask(struct irq_data *d)
> +{
> +	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
> +
> +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
> +	rcar->rp_irq_enabled = true;
> +	rcar_gen4_pcie_app_irq_sync_locked(rcar);
> +}
> +
> +static void rcar_gen4_pcie_rp_irq_ack(struct irq_data *d)
> +{
> +	struct rcar_gen4_pcie *rcar = irq_data_get_irq_chip_data(d);
> +
> +	/*
> +	 * handle_level_irq() may skip the handlers after calling irq_ack().
> +	 * Keep notifications latched if the IRQ is disabled or in progress,
> +	 * so they raise a parent IRQ again after unmasking. The descriptor
> +	 * lock serializes this check with IRQD_IRQ_INPROGRESS.
> +	 */
> +	if (irqd_irq_disabled(d) || irqd_irq_inprogress(d))
> +		return;
> +
> +	/* Clear APP latches before the service clears Root Error Status. */
> +	writel(RP_LATCHED_MASK, rcar->base + PCIEINTSTS0CLR);
> +}
> +
> +static const struct irq_chip rcar_gen4_pcie_rp_irq_chip = {
> +	.name = "rcar-gen4-rp",
> +	.irq_mask = rcar_gen4_pcie_rp_irq_mask,
> +	.irq_unmask = rcar_gen4_pcie_rp_irq_unmask,
> +	.irq_ack = rcar_gen4_pcie_rp_irq_ack,
> +};
> +
> +static int rcar_gen4_pcie_rp_irq_map(struct irq_domain *domain,
> +				     unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &rcar_gen4_pcie_rp_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +	irq_set_noprobe(irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops rcar_gen4_pcie_rp_irq_domain_ops = {
> +	.map = rcar_gen4_pcie_rp_irq_map,
> +};
> +
> +static irqreturn_t rcar_gen4_pcie_aer_irq_handler(int irq, void *data)
> +{
> +	struct rcar_gen4_pcie *rcar = data;
> +	u32 status;
> +
> +	/* The line also fires on link down; reset requests come first. */
> +	if (rcar_gen4_pcie_handle_link_down(rcar))
> +		return IRQ_HANDLED;
> +
> +	status = readl(rcar->base + PCIEINTSTS0) &
> +		 readl(rcar->base + PCIEINTSTS0EN);
> +	if (!(status & RP_AER_MASK))
> +		return IRQ_NONE;
> +
> +	rcar_gen4_pcie_rp_irq_dispatch(rcar);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rcar_gen4_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	struct rcar_gen4_pcie *rcar = dev_get_drvdata(bridge->dev.parent);
> +
> +	/* Downstream devices use standard OF INTx mapping */
> +	if (!pci_is_root_bus(dev->bus))
> +		return of_irq_parse_and_map_pci(dev, slot, pin);
> +
> +	/* Root Port uses the virtual IRQ (always INTA) */
> +	return rcar->rp_irq;
> +}
> +
> +static int rcar_gen4_pcie_rp_irq_init(struct rcar_gen4_pcie *rcar)
> +{
> +	struct device *dev = rcar->dw.dev;
> +	struct fwnode_handle *fwnode;
> +	int irq, ret;
> +
> +	irq = platform_get_irq_byname_optional(rcar->pdev, "aer");
> +	if (irq == -ENXIO)
> +		irq = 0;	/* old DT: Root Port AER stays unavailable */
> +	else if (irq < 0)
> +		return dev_err_probe(dev, irq, "Failed to get AER IRQ\n");
> +
> +	fwnode = irq_domain_alloc_named_fwnode(dev_name(dev));
> +	if (!fwnode)
> +		return -ENOMEM;
> +
> +	rcar->rp_irq_domain = irq_domain_create_linear(fwnode, 1,
> +						       &rcar_gen4_pcie_rp_irq_domain_ops,
> +						       rcar);
> +	if (!rcar->rp_irq_domain) {
> +		ret = -ENOMEM;
> +		goto err_free_fwnode;
> +	}
> +
> +	rcar->rp_irq = irq_create_mapping(rcar->rp_irq_domain, 0);
> +	if (!rcar->rp_irq) {
> +		ret = -ENOMEM;
> +		goto err_remove_domain;
> +	}
> +
> +	if (irq) {
> +		/*
> +		 * Dispatch the child IRQ in hard IRQ context, including on
> +		 * PREEMPT_RT. Enable it together with the "msi" parent IRQ.
> +		 */
> +		ret = devm_request_irq(dev, irq, rcar_gen4_pcie_aer_irq_handler,
> +				       IRQF_NO_THREAD | IRQF_NO_AUTOEN,
> +				       "rcar-gen4-pcie-aer", rcar);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "Failed to request AER IRQ\n");
> +			goto err_dispose_mapping;
> +		}
> +		rcar->aer_irq = irq;
> +	}
> +
> +	return 0;
> +
> +err_dispose_mapping:
> +	irq_dispose_mapping(rcar->rp_irq);
> +err_remove_domain:
> +	irq_domain_remove(rcar->rp_irq_domain);
> +err_free_fwnode:
> +	irq_domain_free_fwnode(fwnode);
> +
> +	return ret;
> +}
> +
> +static void rcar_gen4_pcie_rp_irq_deinit(struct rcar_gen4_pcie *rcar)
> +{
> +	struct fwnode_handle *fwnode = rcar->rp_irq_domain->fwnode;
> +
> +	irq_dispose_mapping(rcar->rp_irq);
> +	irq_domain_remove(rcar->rp_irq_domain);
> +	irq_domain_free_fwnode(fwnode);
> +}
> +
>   static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
>   					struct pci_dev *dev)
>   {
> @@ -854,6 +1035,13 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie_rp *pp)
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * Root Port MSIs are not delivered. Hide the MSI/MSI-X capabilities
> +	 * so port services use the virtual INTx IRQ.
> +	 */
> +	dw_pcie_remove_capability(dw, PCI_CAP_ID_MSI);
> +	dw_pcie_remove_capability(dw, PCI_CAP_ID_MSIX);
> +
>   	msleep(PCIE_T_PVPERL_MS);	/* pe_rst requires 100msec delay */
>   	rcar_gen4_pcie_host_perst_assert(pp, false);
>   
> @@ -869,6 +1057,8 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
>   
>   	/* The MSI status lives in DBI; keep the handler away during the reset. */
>   	disable_irq(rcar->msi_irq);
> +	if (rcar->aer_irq > 0)
> +		disable_irq(rcar->aer_irq);
>   }
>   
>   static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
> @@ -879,6 +1069,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
>   		rcar_gen4_pcie_app_irq_sync_locked(rcar);
>   	}
>   
> +	if (rcar->aer_irq > 0)
> +		enable_irq(rcar->aer_irq);
>   	enable_irq(rcar->msi_irq);
>   }
>   
> @@ -945,6 +1137,8 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
>   	if (pp->bridge) {
>   		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
>   		pp->bridge->reset_root_port = rcar_gen4_pcie_reset_root_port;
> +		/* Route Root Port INTx to the virtual IRQ. */
> +		pp->bridge->map_irq = rcar_gen4_pcie_map_irq;
>   	}
>   
>   	rcar_gen4_pcie_host_perst_assert(pp, true);
> @@ -1003,10 +1197,14 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
>   	raw_spin_lock_init(&rcar->app_lock);
>   	INIT_WORK(&rcar->link_down_work, rcar_gen4_pcie_link_down_work);
>   
> -	ret = rcar_gen4_pcie_msi_irq_init(rcar);
> +	ret = rcar_gen4_pcie_rp_irq_init(rcar);
>   	if (ret)
>   		return ret;
>   
> +	ret = rcar_gen4_pcie_msi_irq_init(rcar);
> +	if (ret)
> +		goto err_rp_irq_deinit;
> +
>   	pp->num_vectors = MAX_MSI_IRQS;
>   	/* Reserve an iATU window for the generic PME_Turn_Off implementation. */
>   	pp->use_atu_msg = true;
> @@ -1018,7 +1216,15 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
>   	pp->msi_irq[0] = -ENODEV;
>   	pp->ops = &rcar_gen4_pcie_host_ops;
>   
> -	return dw_pcie_host_init(pp);
> +	ret = dw_pcie_host_init(pp);
> +	if (ret)
> +		goto err_rp_irq_deinit;
> +
> +	return 0;
> +
> +err_rp_irq_deinit:
> +	rcar_gen4_pcie_rp_irq_deinit(rcar);
> +	return ret;
>   }
>   
>   static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
> @@ -1026,6 +1232,7 @@ static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
>   	/* Cancel recovery work before removing the PCI bus */
>   	rcar_gen4_pcie_rp_events_disarm(rcar);
>   	dw_pcie_host_deinit(&rcar->dw.pp);
> +	rcar_gen4_pcie_rp_irq_deinit(rcar);
>   }
>   
>   /* Endpoint mode */


-- 
Best regards,
Marek Vasut
