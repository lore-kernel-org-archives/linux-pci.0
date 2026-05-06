Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE543AF646
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100019; cv=none; b=Wko8ekgbPbzRbAjtJrWUMMy6EBaRIY2iBP7am1e4S0+KdSZL6iUP4SrjWfeeaoW751/O11OQVYX5BpprrS9F3Fh5FLpahvnEIqw1C2zOS0lV8zYXaNwUYT3OTjIWNtP3PKRtmlD1P6Qjlr9m5w5tcZV2L5ekSI1hKb9BVaDLfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100019; c=relaxed/simple;
	bh=oZjggD/JUIQWp6JBa5utsRzMjSxmrAdtcY9wd8v8Xb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FMox/DNzoHxOLR70zJXZSeXNP6/GVMq9aXkpgMC8yTX2MoNrWYeyVhHgDzLY+OWSYHVk4QbdDcVcAOfYPAuyNp3yzlt2iMahmRWADEVNTHktZyMa6Vxr6eJkB0cscoSn4O+yfvOp2LvPWSUeVojPNVnw2Cmia/3wTmcTQz5d/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3wEakDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3wEakDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D2DC2BCB0;
	Wed,  6 May 2026 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778100019;
	bh=oZjggD/JUIQWp6JBa5utsRzMjSxmrAdtcY9wd8v8Xb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=G3wEakDLifC6I2KU32n0ia9DN2TNdrQenCh5Y9lT0BkTG1zzA/R30IgXNG4aiGIhP
	 mL/dPo21HIQTy4hIeA4QWlNCj7Txhe67cA2zcwHhGNWp94pOobA8LAM1rRs5dufCwY
	 HNPsx3dsn3lUCVJG+qisWthYTFDnEdl5M0l5RXZhL01+8koMQHpd4AFdPDEWT/aeqo
	 FL9Xqj+M1jRPmg0ddJu6fyCdOGIyddCjNJXxisocENz0vjZpmKmaapI9n5/+R/jAG6
	 TCGIWu8UoWKi7n0xNHEJp4oaxVYlETLZi8U+wkz8NtSGlwALdNk+FZKllXDoPY17ll
	 2DLNs7/5ftrjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: brcmstb: Assign pcie->gen from
 of_pci_get_max_link_speed()
Reply-To: sashiko@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506164537.103196-1-florian.fainelli@broadcom.com>
References: <20260506164537.103196-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:40:18 +0000
Message-Id: <20260506204019.52D2DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The error handling path in `brcm_pcie_probe()` causes a NULL point=
er dereference if `pci_host_probe()` fails.
- [High] The driver fails to handle the `msi-map` device tree binding varia=
nt when determining if the internal MSI controller should be enabled.
--

commit 8f216627ede49601fd793dae393dc6232ac6f438
Author: Florian Fainelli <florian.fainelli@broadcom.com>

PCI: brcmstb: Assign pcie->gen from of_pci_get_max_link_speed()

After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
pcie->gen stopped being assigned and as a result the established PCIe
link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().

Whether the 'max-link-speed' property is not specified, or it exceeds
Gen3, resort to the HW defaults.

Link: https://github.com/raspberrypi/linux/issues/7343

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index 714bcab97b603..08a0e7091cedc 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -2072,8 +2072,10 @@ static int brcm_pcie_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(pcie->clk);
> =20
>  	ret =3D of_pci_get_max_link_speed(np);
> -	if (pcie_get_link_speed(ret) =3D=3D PCI_SPEED_UNKNOWN)
> +	if (ret < 0 || ret > 3)
>  		pcie->gen =3D 0;
> +	else
> +		pcie->gen =3D ret;
> =20
>  	pcie->ssc =3D of_property_read_bool(np, "brcm,enable-ssc");

This isn't a regression from this commit, but while reviewing this function
I noticed a pre-existing regression. The driver currently checks for
msi-parent but does not check for the msi-map device tree binding variant:

drivers/pci/controller/pcie-brcmstb.c:brcm_pcie_probe() {
    ...
	if (pci_msi_enabled()) {
		struct device_node *msi_np =3D of_parse_phandle(pcie->np, "msi-parent", 0=
);

		if (msi_np =3D=3D pcie->np)
			ret =3D brcm_pcie_enable_msi(pcie);
    ...
}

Will this bypass brcm_pcie_enable_msi() and prevent the creation of the
local MSI domain if a platform's DT uses msi-map instead of msi-parent
to reference the built-in MSI controller?

I also noticed another pre-existing regression in the probe error handling =
path:

drivers/pci/controller/pcie-brcmstb.c:brcm_pcie_probe() {
    ...
	ret =3D pci_host_probe(bridge);
	if (!ret && !brcm_pcie_link_up(pcie))
		ret =3D -ENODEV;

	if (ret) {
		brcm_pcie_remove(pdev);
		return ret;
	}
    ...
}

If pci_host_probe(bridge) fails early before allocating bridge->bus,
bridge->bus will remain NULL.

Inside brcm_pcie_remove(pdev), bridge->bus is passed directly to
pci_stop_root_bus(bridge->bus).

The function pci_stop_root_bus() evaluates pci_is_root_bus(bus), which
dereferences the pointer via !(bus->parent).

Does this cause a NULL pointer dereference and a kernel panic if
pci_host_probe() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506164537.1031=
96-1-florian.fainelli@broadcom.com?part=3D1
