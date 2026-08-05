Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFC442B26
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928076; cv=none; b=qXlGsyocqBnfc1afzTXQPG47+1pCSPoqcQpesQUGK8BKqLxAPhimxAT3uWEgxdp/J4NNNAtVGeVmbeXS8AEiHqHwlaC9gwj+bUwqt+hsK+3MLTKvZbZkwtD/dLN+Fq6q6of+E/V9GLi2zbzhvyvy8lt/9nuX0GwqSXNs8WvctWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928076; c=relaxed/simple;
	bh=1Dj0BZnxhzbTVRzZl9WD+AcAqWudLqDXBRWKcSzghs0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NPp/dkeZfOhJUlK1lN6J82C8mpbTgCFtlfs3HyOgfOJy2XFexwBcNtfErYga+LMBSKwAH/o3iu5PatpI5sGtsgC2C9EQZp4DFAlCfczLz/BhtBOkbdRJyKDSYeVYgQrmD9Hl9PKZ1POXMVMqEDXxjzrv+5vbn/i3TI4ttfAEV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1tpqHEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1tpqHEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE9D1F000E9;
	Wed,  5 Aug 2026 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785928072;
	bh=8Zk5Gvpf35cUo0nbppdbF70CvQmfAzPdygN0Q/a2pO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1tpqHEvOysYYc9b6tRGWr4fguwKfHpCoRk46tB9PRtLUL9Wbb94Oa7BfDBAf9Rcm
	 uKcsG7kAPIq/D3Nktu/A0FWs/t1uotmCtOgcpALPLv9GQqZusZHLArxArjSiAHgLpC
	 vs6lcZWvMuMCJiVMsP4Ue/T5nSKsdpjwshRxJTCSyKZ1P1grAwymNVadqn7e1VbPgq
	 45nUdrUhveALNgY9Sqi+u737Q18Y40pdAheBtn2H1VSOfEXQn8gTwVZUMVyzl9Cvop
	 5kPSvOIJElsJBXKYAHhK9krTz8GBMCKghKP9KjpMGH9ubKxxzh64YXMX0o4Vcud8/6
	 ahG63KqimYNAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: cadence-plat: Fix host/endpoint dependencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260805105014.3952686-1-a-garg7@ti.com>
References: <20260805105014.3952686-1-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:07:51 +0000
Message-Id: <20260805110752.4AE9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid drvdata cast in cdns_plat_pcie_shutdown causes out-of-boun=
ds access and kernel panic.
- [High] Probe error paths unconditionally return 0, masquerading initializ=
ation failures as success.
--

--- Patch [1]: [PATCH] PCI: cadence-plat: Fix host/endpoint dependencies ---
commit f31c2dc6bdd9c13d43549cb7b505f8e0289ac1c5
Author: Aksh Garg <a-garg7@ti.com>

PCI: cadence-plat: Fix host/endpoint dependencies

The cadence-plat driver has a single platform driver that can be built-in
or a loadable module, but it calls two separate backend drivers depending
on whether it is a host or endpoint. Fix this by moving the 'select' of=20
PCIE_CADENCE_HOST and PCIE_CADENCE_EP into the common PCIE_CADENCE_PLAT=20
symbol.

Link: https://lore.kernel.org/linux-next/589ea512-93c6-4e1c-83d7-ba45a0b358=
43@infradead.org/

> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/control=
ler/cadence/Kconfig
> index 9e651d5459735..fd704dec47dda 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in
drivers/pci/controller/cadence/pcie-cadence-plat.c:cdns_plat_pcie_shutdown(=
).
The function casts the drvdata to struct cdns_pcie:

drivers/pci/controller/cadence/pcie-cadence-plat.c:cdns_plat_pcie_shutdown(=
) {
	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
	...
	cdns_pcie_disable_phy(pcie);
}

However, the probe function allocates a smaller wrapper struct and sets it
as drvdata:

drivers/pci/controller/cadence/pcie-cadence-plat.c:cdns_plat_pcie_probe() {
	cdns_plat_pcie =3D devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
	...
	platform_set_drvdata(pdev, cdns_plat_pcie);
}

Since cdns_pcie_disable_phy() attempts to read pcie->phy_count and iterates
over pcie->phy[i], could this out-of-bounds access cause a kernel panic
during shutdown?

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a problem
with the error handling in the probe function:

drivers/pci/controller/cadence/pcie-cadence-plat.c:cdns_plat_pcie_probe() {
	...
 err_init:
 err_get_sync:
	pm_runtime_put_sync(dev);
	pm_runtime_disable(dev);
	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
	phy_count =3D cdns_plat_pcie->pcie->phy_count;
	while (phy_count--)
		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);

	return 0;
}

Does this unconditionally return 0 on failure paths?

It looks like the error code is dropped, which would masquerade probe
failures as successes. This could leave the driver bound while its resources
are actually disabled, potentially leading to crashes on unbind or shutdown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805105014.3952=
686-1-a-garg7@ti.com?part=3D1
