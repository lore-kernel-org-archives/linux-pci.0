Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18F46AED1;
	Tue, 14 Jul 2026 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036267; cv=none; b=OvMdXrx5C1EFQ0gBsDOBYr5chYp3lgQbIadzE49GOYleNmXS/2EB6GpeogVJ+50UKexlQNL7tRDUW/iwBvacLsKSK31sMULDoZ1158ThsoQixXn4JlPzf1/5qsfwXF+hWlAu0r56OWxuyvThEOtnLdW/hvCWttcstUhFeUZjMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036267; c=relaxed/simple;
	bh=Vks6p+Wt/0K1/SXbSBGlKT4hNpjD4Fg6SncklLe+XQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/KnNJ8KOEo53A/Krz8fXV8dnzRLzPQuu0JfwstyLWVsQ0io37WYqFYoQ/FVWMPwsmTGNxnZjSlIgfrL82MxEDjAgVJRvs4pdNgBe/VseMbh0Fp0W3TLdc9kimZLyMDIa8KkRJLUPOL5NtrVq+5l+F3XzwXFVJcLdUApUiA1M1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkdtxJz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkdtxJz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0394F1F000E9;
	Tue, 14 Jul 2026 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036266;
	bh=MRUxZmD7tUa8RV4aJ0FH1IXo7TRn2t4zqK4O1Y0A1CY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MkdtxJz+G7iwGq3xnYkjgbVTM2oD6KUjxOQ+3Aj+tCjKIwxi0PXH8ck/8SnKNIbVn
	 35NTJiDMCThgTuhJwy4EV3B7mvs7vjGet6EroD2X/f9pjF0k9jnXFDA9KD5A52fTNH
	 2S2nctq846H+2HGDRhx3duCXSC17DgzRifhFVS3HksHngESZUFyTPTYEKXvyYj0Fc1
	 PTZBiATyX9IGwM/j1l8zxkBHNxMJuetA94prM4dEn4mPPVvozs5YmBZ4aJSKJzSaUb
	 W+iDf9d7YpBneaODyWSUasppP/cZ2OlPxygzyfsC28jx8RZ0SXghR9ogwgw9QoC1ej
	 WYbnUz0jND3gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Isolate driver to ARM64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260714131957.38067-1-marek.vasut+renesas@mailbox.org>
References: <20260714131957.38067-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:37:45 +0000
Message-Id: <20260714133746.0394F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unjustified COMPILE_TEST restriction due to incorrect commit mes=
sage claim.

Pre-existing issues:
- [High] Missing return in error handling path leads to endpoint notificati=
on on a de-initialized endpoint.
--

--- Patch [1]: [PATCH v2] PCI: rcar-gen4: Isolate driver to ARM64 ---
commit 9fa6f24cbaf3124b832a16ce500ea61d355eb4f5
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: rcar-gen4: Isolate driver to ARM64

The driver includes linux/irqchip/arm-gic-v3.h which pulls in headers
which are available only on ARM and ARM64, on other architectures the
headers are not present and the driver fails to build. This driver is
used only on ARM64 hardware, isolate its build only to ARM64 to avoid
build failures on other architectures.

Link: https://lore.kernel.org/oe-kbuild-all/202607100310.iQw5m9Uo-lkp@intel=
.com/

> The driver includes linux/irqchip/arm-gic-v3.h which pulls in headers
> which are available only on ARM and ARM64, on other architectures the
> headers are not present and the driver fails to build.

[Severity: Medium]
Is this description accurate for the current tree?

A review of drivers/pci/controller/dwc/pcie-rcar-gen4.c confirms it does not
actually include linux/irqchip/arm-gic-v3.h or use GIC-specific macros. Does
restricting COMPILE_TEST strictly to ARM64 needlessly degrade cross-archite=
cture
build testing coverage?

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index aa0b784c85b47..0d4bf8d4cf565 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -344,7 +344,7 @@ config PCIE_RCAR_GEN4
> =20
>  config PCIE_RCAR_GEN4_HOST
>  	tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
> -	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on ARM64 && (ARCH_RENESAS || COMPILE_TEST)
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select PCIE_RCAR_GEN4
> @@ -355,7 +355,7 @@ config PCIE_RCAR_GEN4_HOST
> =20
>  config PCIE_RCAR_GEN4_EP
>  	tristate "Renesas R-Car Gen4 PCIe controller (endpoint mode)"
> -	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on ARM64 && (ARCH_RENESAS || COMPILE_TEST)
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	select PCIE_RCAR_GEN4

[Severity: High]
This isn't a bug introduced by this patch, but is it intentional that the e=
rror
path in rcar_gen4_add_dw_pcie_ep() falls through without returning?

drivers/pci/controller/dwc/pcie-rcar-gen4.c:rcar_gen4_add_dw_pcie_ep() {
    ...
	ret =3D dw_pcie_ep_init_registers(ep);
	if (ret) {
		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
		dw_pcie_ep_deinit(ep);
		rcar_gen4_pcie_ep_deinit(rcar);
	}

	pci_epc_init_notify(ep->epc);
    ...
}

If dw_pcie_ep_init_registers() fails, execution incorrectly falls through to
pci_epc_init_notify(), notifying any bound EPF devices that the endpoint is
ready. Since the hardware has just been de-initialized, could an EPF driver
attempting to interact with the EPC cause bus faults or use-after-free
conditions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714131957.3806=
7-1-marek.vasut+renesas@mailbox.org?part=3D1
