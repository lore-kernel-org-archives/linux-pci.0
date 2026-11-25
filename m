Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580763;
	b=08uz9YFL0HyQfyh8onr29xkbi2ZKisPbTRWd8/BWY8UFIpjMY4Syzo3H1dhMgayhaLKf
	 8zioyeN9Ynk/p6rGN/nuUKGq7bQVkLTGbXXq/5FIQWBti5qwjh7e5YCaf2X4IWlbMx01M
	 vYriv5f6zswAiI5pWkasFX3ZMjfuFPcGqMUXaOI9KnftDk1AiY3ubNdtQnFOW+EcpVR6e
	 aoXm3CD46PAF3zrI37SS34yUmN1mRKV6QqB6hWvIqEhiTPI/UNu4VXKCOj0/rZtvLhCFI
	 WSiswv/KkLgasRdf8HZDWY2pX7vs+Qd8FJjkJWNFosnL+ww9TCI37pkyWyg9nb9X0tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580763;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fy8hrrAYp1vvqwMg++pbtZOax1txVXT4hjcPAmH/pkk=;
	b=dJeNeXuTurjJ/woiHcJmTM9niB6olhq91gpcZFYdtArmJlmqnc2AjqlRn0jkFfdfE1UT
	 SDEPYWHh+ued19sWrQnG+8ILrs0cFbrfUv8W6zY0uzIH057tRGS5da7FcHOAGQfV5KEmu
	 o9AuSaS7pan8quSiQMdz2O9o8A0OBbhtR/Ozu87IJRjn+x8KKCsyVPpYmZzWbNWWsS1FB
	 yOIRIjGeQkKwWH1DRx5NPV0oTmdXI2a0YYQB3hr2aOah1F58KGri35yYpa5s2AJJRur3r
	 XxYyLEyhbTm2iOBz4cx6ci0ikfpJOwmBmH3wHIdgRrF8N7PV26ZpUzWjpnhTLKt5p3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZcJJ42H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC431606A31E;
	Wed, 25 Nov 2026 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZcJJ42H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478C51F000C6;
	Wed, 25 Nov 2026 04:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795580763;
	bh=fy8hrrAYp1vvqwMg++pbtZOax1txVXT4hjcPAmH/pkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZcJJ42HX52382QxwwDV787EMN2Bjec0XLZDVSj6j7FejWPf0IXOUY4kZU7+V0oYJ
	 ftOjI2XAHml6bx2IFEQtIcL51Y9pwDd6Av1PBvLGN3SQNFmKqGhsjGUTAvaqhiBbTK
	 4DPArZJd1skfvdwjrPxDcgJU+qCjJWIF9SMXryM1RRSpQKvOJVSYuYC27Vn/5+pJ1y
	 13vRIOjMbg/v4nZh2N5+Uj0qTV08JTzzK8O7eBLmmm1pK2c3dQhCEX4YMXlozJehR6
	 0+ye1CJ9LFdb1qNCLSJRiSChyWTeVpy2Tg30XbxlHX9GFozgIRgjg1X/MkHjIJgBpK
	 1YyWhVanqPn0Q==
Message-ID: <sashiko-outbox-232574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/6] PCI: spacemit-k1: Add multiple PHY handles
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125041523.242588-3-inochiama@gmail.com>
References: <20261125041523.242588-1-inochiama@gmail.com>
 <20261125041523.242588-3-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:26:02 +0000
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
- [Low] PCI: spacemit-k1: build failure due to undeclared phy_bulk APIs
--

commit 0e939e698b5ba47d963ad632ba592ec50b9439b0
Author: Inochi Amaoto <inochiama@gmail.com>

PCI: spacemit-k1: Add multiple PHY handles support

This commit converts the SpacemiT K1 PCIe driver from handling a single
PHY to supporting multiple PHY handles via the phy_bulk API.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index 658ad2fa87b26..8a3cae32609f7 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -54,12 +54,14 @@ struct k1_pcie_device_data {
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
> +	unsigned int phy_count;
>  	void __iomem *link;
>  	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
>  	u32 pmu_off;
> @@ -118,6 +120,25 @@ static void k1_pcie_disable_resources(struct k1_pcie=
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
> +	if (count < 0)
> +		return count;
> +	if (!count)
> +		return -ENOENT;
> +	if (count > data->max_phy_count)
> +		return -EINVAL;
> +
> +	k1->phy_count =3D count;
> +
> +	return 0;
> +}
> +
>  /* FIXME: Disable ASPM L1 to avoid errors reported on some NVMe drives */
>  static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
>  {
> @@ -173,12 +194,13 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	 */
>  	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
> =20
> -	ret =3D phy_init(k1->phy);
> -	if (ret) {
> -		k1_pcie_disable_resources(k1);
> +	ret =3D phy_bulk_init(k1->phy_count, k1->phys);
> +	if (ret)
> +		goto failed_phy_init;
> =20
> -		return ret;
> -	}
> +	ret =3D phy_bulk_power_on(k1->phy_count, k1->phys);
> +	if (ret)
> +		goto failed_phy_power_on;
> =20
>  	/* Deassert fundamental reset (drive PERST# high) */
>  	regmap_clear_bits(k1->pmu, reset_ctrl, PCIE_RC_PERST);
> @@ -187,6 +209,14 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	k1_pcie_disable_aspm_l1(k1);
> =20
>  	return 0;
> +
> +failed_phy_power_on:
> +	phy_bulk_exit(k1->phy_count, k1->phys);
> +failed_phy_init:
> +	k1_pcie_disable_resources(k1);
> +
> +	return ret;
> +
>  }
> =20
>  static void k1_pcie_deinit(struct dw_pcie_rp *pp)
> @@ -198,7 +228,8 @@ static void k1_pcie_deinit(struct dw_pcie_rp *pp)
>  	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>  			PCIE_RC_PERST);
> =20
> -	phy_exit(k1->phy);
> +	phy_bulk_power_off(k1->phy_count, k1->phys);
> +	phy_bulk_exit(k1->phy_count, k1->phys);

[Severity: Low]
Does this fail to build when CONFIG_PCIE_SPACEMIT_K1 is enabled?  Neither
include/linux/phy/phy.h nor drivers/phy/ defines struct phy_bulk_data or
declares devm_of_phy_bulk_get_all(), phy_bulk_init(), phy_bulk_power_on(),
phy_bulk_power_off(), and phy_bulk_exit().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125041523.2425=
88-1-inochiama@gmail.com?part=3D2
