Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8D1A9B58
	for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784382956; cv=none; b=BJHuxlG7/5dtT0xMJvl9YKHmOg6aVA5vt2f0u8K+Y8Q6AasyPs8j3R4PWkQ9Gychma+50/bPDYI1Pe7j5xZJKr0l1uoBlf7R2zopsNq/fGrmKAvz+yXjuYw/hqm7uDyh4Cn8KMLXORWlRW+cDQxk40C3NghOyaJFCdsHGd+i5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784382956; c=relaxed/simple;
	bh=76q9Pc11jdXZuZcM5STl5ZlxRM1kQyXB4tHLzEa5vAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eApb+hUpTktULb3kS12FPTx3+UbrWSlVeMaHgY+Wz+44gBjl4ollOumATDiLTCZWHBUFemC1WyIRtcFdm8dAiUs/TvRToHhtp/Z4u8WUerJhD8HA02sJo9rY1/jc276rDAQaBlohM3PPlAtwF+NZ9bfO24jZW8DIp+4ceU4Bh3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVPRKghZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVPRKghZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA03E1F000E9;
	Sat, 18 Jul 2026 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784382954;
	bh=Osc08uhvQRF1zh+wxmkgqd2zhpsfq/TvlB7jDaimTOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SVPRKghZdGWDs42mIPYUC1DPdHxuZSo/dXEExf3btO3jizmQN92rfLysSUwcqtBAq
	 fkYj5PVmvXuoUHS2UxmClItkhqLmR5qh5loR6O0rfDMmvatRlONRdVUJs29yZc3agx
	 Ka+sT2vU9sQxdBAwhyX7g/rjHH858Uodr9vW9yqRecSIcMLoU1ZDpF7awC5FYFXBR8
	 cqNCALH6I2au8P0tNU3jmO9g532p34hsbdARkpCyoC6XwAUXpdaQJw8qF6EB7u6Xaf
	 QvcSnN2taNyztLtpWnszXdE+2YAN+12KEFEgUr/qzOifvTYlsy7t07AoguUqKw9/0C
	 FWwwCdGFgXGnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: starfive: Fix Runtime PM handling and teardown
 ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260718133825.445041-1-alitariq45892@gmail.com>
References: <20260713145014.740898-1-alitariq45892@gmail.com>
 <20260718133825.445041-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 13:55:54 +0000
Message-Id: <20260718135554.AA03E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver ignores the return value of `pm_runtime_get_sync()` dur=
ing probe, which can lead to unmanaged hardware register accesses.
- [High] `starfive_pcie_host_init()` leaks resources on error paths and sil=
ently ignores `regulator_enable()` failures.
- [High] IRQ domains are permanently leaked on error paths during initializ=
ation.
- [High] Use-After-Free of `irq_domain` and access to disabled hardware due=
 to improper `devres` interrupt teardown.
- [High] Leaked virtual IRQ mappings (virqs) because `irq_dispose_mapping()=
` is never called on teardown.
- [Medium] Incorrect wrapper macro `pm_sleep_ptr()` used for the `dev_pm_op=
s` structure pointer.
--

--- Patch [1]: [PATCH v2] PCI: starfive: Fix Runtime PM handling and teardo=
wn ordering ---
commit 8242552d46d79f7bcd9a83c741e3ab1492a12e4c
Author: Ali Tariq <alitariq45892@gmail.com>

PCI: starfive: Fix Runtime PM handling and teardown ordering

The starfive_pcie_remove() path incorrectly disabled runtime PM before
executing plda_pcie_host_deinit(), which can cause unmanaged hardware regis=
ter
access while power domains or clocks are disabled. Fix this by restructuring
starfive_pcie_remove() to deinitialize the host hardware first while runtime
PM is active, followed by a synchronous pm_runtime_put_sync() and
pm_runtime_disable().

Link: https://lore.kernel.org/linux-pci/20260712180440.423421F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/co=
ntroller/plda/pcie-starfive.c
> index 298036c3e7f94..6b439378e82eb 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -436,9 +436,9 @@ static void starfive_pcie_remove(struct platform_devi=
ce *pdev)
>  {
>  	struct starfive_jh7110_pcie *pcie =3D platform_get_drvdata(pdev);
> =20
> -	pm_runtime_put(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
>  	plda_pcie_host_deinit(&pcie->plda);

[Severity: High]
This isn't a bug introduced by this patch, but does this deinitialize the I=
RQ
domains and hardware clocks before devres has freed the interrupts requested
with devm_request_irq()?

The driver allocates event interrupts using devm_request_irq(), which delays
free_irq() until after starfive_pcie_remove() completes. However, calling
plda_pcie_host_deinit() manually removes the irq_domain structures and fully
disables the hardware clocks and PHY.

When devres eventually invokes free_irq() on device unbind, the kernel will
dereference the freed IRQ domain and invoke the masking callback:

drivers/pci/controller/plda/pcie-plda-host.c:plda_mask_event_irq() {
	...
	val =3D readl_relaxed(port->bridge_addr + IMASK_LOCAL);
	val &=3D ~mask;
	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
	...
}

Can this access hardware registers when they have already been unclocked,
resulting in a Use-After-Free and a synchronous external abort?

> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  	platform_set_drvdata(pdev, NULL);
>  }

While reviewing this code, I noticed a few other pre-existing issues in
related areas:

drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_probe() {
	...
	pm_runtime_enable(&pdev->dev);
	pm_runtime_get_sync(&pdev->dev);

[Severity: High]
This is a pre-existing issue, but is the return value of pm_runtime_get_syn=
c()
ignored here during probe?

If pm_runtime_get_sync() fails to enable the PM domain or clocks, the error
will go undetected. Will the driver then proceed to access unpowered hardwa=
re
registers, potentially causing a synchronous external abort?


drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_driver {
	...
	.driver =3D {
		.name =3D "pcie-starfive",
		.of_match_table =3D of_match_ptr(starfive_pcie_of_match),
		.pm =3D pm_sleep_ptr(&starfive_pcie_pm_ops),

[Severity: Medium]
This isn't a bug introduced by this patch, but shouldn't pm_ptr() be used h=
ere
instead of pm_sleep_ptr() for the dev_pm_ops structure pointer?

The Power Management Subsystem guidelines mandate using pm_ptr() for the
structure pointer when PM callbacks are involved. Using pm_sleep_ptr()
inappropriately ties the structure's inclusion directly to CONFIG_PM_SLEEP
rather than CONFIG_PM.


drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_host_init() {
	...
		ret =3D regulator_enable(pcie->vpcie3v3);
		if (ret)
			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");

[Severity: High]
This is a pre-existing issue, but is there a missing return statement after
the regulator_enable() failure?

If regulator_enable() fails, it prints an error via dev_err_probe() but
execution proceeds to touch hardware without the required 3.3V supply.

Also, if starfive_pcie_clk_rst_init() fails earlier in this function, it
returns the error immediately without disabling the previously enabled PHY.
Does this permanently leak the PHY resources?


drivers/pci/controller/plda/pcie-plda-host.c:plda_pcie_init_irq_domains() {
	...
	port->intx_domain =3D irq_domain_create_linear(of_fwnode_handle(pcie_intc_=
node), PCI_NUM_INTX,
						     &intx_domain_ops, port);
	if (!port->intx_domain) {
		dev_err(dev, "failed to get an INTx IRQ domain\n");
		of_node_put(pcie_intc_node);
		return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak the
event_domain created immediately prior?


drivers/pci/controller/plda/pcie-plda-host.c:plda_pcie_host_init() {
	...
	ret =3D plda_init_interrupts(pdev, port, plda_event);
	if (ret)
		goto err_host;

[Severity: High]
This is a pre-existing issue, but does this error jump bypass the err_probe
label where plda_pcie_irq_domain_deinit() would normally clean up the IRQ
domains?

If plda_init_interrupts() fails during probe, jumping directly to err_host
completely skips the irq_domain cleanup, causing a resource leak.


drivers/pci/controller/plda/pcie-plda-host.c:plda_pcie_irq_domain_deinit() {
	...
	irq_domain_remove(pcie->msi.dev_domain);

	irq_domain_remove(pcie->intx_domain);
	irq_domain_remove(pcie->event_domain);

[Severity: High]
This isn't a bug introduced by this patch, but are these domains removed
without first disposing of their associated IRQ mappings?

The driver uses irq_create_mapping() to allocate virtual IRQs for event_irq,
intx_irq, and msi_irq. Removing the domains without disposing of the mapped
virqs via irq_dispose_mapping() leaks the IRQ descriptors and mapping entri=
es.
Could this trigger a WARN_ON within irq_domain_remove() because the domain's
radix tree still contains active mappings on teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718133825.4450=
41-1-alitariq45892@gmail.com?part=3D1
