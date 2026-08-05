Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC944E64D;
	Wed,  5 Aug 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931841; cv=none; b=iIL4YB7CPRoLRWVLHwhX4bNYuhNingY+RDgv39VCIGLt/0PcJfGeabcj584LmUZraEDoNbrpyrYjwHW4pDravssPaJG0Sql/AUTRQ35GqoMARh3hcANcVndJ+mu1FOecclxEXSOyCUEbckS/4jqZ4/ezrGgP4G9gbZyrAxP3ZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931841; c=relaxed/simple;
	bh=5pIJIfV+YR+q4i/R4IIkolPMtahW+WPpCxE6tYVcJjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R0/nrkeE/zy99OWcd8QvbshzBhNzU5unUXsoumRRF6LXX16ahrskuByumojQK3RGoja8fH6O+TuQ4KBkM4egHiuG+e0/ROJesTIg1VjaT4vDQmYiD5ljfphu90SNzespEXyJLXqf8S5+81B9EgfbRI/PYko9sE3bRd4jL/YJXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nigI4Ktz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nigI4Ktz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79921F00A3A;
	Wed,  5 Aug 2026 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931840;
	bh=+4esMFML0iy9g6QkQqMeLsJKf4UvPTNVHdBJSi2Jyco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nigI4KtzigSqFAicAA8+1oLa6xCNIBgmM30vn6C/K0kl/wXPS1lcYjqq7tHUa5kR2
	 lUDWk8PAouXNECGxjN9vyIEhXCWJ3xRa7kjSq4nBjGXc7Xioxk1iHSoeScvaOv9fC+
	 JlyzhNg1aMtYr1CspxSU92nqLNI7lYPr9qXK6uHBXf8HC1Q2Vs347fO0rSNB+dmUt/
	 0pGp0+zTrymq80naLIHjsW4eccSwEw4TqJ3KIWWiYDTgOYWW374uLddKVgnsVSN4Ft
	 rWNa/VtlofEAXADgdM9ZUyZKNIiHWuYMkBHxehxOOz05AX/QVnahI+sOTHvbva9+Ne
	 uFOZWSPy6ggHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/5] PCI: tegra: Add Tegra264 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260805-tegra264-pcie-v9-3-fa2ed7350ae1@nvidia.com>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-3-fa2ed7350ae1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:10:38 +0000
Message-Id: <20260805121039.A79921F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The driver incorrectly accesses the ECAM window via `pcie->cfg->wi=
n` to read the root port configuration space, causing an out-of-bounds heap=
 read on 32-bit platforms.
- [High] The driver incorrectly uses the Negotiated Link Width (NLW) to set=
 interconnect bandwidth for hotplug-capable ports when the link is down, pe=
rmanently setting it to 0.
--

--- Patch [3]: [PATCH v9 3/5] PCI: tegra: Add Tegra264 support ---
commit af63006f768e2991e49a48de9855ea58d20662ed
Author: Thierry Reding <treding@nvidia.com>

    PCI: tegra: Add Tegra264 support
   =20
    Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
    driver is very small, with its main purpose being to set up the address
    translation registers and then creating a standard PCI host using ECAM.

> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/control=
ler/pcie-tegra264.c
> new file mode 100644
> index 0000000000000..e0c5b9d0d20bf
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c
[ ... ]
> +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> +{
> +	u32 value, speed, width;
> +	int err;
> +
> +	value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +	speed =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> +	width =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> +
> +	value =3D Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]=
));

[Severity: High]
Will this permanently set the interconnect bandwidth to 0 for hotplug-capab=
le
ports if the link is initially down?

When the link is down, the Negotiated Link Width (NLW) is 0, which means
the bandwidth value will be calculated as 0. Since the generic pciehp driver
handles hotplug but doesn't know about this driver's specific interconnect
bandwidth requirements, it appears there is no way to dynamically increase
the bandwidth later when a device is actually inserted.

Should this read the Maximum Link Width and Speed from PCI_EXP_LNKCAP
instead of PCI_EXP_LNKSTA to properly reserve bandwidth for a hotplug slot?

> +
> +	/*
> +	 * We don't want to error out here because a boot-critical device
> +	 * could be connected to this root port. Failure to set the bandwidth
> +	 * request may have an adverse impact on performance, but it is not
> +	 * generally fatal, so we opt to continue regardless so that users
> +	 * get a chance to fix things.
> +	 */
> +	err =3D icc_set_bw(pcie->icc_path, value, value);
[ ... ]
> +static int tegra264_pcie_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	pcie->cfg =3D pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops=
);
> +	if (IS_ERR(pcie->cfg)) {
> +		err =3D dev_err_probe(dev, PTR_ERR(pcie->cfg),
> +				    "failed to create ECAM\n");
> +		goto err_put_pm;
> +	}
> +
> +	bridge->ops =3D (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +	bridge->sysdata =3D pcie->cfg;
> +	pcie->ecam =3D pcie->cfg->win;

[Severity: High]
Can this cause an out-of-bounds heap read on 32-bit platforms?

In pci_ecam_create(), per_bus_mapping is enabled by default on 32-bit builds
(!IS_ENABLED(CONFIG_64BIT)). When per_bus_mapping is active, the win member
of struct pci_config_window aliases to winp (an array of pointers) because
they are defined in a union.

By assigning pcie->ecam =3D pcie->cfg->win here, the driver stores a pointer
to this heap array. Later, when the driver attempts to access the root port
configuration space:

tegra264_pcie_link_up()
    u16 value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);

will this read arbitrary heap memory as if it were MMIO?

> +
> +	tegra264_pcie_init(pcie);
> +
> +	/*
> +	 * Fail if the link isn't up and doesn't support hotplug, no device
> +	 * will ever be able to be added on this bus.
> +	 */
> +	if (!pcie->link_up && !pcie->supports_hotplug) {
> +		err =3D dev_err_probe(pcie->dev, -ENODEV,
> +				    "PCIe #%u link is down and not hotplug-capable, turning off\n",
> +				    pcie->ctl_id);
> +		tegra264_pcie_power_off(pcie);
> +		goto err_free_ecam;
> +	}
> +
> +	err =3D pci_host_probe(bridge);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to register host\n");
> +		goto err_free_ecam;
> +	}
> +
> +	return 0;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-tegra264-p=
cie-v9-0-fa2ed7350ae1@nvidia.com?part=3D3
