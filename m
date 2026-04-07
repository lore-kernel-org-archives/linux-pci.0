Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4738AC93;
	Tue,  7 Apr 2026 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554711; cv=none; b=kWxRJVLMDudJPxI+n5M5TPWfas8OS9rIoz7SYaqM3t6xWdRjiieaBvaqPDy/sytwgE+C/Ku8agTPIYRBwPK7jJS4MXzlGZ/a5yrk7W9iQGIjh7EVP7N0CstmZszPBmXFdOfvJQC6Dlidoid7tAaanGneHubwI3sakbldMAB6Ikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554711; c=relaxed/simple;
	bh=Uclf5ajKGlirtFS+exys4PG+9RGNZbkt5MlvGo9XdQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSkAcIb6HgnY/+Wg2lAyN5WhlKQCZxXzxTsC9C8CGq8VhdEynxIcIt8LirUkK4DG5qo2cMAO636gDArsA1nm3FOp5R4vlL8BRJ9FkfDM0ikPDetxYFULN7m0ubDG9r5qpiR/m5odENlePkkiICJH4QIRWUZ/63xZJUpw8uQzrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk87Mz5+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk87Mz5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB40C116C6;
	Tue,  7 Apr 2026 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775554711;
	bh=Uclf5ajKGlirtFS+exys4PG+9RGNZbkt5MlvGo9XdQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rk87Mz5+8zNd8ViFTM/x+ma8Z16WtyLvt2IZj/EOooJFfHKz2LnBAYdzKKWuTKIHx
	 tkds+wFJe5Y3EyrOGGuhGN/AI7qM5eje9RNBKhdS8HcNVh+o6E6RLNB1mGhd9fMd46
	 uDfXG34YKhgyX7CoeypvOWcNvvKBubM+9Ozopw84vdJP3oEcoBU9MVJPeFNvmuhPdt
	 Tp71MMFoOMwuR/ZtO7xcJTFYc0eO2eXSTnw0ikAJOtcbz598y9rtbo0tx2VMwb2I3h
	 Aq+i8aMGWY3Mt4h5h2Ignec1MGLZh0WGN5QgiCuq5F+BHADfShsaluYcUeBZtpk2+u
	 iIGNguEMCdO3Q==
Date: Tue, 7 Apr 2026 11:38:28 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v4 3/4] PCI: tegra: Add Tegra264 support
Message-ID: <adTAVYEzfD9FQl8N@orome>
References: <20260402-tegra264-pcie-v4-0-21e2e19987e8@nvidia.com>
 <20260402-tegra264-pcie-v4-3-21e2e19987e8@nvidia.com>
 <iaoee5r5e2w52fap7ex23wdikbuvpjpesinedgjkehsedszhzo@64yoo2avmxle>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q44iycnkojb2hlgm"
Content-Disposition: inline
In-Reply-To: <iaoee5r5e2w52fap7ex23wdikbuvpjpesinedgjkehsedszhzo@64yoo2avmxle>


--q44iycnkojb2hlgm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/4] PCI: tegra: Add Tegra264 support
MIME-Version: 1.0

On Thu, Apr 02, 2026 at 11:02:02PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 02, 2026 at 04:27:37PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> > driver is very small, with its main purpose being to set up the address
> > translation registers and then creating a standard PCI host using ECAM.
> >=20
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> What is the rationale for adding a new driver? Can't you reuse the existi=
ng one?
> If so, that should be mentioned in the description.

Which existing one? Tegra PCI controllers for previou generations
(Tegra194 and Tegra234) were DesignWare IP, but Tegra264 is an internal
IP, so the programming is entirely different. I'll add something to that
effect to the commit message.

> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index 5aaed8ac6e44..6ead04f7bd6e 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -254,7 +254,15 @@ config PCI_TEGRA
> >  	select IRQ_MSI_LIB
> >  	help
> >  	  Say Y here if you want support for the PCIe host controller found
> > -	  on NVIDIA Tegra SoCs.
> > +	  on NVIDIA Tegra SoCs (Tegra20 through Tegra186).
> > +
> > +config PCIE_TEGRA264
> > +	bool "NVIDIA Tegra264 PCIe controller"
>=20
> This driver seems to be using external MSI controller. So it can be built=
 as a
> module. Also, you have the remove() callback for some reason.

Okay, I can turn this into a tristate symbol.

> > +	depends on ARCH_TEGRA || COMPILE_TEST
> > +	depends on PCI_MSI
>=20
> Why?

I suppose it's not necessary in the sense of it being a build
dependency. At runtime, however, the root complex is not useful if PCI
MSI is not enabled. We can drop this dependency and rely on .config to
have it enabled as needed.

> > diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/contr=
oller/pcie-tegra264.c
> > new file mode 100644
> > index 000000000000..3ce1ad971bdb
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-tegra264.c
[...]
> > +struct tegra264_pcie {
> > +	struct device *dev;
> > +	bool link_up;
>=20
> Keep bool types at the end to avoid holes.

Done.

> > +static int tegra264_pcie_parse_dt(struct tegra264_pcie *pcie)
> > +{
> > +	int err;
> > +
> > +	pcie->wake_gpio =3D devm_gpiod_get_optional(pcie->dev, "nvidia,pex-wa=
ke",
>=20
> You should switch to standard 'wake-gpios' property.

Will do.

> > +						  GPIOD_IN);
> > +	if (IS_ERR(pcie->wake_gpio))
> > +		return PTR_ERR(pcie->wake_gpio);
> > +
> > +	if (pcie->wake_gpio) {
>=20
> Since you are bailing out above, you don't need this check.

I think we still want to have this check to handle the case of optional
wake GPIOs. Not all controllers may have this wired up and
devm_gpiod_get_optional() will return NULL (not an ERR_PTR()-encoded
error) if the wake-gpios property is missing.

> > +static void tegra264_pcie_bpmp_set_rp_state(struct tegra264_pcie *pcie)
>=20
> I don't think this function name is self explanatory. Looks like it is tu=
rning
> off the PCIe controller, so how about tegra264_pcie_power_off()?

Agreed. The name is a relic from when this was potentially being used to
toggle on and off the controller. But it's only used for disabling, so
tegra264_pcie__power_off() sounds much better.

> > +{
> > +	struct tegra_bpmp_message msg =3D {};
> > +	struct mrq_pcie_request req =3D {};
> > +	int err;
> > +
> > +	req.cmd =3D CMD_PCIE_RP_CONTROLLER_OFF;
> > +	req.rp_ctrlr_off.rp_controller =3D pcie->ctl_id;
> > +
> > +	msg.mrq =3D MRQ_PCIE;
> > +	msg.tx.data =3D &req;
> > +	msg.tx.size =3D sizeof(req);
> > +
> > +	err =3D tegra_bpmp_transfer(pcie->bpmp, &msg);
> > +	if (err)
> > +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %pe\n",
>=20
> Why not dev_err()?
>=20
> > +			 pcie->ctl_id, ERR_PTR(err));
> > +
> > +	if (msg.rx.ret)
> > +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %d\n",
>=20
> Same here.

These are not fatal errors and are safe to ignore. dev_err() seemed too
strong for this. They also really shouldn't happen. Though I now realize
that's a bad argument, or rather, actually an argument for making them
dev_err() so that they do stand out if they really should happen.

>=20
> > +			 pcie->ctl_id, msg.rx.ret);
> > +}
> > +
> > +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> > +{
> > +	u32 value, speed, width, bw;
> > +	int err;
> > +
> > +	value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> > +	speed =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> > +	width =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> > +
> > +	bw =3D width * (PCIE_SPEED2MBS_ENC(speed) / BITS_PER_BYTE);
> > +	value =3D MBps_to_icc(bw);
>=20
> So this becomes, 'width * (PCIE_SPEED2MBS_ENC(speed) / 8) * 1000 / 8'. Bu=
t don't
> you want, 'width * (PCIE_SPEED2MBS_ENC(speed)) * 1000 / 8'?

This is M*B*ps_to_icc(), not M*b*ps_to_icc(), so we do in fact get the
latter. I almost fell for this as well because I got confused by some of
these macros being all-caps and other times the case actually mattering.

> > +	err =3D icc_set_bw(pcie->icc_path, bw, bw);
> > +	if (err < 0)
> > +		dev_err(pcie->dev,
> > +			"failed to request bandwidth (%u MBps): %pe\n",
> > +			bw, ERR_PTR(err));
>=20
> So you don't want to error out if this fails?

No. This is not a fatal error and the system will continue to work,
albeit perhaps at suboptimal performance. Given that Ethernet and mass
storage are connected to these, a failure to set the bandwidth and
erroring out here may leave the system unusable, but continuing on would
let the system boot and update firmware, kernel or whatever to recover.

I'll add a comment explaining this.

[...]
> > +static void tegra264_pcie_init(struct tegra264_pcie *pcie)
> > +{
> > +	enum pci_bus_speed speed;
> > +	unsigned int i;
> > +	u32 value;
> > +
> > +	/* bring the link out of reset */
>=20
> s/link/controller or endpoint?

This controls the PERST# signal, so I guess "endpoint" would be more
correct.

> > +	value =3D readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> > +	value |=3D XTL_RC_MGMT_PERST_CONTROL_PERST_O_N;
> > +	writel(value, pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> > +
> > +	if (!tegra_is_silicon()) {
>=20
> This looks like some pre-silicon validation thing. Do you really want it =
to be
> present in the upstream driver?

At this point there is silicon for this chip, but we've been trying to
get some of the pre-silicon code merged upstream as well because
occasionally people will want to run upstream on simulation, even after
silicon is available. At other times we may want to reuse these drivers
on future chips during pre-silicon validation.

Obviously there needs to be a balance. We don't want to have excessive
amounts of code specifically for pre-silicon validation, but in
relatively simple cases like this it is useful.

>=20
> > +		dev_info(pcie->dev,
> > +			 "skipping link state for PCIe #%u in simulation\n",
> > +			 pcie->ctl_id);
> > +		pcie->link_up =3D true;
> > +		return;
> > +	}
> > +
> > +	for (i =3D 0; i < PCIE_LINK_WAIT_MAX_RETRIES; i++) {
> > +		if (tegra264_pcie_link_up(pcie, NULL))
> > +			break;
> > +
> > +		usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
> > +	}
> > +
> > +	if (tegra264_pcie_link_up(pcie, &speed)) {
>=20
> Why are you doing it for the second time?

It's just a last-resort check to see if it's really not come up after
the retries. Also, in this call we're actually interested in retrieving
the detected link speed.

>=20
> > +		/* Per PCIe r5.0, 6.6.1 wait for 100ms after DLL up */
>=20
> No need of this comment.

Fair enough. This was perhaps more useful in earlier versions of the
patch before the line below used the standardize wait time.

[...]
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
> > +	if (!bridge)
> > +		return dev_err_probe(dev, -ENOMEM,
> > +				     "failed to allocate host bridge\n");
> > +
> > +	pcie =3D pci_host_bridge_priv(bridge);
> > +	platform_set_drvdata(pdev, pcie);
> > +	pcie->bridge =3D bridge;
> > +	pcie->dev =3D dev;
> > +
> > +	err =3D pinctrl_pm_select_default_state(dev);
>=20
> I questioned this before:
> https://lore.kernel.org/linux-pci/o5sxxdikdjwd76zsedvkpsl54nw6wrhopwsflt4=
3y5st67mrub@uuw3yfjfqthd/

I'll remove this. Looks like we should be fine with just relying on the
default state being set by the pinctrl core. We might need to move it
into the resume callback.

> > +	if (err < 0)
> > +		return dev_err_probe(dev, err,
> > +				     "failed to configure sideband pins\n");
> > +
> > +	err =3D tegra264_pcie_parse_dt(pcie);
> > +	if (err < 0)
> > +		return dev_err_probe(dev, err, "failed to parse device tree");
> > +
> > +	pcie->xal =3D devm_platform_ioremap_resource_byname(pdev, "xal");
> > +	if (IS_ERR(pcie->xal))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->xal),
> > +				     "failed to map XAL memory\n");
> > +
> > +	pcie->xtl =3D devm_platform_ioremap_resource_byname(pdev, "xtl-pri");
> > +	if (IS_ERR(pcie->xtl))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->xtl),
> > +				     "failed to map XTL-PRI memory\n");
> > +
> > +	bus =3D resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> > +	if (!bus)
> > +		return dev_err_probe(dev, -ENODEV,
> > +				     "failed to get bus resources\n");
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam");
> > +	if (!res)
> > +		return dev_err_probe(dev, -ENXIO,
> > +				     "failed to get ECAM resource\n");
> > +
> > +	pcie->icc_path =3D devm_of_icc_get(&pdev->dev, "write");
> > +	if (IS_ERR(pcie->icc_path))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(pcie->icc_path),
> > +				     "failed to get ICC");
> > +
> > +	/*
> > +	 * Parse BPMP property only for silicon, as interaction with BPMP is
> > +	 * not needed for other platforms.
> > +	 */
> > +	if (tegra_is_silicon()) {
> > +		pcie->bpmp =3D tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
> > +		if (IS_ERR(pcie->bpmp))
> > +			return dev_err_probe(dev, PTR_ERR(pcie->bpmp),
> > +					     "failed to get BPMP\n");
> > +	}
> > +
>=20
> pm_runtime_set_active()
>=20
> > +	pm_runtime_enable(dev);
>=20
> devm_pm_runtime_enable()?

Looks like I can even use devm_pm_runtime_set_active_enabled() to
combine the two.

>=20
> > +	pm_runtime_get_sync(dev);
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
> > +		goto free;
>=20
> goto free_ecam;

It's not clear to me, but are you suggesting to rename the existing
"free" label to "free_ecam"? I can do that.

> > +	err =3D pci_host_probe(bridge);
> > +	if (err < 0) {
> > +		dev_err(dev, "failed to register host: %pe\n", ERR_PTR(err));
>=20
> dev_err_probe()

Okay.

>=20
> > +		goto free;
> > +	}
> > +
> > +	return err;
>=20
> return 0;

Done.

[...]
> > +static int tegra264_pcie_resume_noirq(struct device *dev)
> > +{
> > +	struct tegra264_pcie *pcie =3D dev_get_drvdata(dev);
> > +	int err;
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
> > +
> > +	tegra264_pcie_init(pcie);
> > +
>=20
> Why do you need init() here without deinit() in tegra264_pcie_suspend_noi=
rq()?

That's because when we come out of suspend the link may have gone down
again, so we need to take the endpoint out of reset to retrigger the
link training. I think we could possibly explicitly clear that PERST_O_N
bit in the PERST_CONTROL register in a new tegra264_pcie_deinit() to
mirror what tegra264_pcie_init() does, but it's automatically done by
firmware anyway, so not needed.

Thierry

--q44iycnkojb2hlgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnU0JEACgkQ3SOs138+
s6H4mhAAj69cIjkOjfrlyDPnuCpXLVmKhK5GcEX189lxYsxkcWieA9t/WNB0LQpr
jwLRptKVBBNA1uJvi3vhFrzDumYVugeKreYr+IrxnCFHONLe8V4hzDDgWXoTRk87
UpE7YpQNqrSXC7gF8+PU/HQ7keyLnTqvPPIQXBL/7Mpo4gqHnvNCOAaqA4SB8Zke
0XKHXdJ7jb/ctJZnGPjqsgB31pBRaPzJ6KL3Q5N09AdMz7bRPk1Umf844lwfB1Np
cwttsID9SRWx8fkZtsSvzkNRUka2l71O9b2Y9RnHFNvpNbvQR1aj95prjZYmi0ID
uVwhT2n0omToDkP6eHYdoHvR5WtBbIw2C6z+7ocptiT5/bR0JxDxotNKGOeZgzEd
kQY3lUSVdPOa5ML+yZ7Odo8WXV76IAiGpS3CVXXfTK5n65c75g01IF4VB1GjGKDF
K0j/a477oiJ/WFn2J+yRj3milfNidXcMwrQC7ImdY2gT6Mn2EClvPGIv3nF9xYfu
NdSXxIWmpoZxfVWKprY91cgnawFDusim1UO+w3iZ2SPFG81Aj0WekmcJ3zsFAaMn
kFyzXAVzMm7m9/vxlnYEaeBFnoVmf2HMUeNWt7O0drlfKN5XG36MYSu1FdEDCfUK
l+x/oy8E/GYC5nwfKp5TYVmAnkFjQbo+ZWgSyxw2mg1CYBpyzbY=
=TfWe
-----END PGP SIGNATURE-----

--q44iycnkojb2hlgm--
