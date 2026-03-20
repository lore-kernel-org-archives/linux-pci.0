Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D639526D;
	Fri, 20 Mar 2026 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003171; cv=none; b=UbmNmuZDoRsbPSUOBvIGsskNXTicllrp7Y53BKE26AYla1eIjZxI4+mUYoblGOQJV3a8QuyWHfptnwyxdWhz/X7+5eKpAaBEdSISTrUIwUEAEne7SIl/r2eQjxVqDuXHfp8U7WZ8A+OZyuICYimBVm6N4pIDrE9F/NnWZ+HiHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003171; c=relaxed/simple;
	bh=t3S6s7zhyPlctDJGbCS0BRukj5/YukPmzBmO0tlt2RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABWSLxHz1uPrNEARTI2Krhf8623uYR+mOrBTX1GBpACKSJL8kuQiOjCcP7a5zjGWDVsdfv5ai9E2mAT9h2S72UmOzoLb+DFZcAXQK2y1YIQzK4S7CbVxY8jdmy7tHJQbne4Vxr/mupU16tSyy/LN9RXorEFmj3e3ZKFVkO44vQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6EE7+ZK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6EE7+ZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05824C4CEF7;
	Fri, 20 Mar 2026 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774003171;
	bh=t3S6s7zhyPlctDJGbCS0BRukj5/YukPmzBmO0tlt2RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6EE7+ZKbTaitT7t6alssiIzdrh/B6Em5wvrV9qXK8rnsV+mU5oIN3DTl2QrErE+w
	 t6vbrFdwQGtd4exScZJ1kNOEEYsqn/+wnrPCCE/v/HDFMbGVglr52LIYaBqwzcqBxI
	 X/istXjpwRVTOhZZINS4ce1pDAlRTEOmiyp1/z1o819mM5lsmrynnbK5EcR2/aAUfy
	 RQNjuCG6RAL68gjC1PwID1xhGd5tkTbUkI9bwWeD1cNfHB1jA1VahwItbhZcUwfXO2
	 vbjyn4NekijtlEw2LpWckQyj43SPcGSJSGPhBNlHzH5pDpZ28ey7b6jLdXH+V7MTIX
	 nWHQjpV/oicdQ==
Date: Fri, 20 Mar 2026 11:39:28 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: tegra: Add Tegra264 support
Message-ID: <ab0i4YK-aZcOmoR4@orome>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-5-thierry.reding@kernel.org>
 <a20bf111-6c5f-4ae2-b8f3-697854626c10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3hmvmzeidwji3lq"
Content-Disposition: inline
In-Reply-To: <a20bf111-6c5f-4ae2-b8f3-697854626c10@kernel.org>


--f3hmvmzeidwji3lq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] PCI: tegra: Add Tegra264 support
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 05:14:03PM +0100, Krzysztof Kozlowski wrote:
> On 19/03/2026 17:01, Thierry Reding wrote:
> >  obj-$(CONFIG_PCI_RCAR_GEN2) +=3D pci-rcar-gen2.o
> >  obj-$(CONFIG_PCIE_RCAR_HOST) +=3D pcie-rcar.o pcie-rcar-host.o
> >  obj-$(CONFIG_PCIE_RCAR_EP) +=3D pcie-rcar.o pcie-rcar-ep.o
> > diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/contr=
oller/pcie-tegra264.c
> > new file mode 100644
> > index 000000000000..0c8351b88941
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-tegra264.c
> > @@ -0,0 +1,506 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// SPDX-FileCopyrightText: Copyright (c) 2022-2025, NVIDIA CORPORATION=
=2E All rights reserved.
>=20
> Don't use that tag, please, but standard Copyright.

Done.

> > +static int tegra264_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct pci_host_bridge *bridge;
> > +	struct tegra264_pcie *pcie;
> > +	struct resource_entry *bus;
> > +	struct resource *res;
> > +	int err;
> > +
> > +	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(struct tegra264_pci=
e));
> > +	if (!bridge) {
> > +		dev_err(dev, "failed to allocate host bridge\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	pcie =3D pci_host_bridge_priv(bridge);
> > +	platform_set_drvdata(pdev, pcie);
> > +	pcie->bridge =3D bridge;
> > +	pcie->dev =3D dev;
> > +
> > +	err =3D pinctrl_pm_select_default_state(dev);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to configure sideband pins: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	err =3D tegra264_pcie_parse_dt(pcie);
> > +	if (err < 0)
> > +		return dev_err_probe(dev, err, "failed to parse device tree");
> > +
> > +	pcie->xal =3D devm_platform_ioremap_resource_byname(pdev, "xal");
> > +	if (IS_ERR(pcie->xal)) {
> > +		err =3D PTR_ERR(pcie->xal);
> > +		dev_err(dev, "failed to map xal memory: %d\n", err);
> > +		return err;
>=20
> What's with this syntax here? This is just one call return
> dev_err_probe. Looks like you are sending us some old code, instead of
> use recent drivers starting point.

It's not old code, just me being old and used to the old ways. I don't
see much point in dev_err_probe() for some of these cases because there
is no probe deferral and then dev_err_probe() is just extra overhead.
It's also much clunkier to use because it almost always requires
wrapping lines and then what's left of any benefits is pretty much
dissipated.

I get that it's the shiny new thing, but honestly, I don't think we're
doing ourselves any favours by blindly using it everywhere.

Thierry

--f3hmvmzeidwji3lq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmm9I+AACgkQ3SOs138+
s6FvcBAAuVjpkkYOq9Odf+Jck9DMGNDLqIQ5xtEPn3/nS0IUpB2dQyEmB9bUOVB7
4hOXB1M0/TjUfci8omilvOsYdlXGSR3K3wwW+BAL2aij++K7Gv3eJLgj0mZKqSky
NgJzjXalSPNKPC+CfOjDuJ1D5ZtUAdkAV94TAjNpIf1tPqYljvPYyjPP05SYevS/
GwuCnloiVEo5/HQCMZX5NcxFi3S4WRuLQcCvqNfPJTDJBgOeA1hOJdvkxceWFYYJ
AiNQ448Vh3Qo0r2TsZ4vISGV7VT6gv/Mg9mN6ZKHA6rMiyFoxy6rEgm9GK0808mM
lpwzy/AHla3XcCaVaHkIn0jxBJXgyQRk7lmHwipmkcR9pOaxQvs/aBj7SGBrHVys
kUMk2evqcycV0Dr4XDoLKAkrGEAfu39x0077ekrsNcznq7sLDPb/P3ziJreOoWzS
EiewPGIrZthua690IY9/Xk9YAVlZRsgXswi7rZryFWiY0qsf6NMf1r8oGyPU+ZBJ
voDxJfbDzWeRbpgPnlBJtvReyLZJzs7sYP+VV88rwYmJ5MmPy/oXj2ZN1ek2hmpA
dk3Bra0ysbb8IqZO24vcDRzdoT+smdi3PjMTs+WdbXA/Wn8J7SC4z3cdj6hr5Fgk
go//Ov9jxa8IsgQN6n/Qsi+RfD57o01/k89dLZGwaTysxE10vnQ=
=qB7j
-----END PGP SIGNATURE-----

--f3hmvmzeidwji3lq--
