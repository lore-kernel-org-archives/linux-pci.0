Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB241476694
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049096; cv=none; b=AsgNTRdg2lbmrO2OVLM85pDa6l1LlnbMlS1zcwsN9s71X+E97BjoE/6F4dkaLqf/H59pL0Rwwlh0pYw+hMlpicmXH4X0mbRD0Yarq3UHe/Im/ZJ3Z0c13Xx/QnuZgLWRiTyROio0nVyOwt5hNS2HyhMkLO3Xar2I71fg5dwaXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049096; c=relaxed/simple;
	bh=JFjM0SCrVzG4SHlNSB7Jq9Wk6iqUVESV1kNsss3Yncs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EiZFM7PDgEqeBu4NylC8VqK1H8xn3/rh8nVR/q75C7Re4YJRlVJZsPMhcG0XLZSO8YLnqheBWBvSdMF6z874BGdemVRzEWVFHpoIJNoSESR2Uzz5Fmmsy8V6EU013DXqKT9/f3YAkLqrFNxfUOGoUDbrjVjdp/28r8eZr+ZdRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2oPM0/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2oPM0/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DBD1F000C9;
	Thu, 15 Oct 2026 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792049082;
	bh=EfRNsDQr92macG+oTANxoIaROLsSdn4MJW7QDDiiDrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d2oPM0/bZdZHqsG+Agy0TbVEk/xA75kFWjwTMhCZ5kUJVLD+UfCptHoSu+Tv4G3nR
	 3H8M8IG3fGEC2CMjrARqX8lR7hIow31TrY1uDHBLFqCf3MYuzghazt78XTSQozRBNa
	 W1gbEDbc9I+zBi6DeG/ZnbthVGnHTPC3/LM9ncM+uuk2FTm05JG/xx0EzJ359itolu
	 eIjcT8A3XrtxFaoGrW2MbTfPQvXNBImxS5aQ1dyDx1g7dNrXp9sOQWs0OwiXM13Yk8
	 K4VEb/+uFDxm3R4d321QxqvSc7n9bRArM2lZRg9j3h0GyaovMwduo5vRU0vgSaWfWj
	 Q9dC46KXvyN7g==
Message-ID: <sashiko-outbox-172407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/24] PCI: dwc: Add ZTE ZX279128S host controller
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navid Ghahremani" <ghahramani.navid@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261014072109.1759502-14-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-14-ghahramani.navid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:24:41 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: dwc: zx279128s: -EPROBE_DEFER masked when requesting core res=
et
- [Medium] pci: dwc: zx279128s link training failure on concurrent probe
--

commit 31ef562bd53943175554ff3b4004b8759b588b24
Author: Navid Ghahremani <ghahramani.navid@gmail.com>
Subject: PCI: dwc: Add ZTE ZX279128S host controller driver

This commit adds support for the two Synopsys DesignWare PCIe host controll=
ers
found on the ZTE ZX279128S SoC. It manages the clocks, resets, and PHYs usi=
ng
standard kernel frameworks. The driver limits the link speed to Gen1 as done
by the vendor firmware.

> diff --git a/drivers/pci/controller/dwc/pcie-zx279128s.c b/drivers/pci/co=
ntroller/dwc/pcie-zx279128s.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-zx279128s.c
[ ... ]
> +static int zx279128s_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct zx279128s_pcie *pcie =3D to_zx279128s_pcie(pci);
> +	int ret;
> +
> +	/*
> +	 * The board lines reset a device that can sit behind both controllers
> +	 * (the MT7915 of the H3600 uses both). The first controller to start
> +	 * resets and releases it; the second must not reset it again.
> +	 */
> +	mutex_lock(&zx279128s_board_lock);
> +	if (!zx279128s_board_released && (pcie->reset || pcie->enable)) {

[Severity: Medium]
If both PCIe controllers are probed concurrently (for example, via
asynchronous probing), could the second controller skip this reset sequence
and fail link training?

If the second controller requests the shared reset GPIO in
zx279128s_pcie_probe() and receives -EBUSY, its GPIO pointers will be set to
NULL. When it reaches this critical section before the first controller has
executed the reset toggle, it will evaluate pcie->reset || pcie->enable as
false.

This would cause it to skip the wait block, proceeding immediately to link
training while the endpoints are still in reset.

> +		ret =3D gpiod_direction_output(pcie->reset, 1);
> +		if (ret)
> +			goto err_unlock;
[ ... ]
> +static int zx279128s_pcie_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	pcie->clk =3D devm_clk_get_enabled(dev, "pcie");
> +	if (IS_ERR(pcie->clk))
> +		return dev_err_probe(dev, PTR_ERR(pcie->clk),
> +				     "failed to get pcie clock\n");
> +
> +	pcie->rst =3D devm_reset_control_get_exclusive(dev, "core");
> +	if (IS_ERR(pcie->rst))
> +		pcie->rst =3D devm_reset_control_get_exclusive(dev, "pcie");
> +	if (IS_ERR(pcie->rst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->rst),
> +				     "failed to get pcie reset\n");

[Severity: High]
Does this unconditional fallback logic mask probe deferrals?

If the reset controller is not yet ready, the initial request for the core
reset line returns -EPROBE_DEFER.

The fallback unconditionally requests the pcie reset line. If the device
tree only specifies core, the second request will return -ENOENT or -EINVAL.

This overwrites the original -EPROBE_DEFER, causing the controller to
permanently fail probing instead of deferring.

> +
> +	pcie->phy =3D devm_phy_get(dev, "pcie");
> +	if (IS_ERR(pcie->phy))
> +		return dev_err_probe(dev, PTR_ERR(pcie->phy),
> +				     "failed to get pcie phy\n");
> +
> +	/*
> +	 * Optional board lines to reset and enable endpoints. If already
> +	 * claimed by another controller, treat -EBUSY as already managed.
> +	 */
> +	pcie->reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
> +	if (IS_ERR(pcie->reset)) {
> +		if (PTR_ERR(pcie->reset) =3D=3D -EBUSY)
> +			pcie->reset =3D NULL;
> +		else
> +			return dev_err_probe(dev, PTR_ERR(pcie->reset),
> +					     "failed to get the reset GPIO\n");
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014072109.1759=
502-1-ghahramani.navid@gmail.com?part=3D13
