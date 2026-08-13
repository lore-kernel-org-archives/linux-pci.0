Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B33C063A
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665409; cv=none; b=c9XO5ijLbEWqcQ7bnXYsZwaKbB46UFU4bAT/A9mpGI+k8CEvantNAXmUxjpIydqV/60yNAzd/aPRJsABTocC5aM2u8uUwwQHs8grXDZ8KYQMUbcR1txLGSV3aQxiXqkNIvchocVV0DNJXVlfkcHzIBc7hidubidpgWTFfabr2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665409; c=relaxed/simple;
	bh=mWiNcibqBQQB9YJvxL4AoMrUAkpwYVHtR/+XX/wLiWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pYtnDAwG4e5CaDsxskq3p7VNGWpoqdNy+DwWHyF7HLKT7ucBIJYgTZyvSGl9+1z7phncmoelXbUv8ArtBVuciTzBiMqpqrXPDlweAmj+kyKkuA2Z/WBB60VSgZcM7Eq7WRcuizaezEjQC3KQRjDw6bfqxa5KT2UZlQxfHcF54os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1maOVjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1maOVjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AFF1F000E9;
	Thu, 13 Aug 2026 23:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665408;
	bh=7wPZSV2mR/fhPSS1Gtf+eKeTUbfWo4yqE967oBlZLts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h1maOVjNWFMZNpAoQ2HxltRCfHu9Idjzjsx1e+hp1VA//jEjb9Fd+F199HLD6A0Tf
	 K5Yydtfjzq3u+8bZy8P3YyosUsw0SuFjuabhOytEeff9u+H+chsiPReDeErQay7aJY
	 1of0alKYepavG3kJUHUYCU1kY+2n+YSsSPRblPrCCfx70F/8kGNOegdIqJOD1J+BfD
	 JM2VLYgCYAymWqYdwd3mWCjxhLgyCC99BwfnDlQ+Eaik41Ae7IOJ7PfACAWx5lzcCs
	 c5TIzoLqD5LtZ/l3jEXS9LHjFly6EAaktvZWvRvDZ2A45v7bQcIJOBaMU5YzbMfmdV
	 6tw7XdEnUfeog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/14] PCI: tegra194: Fix CBB timeout caused by DBI
 access before core power-on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260324190755.1094879-15-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-15-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:56:47 +0000
Message-Id: <20260813235648.05AFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Null pointer dereference in dwc_pcie_rasdes_debugfs_deinit() w=
hen RAS DES capability is absent. This problem wasn't introduced by this pa=
tch, but causes an unconditional crash on cleanup.
- [High] Unbounded memory leak of DMA coherent memory, EDMA controller stru=
ctures, and debugfs elements on every PERST# deassertion. This problem wasn=
't introduced by this patch, but it causes a remotely triggerable DoS.
- [High] Double free and UAF of EDMA, debugfs, and PTM pointers due to miss=
ing pointer invalidation in cleanup paths. This problem wasn't introduced b=
y this patch, but causes a kernel panic on repeated cleanup.
- [High] Unchecked return value of reset_control_deassert() leads to the id=
entical CBB hardware timeout. This problem wasn't introduced by this patch,=
 but the patch relies on the deassert succeeding.
- [High] Calling dw_pcie_ep_deinit() in module removal path triggers a CBB =
timeout. This problem wasn't introduced by this patch, but crashes the syst=
em on driver unbind.
--

--- Patch [14]: [PATCH v8 14/14] PCI: tegra194: Fix CBB timeout caused by D=
BI access before core power-on ---
commit 10ff75dbe7f3c6a826d07e1505268c730461b17c
Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: PCI: tegra194: Fix CBB timeout caused by DBI access before core po=
wer-on

This patch delays the endpoint cleanup operations in the TEGRA194 PCI driver
until after the core reset has been deasserted. By moving
pci_epc_deinit_notify() and dw_pcie_ep_cleanup() after
reset_control_deassert(), it ensures the dbi registers are accessible. This
prevents a cbb timeout that occurs when accessing registers on an unpowered
core.

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index b159836b7e9a0..b13f7221c9761 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1749,10 +1749,6 @@ static void pex_ep_event_pex_rst_deassert(struct t=
egra_pcie_dw *pcie)
>  		goto fail_phy;
>  	}
> =20
> -	/* Perform cleanup that requires refclk */
> -	pci_epc_deinit_notify(pcie->pci.ep.epc);
> -	dw_pcie_ep_cleanup(&pcie->pci.ep);
> -
>  	/* Clear any stale interrupt statuses */
>  	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);

[ ... ]

> @@ -1822,6 +1818,10 @@ static void pex_ep_event_pex_rst_deassert(struct t=
egra_pcie_dw *pcie)
> =20
>  	reset_control_deassert(pcie->core_rst);

[Severity: High]
This is a pre-existing issue, but is it safe to proceed without checking th=
e=20
return value of reset_control_deassert() here?

If reset_control_deassert() fails and returns an error, the core remains=20
unpowered and reset is still asserted. The code then proceeds to call=20
dw_pcie_ep_cleanup() and access dbi registers.

Accessing the dbi registers on an unpowered core triggers the exact same cb=
b=20
hardware timeout (bus error) that this patch intends to fix.

> +	/* Perform cleanup that requires refclk and core reset deasserted */
> +	pci_epc_deinit_notify(pcie->pci.ep.epc);
> +	dw_pcie_ep_cleanup(&pcie->pci.ep);

[Severity: High]
This isn't a bug introduced by this patch, but does repeatedly calling=20
dw_pcie_ep_cleanup() followed by dw_pcie_ep_init_registers() cause a memory=
=20
leak?

When the host repeatedly toggles the perst# signal, each deassertion calls=
=20
dw_pcie_ep_init_registers(), which unconditionally allocates memory using=20
devres/dmam functions (like dw_pcie_edma_ll_alloc(), dw_edma_probe(), and=20
dwc_pcie_debugfs_init()).

Since dw_pcie_ep_cleanup() unregisters the subsystems but cannot free the=20
devm_ allocated memory, this leads to an unbounded memory leak on every=20
link toggle.

[Severity: High]
This is a pre-existing issue, but does dw_pcie_ep_cleanup() leave pointers=
=20
dangling?

When pex_ep_event_pex_rst_deassert() calls dw_pcie_ep_cleanup(), it frees=20
resources (like irqs via dw_edma_remove() and dentries via=20
dwc_pcie_debugfs_deinit()), but leaves pointers dangling.

If dw_pcie_ep_init_registers() fails before updating these pointers, they=20
remain dangling. A subsequent perst# deassertion will call=20
dw_pcie_ep_cleanup() again on the dangling pointers, resulting in a double=
=20
free of irqs and a use-after-free of dentries.

[Severity: Critical]
This is a pre-existing issue, but does dw_pcie_ep_cleanup() trigger a null=
=20
pointer dereference when the rasdes capability is absent?

If the hardware lacks the rasdes capability, dwc_pcie_rasdes_debugfs_init()=
=20
returns early without allocating rasdes_info, leaving=20
pci->debugfs->rasdes_info as NULL.

When dw_pcie_ep_cleanup() runs (either on driver removal or perst# toggle),=
=20
dwc_pcie_rasdes_debugfs_deinit() is called, which unconditionally dereferen=
ces=20
pci->debugfs->rasdes_info to destroy the mutex:

drivers/pci/controller/dwc/pcie-designware-debugfs.c:dwc_pcie_rasdes_debugf=
s_deinit() {
    struct dwc_pcie_rasdes_info *rinfo =3D pci->debugfs->rasdes_info;
   =20
    mutex_destroy(&rinfo->reg_event_lock);
    ...
}

This will cause a kernel panic on cleanup.

[Severity: High]
This isn't a bug introduced by this patch, but does the driver module remov=
al=20
path also trigger a cbb timeout?

Looking at tegra_pcie_dw_remove() in drivers/pci/controller/dwc/pcie-tegra1=
94.c,=20
it calls pex_ep_event_pex_rst_assert(), which completely disables core cloc=
ks=20
and asserts the core reset.

It then immediately calls dw_pcie_ep_deinit(), which invokes dw_edma_remove=
()=20
and writes to eDMA hardware registers. Accessing registers while clocks are=
 off=20
and reset is asserted causes the same cbb timeout (bus error), hanging the=
=20
system during module unbind.

> +
>  	val =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>  	val &=3D ~PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324190755.1094=
879-1-mmaddireddy@nvidia.com?part=3D14
