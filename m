Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374923C3C0C;
	Sat,  8 Aug 2026 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187179; cv=none; b=XYP2f8G/YRSgkGaLen26MAT4gEr5XxGpjDHQRKYNwjfJKj8B4TtB91Ogte+7ev9km70Oxinyyv8efjTKSg8X9RFVkOUH3K0Qswclo4CtSOCUY2lDFigoLr0vgP/v6yf8FAGwYNEDY9tSmDjq0dT9pbIgIwf0xIQFOYdzMb8xu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187179; c=relaxed/simple;
	bh=2ZhI7y35F5qrCc9E2WoA5tixdZnvoicNVYzHCNge9QA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwfjF+a5YdH8A4uuuj8E/O21MIi6JRC5iVR99Z/eJUrzYP7ACyRybI8AzE9eIx3DZaTiup6avzu2JYqxWAfpeGZvTlpz4yWsyHgkJ91HSszbO4VvKz2vj+kuTYz9fJAa/f21BhBaxfZphlQQw/8e7GTXRpl+9kYqGVMB+Hd8vSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDpFvey/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDpFvey/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490CF1F000E9;
	Sat,  8 Aug 2026 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187177;
	bh=rQaQcLi1KJC+YIQoj71LEB4AQPh2I00wCbrzOgERTZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDpFvey/Y2BysjajeJa4fkUIRMLgcjpMtNxV4O0XtHcFqN7RgRjqygE2q/TyAPPYx
	 LlHoRT8cqzYWZ+5r3ibIh14wFggRrzLzf85Y57VxQi0C0aoMiqd+xyJpCxe/pJplE1
	 lPGfHZ10dmJdpPa6CBBSIsa7F5KxNo7H2abdyfDi7Mjen8QzAsP4aZJZkblcDCWvYJ
	 VnGDVFgg+v5HunUzcR6x1hRgoZPcaK9rK+DmUAGX7iKM0fveIIa1t2wfBuEpNIP7L4
	 l9ohptBj8iz+2wf/oTroKVEfA6lh5U23jdjHCRCBzXqxjeQYOtCnfb7I5DCAFHNR/X
	 f0RM1oz6LKbyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] PCI: amd-mdb: Add CPM6 host controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260808105256.3705889-3-sai.krishna.musham@amd.com>
References: <20260808105256.3705889-1-sai.krishna.musham@amd.com>
 <20260808105256.3705889-3-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 11:06:16 +0000
Message-Id: <20260808110617.490CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The shared event IRQ handler unconditionally returns IRQ_HANDLED a=
nd clears shared aggregators, breaking spurious interrupt detection.
- [High] Probe error paths fail to disable hardware interrupts, leading to =
unrecoverable IRQ storms on the shared interrupt line.
- [High] Hardware interrupts are unmasked before the interrupt handler is r=
egistered, creating a race window for an IRQ storm.

Pre-existing issues:
- [High] Probe failure cleanup frees IRQ domains while devm-managed handler=
s are still active, leading to Use-After-Free.
- [High] MDB5 INTB, INTC, and INTD interrupts trigger a WARN_ON_ONCE due to=
 attempting to dispatch unmapped hwirqs.
--

--- Patch [2]: [PATCH v4 2/2] PCI: amd-mdb: Add CPM6 host controller suppor=
t ---
commit b10c5fc8b35403027eb649f10e64e4ddee1b0920
Author: Sai Krishna Musham <sai.krishna.musham@amd.com>
Subject: PCI: amd-mdb: Add CPM6 host controller support

This commit extends the AMD MDB PCIe driver to support AMD Versal2 CPM6
variants. It adds variant-specific register layouts and implements
aggregator clearing for the new shared interrupt architecture.

Link: https://lore.kernel.org/all/20260402180006.486229-3-sai.krishna.musha=
m@amd.com/
Link: https://lore.kernel.org/all/20260728202044.1785986-3-sai.krishna.mush=
am@amd.com/
Link: https://lore.kernel.org/all/20260803144412.713639-3-sai.krishna.musha=
m@amd.com/

> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/cont=
roller/dwc/pcie-amd-mdb.c
> index dee295f281a30..3e8e02ab96bce 100644
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
[ ... ]
> @@ -226,13 +387,44 @@ static irqreturn_t amd_mdb_pcie_event(int irq, void=
 *args)
>  {
>  	struct amd_mdb_pcie *pcie =3D args;
>  	unsigned long val;
> +	u32 ev_raw, err;
>  	int i;
> =20
> -	val =3D readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> -	val &=3D ~readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_MASK_MISC);
> +	ev_raw =3D readl_relaxed(pcie->intr_base + pcie->variant->misc_status_r=
eg);
> +	val =3D ev_raw;
> +	val &=3D ~readl_relaxed(pcie->intr_base + pcie->variant->misc_mask_reg);
> +
> +	if (pcie->variant->version =3D=3D MDB5) {
> +		for_each_set_bit(i, &val, 32)
> +			generic_handle_domain_irq(pcie->mdb_domain, i);

[Severity: High]
This isn't a bug introduced by this patch, but does this code cause a
WARN_ON_ONCE if INTB, INTC, or INTD is asserted on MDB5?

The mask AMD_MDB_TLP_PCIE_INTX_MASK covers bits 16 to 23 of misc_status_reg.
This loop dispatches all set bits to generic_handle_domain_irq(). However,
in amd_mdb_setup_irq(), only INTA (hwirq 16) is mapped via
irq_create_mapping().

If INTB (bit 18) asserts, the handler will dispatch hwirq 18, which is
unmapped, failing to invoke the handler and triggering a warning in the IRQ
core.

> +		writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
> +		return IRQ_HANDLED;
> +	}
> +
> +	err =3D readl_relaxed(pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
> +
> +	val &=3D pcie->variant->misc_mask_all;
> +
>  	for_each_set_bit(i, &val, 32)
>  		generic_handle_domain_irq(pcie->mdb_domain, i);
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +
> +	/* Clear handled + any unhandled sticky bits to avoid IRQ storms. */
> +	writel_relaxed(ev_raw, pcie->intr_base + pcie->variant->misc_status_reg=
);
> +
> +	/* On CPM6 completion timeout is reported via PCIE_ERR. */
> +	if (err) {
> +		u32 pending =3D err & ~readl_relaxed(pcie->intr_base +
> +						   AMD_CPM6_PCIE_ERR_MASK);
> +
> +		if (pending & AMD_CPM6_PCIE_ERR_MASK_ALL)
> +			generic_handle_domain_irq(pcie->mdb_domain,
> +						  AMD_CPM6_PCIE_INTR_CMPL_TIMEOUT);
> +		/* Clear every asserted bit so the leaf and MERGED de-assert. */
> +		writel_relaxed(err, pcie->intr_base + AMD_CPM6_PCIE_ERR_STATUS);
> +	}
> +
> +	/* Sticky aggregation bits; clear each pass or the IRQ re-fires */
> +	amd_mdb_pcie_clear_aggregators(pcie);
> =20
>  	return IRQ_HANDLED;
>  }

[Severity: High]
Could returning IRQ_HANDLED unconditionally here break the kernel's spurious
interrupt detection?

Since this IRQ is shared (as seen by the IRQF_SHARED flag), any interrupt on
the shared line invokes this handler. If the interrupt was generated by the
other host controller and this one is idle (ev_raw =3D=3D 0 and err =3D=3D =
0), this
code returns IRQ_HANDLED without doing any work.

Additionally, unconditionally calling amd_mdb_pcie_clear_aggregators() clea=
rs
the shared PS_MISC_IR_STATUS aggregator, which could drop interrupts for the
other host controller.

[ ... ]
> @@ -351,15 +569,20 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *p=
cie,
>  	struct dw_pcie *pci =3D &pcie->pci;
>  	struct dw_pcie_rp *pp =3D &pci->pp;
>  	struct device *dev =3D &pdev->dev;
> +	const struct amd_mdb_intr_cause *intr_cause;
> +	unsigned long event_flags =3D IRQF_NO_THREAD;
>  	int i, irq, err;
> =20
> +	intr_cause =3D pcie->variant->version =3D=3D MDB5 ?
> +		     mdb5_intr_cause : cpm6_intr_cause;
> +
>  	amd_mdb_pcie_init_port(pcie);

[Severity: High]
Is there a race condition leading to an IRQ storm by enabling hardware
interrupts before registering the handler?

amd_mdb_pcie_init_port() enables and unmasks hardware interrupts and shared
aggregators. The devm_request_irq() for the handler happens later in this
function.

For CPM6's shared IRQ, if the hardware asserts an interrupt during this win=
dow,
the shared line fires. The other host's handler will spin endlessly because=
 it
cannot clear this un-probed host's internal hardware state.

> =20
>  	pp->irq =3D platform_get_irq(pdev, 0);
>  	if (pp->irq < 0)
>  		return pp->irq;
[ ... ]
> +	/*
> +	 * On CPM6 the misc GIC line is shared between both host controllers,
> +	 * so the event IRQ must allow sharing.
> +	 */
> +	if (pcie->variant->version !=3D MDB5)
> +		event_flags |=3D IRQF_SHARED;
> +
>  	/* Plug the main event handler. */
> -	err =3D devm_request_irq(dev, pp->irq, amd_mdb_pcie_event, IRQF_NO_THRE=
AD,
> +	err =3D devm_request_irq(dev, pp->irq, amd_mdb_pcie_event, event_flags,
>  			       "amd_mdb pcie_irq", pcie);
>  	if (err) {
>  		dev_err(dev, "Failed to request event IRQ %d, err=3D%d\n",
> -			pp->irq, err);
> +			pp->irq, err);
>  		return err;
>  	}

[Severity: High]
Will the probe error path leave hardware interrupts enabled and unmasked?

If a failure occurs after this point (e.g., in dw_pcie_host_init()), the er=
ror
path in amd_mdb_add_pcie_port() only cleans up the IRQ domains. It fails to
mask the hardware interrupts and shared aggregators that were just enabled =
in
amd_mdb_pcie_init_port().

Because the IRQ is shared on CPM6, if the uninitialized hardware asserts an
interrupt, the other host controller's handler will be continuously invoked=
 but
unable to clear the source, causing an unrecoverable IRQ storm.

[Severity: High]
This isn't a bug introduced by this patch, but can the probe error path cau=
se
a use-after-free of the IRQ domain?

If a failure occurs after devm_request_irq() succeeds, amd_mdb_add_pcie_por=
t()
jumps to its error path and calls amd_mdb_pcie_free_irq_domains(), which
immediately destroys and frees pcie->mdb_domain. However, the IRQ handlers
were registered with devm-managed functions and remain active until devres
cleanup runs after the probe function returns.

If an interrupt fires in this window (which is likely if hardware interrupts
are left enabled), amd_mdb_pcie_event() will dereference the freed domain v=
ia:

amd_mdb_pcie_event() {
    ...
    generic_handle_domain_irq(pcie->mdb_domain, i);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808105256.3705=
889-1-sai.krishna.musham@amd.com?part=3D2
