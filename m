Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C783D093E;
	Fri, 14 Aug 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722677; cv=none; b=NedIpExiZKSyO+x+hhIWlac8LmMBRsnx+oemRjQ7Y2VZXdjEXRlUSAhCF2KPKK2SAsKmCetJ6LrrP+3Vw5S15KMOL/A0Rk+3qn7TNHhBJ8w5p6fkpaOzmg9B7MC7u1vcyu2OLACQ9uvGJDHSbntqctbgjIDcUVUkJhnTKqrWLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722677; c=relaxed/simple;
	bh=4tp7aJlumMljONPZRdfMVHBbRNdRTbHnJN8WnmLpAcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mdNUp+97O8tVsQ5d8iDXB3GcCpYAFdUSAlFv59uE57ZgL342DskQPez1/fMoU2KjYazD5iJnLuovz48/WJN0PUBZoBA1vUDRQ1XXb06v5Ws52k6wMRS1vE00JQw/ZkzmbTbpEOpDI0k/Q4zQRf2ge+vBNGwPzMt5fMwhVabjjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ9LO3p8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ9LO3p8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FFE1F000E9;
	Fri, 14 Aug 2026 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722676;
	bh=wCfv8gMOvvxAXpqXiRKxAIWlIj9DV4e1/eKST/24Dpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jJ9LO3p8S6OxWaUHlB11gxRrcjy8s/FZ6uCq7R5cqQrNfu4K/Nk2BFuGRZU0iXyyq
	 b4OKDVDIA0ctoPAAte9wyFWJleUtHfYr360FX/6YmB5nLZp6U2OjYVBCWacmpsFYjQ
	 SZx61Min5PCO0A/qKEBcHDgWjQ77AamdK0nFeB3KHmYfLNDkeYt+x4IvHo8SVES7uE
	 kwYbXwMGEF9HrqWBBRJzyUHsTkeRhhtzUti1EmYp9ASdGS6ViLN2DSGgcr/m7RcIb+
	 TlkhpQGXsURi1Svh6N2KH9YlsZ8PilyBNUvyeiTi7tcU7jEMet7uKSbxUFng5oKACV
	 f8FydWWtK35Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/5] PCI: tegra: Add Tegra264 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260814-tegra264-pcie-v10-3-05d08c592b05@nvidia.com>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
 <20260814-tegra264-pcie-v10-3-05d08c592b05@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:51:15 +0000
Message-Id: <20260814155115.D1FFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect register offset for `XTL_RC_PCIE_CFG_LINK_CAPS` causes `=
readw()` to fetch the wrong bits, leading to bogus link capabilities extrac=
tion.
- [High] Unvalidated PCIe Link Speed index extracted from hardware register=
s leads to an out-of-bounds read of the `pcie_link_speed` array.
- [Medium] The driver directly dereferences `pcie->cfg->win` as I/O memory,=
 which is invalid on 32-bit platforms where `per_bus_mapping` is enabled fo=
r ECAM.
--

--- Patch [3]: [PATCH v10 3/5] PCI: tegra: Add Tegra264 support ---
commit af57b50d38f94a70c577cb3fb66bd77477d89532
Author: Thierry Reding <treding@nvidia.com>
Subject: PCI: tegra: Add Tegra264 support

Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
driver is very small, with its main purpose being to set up the address
translation registers and then creating a standard PCI host using ECAM.

> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/control=
ler/pcie-tegra264.c
> new file mode 100644
> index 0000000000000..7774ce10544ab
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c

[ ... ]

> +/* XTL registers */
> +#define XTL_RC_PCIE_CFG_LINK_CAPS		0x56

[Severity: High]
Is the offset for XTL_RC_PCIE_CFG_LINK_CAPS correct? Since Link Status is at
0x5a, should Link Capabilities be at 0x54 instead of 0x56? Reading from 0x56
with readw() in tegra264_pcie_icc_set() would fetch the upper 16 bits of the
32-bit Link Capabilities register, resulting in incorrect values for link
speed and width.

> +#define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a
> +
> +#define XTL_RC_MGMT_PERST_CONTROL		0x218

[ ... ]

> +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> +{
> +	u32 value, speed, width;
> +	int err;

[ ... ]

> +	if (pcie->link_up) {
> +		value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +		speed =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> +		width =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> +	} else {
> +		value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_CAPS);
> +		speed =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, value);
> +		width =3D FIELD_GET(PCI_EXP_LNKCAP_MLW, value);
> +	}
> +
> +	value =3D Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]=
));

[Severity: High]
Can the speed index extracted from the hardware registers exceed the bounds
of the pcie_link_speed array?

If the register contains an unexpected value (such as 0xffff when the device
is inaccessible, or corrupted data due to an incorrect register offset), the
extracted speed could be greater than 6, causing an out-of-bounds read on t=
he
array.

> +
> +	/*
> +	 * We don't want to error out here because a boot-critical device

[ ... ]

> +static bool tegra264_pcie_link_up(struct tegra264_pcie *pcie,
> +				  enum pci_bus_speed *speed)
> +{
> +	u16 value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +
> +	if (value & PCI_EXP_LNKSTA_DLLLA) {
> +		if (speed)
> +			*speed =3D pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS,
> +							   value)];

[Severity: High]
Similar to tegra264_pcie_icc_set() above, could this field extraction result
in an out-of-bounds read of the pcie_link_speed array if the status register
contains an unexpected value?

> +
> +		return true;
> +	}
> +
> +	return false;
> +}

[ ... ]

> +static int tegra264_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;

[ ... ]

> +	bridge->ops =3D (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +	bridge->sysdata =3D pcie->cfg;
> +	pcie->ecam =3D pcie->cfg->win;

[Severity: Medium]
Does this direct assignment of pcie->cfg->win work correctly on 32-bit
platforms where per_bus_mapping might be enabled?

When per_bus_mapping is true, cfg->win is an unmapped kzalloc'd pointer
array (cfg->winp) due to their union structure, not device I/O memory.
Accessing it via readw() later in tegra264_pcie_link_up() would yield
zero-initialized garbage data instead of I/O memory.

> +
> +	tegra264_pcie_init(pcie);
> +
> +	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra264-p=
cie-v10-0-05d08c592b05@nvidia.com?part=3D3
