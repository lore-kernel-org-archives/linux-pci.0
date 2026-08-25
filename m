Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FE463B7A;
	Tue, 25 Aug 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668148; cv=none; b=sX3eCjfxkJszx1LvlMcPu4ecXFuNxhQ0q9TVBlWe7guoWPNwFCZkFyy18IgjtZlYtnXAMZZ1WOtmyygDVdaHtm0XrT1vP56VpzArw1zopoRNacO52N4OQwMq835JNeM20whsAlexeka8GVuSloXZ9/FF2mHEu8cX7yaq+n351Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668148; c=relaxed/simple;
	bh=6iCr0zLDorxuyWQZ4CIe1nNtRUIvbw46NOsAukWkox8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vGqeuldoXqUTon7V/A1quhzE+iVyf+3Fb3qIDb1eL7fkxsZyOuIg25149qE2rvqLDKXhW7GMfDgvlwV2aPcxliUlJHJyg55ZLehKcTjQf8fQ1ICxwMD8U774p6mLDJ0v8DjqwSGNuOq8I7mhtTnQKPgVGREZ2x5NHgeGXc9z3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDT88Ui0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDT88Ui0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060791F000E9;
	Tue, 25 Aug 2026 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787668147;
	bh=lyeHIZKRGuANjbVBL/d7t74keme98eD411Weu5XvPac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eDT88Ui0Gj6OVf8MoEynt4bmzhK8SC9bBTokwtqHsk2UwKtERKxjUD3AvEEilQkA0
	 +p6n+dXcBgKnc14fJYXyWLpyWog/JJ3gAl2uu4+wrMstlOZuoDI5ouXXiijEIeUM44
	 TVg9DbXgtb+iLy3NaFtVR0M8bzKSJYzQD/Yy1K2VWeJz/Bs5yHd6vRxkSvHCfj9NKJ
	 fWEyjDW9jD1S54NLCSblLZddJZR0MpQIvSNQemmzaSAvmpE4dEkDlpR5lHPvsAyKb/
	 /owPVnbJ/X9IDT848aupDFy36lF2/KjcJqYxOwyd4w01gvcq9zinmNyFe2Mm26futt
	 Dx2VhKN6nmsvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: fix endpoint init error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhijian Han" <hanzhijian1991@gmail.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260825141526.3911472-1-hanzhijian1991@gmail.com>
References: <20260825141526.3911472-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 14:29:06 +0000
Message-Id: <20260825142907.060791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deferring imx_pcie_host_exit() via devm_add_action_or_reset() crea=
tes a teardown ordering conflict with manual cleanup in probe, causing pwrc=
trl devices to leak on endpoint initialization failure.
--

--- Patch [1]: [PATCH v3] PCI: imx6: fix endpoint init error handling ---
commit 8e59197090261ab72469bfcfa7c4d49abbeafbae
Author: Zhijian Han <hanzhijian1991@gmail.com>

PCI: imx6: fix endpoint init error handling

This commit updates imx_add_pcie_ep() to check the return value of
imx_pcie_host_init(). It also registers a devres action to release host
resources on error, aiming to unregister the EPC device before powering
off hardware.

Link: https://lore.kernel.org/all/20260824152857.DB9771F00A3D@smtp.kernel.o=
rg/

> This mirrors the root
> port path, where dw_pcie_host_init() releases these resources through
> the same framework.

[Severity: Low]
Is this description accurate? The root port path handles deinitialization
synchronously without devres, rather than through the same framework.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..f0fb4e1b0ac6b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -1634,7 +1639,20 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pc=
ie,
>  	struct dw_pcie_rp *pp =3D &pci->pp;
>  	struct device *dev =3D pci->dev;
> =20
> -	imx_pcie_host_init(pp);
> +	ret =3D imx_pcie_host_init(pp);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Tear the host resources down via a devm action so that, on probe
> +	 * failure, the EPC device created by dw_pcie_ep_init() is
> +	 * unregistered (also via devres) before the clocks, regulators and
> +	 * PHY are switched off.
> +	 */
> +	ret =3D devm_add_action_or_reset(dev, imx_pcie_host_exit_action, pp);

[Severity: High]
Does deferring imx_pcie_host_exit() via devres create a teardown ordering
conflict with the manual cleanup in imx_pcie_probe()?

If imx_add_pcie_ep() returns an error during endpoint initialization,
imx_pcie_probe() will execute its manual cleanup before any devres actions
run:

drivers/pci/controller/dwc/pci-imx6.c:imx_pcie_probe() {
    ...
    if (imx_pcie->drvdata->mode =3D=3D DW_PCIE_EP_TYPE) {
        ret =3D imx_add_pcie_ep(imx_pcie, pdev);
        if (ret < 0)
            goto err_pwrctrl_destroy;
    ...
err_pwrctrl_destroy:
    pci_pwrctrl_destroy_devices(dev);
    ...
}

Since pci_pwrctrl_destroy_devices() unregisters the child pwrctrl devices,
when the deferred imx_pcie_host_exit_action() finally executes and calls
pci_pwrctrl_power_off_devices(), the devices are already unregistered.

Could this cause the power-off to be skipped, leaving the hardware resources
permanently powered on?

> +	if (ret)
> +		return ret;
> +
>  	ep =3D &pci->ep;
>  	ep->ops =3D &pcie_ep_ops;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825141526.3911=
472-1-hanzhijian1991@gmail.com?part=3D1
