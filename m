Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BF30D406;
	Wed, 23 Sep 2026 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128806; cv=none; b=rJKom5cUBStmdBHO01dVMF9wwROB6cAc3f48r+Xqvh0j5vedE0DASsPhmPxVRc+qTc5czGQjpgniB83oFtcjvOnTk4ywecv33bJptDWHRPov4FDl7/57du4FODC0IjmbMLCwWXDpOLuvHCgJyaUSn3UD0Urk7mmuZdCHG53xRCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128806; c=relaxed/simple;
	bh=SXbbU+Qcn/DLe0Fa6JMISbfUWE7+QRUTiBs8VRY+vP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DbW7S7GPCCRHL0MDRlH2LmNsjOwlDdZBla/oMHJ++L68/Kg+cQ9HkORRvOM9Bu1SAY+F876ypqr/5Vxf8VCnx0DyZcmjm8bqdGbT3ppPgvgAib7n8CrIUY2KRE+3dtrol31fSH9fTrAhNnqN9VJDlBEjjvXtSzOgWZGIvwZVT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azQ7HKZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azQ7HKZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0A01F00893;
	Wed, 23 Sep 2026 02:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128805;
	bh=0s/vJiE/Lb9py7MUkS51MzlUjRA7u3FOqIa0dTtRusE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=azQ7HKZn0CQx6kK270Bb5RLdq3KQWPZ1nEFNrltr3cTFIupVRBOE1zCJDjN5MjjBx
	 mO3u3IAQ7QjT4BaPN3Ml6uYxWZIv58/39OeSnYixWjB+Og1ZeneM/bZVWZYMVyMh43
	 bw7FdgX+jTKq2t/hAwbqHyzZ3J5GB1ikqXeoh5GDKqp0oKpxM9rb9rfgLlfpBPBv+4
	 8o25MfuvSSvR2i0xcurYvgBxInDKzz4CBIpP+gz3yi0e+kaIe5FRx9m8Kr8BLU3KU5
	 r9Pi6qVNmYUZJU9lAbWG6bNWZEMO6DnhZa6I+a9YbEo8LwhFAW+SA9bb40BgiHmGSI
	 9KNdiuoZLHDxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] PCI: spacemit-k1: Add multiple PHY handles
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260923015016.64069-3-inochiama@gmail.com>
References: <20260923015016.64069-1-inochiama@gmail.com>
 <20260923015016.64069-3-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 02:00:04 +0000
Message-Id: <20260923020004.CE0A01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pci: spacemit-k1: use of non-existent phy_bulk API causes build fai=
lure
--

commit ea15a827c71ea1a0c124ab062feba5fc9254cc6d
Author: Inochi Amaoto <inochiama@gmail.com>

PCI: spacemit-k1: Add multiple PHY handles support

This commit extends the Spacemit K1 PCIe controller driver to support
multiple PHY handles at the same time. It modifies the driver to initialize
and manage multiple PHYs as a bulk operation.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index ab2953ad8f56f..8c4f0b09fe24d 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
[ ... ]
> @@ -51,12 +51,14 @@ struct k1_pcie_device_data {
>  	const struct dw_pcie_host_ops *host_ops;
>  	const struct dw_pcie_ops *ops;
>  	int (*parse_port)(struct k1_pcie *k1);
> +	unsigned int max_phy_count;
>  };
> =20
>  struct k1_pcie {
>  	struct dw_pcie pci;
>  	const struct k1_pcie_device_data *data;
> -	struct phy *phy;
> +	struct phy_bulk_data *phys;

[Severity: Low]
Does struct phy_bulk_data exist in the kernel tree? It appears to be
undefined, which would lead to an incomplete type error during the build.

> +	unsigned int phy_count;
>  	void __iomem *link;
>  	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
>  	u32 pmu_off;
[ ... ]
> @@ -115,6 +117,25 @@ static void k1_pcie_disable_resources(struct k1_pcie=
 *k1)
>  	clk_bulk_disable_unprepare(ARRAY_SIZE(pci->app_clks), pci->app_clks);
>  }
> =20
> +static int k1_pcie_get_phy_handle(struct k1_pcie *k1, struct device_node=
 *node)
> +{
> +	const struct k1_pcie_device_data *data =3D k1->data;
> +	struct device *dev =3D k1->pci.dev;
> +	int count;
> +
> +	count =3D devm_of_phy_bulk_get_all(dev, node, &k1->phys);

[Severity: Low]
Is devm_of_phy_bulk_get_all() part of the kernel's PHY framework? This
function doesn't seem to be declared anywhere, causing an implicit function
declaration build failure.

> +	if (count < 0)
> +		return count;
[ ... ]
> @@ -170,12 +191,13 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	 */
>  	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
> =20
> -	ret =3D phy_init(k1->phy);
> -	if (ret) {
> -		k1_pcie_disable_resources(k1);
> +	ret =3D phy_bulk_init(k1->phy_count, k1->phys);

[Severity: Low]
Do these bulk initialization APIs like phy_bulk_init() exist? Calling this
non-existent function causes build failures.

> +	if (ret)
> +		goto failed_phy_init;
> =20
> -		return ret;
> -	}
> +	ret =3D phy_bulk_power_on(k1->phy_count, k1->phys);

[Severity: Low]
Similarly, does phy_bulk_power_on() exist in the tree? Calling it here
will result in another implicit declaration build failure.

> +	if (ret)
> +		goto failed_phy_power_on;
> =20
>  	/* Deassert fundamental reset (drive PERST# high) */
>  	regmap_clear_bits(k1->pmu, reset_ctrl, PCIE_RC_PERST);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923015016.6406=
9-1-inochiama@gmail.com?part=3D2
