Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B235200C;
	Fri, 29 May 2026 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019226; cv=none; b=efolhTDazloSeRba5gGrsdgMiisJ3w3ZrCSUZD0+dEVqJr/jMc/hZhQfc1qMrzJLoBsrAkcyMuPnh3pFFIxmtjvXguWMrrTRb/94iesfn6BIXu51ZcWgwbhoKtnKxSMMpeASn4k6q/ztKPf0y3wVlzXaufy0uUVhqKYWGjFJF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019226; c=relaxed/simple;
	bh=h+EXYClqG8eVxVIbJOdqhSjweHJ6PhJ9yE01u08sTuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d9CU58LxO+lDhR/z+JdiDUMHGItbR4TPtsjyNt0quTeUenHhm3sF6mh5tvGPXTNG6AXb2k6qhVOImV/xp3Wv3orjQNcMQQPaw2Nph9tEdsOWdm8vo8sTexueV19ARUq0MVK33Ym6bvlvauyMoT10TZug/U7qpWAWD4pdeanu5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGTnl1RI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGTnl1RI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE9E1F000E9;
	Fri, 29 May 2026 01:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780019225;
	bh=g0VkQdWn0eJwDiorBvVhiVkvqJUgdclsU5ZEvIZ1UTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGTnl1RIfFceIV8/JIvJvHievzuj2zKJOxXzWATnd1WXRipLoofFuMHOB4EkF8MLl
	 1ULCZwGL+TMxhqoh+2u+WnpF43RLOlzq8gumEP0yTfrm3LM9H9srSpG5FmnCPZkgL9
	 gGu0iCOdnxmoj+hUjJSPdRjhzHaHn/4dJONeJXujHRDYs09Iw9jQBXmazHhZ/1RdBv
	 qylBXtyuhXBxK9f10isdfM881lQKX9+CauCn2xeHl0N/MI8LO5e1AtqmOp2I6+/nVc
	 b2LPw+162afaj8Gy9ZuBLxhzVj40+komUZ4b2nre6SHAXBBcWOb3G7gt9Az6AmyAlE
	 H7gZlO1VYctPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add support for Hawi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Leung" <matthew.leung@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260529-hawi-pcie-v2-2-de87c6cc230c@oss.qualcomm.com>
References: <20260529-hawi-pcie-v2-2-de87c6cc230c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 01:47:04 +0000
Message-Id: <20260529014705.0BE9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The compatible string `qcom,hawi-pcie` violates the established =
Qualcomm PCIe naming convention and fails to differentiate between distinct=
 controller instances.

Pre-existing issues:
- [High] Missing hardware readback before disabling clocks in qcom_pcie_dei=
nit_2_7_0() can cause bus lockups.
- [High] Out-of-bounds memory read when parsing a malformed 'iommu-map' pro=
perty in qcom_pcie_config_sid_1_9_0().
--

commit d9d16f2083b5ca557a88fe9cb78cb5c885342df2
Author: Matthew Leung <matthew.leung@oss.qualcomm.com>

PCI: qcom: Add support for Hawi

Add support for the Hawi platform which has two PCIe controllers: one
capable of Gen3 x2 operation and one capable of Gen4 x1 operation.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 11fc604898926..5fe8667fdb8f5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -2280,6 +2280,7 @@ static int qcom_pcie_resume_noirq(struct device *de=
v)
>  }
> =20
>  static const struct of_device_id qcom_pcie_match[] =3D {
> +	{ .compatible =3D "qcom,hawi-pcie", .data =3D &cfg_1_9_0 },

[Severity: Medium]
Since the commit message notes the platform has two controllers with differ=
ing
capabilities, is it intentional to use a single compatible string rather th=
an
instance-specific ones?

Modern Qualcomm platforms typically use instance-specific compatibles like
qcom,pcie-sm8450-pcie0 and qcom,pcie-sm8450-pcie1 to manage differences in
interconnects, link speeds, and quirks. Lumping them under a single
compatible might prevent the driver from differentiating the controllers.

Additionally, the new compatible string reverses the established
qcom,pcie-<platform> naming pattern.

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential bus lo=
ckup
risk here:

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_deinit_2_7_0() {
    ...
	val =3D readl(pcie->parf + PARF_PHY_CTRL);
	val |=3D PHY_TEST_PWR_DOWN;
	writel(val, pcie->parf + PARF_PHY_CTRL);

	clk_bulk_disable_unprepare(res->num_clks, res->clks);
    ...
}

Because writel() performs a posted write, there is no guarantee that the
transaction has reached the peripheral before the clocks are removed.
Disabling the clock while a write is still propagating over the interconnect
can result in a lost write or a fatal bus lockup.

Does this need a hardware readback after the writel() to ensure completion
before disabling the clocks?

[Severity: High]
This is a pre-existing issue, but could this code cause an out-of-bounds
memory read when parsing a malformed iommu-map property?

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_config_sid_1_9_0() {
    ...
	of_get_property(dev->of_node, "iommu-map", &size);
	if (!size)
		return 0;
    ...
	map =3D kzalloc(size, GFP_KERNEL);
	if (!map)
		return -ENOMEM;

	of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)map,
				   size / sizeof(u32));
    ...
	smmu_sid_base =3D map[0].smmu_sid;
    ...
}

If the iommu-map property is present but smaller than the size of one entry,
kzalloc() allocates only that small size. The code then unconditionally
accesses map[0].smmu_sid, which resides at offset 8.

Would this cause an out-of-bounds memory read from the heap, potentially
triggering a kernel panic if the buffer is at the end of a slab page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529-hawi-pcie-=
v2-0-de87c6cc230c@oss.qualcomm.com?part=3D2
