Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9E392811;
	Wed, 19 Aug 2026 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160767; cv=none; b=lmGYau0amLJ4j1krnNmI3B70oy3ejg9mQ1GtcecJLB9lSqoakUufCNPosPlfYPmahETwqj3w+c4u64g63HAMkhI4RvhUUSIRb567BdR166kzdFYTN0H5HAQX53TOkixrPbkN1q7WcEfzfst/PKhftVj+kqSG8J7l3qOEmOVnPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160767; c=relaxed/simple;
	bh=Qy0MqMKmMCYD/xywyWZaD/JbE4rnCiLe4nfBPEZ5pKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lJHPNoroNtB5VOpImp4OwIpRlBGYHXSCGyzkDJf8FsA7o7YBzrJXdSwOTbA3NcypGhlRblzOsyasMKjOxaeqBnjOdh3ws61t7o6vLnAN7EanAXPfTz5GKe4FLBPmFi014qwOcNeoILZt4k5ctZS1fCExTk+cR1TW1q1hkFHkpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHPURa9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHPURa9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778871F00A3D;
	Wed, 19 Aug 2026 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160765;
	bh=8jJDbZub/J6SXZXitZoNMXHQ2ERBZRvx6BO+6bpZMh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FHPURa9tI0aA3zmnKzYsBqeBNHrn+q+23As661CnYCpwO1+aaSj7caohJ8pg68Irk
	 ctSRTMakqncRN2YIFpofr9XuIpprZAg2PjWRhT06V+plBU3Z08XpYkqb5Zy4aMtU8l
	 z/NxXdJLRSQmcrwTup/2Qmsdm1rBKESx9+HWKn4aL2t0v0cdYDInYpdN0EYm5yDwvH
	 3MrQLr1gHlYSxLMbyQdb/GPG1uMZkPO8yJqvjC5T9JsRUuMg+q/Lw25PvFHCfTrqDV
	 T7uGSqxJqGc/uG0j1KSypGuXCOOfpLWF8lhVbK8LvysS+YokfBTdlR6SY+pk1ekJIG
	 pIx8MOcTDkO9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] PCI: amd-mdb: Add CPM6 host controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260819172057.3636214-3-sai.krishna.musham@amd.com>
References: <20260819172057.3636214-1-sai.krishna.musham@amd.com>
 <20260819172057.3636214-3-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 17:32:45 +0000
Message-Id: <20260819173245.778871F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The shared event interrupt handler `amd_mdb_pcie_event` unconditio=
nally returns `IRQ_HANDLED` and clears shared aggregators even when no even=
ts are pending, breaking spurious interrupt detection and potentially disru=
pting the peer host.
- [High] The CPM6 hardware INTx enable bit is unconditionally unmasked duri=
ng initialization and probe, completely defeating the newly added `intx_ref=
mask` refcount logic and leaving the system vulnerable to unhandled interru=
pt storms.
- [High] Probe error path and teardown destroy IRQ domains while devm-manag=
ed IRQs and mappings are still active, leading to leaked mappings, kernel w=
arnings, and potential use-after-free via the shared IRQ line.
- [Medium] Failing to disable hardware interrupts on an early probe error p=
ath leaves the shared line asserted, potentially causing an endless IRQ sto=
rm.
--

--- Patch [2]: [PATCH v6 2/2] PCI: amd-mdb: Add CPM6 host controller suppor=
t ---
commit 35b39748e651a7f764a655c28114103b16705e80
Author: Sai Krishna Musham <sai.krishna.musham@amd.com>
Subject: PCI: amd-mdb: Add CPM6 host controller support

This commit adds support for the AMD Versal2 CPM6 host controller variants.
It introduces a new interrupt register layout and handles a shared GIC event
interrupt line by clearing the controller's aggregator contribution.

> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/cont=
roller/dwc/pcie-amd-mdb.c
> index dee295f281a30..4355fa6d48a39 100644
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c

[ ... ]

> @@ -193,11 +285,10 @@ static void amd_mdb_event_irq_unmask(struct irq_dat=
a *d)
>  	struct dw_pcie *pci =3D &pcie->pci;
>  	struct dw_pcie_rp *port =3D &pci->pp;
>  	unsigned long flags;
> -	u32 val;
> =20
>  	raw_spin_lock_irqsave(&port->lock, flags);
> -	val =3D BIT(d->hwirq);
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> +	writel_relaxed(BIT(d->hwirq),
> +		       pcie->intr_base + pcie->variant->misc_enable_reg);
>  	raw_spin_unlock_irqrestore(&port->lock, flags);
>  }

[Severity: High]
Does this unconditionally unmask the INTx enable bit in the hardware
register?

Since devm_request_irq() will call amd_mdb_event_irq_unmask(), it appears
the parent IRQ subsystem will unconditionally write the hardware bit here.
Would this completely defeat the intx_refmask refcount logic added in
amd_mdb_intx_irq_unmask(), and leave the system vulnerable to an unhandled
interrupt storm if a downstream device asserts INTx early?

[ ... ]

> @@ -226,13 +317,30 @@ static irqreturn_t amd_mdb_pcie_event(int irq, void=
 *args)
>  {
>  	struct amd_mdb_pcie *pcie =3D args;
>  	unsigned long val;
> +	u32 ev_raw;
>  	int i;
> =20
> -	val =3D readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> -	val &=3D ~readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_MASK_MISC);
> +	ev_raw =3D readl_relaxed(pcie->intr_base + pcie->variant->misc_status_r=
eg);
> +	val =3D ev_raw;
> +	val &=3D ~readl_relaxed(pcie->intr_base + pcie->variant->misc_mask_reg);

[ ... ]

> +	/* Clear handled + any unhandled sticky bits to avoid IRQ storms. */
> +	writel_relaxed(ev_raw, pcie->intr_base + pcie->variant->misc_status_reg=
);
> +
> +	/* Sticky aggregation bits; clear each pass or the IRQ re-fires */
> +	amd_mdb_pcie_clear_aggregators(pcie);
> =20
>  	return IRQ_HANDLED;
>  }

[Severity: High]
Could this function unconditionally return IRQ_HANDLED and clear the
shared aggregators even when there are no events pending (when
ev_raw =3D=3D 0)?

The IRQ_NONE return logic seems to have been placed in dw_pcie_rp_intx()
instead of here. Does returning IRQ_HANDLED unconditionally break spurious
interrupt detection for the shared line?

Also, if the peer host triggered the interrupt, will this clear the shared
AMD_CPM6_PS_MISC_IR_STATUS aggregator before the peer can process it?

[ ... ]

> @@ -250,24 +358,59 @@ static void amd_mdb_pcie_free_irq_domains(struct am=
d_mdb_pcie *pcie)

[ ... ]

> +static void amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
> +{
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
> =20
>  	/* Clear pending TLP interrupts. */
> -	val =3D readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> -	val &=3D AMD_MDB_PCIE_IMR_ALL_MASK;
> -	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +	val =3D readl_relaxed(pcie->intr_base + pcie->variant->misc_status_reg)=
 &
> +	      misc_mask_all;
> +	writel_relaxed(val, pcie->intr_base + pcie->variant->misc_status_reg);
> =20
>  	/* Enable all TLP interrupts. */
> -	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
> -		       pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> +	writel_relaxed(misc_mask_all,
> +		       pcie->intr_base + pcie->variant->misc_enable_reg);

[Severity: High]
Does this unconditionally write misc_mask_all (which contains the INTx
enable bit) to the hardware enable register?

Similar to the issue in amd_mdb_event_irq_unmask(), does this bypass the
dynamic intx_refmask refcounting logic intended for the child domain?

[ ... ]

> @@ -435,9 +601,36 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie=
 *pcie,
>  	struct device *dev =3D &pdev->dev;
>  	int err;
> =20
> -	pcie->slcr =3D devm_platform_ioremap_resource_byname(pdev, "slcr");
> -	if (IS_ERR(pcie->slcr))
> -		return PTR_ERR(pcie->slcr);
> +	if (pcie->variant->version =3D=3D MDB5) {

[ ... ]

> +		pcie->intr_base =3D devm_platform_ioremap_resource_byname(pdev, "intr"=
);
> +		if (IS_ERR(pcie->intr_base))
> +			return PTR_ERR(pcie->intr_base);
> +	}
> =20
>  	err =3D amd_mdb_pcie_init_irq_domains(pcie, pdev);
>  	if (err)
> -		return err;

[Severity: Medium]
If amd_mdb_pcie_init_irq_domains() fails, this returns the error directly
and bypasses the out label.

Does this skip the newly added amd_mdb_pcie_disable_interrupts() call,
potentially leaving the shared line asserted and causing an interrupt storm?

[ ... ]

> @@ -466,6 +659,11 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie=
 *pcie,
>  	return 0;
> =20
>  out:
> +	/*
> +	 * Mask the hardware interrupts before tearing down so a stale source
> +	 * cannot storm the shared CPM6 GIC line once this host is unwound.
> +	 */
> +	amd_mdb_pcie_disable_interrupts(pcie);
>  	amd_mdb_pcie_free_irq_domains(pcie);
>  	return err;
>  }

[Severity: High]
Does this error cleanup path destroy the IRQ domains while the devm-managed
IRQs and mappings are still active?

Because devres frees the requested handlers after the probe function return=
s,
the newly shared IRQ handler remains active while pcie->mdb_domain is NULL.
Can an asynchronous interrupt from the peer controller hitting the handler
during this window cause a NULL pointer dereference?

Should the mappings be disposed of via irq_dispose_mapping() or the handlers
freed explicitly before destroying the domains?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819172057.3636=
214-1-sai.krishna.musham@amd.com?part=3D2
