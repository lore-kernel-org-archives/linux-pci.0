Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241484C4F7A;
	Tue, 29 Sep 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672039; cv=none; b=p3vJ9YhdCt3BCCWxEKs0mQgEGg917K9NQnTEOkAIKM30TU9m8u+PyWtpV1PaWki5RcoxgYLACQCGdirJ3RwCHbtqwG6o0e1an18GcBnjp5mgCb+yKIFbKJ+h46aca2ApnAQqtBFWeBTuzTLr54YIKV9Tq6Tnst+x8W/XWM3qACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672039; c=relaxed/simple;
	bh=z/j0cztnTq2OR5Rrz05GFkWV2zhwXBK9hFn8MeRlkW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g53wy9jKloJDmBjLKJ8utAXk2hB1qq0cTKcENz1xB98htLD+WwkulCW8TtEr3XDwQJvMeF4QksuLXBzqZ8eVEy3XkKAUnvZvivqH7UvPg4Xi4lScHNJdr36ogpgOw+/TSHHZjBYuMvSGw1/Zr2605A/X465/Jj8mqwN3RuVy4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+fgmqJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+fgmqJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E3D1F000FF;
	Tue, 29 Sep 2026 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790672037;
	bh=selsDhelZ3oDod4x6EyjnLEbNBV9NuDvI1x5f5Xp8ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y+fgmqJIcxxFjjotaCcrshWzlWd4KK49fU2xZo9Z5hjR4C7ac83wd9z9uyiQ0Mp4B
	 9StNJpo4ikzm8JlkK/ZYPm7FzFxWsU5GLETQKAxxDFUfFkGQWhHAkl7tPKcMdqebIV
	 nKUisMO7zXvtAfHUdl0Y5JB4j+K9sy8bXH6GfMujuNNsZCZM7a0L9ejAs/w8t5E4pB
	 0rDPjMwRqSCIcRzay9RDy2Itu3Jt26pBKhUfYsbKoXVSf4hb6oq+2noNwwWgAnNSOG
	 8JUmqF63C7q8475iDxpmSxjL6ZUVppJxARnsxl3PGI71u/La9ycECf+qn5ZbH0Xo+K
	 EBogna+sXVfqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260929083755.458238-7-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-7-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:53:56 +0000
Message-Id: <20260929085357.71E3D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] System crash on probe due to unclocked MMIO access
- [High] Logic error in equalization preset request configures non-existent=
 lane
- [Low] Build failure due to missing PHY bulk APIs
--

commit 0e2b713f89ed74d3eac594b76efb0fd900f80b44
Author: Inochi Amaoto <inochiama@gmail.com>

PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support

This commit adds support for the Spacemit K3 PCIe host controller. It exten=
ds
the existing K1 driver to handle external MSI controllers and multiple PHYs
required by the K3 architecture.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index ec59ccb710ec1..61b430f2294a7 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
[ ... ]
> @@ -315,6 +328,123 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
[ ... ]
> +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
> +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
> +
> +	ret =3D phy_bulk_init(k1->phy_count, k1->phys);

[Severity: Low]
Does this code rely on a custom or out-of-tree API? The generic PHY subsyst=
em
does not contain a phy_bulk_init() or devm_of_phy_bulk_get_all() function.
Calling these non-existent bulk PHY APIs causes an immediate build failure.

> +	if (ret)
> +		goto failed_phy_init;
[ ... ]
> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);
> +
> +	val =3D dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	val =3D u32_replace_bits(val, BIT(7),
> +			       GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);

[Severity: High]
Is BIT(7) the correct value here?=20

GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC is a 16-bit vector where each bit correspo=
nds
to a PCIe lane. Passing BIT(7) (128) into u32_replace_bits() sets the 8th b=
it
of the vector (Lane 7).

Since the K3 controller only has a maximum of 6 lanes, doesn't this issue an
invalid preset request for a non-existent lane and skip equalization for the
actual active lanes? This can potentially lead to link training failure or
incorrect functional behavior.

> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> +
> +	k1_pcie_set_device_id(k1);
[ ... ]
> +static const struct dw_pcie_host_ops k3_pcie_host_ops =3D {
> +	.init		=3D k3_pcie_init,
> +	.deinit		=3D k3_pcie_deinit,
> +	.msi_init	=3D k3_pcie_msi_host_init,
> +};
> +
> +static int k3_pcie_parse_port(struct k1_pcie *k1)
> +{
> +	u32 status0, status1, status2;
> +
> +	/* Clear the status registers */
> +	status0 =3D readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	status1 =3D readl_relaxed(k1->link + INTR_STATUS);
> +	status2 =3D readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);

[Severity: High]
Can accessing these MMIO registers crash the system during boot?

Looking at k1_pcie_probe(), it calls data->parse_port(k1) before
dw_pcie_host_init(). The application clocks and resets are only enabled lat=
er
in the sequence when dw_pcie_host_init() calls k3_pcie_init() and then
k1_pcie_enable_resources().

Accessing these hardware registers unconditionally while the PCIe controller
is still unclocked and in reset causes a synchronous external abort.

> +
> +	writel_relaxed(status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929083755.4582=
38-1-inochiama@gmail.com?part=3D6
