Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21A3624B2;
	Tue, 14 Jul 2026 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997632; cv=none; b=VokAVPG9JBVNZb4aS94i6d1Sb63QMF0bSWw2mWVxwyGyomREp0HTPj4jNEFN3rSRm3J3V5W4Dx+8xDarz7V95u4kc87HlZWWOBXnLNtLNYm6xvj9ffhmuc+PPGglRratvLoniNnfDKACibyu+NaMu7lG+je8qzAyvoOFEaqthSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997632; c=relaxed/simple;
	bh=z+X5Yafpf3kZHJreBnkkLe6fajtS/9of4nEtykaKZgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNyqigEFIQhRvRC1NveOFWA++5cHLknHOQZg+Jtw+lli64foK7xUjT+DER9C3ZtWW0ckuYSpgMzQb686zoUYRhXZHYVBjaUKGrpYEnvtyodYOvlZpc/xir/P3KSPlnZBDjO/kFYtrUV0I5ozxUY5i4EcwRZHYoDmVFymly52Ro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTRsSkn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTRsSkn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F420D1F000E9;
	Tue, 14 Jul 2026 02:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783997631;
	bh=OauW7f7QeAm+FboPvTNWcCRNujH/EjuFg3dsxU54rb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HTRsSkn94vvzzzAwC2kRZsMUufF+ars3tswntaZRFDsQ1KWHAFQcoSwCipVq3nSiJ
	 Rm9r+kHTFktPOim7m7Fbxoshj01YvCey1Z87agTRKYfdN/z0v0vaUPXhsTdF0gskOR
	 pIYXUgeiiTKA4A3qCMhkMfHCoDqjT4fXXqEuIYMQZluD6/dGOJPmwBu08ie8/A6ITG
	 s9EF1MJg2L3AUiwaesECa8opfJVnjjBZsKue4JVJW3wqghT3I+RYKoxPbwcXXZIwFW
	 rHMxnBr7BNFR0/2I+nHBTDcw65Nga1wJhohb2gAOex1kTBDiIk5birhLP6OguN9fju
	 uKHcWfDlzNqdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>
References: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 02:53:50 +0000
Message-Id: <20260714025350.F420D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Non-atomic configuration of the PHY address and enable bit in `i=
mx95_pcie_phy_write` creates a potentially unsafe intermediate hardware sta=
te.
- [Medium] The unconditional 200=C2=B5s delay is misplaced at the beginning=
 of the PHY write function, leading to a missing post-write settling delay.
- [Medium] Raw write to `IMX95_PCIE_PHY_MPLLB_OVRD_IN` potentially clobbers=
 other override bits.
--

--- Patch [1]: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX=
95 Gen3 PCIe stability ---
commit 62a7810800383a4677a34a256947f86390e8e2a1
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability

This commit updates the MPLLB bandwidth margin settings for the i.MX95 Gen3
PCIe driver to improve link stability across voltage and temperature
variations. It implements a PHY register write helper function to configure
the override registers.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..55f8aa47cccfd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -269,6 +280,16 @@ static int imx95_pcie_select_ref_clk_src(struct imx_=
pcie *imx_pcie)
>  	return 0;
>  }
> =20
> +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u1=
6 data)
> +{
> +	udelay(200);

[Severity: Medium]
Is the udelay(200) placed correctly here before the register updates?

If this delay is intended to allow the hardware to process the PHY register
write, placing it unconditionally before the writes means the final write i=
n a
sequence will not have a settling delay before initialization proceeds. Wou=
ld
it make more sense to place this delay after the regmap_write()?

> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_EN, IMX95_PCIE_PHY_REG_EN);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);

[Severity: Medium]
Does setting the enable bit in a separate transaction before updating the
address expose a stale address to the PHY interface?

If setting the IMX95_PCIE_PHY_REG_EN bit with a stale address initiates an
access, this sequence might cause a spurious hardware transaction. Could bo=
th
the address mask and the enable bit be updated simultaneously in a single
atomic read-modify-write operation?

> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA, data);
> +}
> +
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {

[ ... ]

> @@ -289,6 +310,11 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_=
pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
> =20
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_IN,
> +			     IMX95_PCIE_PHY_MPLLB_BW_VAL);
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
> +			     IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN);

[Severity: Medium]
Could this write to IMX95_PCIE_PHY_MPLLB_OVRD_IN unintentionally clobber
other bits in the register?

imx95_pcie_phy_write() calls regmap_write() for the data, which will clear
all unspecified bits in the target register to zero. If there are other
necessary override bits or default settings in this register, they would be
disabled by this raw write. Should this use a read-modify-write sequence
instead?

> +
>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714024107.4113=
926-1-hongxing.zhu@oss.nxp.com?part=3D1
