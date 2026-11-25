Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581008;
	b=t3Q5yuBnu9u0bVcp72o6Q0hQs3k0rucbvgfgly/g0SK/Ak3Fg09AuRWr9Xf+9pgxGb89
	 5PXLbz9wuJdOjlFkepKf5S396iZglmAhvQerINsLSbnLeqSYqtX84+4IA4oXSAok/xs5r
	 oTw0zm8aDLNLFIWM0O5ilBMsowThUCxMcUyf/IXUbtsZ5cM2eRVRucTcfQTAASKnS53PU
	 4usR5YBO1hgTNspAsmjkV+hllU9BO7vPipdPQAAHY8dshYnpGYgpnUan8S3GhKIvQrbzP
	 ElJ9o7etkgc0MxfiwC3KaqaBAX6/8d7qYwLsIOSmEXK2QasjpkdhhfRAfaiu2DjQCsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yDVlKq98CEH0WE9TVXzizu5tGJbSIqtXxd/1GB+N+s8=;
	b=xn6IxsQL1ZzhDnORNUoQcxC46CVHxzCZoS0n+38sJIUZCDMFOSG63C9lPigpygOLYSOA
	 BuRH7cyK4hlpRTrobH+Lni5cTdm0kcs2Yka+KwrZuISXPzDBtk+Nmzx3xR0nQeTXwKaXp
	 8dBAHr5HUZi0fLapoXwN7z8flfeeAbKbIqX9MJVgj7M7TIzozKLR8DH1Tmesj8cxnbRYq
	 uve+HStNx7Rt3F04OabKozHisa9pE/SV+8nxU1net4XL8Nan5WbJrJRGDXEcw6Q9+2Rbv
	 GwPs3n2Z08V/lLvIvNN1ChI3og+yCVJottkQNosFI7MZgMvq5Op3T7mCRVj+Pv/vsfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxRX4xuX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67D606A326;
	Wed, 25 Nov 2026 04:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxRX4xuX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6246F1F000C0;
	Wed, 25 Nov 2026 04:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795581007;
	bh=yDVlKq98CEH0WE9TVXzizu5tGJbSIqtXxd/1GB+N+s8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxRX4xuXVJBY+Us7QgWfvmMaKR406TbVqxLesDfJNyGPDcBTFq2M6w7OT35DGbC6C
	 1ejBa6E2uiEbfTWbiGrVAhQ0pJNp+pgWzv3Yod3fWAFSPxEQJQFyUMw3SxP+JfGeu6
	 KcEerHSwvc57rnmbFs6+5P+FLMFMJrrpfyur7kUOZqT0TIp4RPje8Ba84Oi21qRpT3
	 pwAkwXSeMV41V75czecP5QovzokFG1K3xxoqa/+qvlOZhDX+mQ7WPXogjZI0AthosX
	 u5KM4tWDRAeGij2P8XIO+SS87U+0zSdRYwcI4NaYJU/QbHHQfnTncu2gcRUPCTT1oc
	 MG7awqkKUAPUA==
Message-ID: <sashiko-outbox-232578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125041523.242588-7-inochiama@gmail.com>
References: <20261125041523.242588-1-inochiama@gmail.com>
 <20261125041523.242588-7-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:30:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: spacemit-k1: build failure due to missing phy_bulk APIs
--

commit 4aae440e551f70d7fefa7fcf7c1e36ade9f9d994
Author: Inochi Amaoto <inochiama@gmail.com>

PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support

This commit adds host controller support for the DesignWare-based PCIe
controller on the SpacemiT K3 SoC.

Link: https://spacemit.com/community/document/info?lang=3Den&nodepath=3Dhar=
dware/key_stone/k3/k3_docs/k3_usermanual/14_connectivity/pcie.md

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index f20c74eca73e2..9fd0c946bc595 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c

[ ... ]

> @@ -318,6 +331,121 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
>  	return ret;
>  }
> =20
> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct k1_pcie *k1 =3D to_k1_pcie(pci);
> +	u32 reset_ctrl =3D k1->pmu_off + PCIE_CLK_RESET_CONTROL;
> +	u32 val;
> +	int ret;
> +
> +	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
> +
> +	k1_pcie_toggle_soft_reset(k1);
> +
> +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE |
> +			   PCIE_PERSTN_OUT,
> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE);
> +
> +	ret =3D k1_pcie_enable_resources(k1);
> +	if (ret)
> +		goto failed_resources;
> +
> +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
> +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
> +
> +	ret =3D phy_bulk_init(k1->phy_count, k1->phys);
> +	if (ret)
> +		goto failed_phy_init;
> +
> +	ret =3D phy_bulk_power_on(k1->phy_count, k1->phys);
> +	if (ret)
> +		goto failed_phy_power_on;
> +
> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);
> +
> +	val =3D dw_pcie_readl_dbi(pci, GEN3_EQ_CTRL);
> +	val =3D u32_replace_bits(val, BIT(7), GEN3_EQ_CTRL_PSET_REQ_VEC);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CTRL, val);
> +
> +	k1_pcie_set_device_id(k1);
> +
> +	/* Finally, as a workaround, disable ASPM L1 */
> +	k1_pcie_disable_aspm_l1(k1);
> +
> +	return 0;
> +
> +failed_phy_power_on:
> +	phy_bulk_exit(k1->phy_count, k1->phys);
> +failed_phy_init:
> +	k1_pcie_disable_resources(k1);
> +failed_resources:
> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			   PCIE_PERSTN_OUT | PCIE_PERSTN_OE, PCIE_PERSTN_OE);
> +
> +	return ret;
> +}
> +
> +static void k3_pcie_deinit(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct k1_pcie *k1 =3D to_k1_pcie(pci);
> +
> +	/* Assert fundamental reset (drive PERST# low) */
> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			   PCIE_PERSTN_OUT | PCIE_PERSTN_OE, PCIE_PERSTN_OE);
> +
> +	phy_bulk_power_off(k1->phy_count, k1->phys);
> +	phy_bulk_exit(k1->phy_count, k1->phys);

[Severity: Low]
Does this series depend on unmerged PHY bulk patches for phy_bulk_init(),
phy_bulk_power_on(), phy_bulk_power_off(), phy_bulk_exit(),
devm_of_phy_bulk_get_all() and struct phy_bulk_data?  None of those symbols
exist in include/linux/phy/phy.h, so building with CONFIG_PCIE_SPACEMIT_K1
enabled fails with implicit function declaration and incomplete type errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125041523.2425=
88-1-inochiama@gmail.com?part=3D6
