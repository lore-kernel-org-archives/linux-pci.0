Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54C233959;
	Wed, 24 Jun 2026 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304507; cv=none; b=eAIBQgX+XIhPDgq+91gdmkYsU/RAXD0HHz7yTcOD/gTqvPpHaR8MeAxrqgk5ntsbf5s5fS4qXvq2mvtwWP6QxjpcnuQoFVv7XOI6BxWjyEe6NZfBPi4IMKuiUbq/omQb1JIFwcvh1AOu5KmWj2Q0QCjLSptXNRCa2BsrpfiU4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304507; c=relaxed/simple;
	bh=bmQHDy0xnKiTPit54joBRHL3VV8pG1ZaF6qNqBiBzwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHcPOZL8ZkKt0NIZWrtR12tvLP9zn0+IJOkUMmOG/7XhVwBhH6mkK8YGGANWAhP/BHG53085gtSo+v2hcGW8LKWrvdq6YMZ0emLV0YrMF//xWyNQFdoMq8jzYyYDp+b72zGkct6Zn/i3+uszs2kacljj35wxbhYhQc4c/OV6/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGnN75eY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGnN75eY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A6D1F000E9;
	Wed, 24 Jun 2026 12:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782304506;
	bh=nSlHeZgCT1oHjvLSw+acVz7VxQaUvcpCz7IcbZqf/FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fGnN75eYr5ZYS8PB60tTDlz6Um7sYGuRKfaMDzNmcXFBGrQB8djWZrFhFCuxXPMRo
	 X5r/pb/u1XHBjKYr0GSBDvM12jERqrJb1mtHZX2Wz5pY3wSgnl0jfvHPwf/Oz7vlTC
	 i0ouMkB9eExbHNFziYN4OpcunLEZv9PX8G0d3riVRGTMW5pZ3QXA7zoX6Ocz0lJx7S
	 26LJ01PmqJG03rD9qaIz5WzqgIinUCbSsJ76kUHwXptE4g4LtN9U0xxXoOzFb4T4oU
	 0a1eeHS4Zdn5QEITiRCwAMpQHmezlyZAwqebueChlNBATEMaB9c/jwPE4HkNPrU7ot
	 pX9dCIZawRGMw==
Date: Wed, 24 Jun 2026 14:35:04 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v7 3/4] PCI: tegra: Add Tegra264 support
Message-ID: <aju3jokcWR5DzPrv@orome>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-3-eae7ae964629@nvidia.com>
 <slfaxyt6p5mwsqmxvmriy6npilpjhjxv5ruegj4hnivj6zufkl@o6adjy5jmzfy>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="om3weh3neg6kh743"
Content-Disposition: inline
In-Reply-To: <slfaxyt6p5mwsqmxvmriy6npilpjhjxv5ruegj4hnivj6zufkl@o6adjy5jmzfy>


--om3weh3neg6kh743
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 3/4] PCI: tegra: Add Tegra264 support
MIME-Version: 1.0

On Thu, Jun 18, 2026 at 09:26:33AM +0200, Manivannan Sadhasivam wrote:
> On Wed, Jun 17, 2026 at 06:01:30PM +0200, Thierry Reding wrote:
[...]
> > +static int tegra264_pcie_parse_dt(struct tegra264_pcie *pcie)
> > +{
> > +	struct device *dev =3D pcie->dev;
> > +	int err;
> > +
> > +	pcie->wake_gpio =3D devm_gpiod_get_optional(dev, "wake", GPIOD_IN);
> > +	if (IS_ERR(pcie->wake_gpio))
> > +		return PTR_ERR(pcie->wake_gpio);
> > +
> > +	if (!pcie->wake_gpio)
> > +		return 0;
> > +
> > +	err =3D gpiod_to_irq(pcie->wake_gpio);
> > +	if (err < 0)
> > +		return dev_err_probe(dev, err, "failed to get wake IRQ\n");
> > +
> > +	pcie->wake_irq =3D (unsigned int)err;
> > +
> > +	err =3D devm_device_init_wakeup(dev);
> > +	if (err < 0)
> > +		return dev_err_probe(dev, err, "failed to initialize wakeup\n");
> > +
> > +	err =3D devm_pm_set_wake_irq(dev, pcie->wake_irq);
> > +	if (err < 0)
> > +		return dev_err_probe(dev, err, "failed to set wakeup IRQ\n");
> > +
>=20
> I'd really like to get rid of custom WAKE# handling in the controller dri=
vers.
> Krishna is trying to add generic WAKE# handling in the PCI core and I'd s=
uggest
> you to take a look at the patches:
> https://lore.kernel.org/linux-pci/20260511-wakeirq_support-v10-2-c10af9c9=
eb8c@oss.qualcomm.com/
>=20
> But this also means that you need to use switch to Root Port binding to m=
ove the
> Root Port properties out of the controller node. This is something we are
> mandating for the new controllers. Not a big change though...
>=20
> Reference:
>=20
> Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml#n80

Okay, let me look into it.

[...]
> > +	err =3D devm_pm_runtime_set_active_enabled(dev);
>=20
> I belive this has to come after pm_runtime_get_sync() because at this poi=
nt, the
> controller is not enabled.

Okay, I'll change that.

> > +	if (err < 0) {
> > +		dev_err_probe(dev, err, "failed to enable runtime PM\n");
> > +		goto put_bpmp;
> > +	}
> > +
> > +	err =3D pm_runtime_get_sync(dev);
> > +	if (err < 0) {
> > +		dev_err_probe(dev, err, "failed to power on device\n");
> > +		goto put_bpmp;
> > +	}
> > +
> > +	/* sanity check that programmed ranges match what's in DT */
> > +	if (!tegra264_pcie_check_ranges(pdev)) {
> > +		err =3D -EINVAL;
> > +		goto put_pm;
> > +	}
> > +
> > +	pcie->cfg =3D pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_o=
ps);
> > +	if (IS_ERR(pcie->cfg)) {
> > +		err =3D dev_err_probe(dev, PTR_ERR(pcie->cfg),
> > +				    "failed to create ECAM\n");
> > +		goto put_pm;
> > +	}
> > +
> > +	bridge->ops =3D (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> > +	bridge->sysdata =3D pcie->cfg;
> > +	pcie->ecam =3D pcie->cfg->win;
> > +
> > +	tegra264_pcie_init(pcie);
> > +
> > +	if (!pcie->link_up)
> > +		return 0;
>=20
> So not hotplug support? Also, you do not want the driver to error out? I'm
> wondering what's the use then?

Hotplug is supported via pciehp. We skip probing the host bridge if no
link was detected because there's simply nothing attached to the port,
otherwise the link would've come up.

pcie->link_up is slightly misleading because it actually means something
along the lines of "link could be up at some point", either during probe
or after some hotplug event later on. It is only ever false if there's
no link during probe and hotplug isn't supported at all.

> > +
> > +	err =3D pci_host_probe(bridge);
> > +	if (err < 0) {
> > +		dev_err_probe(dev, err, "failed to register host\n");
> > +		goto free_ecam;
> > +	}
> > +
> > +	return 0;
> > +
> > +free_ecam:
>=20
> Nit: Prefix 'err' for the labels.

I don't see any benefit of adding a prefix. Seems pretty redundant, but
I also don't feel too strongly about it, so I can add it.

> > +	pci_ecam_free(pcie->cfg);
> > +put_pm:
> > +	pm_runtime_put_sync(dev);
> > +put_bpmp:
> > +	tegra_bpmp_put(pcie->bpmp);
> > +
> > +	return err;
> > +}
> > +
> > +static void tegra264_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct tegra264_pcie *pcie =3D platform_get_drvdata(pdev);
> > +
> > +	/*
> > +	 * If we undo tegra264_pcie_init() then link goes down and need
> > +	 * controller reset to bring up the link again. Remove intention is
> > +	 * to clean up the root bridge and re-enumerate during bind.
>=20
> But the controller will be consuming power even if PCIe is not used. Do y=
ou
> really want that? Can't tegra264_pcie_init() handle the initialization? I=
'm
> wondering how tegra264_pcie_deinit() in tegra264_pcie_suspend() works the=
n.

I had to clarify this with the PCI team and they indicated that
tegra264_pcie_deinit() is actually useless and maybe even harmful. The
reason is that there's a processor on these boards (BPMP) that takes
care of power sequencing and it will automatically take the PCI links
to L2 on suspend and assert PERST#.

Another reason why we don't want to reset the entire controller is that
it is already set up during early boot by UEFI and the kernel driver
does not redo the entire initialization.

So yes, I think a little bit of power consumption is the compromise that
we will have to live with. In the bigger picture it's probably not going
to be noticeable in most cases, and given that these are embedded
platforms we'll likely see fixed configurations most of the time and the
case where we remove the PCIe host controller will not be common.

> > +	 */
> > +	pci_lock_rescan_remove();
> > +	pci_stop_root_bus(pcie->bridge->bus);
> > +	pci_remove_root_bus(pcie->bridge->bus);
> > +	pci_unlock_rescan_remove();
> > +
> > +	pm_runtime_put_sync(&pdev->dev);
> > +	tegra_bpmp_put(pcie->bpmp);
> > +	pci_ecam_free(pcie->cfg);
> > +}
> > +
> > +static int tegra264_pcie_suspend(struct device *dev)
> > +{
> > +	struct tegra264_pcie *pcie =3D dev_get_drvdata(dev);
> > +	int err;
> > +
> > +	tegra264_pcie_deinit(pcie);
> > +
> > +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> > +		err =3D enable_irq_wake(pcie->wake_irq);
> > +		if (err < 0)
> > +			dev_err(dev, "failed to enable wake IRQ: %pe\n",
> > +				ERR_PTR(err));
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tegra264_pcie_resume(struct device *dev)
> > +{
> > +	struct tegra264_pcie *pcie =3D dev_get_drvdata(dev);
> > +	int err;
> > +
> > +	err =3D pinctrl_pm_select_default_state(dev);
> > +	if (err < 0)
> > +		dev_err(dev, "failed to configure sideband pins: %pe\n",
> > +			ERR_PTR(err));
>=20
> Please remind me if you justified this manual pinctrl handling before.

This is just regular pinctrl PM boilerplate. There's plenty of other
drivers where we do this, too. We want this because some of the pins
get configured to non-default states on boot/resume, so doing this
here ensures they are muxed correctly.

> > +
> > +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> > +		err =3D disable_irq_wake(pcie->wake_irq);
> > +		if (err < 0)
> > +			dev_err(dev, "failed to disable wake IRQ: %pe\n",
> > +				ERR_PTR(err));
> > +	}
> > +
> > +	if (pcie->link_up =3D=3D false)
> > +		return 0;
>=20
> How is this possible? If 'pcie->link_up' was 'false' during probe(), then=
 it is
> going to stay until tegra264_pcie_init() is called below.

Yes, this keeps confusing me, too. The purpose of this is to skip
initialization if we've already determined during probe that there is
never going to be a link. link_up will be false if and only if there was
no link during probe and we don't expect there ever will be a link
because there is no hotplug support.

Maybe a different name for link_up could help here? maybe_link_up
perhaps? I don't know if that's any clearer, but I also couldn't come up
with a better name.

Or maybe we should split this into two booleans, since we're essentially
trying to use one boolean to track a tristate. What we want to know is
if a link is truly up and if the controller should be kept powered for
the case where hotplug is supported.

I suppose we could do:

	bool link_up; /* track the link state */
	bool supports_hotplug; /* track whether port is hotpluggable */

That would make the code a bit cleaner and easier to follow.

Thierry

--om3weh3neg6kh743
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo7zvMACgkQ3SOs138+
s6Hh3Q//X7dmLR4HOiiaGe4uf5xC4DNoBrDoU5+YI1I+wZ92BINHB0j+I+flET5R
SYLDoJu23EpeKKgxNHHQezxjrAT5lKme+6boVw0mYMIahEfiJ2I3jeGOgYPBM60s
eNrvbIo3bsBNZ2LaWyz1FfhGB8b6jPqWXIkRmWro8408qz7niITqHHwNWSdG0H5v
rj1/kvdqgGlsc73fgowsWTSUyBltpGBDIMFta668yViMsj+UqfuUVR/S+D60b2OK
KyHk89OfrWqSPkB70TvgiCKkSxYoDFBk9553K3fUSfkGjHcIwFnSgNeQ4Gfjl/m5
nRFgKQbFXpVVYxYL0/j0hRJsY+kmLW/KF2q/m99Wr2VhMyU7/szFU+4auyux0+K6
RqyFLBLG2S1BbU30+ksgxBQTUMeLLdya4IH826rzuJmw4vSS2/H75EwfHMdMe1GY
qxTfbkZnW6Cj8OfAKrKxY+IFGPTzh3wBZaEyZp9GBncJPx7OCcVJxTv5PaQSymJC
g0ycSrZ7RMGPhAT+1BBCdeP5dOWTfNo34i1v+Xrp/DNlH3TWehEZ5wcwElw4I4N3
Krc/K750Cs7t0FmfmIgdo7U+so6FcSyy68Vt5ytODLCmkagv2VVK9IpGhaJT9mCx
B0c+L6Zkwb5FqFj0Ji3wF8SjlaGaXf3A7R8L36JgsthEEr2RzXE=
=AVvO
-----END PGP SIGNATURE-----

--om3weh3neg6kh743--
