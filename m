Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2F25F98B;
	Sun, 17 May 2026 03:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778987781; cv=none; b=N2hQnsDrT6pQPlukrA+I9Opm7e8/0H/C0Ahye1NOfmW8FrgkEqrkbo5RByf+bN9eP2JN+UawTr62IRGrKVTXoYEuRPALqubUY1WwD8jfY+6mDRy4Xu1Q2Vpj0gZaB3HbUmOQtG8Bt8Z2oMVWHHrC7HehLbTW/ckgYVLfRB1Oqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778987781; c=relaxed/simple;
	bh=PCfvLkWmZcAateO1r8zYfXsOhUrGBkB6G/RPZ1RXeU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m+jTKXrJuHnkqjBwNgeQeU7z+ZSRtU4sInvBUQww/H21qpC4R8VBO523QBW5o/fdTBLGxqis2n9TIqfhr//f4zIkJT1Nm+YaBGmtk0gfn0umWpVEgZZENYCWS6CRt4w0yNnbwM0ZByJl5rRywBVdySiDucQTDeYfRtNu2Lp0e4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7N+SBGF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7N+SBGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1854C2BCB7;
	Sun, 17 May 2026 03:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778987781;
	bh=PCfvLkWmZcAateO1r8zYfXsOhUrGBkB6G/RPZ1RXeU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=K7N+SBGFOzXg0kQBcwMCom+OBdt7MGjnIP8nLdVOxatA1UuhLv5+27PMFAaFM79uX
	 rJrmCuszZdvqlB1JNPwTNbA5cVanqXhVymCypWznyea6wORY5HOjUyETD/IsY3hhFT
	 rXdgcjEHAUfgzRe3irBpL3aoaiuIYqVEG/dkPnd1MEHukZOL46I/Q/vvNEpKnmEWTb
	 p28qKBtWLRV6ballV2wymEntxPU/Sm63Ut9MgVAFmByaU/44UI21WdkX/TGj/NxbC9
	 M5Yc0VmrmipLA4/xvp8OQ1xfFHSdQylt7yd8jAP5j0f9Rfgu3Hb33ffCQNUhlE/yw3
	 NKTHH1CAqSZqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260517014841.254085-6-inochiama@gmail.com>
References: <20260517014841.254085-6-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 03:16:20 +0000
Message-Id: <20260517031620.E1854C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] MMIO registers are accessed before the controller's clocks are ena=
bled, leading to a synchronous external abort or system crash.
- [High] Incorrect use of `u32_replace_bits()` combined with bitwise OR (`|=
=3D`) fails to clear existing bits.
- [High] Missing Root Complex mode configuration for the K3 controller due =
to a copy-paste error.
- [Medium] A bitmask macro for a completely different field is incorrectly =
passed as the replacement value to `u32_replace_bits()`, writing unexpected=
 values.
- [Medium] Asymmetric teardown: `k1_pcie_deinit()` fails to assert reset on=
 the K3 controller because it uses a reset line the controller is explicitl=
y configured to ignore.
--

commit 2826ac7fe9e0d0c0dd248a7fc412ce12f4d7b491
Author: Inochi Amaoto <inochiama@gmail.com>

PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support

This commit adds host controller support for the Spacemit K3 PCIe IP. It
introduces K3-specific initialization, PHY enablement, and MSI host setup,
hooking these into the existing spacemit-k1 driver.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index 7f6f1df31cd81..7854d26220a98 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
[ ... ]
> @@ -262,6 +278,152 @@ static const struct dw_pcie_ops k1_pcie_ops =3D {
[ ... ]
> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> +{
[ ... ]
> +	/*
> +	 * Put the controller in root complex mode, and indicate that
> +	 * Vaux (3.3v) is present.
> +	 */
> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);

Does this code configure the controller as a Root Complex?=20

The comment mentions putting the controller in root complex mode, but the=20
register write only sets the PERSTN bits. In the K1 initialization, this is=
=20
done by setting DEVICE_TYPE_RC, which appears to be missing here.

> +
> +	val =3D dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	val =3D u32_replace_bits(val, GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE,
> +			       GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);

Is the replacement value intended to be GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MO=
DE?=20

This passes a bitmask macro for a completely different field into=20
u32_replace_bits(), which shifts the value into the target mask and writes =
an=20
unexpected value into the register.

> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
[ ... ]
> +static int k3_pcie_msi_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	u32 val;
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val =3D dw_pcie_readl_dbi(pci, COHERENCY_CONTROL_3_OFF);
> +	val |=3D u32_replace_bits(val, K3_CACHE_MSTR_AWCACHE_BEHAVIOR,
> +				K3_CACHE_MSTR_AWCACHE_MODE);

Will this clear the existing bits correctly?=20

The u32_replace_bits() macro returns the fully modified 32-bit word. By usi=
ng=20
the bitwise OR assignment (|=3D), the original bits from val are ORed with =
the=20
new bits, leaving any originally set bits as 1 instead of clearing them.

> +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, val);
[ ... ]
> +static const struct dw_pcie_host_ops k3_pcie_host_ops =3D {
> +	.init		=3D k3_pcie_init,
> +	.deinit		=3D k1_pcie_deinit,

Can k1_pcie_deinit() successfully assert the reset for the K3 controller?=20

During initialization, k3_pcie_init() sets PCIE_IGNORE_PERSTN in=20
PCIE_CONTROL_LOGIC. If k1_pcie_deinit() attempts to assert reset using=20
PCIE_RC_PERST, the hardware might ignore it, leaving the device improperly=
=20
reset during teardown.

> +	.msi_init	=3D k3_pcie_msi_host_init,
> +};
[ ... ]
> +static void k3_pcie_clear_irq_status(struct k1_pcie *k1,
> +				     u32 *status0, u32 *status1, u32 *status2)
> +{
> +	*status0 =3D readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	*status1 =3D readl_relaxed(k1->link + INTR_STATUS);
> +	*status2 =3D readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);
> +
> +	writel_relaxed(*status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	writel_relaxed(*status1, k1->link + INTR_STATUS);
> +	writel_relaxed(*status2, k1->link + K3_ADDR_INTR_STATUS1);
> +}
> +
> +static int k3_pcie_parse_port(struct k1_pcie *k1)
> +{
[ ... ]
> +	k1->phy_count =3D i;
> +	if (k1->phy_count =3D=3D 0)
> +		return -EINVAL;
> +
> +	k3_pcie_clear_irq_status(k1, &status0, &status1, &status2);
> +
> +	return 0;
> +}

Could accessing these MMIO registers before the clocks are enabled cause a
synchronous external abort?

The probe function calls parse_port() before dw_pcie_host_init(). This means
k3_pcie_clear_irq_status() performs direct MMIO reads and writes to the=20
k1->link registers before k1_pcie_enable_resources() is called later in=20
k3_pcie_init().=20

Accessing an unclocked peripheral can cause a bus stall on ARM/RISC-V=20
architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517014841.2540=
85-1-inochiama@gmail.com?part=3D5
