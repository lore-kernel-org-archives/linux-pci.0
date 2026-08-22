Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5E3F1659
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787412042; cv=none; b=K/iND0Xa/Revh/bKiXhmMN5sfh6WUUzpF12TOJdD2xQSlEGi78rd98rV9s1AxD73pvpGRouIYllnZJzct0oSiceJPRQGz65jQbXJwo71Et1hsCVJTzUVeIel/q6Qudj5OlfOf65sH6cWL5zZDUKzxvW/QoR0P4+dpBu/9qJThPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787412042; c=relaxed/simple;
	bh=pG++gZNn/OwPyvE8s8k3vXlGveW0qCRKYPp+EFfNj40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3kYAxf9cZ3nTVBOmWAVIfnrDCMh/Y0lqPjFlzVhpUiNhCk520LIYvd9E8GSMcMPRWACfHugC3iqV90z2CBIFvFIeP8Oou1Q/TozF9p4+NJGAHVF0oYSDo8+haZw8mfcRpL++44X6I08hL6hQucHM10K4FNnBsjxj91+/4VpDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L96J/EV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L96J/EV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB56A1F000E9;
	Sat, 22 Aug 2026 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787412040;
	bh=ACP1bx197RgVbQMDf6IuVihPtjnAg7iqxSyMb8FfGeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L96J/EV7rCRLk2g7m54Gwh/dJ6QMEL24EgwSBhQQ6LYEiDDwjo6cjhZywfkky654t
	 Am1iJJoXzVXH3SraqVcB+2wIGC1z6DrX70vyy2ENMHjGi0L8djpNBiY5beXpH1DyDB
	 E4kY8dT5JKzkpUVYJSUXe0pxRSKIa+3BP7dLFWQHBRXfw3BAzuZkZCGj5gC7ysBXsT
	 D4bu15qmHt8tijySoj4mlm85iAXpEVtidwLw/ZRN5daUv57lFamznHXZ83Np9WpIU/
	 MH2H7vi9asjgjh1DTa0IrDVOXbh2UyM3mA6mCdRLovxIY3dCN3PuUM9lXzTFgDze2B
	 ayBp+JxVu6KXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI: dra7xx: Fix clock enable leak on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felix Gu" <ustc.gu@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260822-dra7xx-v1-1-23e204d5548b@gmail.com>
References: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
 <20260822-dra7xx-v1-1-23e204d5548b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 15:20:40 +0000
Message-Id: <20260822152040.BB56A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of custom INTx IRQ domain and chained handlers on =
probe failure paths.
- [High] Missing `.remove` callback in a loadable module driver leaves hard=
ware active and leaks resources, leading to Use-After-Free.
--

--- Patch [1]: [PATCH 1/3] PCI: dra7xx: Fix clock enable leak on probe fail=
ure ---
commit 949827a7f8e6ad6326095148f4f52df1a75fedb1
Author: Felix Gu <ustc.gu@gmail.com>

PCI: dra7xx: Fix clock enable leak on probe failure

dra7xx_pcie_probe() enables the optional clock but never disables it
when probing fails afterwards.

Switch to devm_clk_get_optional_enabled(), which disables the clock
automatically on failure.

Fixes: 5af9405397bf ("PCI: dra7xx: Get an optional clock")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/contro=
ller/dwc/pci-dra7xx.c
> index 6ae5b27e27b32..d43253f7dea65 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -732,15 +732,11 @@ static int dra7xx_pcie_probe(struct platform_device=
 *pdev)
>  	if (!link)
>  		return -ENOMEM;
> =20
> -	dra7xx->clk =3D devm_clk_get_optional(dev, NULL);
> +	dra7xx->clk =3D devm_clk_get_optional_enabled(dev, NULL);
>  	if (IS_ERR(dra7xx->clk))
>  		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
>  				     "clock request failed");
> =20
> -	ret =3D clk_prepare_enable(dra7xx->clk);
> -	if (ret)
> -		return ret;
> -

[ ... ]

>  	switch (mode) {
>  	case DW_PCIE_RC_TYPE:
>  		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
>  			ret =3D -ENODEV;
>  			goto err_gpio;
>  		}
> =20
>  		dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>  				   DEVICE_TYPE_RC);
> =20
>  		ret =3D dra7xx_pcie_unaligned_memaccess(dev);
>  		if (ret)
>  			dev_err(dev, "WA for Errata i870 not applied\n");
> =20
>  		ret =3D dra7xx_add_pcie_port(dra7xx, pdev);
>  		if (ret < 0)
>  			goto err_gpio;

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this error path
permanently leak the custom IRQ domain?

If dra7xx_add_pcie_port() fails during its internal dw_pcie_host_init() cal=
l,
it returns an error without cleaning up the IRQ domain and chained handler =
it
just created via dra7xx_pcie_init_irq_domain().

Since the probe error path goes straight to err_gpio:, we skip err_deinit:
and the domain is never removed. Because the pci and dra7xx structures are
devm-allocated, they are automatically freed on probe failure.

If the shared IRQ fires afterwards, won't the dangling chained handler
dereference the freed pointer and cause a panic?

[ ... ]

>  static struct platform_driver dra7xx_pcie_driver =3D {
>  	.probe =3D dra7xx_pcie_probe,
>  	.driver =3D {
>  		.name	=3D "dra7-pcie",
>  		.of_match_table =3D of_dra7xx_pcie_match,
>  		.suppress_bind_attrs =3D true,
>  		.pm	=3D &dra7xx_pcie_pm_ops,
>  	},
>  	.shutdown =3D dra7xx_pcie_shutdown,
>  };
>  module_platform_driver(dra7xx_pcie_driver);

[Severity: High]
This is a pre-existing issue, but does this driver need a .remove callback?

This driver can be built as a loadable module, but lacks a .remove callback.
When the module is unloaded, the driver core will unbind the device and
devres will release memory and unmap IO.

However, since there is no explicit teardown, pm_runtime_disable() is
skipped, the PHY is never disabled, dw_pcie_host_deinit() is not called,
and the custom IRQ domain and chained handlers are left active.

Does this guarantee a use-after-free when the chained interrupt handler
later accesses the devres-freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-dra7xx-v1-=
0-23e204d5548b@gmail.com?part=3D1
