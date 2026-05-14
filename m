Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEE2E8DEA;
	Thu, 14 May 2026 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719255; cv=none; b=RXnqKEa9qzdR7IvJx681E4b77yy3t2bQNQsrTi6ixuHUayWWd1k+NouhtlDMO2+dfcyiWLbx0zSwYkrkTvypJ/hRZx6ppEUPO7jX/q6i0O8mXomCICK038R2XzmL1H2j1ZsWX5yD/wbSEJU836Ovy+jgj9oeWC0f+XuvmIdyJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719255; c=relaxed/simple;
	bh=9xPoi/jOuwJ24aHDa6rb5dxZ5tEHkzImVHb7GEE3Ank=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pWe8BGEW5raWGrA3k1rOM1kRZHODxHjnI93vMZsvyNZ/ZkSmg9XzYptQDfTZeH5E4Vmh1u3PpsaKKbP517bMMGV6X334Tbkbc0kwQZGzgnf47dApB2iu73OSrMtu93o1rpjVor5tJI0nXjuzWZMURpI7XexrR291oLaXIBv8zBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwALq+zL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwALq+zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBCAC19425;
	Thu, 14 May 2026 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778719255;
	bh=9xPoi/jOuwJ24aHDa6rb5dxZ5tEHkzImVHb7GEE3Ank=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WwALq+zLr6juGAVWrscXnuOn6M+Si5TMteJB+GlzHW2Ua9l/ulr3ZqFHDIoqxBLIb
	 PsXuSuvGg1sWjx4YeukBgtb52oaRaGE4srSMeiv4gLcwxlru211RTF5oPyfY3NVpwX
	 RjsyS3yLRE15Szc26kgtaNVBqqz0tR+E5W1j9PpyLSZfIvgIVU0NMEIBY7Ed3P81j3
	 kJ4vG+OYVhVKHzNMUOpK9owGmrcpvOPOfceZlaNHJJ6utHDOugmWc+cKHjv7EvLnhR
	 LYdwAVb2g2qsJJga3NlxT7KQBG4MvwfpaOZPvAKoS//6P/b7v7PBE2O6rvGSm2dZ1w
	 Awwq7LSKuCOHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jihong Min" <hurryman2212@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260512213910.871859-2-hurryman2212@gmail.com>
References: <20260512213910.871859-2-hurryman2212@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:40:54 +0000
Message-Id: <20260514004055.1BBCAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The Kconfig dependency `depends on USB_XHCI_PCI=3Dy` completely di=
sables PROM21 support for systems where the core driver is built as a modul=
e.
- [Low] Signed integer overflow when calculating the auxiliary device ID.
--

commit 20f4e35b2f88ebe2b8988b4f07fe7cc28199096b
Author: Jihong Min <hurryman2212@gmail.com>
Subject: usb: xhci-pci: add AMD Promontory 21 PCI glue

This commit adds a small PCI glue driver for AMD Promontory 21 xHCI
controllers. It binds the controllers, delegates USB host operation to
the common xHCI PCI core, and creates an auxiliary device for optional
temperature sensor support.

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig

[ ... ]

> @@ -42,6 +42,26 @@ config USB_XHCI_PCI
>  	depends on USB_PCI
>  	default y
> =20
> +config USB_XHCI_PCI_PROM21
> +	bool "AMD Promontory 21 xHCI PCI support"
> +	depends on X86
> +	depends on USB_XHCI_PCI=3Dy

Does depending strictly on USB_XHCI_PCI=3Dy cause a configuration regression
for most distributions where the core driver is configured as a module?

The driver source appears fully capable of being built as a module, using
module-related macros and module_pci_driver().

If the intent is to prevent an early boot mismatch where xhci-pci is
built-in but the PROM21 glue is a module, could this instead be a tristate
option using depends on USB_XHCI_PCI and depends on !(USB_XHCI_PCI=3Dy && m=
)?
This would enforce the boot constraint while preserving support for modular
kernel builds.

[ ... ]

> diff --git a/drivers/usb/host/xhci-pci-prom21.c b/drivers/usb/host/xhci-p=
ci-prom21.c
> --- /dev/null
> +++ b/drivers/usb/host/xhci-pci-prom21.c

[ ... ]

> +static int prom21_xhci_create_auxdev(struct pci_dev *pdev)
> +{
> +	struct prom21_xhci_auxdev *prom21_auxdev;
> +	struct usb_hcd *hcd =3D pci_get_drvdata(pdev);

[ ... ]

> +	prom21_auxdev->auxdev =3D
> +		auxiliary_device_create(&pdev->dev, KBUILD_MODNAME, "hwmon",
> +					&prom21_auxdev->pdata,
> +					(pci_domain_nr(pdev->bus) << 16) |
> +						pci_dev_id(pdev));

Does left-shifting pci_domain_nr() introduce a signed integer overflow
regression?

The function pci_domain_nr() returns a signed int, which can be up to 0xFFFF
on ACPI systems. Left-shifting a value of 0x8000 or greater by 16 bits
alters the sign bit of a 32-bit int, resulting in undefined behavior in C.

Would casting the return value to an unsigned integer, such as
(u32)pci_domain_nr(pdev->bus) << 16, avoid this overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512213910.8718=
59-1-hurryman2212@gmail.com?part=3D1
