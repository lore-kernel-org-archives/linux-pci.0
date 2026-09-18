Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4F3CDBD3;
	Fri, 18 Sep 2026 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746152; cv=none; b=hrUR+ZbIb1V8J0l2fHavLO4/tHU+ilSqOhkHMD1eb0esnta1RhusnFTb4fLmztULQB9TTKQwBDP7Y5/mN7ZmCIaru97ja+ddcY3Eg6QXudknnM+iFdNpiOdmT6SexoJTsT/hPUmF3Kg4Y3tdr/BrI5rPVCbgX0MOG6V3LlEtu28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746152; c=relaxed/simple;
	bh=Nc1fYKpfYDKJ2iaZhgv9D65V8x76BP9WBeFK94F2Lzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GDyMU+wiZqo51WQkEhwuyMG6lUBjXnt52Wp8zJjXg1p0akPz2pf4h6voZUMfnUgR0xI1xLfZ1LvkJw/ZT6CN5QM1E5EDFXqwX9IQrU9X3xJSyQz4Xv2QB2U/it/vfmteRzXvB0VcOstrHWWUypOv7nwi8qJVtdQBttbGxmiXtDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5UI4L0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5UI4L0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C2B1F000FF;
	Fri, 18 Sep 2026 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746151;
	bh=Nq1nNGrYp/QtXsu7/dFhrMpB6L0NdJSvHwjmt7m74zw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5UI4L0dk9WJCffHaEMN+FRzYKmcXQMJQviGeDVhhY0xzsmOWdDiANgKUDi6vQkWh
	 HEzSmy4RVRVCAYWJ1s7Qs5xaP7Q8G/rojaHFEXOC7Jbn6G4ChwVWVUO1bSr2bZWqRd
	 8wpT7IPAf0fHJZjEjIB3/M/hUsSWI0G8767/Tepx3mhMkT1nm1cRK0DVslBR6W0vU2
	 DsvGevz/TDafx85BN1GLEbEiybIavSOy20z8SX8MMNON4mVOgXZIUazD1cDVqlkX7R
	 RXrahPXqDkV81+3aTIKOefbixBUxeOHSg4hl+a8DF2Scjw8AzGfnMwYevneYtWuTUD
	 OSDGPWzEueuhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] misc: tc9564: introduce base PCI driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918152659.413268-3-elder@riscstar.com>
References: <20260918152659.413268-1-elder@riscstar.com>
 <20260918152659.413268-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:42:30 +0000
Message-Id: <20260918154230.E8C2B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: of_pci_make_dev_node quirk fails to update ranges of existing=
 DT node
- [Medium] kconfig: TC9564_PCI selects PCI_DYNAMIC_OF_NODES without inherit=
ing OF_IRQ dependency
--

commit d693efad7a099f6326c4b836ade779f0f07366be
Author: Alex Elder <elder@riscstar.com>

misc: tc9564: introduce base PCI driver

The Toshiba TC9564 is small and highly-specialized SoC that implements
a PCIe switch as well as an Ethernet AVB/TSN bridge. Create a new PCI
driver under drivers/misc that binds with the embedded PCI endpoint
functions within the TC9564 SoC. Use the PCI quirks mechanism to update
endpoint device nodes dynamically.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 7364931dad3a1..9c5b1e9d672e8 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig

[ ... ]

> @@ -568,6 +568,21 @@ config MCHP_LAN966X_PCI
>  	    - lan966x-miim (MDIO_MSCC_MIIM)
>  	    - lan966x-switch (LAN966X_SWITCH)
> =20
> +config TC9564_PCI
> +	tristate "Toshiba TC9564 PCI function support"
> +	depends on OF
> +	depends on PCI
> +	select PCI_DYNAMIC_OF_NODES

[Severity: Medium]
Can this cause a Kconfig unmet direct dependency warning?

PCI_DYNAMIC_OF_NODES explicitly defines 'depends on OF_IRQ' in
drivers/pci/Kconfig. Selecting it here without inheriting its dependencies
could cause unmet direct dependency warnings and potential build failures on
architectures lacking OF_IRQ support.

> +	select PCI_QUIRKS
> +	default m
> +	help

[ ... ]

> diff --git a/drivers/misc/tc9564-pci.c b/drivers/misc/tc9564-pci.c
> index 0000000000000..e4d00dfecfca9 100644
> --- /dev/null
> +++ b/drivers/misc/tc9564-pci.c

[ ... ]

> +	/* Scan for pci-ep-bus (simple-bus) nodes and probe their sub-devices */
> +	ret =3D of_platform_default_populate(np, NULL, dev);

[ ... ]

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21fd..54e310c4153df 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6391,6 +6391,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x502=
0, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_no=
de);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_no=
de);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node=
);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_n=
ode);

[Severity: High]
Will this quirk successfully update the ranges property of the existing
devicetree node?

Because the tc9564 device has a static device tree node, pci_set_of_node()
attaches the static node to pdev->dev.of_node before this fixup runs.

Inside of_pci_make_dev_node(), the early check for an existing node:

    if (pci_device_to_OF_node(pdev))
        return;

evaluates to true, causing it to return immediately. Consequently,
of_pci_prop_ranges() is never executed.

This means endpoint platform devices populated by of_platform_default_popul=
ate()
in tc9564_function_probe() will fail to map their MMIO addresses correctly,
translating addresses using the placeholder static 'ranges' property rather
than dynamically assigned PCI BAR addresses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918152659.4132=
68-1-elder@riscstar.com?part=3D2
