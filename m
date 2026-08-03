Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9F2F8E95;
	Mon,  3 Aug 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769122; cv=none; b=EMLNuCJJ3O8gRfpTeXydekUz+gdh1TmTGE9IJKcjq6dg6ZSne2u8t3tBPH6iyl0jD++6uY033ufcDM7GkyI8BD1Gd6pNGCO1wUnE7jqyLhxvWD9q3Ow8t2O9cVU/ksqZP9B9ZQ+VdrixiNy2gV8EoKTA2aRHgNcsPgi9gjylB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769122; c=relaxed/simple;
	bh=hXKwc4Yw7442qDQpTS4VKlJD9ADClLKV157Hgq8pAbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dpEW72KUuxLxjnqmGEIyWXZlBbpxb23i8Gwun4cfJMFLuP09cPi7ogW+piQyUlArCK3LBR3evgFYINb1bIPQmhSsGBxyHYNhIz9IJUFj5cCTg0+9BJW18iMqq45hnL4p10N+V0QzzCYOzpdTFN2v7erGTL0aZ4EpwTD3p6Q382g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9T0AZBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9T0AZBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B61C1F000E9;
	Mon,  3 Aug 2026 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769120;
	bh=G71PH27mEuMkhFyVljyE7TV3PkEKP2dfubE8EGFzOm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9T0AZBHgu5SRbwNVGuIHJnzK69GlLB59GP0CeddrMm7hHCbrR6ANCmMoBfdSB/LB
	 xxvMUOu2wqOa3GzlUWxgTIyMThoTuibmpam7nG/mJWN454+ODAu6OE/c375kWATqMT
	 jGNh8en9kod8Pmoqa2SiFjVyoxe/7IJHo3hYGAFiLiLPhsSQOxKyRZxo2Wh8tWb0Ww
	 uwHgi1/e8pxBGRHuuNMurjcydffrhxb2cr1PnVy98pOzW0vb6Nk9/B6f5W8HFgOFZq
	 Uk62ATwUw8T/kVreKwExYLmlewyBUs2TRYndXxE6FnxDaSxYdns7rUzs9Iyps0tShI
	 dR90lx3Hkl6mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: amd-mdb: Add CPM6 host controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260803144412.713639-3-sai.krishna.musham@amd.com>
References: <20260803144412.713639-1-sai.krishna.musham@amd.com>
 <20260803144412.713639-3-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:58:39 +0000
Message-Id: <20260803145840.2B61C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Shared PCIe interrupt line lacks IRQF_SHARED and fails to return I=
RQ_NONE, breaking the second CPM6 host controller.
- [High] Uncoordinated W1C clearing of the shared sticky `PS_MISC` aggregat=
or bit causes lost interrupts for the other host controller.

Pre-existing issues:
- [High] Probe error paths manually destroy IRQ domains before devres frees=
 the requested IRQs and fail to dispose of mappings, leading to UAF and des=
criptor leaks.
- [High] Unconditionally unmasking the shared INTx hardware interrupt durin=
g initialization causes 100% CPU lockup IRQ storms if an unhandled INTx ass=
erts.
- [High] Only INTA is mapped and handled for MDB5; assertions of INTB, INTC=
, or INTD lead to unhandled IRQ storms.
- [High] The driver fails to disable and clear all unhandled interrupt sour=
ces during initialization, risking IRQ storms.
--

--- Patch [2]: [PATCH v3 2/2] PCI: amd-mdb: Add CPM6 host controller suppor=
t ---
commit 143e844605c2e7ba1267fd4895c79f0d1c955a17
Author: Sai Krishna Musham <sai.krishna.musham@amd.com>

PCI: amd-mdb: Add CPM6 host controller support

Extend the AMD MDB PCIe driver to support AMD Versal2 CPM6 variants
(amd,versal2-cpm6-host and amd,versal2-cpm6-host1). Like MDB5, CPM6 is
based on the Synopsys DesignWare PCIe controller and reuses the existing
DesignWare host support; only the interrupt architecture differs.

[ ... ]

> @@ -51,24 +87,133 @@
>  		AMD_MDB_TLP_PCIE_INTX_MASK		\
>  	)

[ ... ]

> +static void amd_mdb_pcie_clear_aggregators(struct amd_mdb_pcie *pcie)
> +{
> +	if (pcie->variant->version =3D=3D MDB5)
> +		return;
> +
> +	/*
> +	 * Clear this host's serviced contributions (MISC_EVENT and PCIE_ERR)
> +	 * from MERGED.
> +	 */
> +	writel_relaxed(amd_mdb_pcie_merged_host_mask(pcie),
> +		       pcie->slcr + AMD_CPM6_MERGED_STATUS);
> +
> +	/*
> +	 * Clear MERGED in the PS_MISC severity register so the misc GIC line
> +	 * de-asserts.
> +	 */
> +	writel_relaxed(AMD_CPM6_PS_IR_MERGED,
> +		       pcie->slcr + AMD_CPM6_PS_MISC_IR_STATUS);
> +}

[Severity: High]
Does this unconditional lockless write clear the shared sticky aggregator b=
it
safely?

This register clears bit 21, which is a single sticky aggregator representi=
ng
the OR of events from both CPM6 host controllers. An unconditional W1C write
by HOST0 will clear the latched state even if HOST1 currently has pending
unhandled events.

Could this lack of synchronization across hosts result in dropped edge
transitions and permanently lost interrupts for the other controller?

[ ... ]

> @@ -226,13 +387,43 @@ static irqreturn_t amd_mdb_pcie_event(int irq, void=
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
> +		writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
> +		return IRQ_HANDLED;
> +	}

[ ... ]

> +	/* Sticky aggregation bits; clear each pass or the IRQ re-fires */
> +	amd_mdb_pcie_clear_aggregators(pcie);
> =20
>  	return IRQ_HANDLED;
>  }

[Severity: High]
Since both CPM6 host controllers share the PS_MISC severity register which
feeds a single shared GIC interrupt line, shouldn't this physical IRQ be
requested with the IRQF_SHARED flag in amd_mdb_setup_irq()?

Currently, devm_request_irq() is called without IRQF_SHARED, which causes t=
he
second controller's probe to fail with -EBUSY.

Furthermore, the shared handler amd_mdb_pcie_event() unconditionally returns
IRQ_HANDLED even when it performs no work (e.g. when ev_raw =3D=3D 0). Does=
 this
violate shared IRQ semantics and defeat the spurious interrupt detection
mechanism?

[ ... ]

> @@ -250,24 +441,47 @@ static void amd_mdb_pcie_free_irq_domains(struct am=
d_mdb_pcie *pcie)
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but is it safe to manually destroy the IRQ
domains in the probe error path before devres frees the requested IRQs?

When dw_pcie_host_init() fails, the error path calls
amd_mdb_pcie_free_irq_domains(), which immediately removes the domains here.
However, irq_dispose_mapping() is never called, leaving the irq_desc mappin=
gs
allocated and triggering a warning during irq_domain_remove.

Additionally, the physical IRQ handler is managed by devres and remains
registered until the probe function fully unwinds. If an interrupt fires in
this window, the handler will use the destroyed domain, leading to kernel
crashes. Could this domain teardown be deferred via devm_add_action_or_rese=
t()
to ensure LIFO cleanup order?

> -static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
> +static void amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
>  {
> -	unsigned long val;
> +	u32 misc_mask_all;
> +	u32 val;
> +
> +	misc_mask_all =3D pcie->variant->misc_mask_all;
> =20
>  	/* Disable all TLP interrupts. */
> -	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
> -		       pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> +	writel_relaxed(misc_mask_all,
> +		       pcie->intr_base + pcie->variant->misc_disable_reg);

[Severity: High]
This is a pre-existing issue, but should the initialization sequence disable
all interrupt sources rather than just the known subset?

The driver only writes the known subset mask (misc_mask_all) to the disable
register. If the bootloader or firmware left any other unhandled interrupt
sources enabled and asserted, they remain unmasked.

When the main event handler runs, it masks out the known bits for processing
but still clears the unhandled status bits and returns IRQ_HANDLED without
actually handling the source or disabling it. For level-sensitive interrupt=
s,
this immediately re-asserts the bit, leading to an IRQ storm. Could this use
~0U to disable all sources?

[ ... ]

>  	/* Enable all TLP interrupts. */
> -	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
> -		       pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> -
> -	return 0;
> +	writel_relaxed(misc_mask_all,
> +		       pcie->intr_base + pcie->variant->misc_enable_reg);

[Severity: High]
This is a pre-existing issue, but does unconditionally unmasking the shared
INTx hardware interrupt during initialization risk an IRQ storm?

Here, the driver writes misc_mask_all to the enable register, which unmasks
INTx in hardware before any child driver has requested it (intx_refmask =3D=
 0).
If INTx is already asserted by a device (e.g., from BIOS), the hardware
interrupt fires immediately.

Because no child driver is registered, no handler clears the interrupt at t=
he
PCI device level. Later in dw_pcie_rp_intx(), the handler unconditionally
returns IRQ_HANDLED, preventing the kernel's spurious interrupt detector fr=
om
masking the IRQ and resulting in a permanent CPU lockup.

[ ... ]

> @@ -379,7 +600,7 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pci=
e,
>  	}
> =20
>  	pcie->intx_irq =3D irq_create_mapping(pcie->mdb_domain,
> -					    AMD_MDB_PCIE_INTR_INTX);
> +				    pcie->variant->intx_hwirq);

[Severity: High]
This isn't a bug introduced by this patch, but are the INTB, INTC, and INTD
interrupts handled correctly for MDB5?

On MDB5, STATUS_MISC exposes separate bits for INTA, INTB, INTC, and INTD.
However, this setup only creates a single IRQ mapping for hwirq 16 (INTA).

If INTB, INTC, or INTD asserts, amd_mdb_pcie_event() iterates over the bits
and calls generic_handle_domain_irq() for the unmapped hwirqs, which will f=
ail.
The handler then clears the status bit and returns IRQ_HANDLED. Since the
underlying device's interrupt was never serviced, it re-asserts immediately.
Does this create a permanent IRQ storm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803144412.7136=
39-1-sai.krishna.musham@amd.com?part=3D2
