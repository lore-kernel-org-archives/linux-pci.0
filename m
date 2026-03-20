Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB653921FF;
	Fri, 20 Mar 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002896; cv=none; b=SyJo/F2TDb3A6cXyjYqwpV1Lv9PoI7SWQsmG+S2MwPV3vyhITcoDyFz8Y9xkE05g8nRm8EGEf9qp253mA3S4RYpth/Zdy7xE8kjjxlPCdFlcYgiY7FzlcWXQTaNuJFcBkd91blQsZn9xrGuRBOLAkr60qMXa3Ik089HcJLHwUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002896; c=relaxed/simple;
	bh=xcsf9IaJ2gl+/grTH18EC+E/mwCcct40oHedC/0qrtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHT+qdepmInT1+Un3aDeChCr5aCjuSo1NXTWYu3e0T9fZOXB5jRoVrP5cRo5ejvCNlJHtsXJ+lPTmXHRDVQMShR0jpIkVd4lnFw3AR9lkNZWa2sshp1smhqkUC7IK0ic4o56aZ9Aw4jyJstJcH61OkkF2m37/7ffNJbXXzPCUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4oCEw8J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4oCEw8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EEEC4CEF7;
	Fri, 20 Mar 2026 10:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774002896;
	bh=xcsf9IaJ2gl+/grTH18EC+E/mwCcct40oHedC/0qrtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4oCEw8JKOEF8ac3ihYtiubZh0jF7EpbWhnew95s7P3yX5gV+6W37y5D6Z2HGlhsa
	 k6qJ8l+wEYc94zA2+qCurNpodc5AWmxMAcel0U7pnQDux0KQed+bAKBFq0NEDmLVni
	 LPN5uwoUVirVnkU1AeH4nToX5XbXsSd8+rjSPJvOvqqzdBjYyFaIp/S42U1MmKmDCX
	 dtJftksTKvCDHOdM37wMjN/BxOoZgVmUAYKjs9/XqhYqWyNr39ZMl6NoSyhZfaaeeu
	 U+BQE8VxORPAQXxChWyp9Bqm5ifedpcf4/ZUG0Q3W3wsZbh4tHHobpnYjOJ/VbeFy9
	 KJHkpdJlXkp8w==
Date: Fri, 20 Mar 2026 11:34:53 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: tegra: Add Tegra264 support
Message-ID: <ab0XT15uG0YEVjBZ@orome>
References: <20260319160110.2131954-5-thierry.reding@kernel.org>
 <20260319174639.GA515667@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cft2orzwoitt2zzk"
Content-Disposition: inline
In-Reply-To: <20260319174639.GA515667@bhelgaas>


--cft2orzwoitt2zzk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] PCI: tegra: Add Tegra264 support
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 12:46:39PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 19, 2026 at 05:01:08PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> > driver is very small, with its main purpose being to set up the address
> > translation registers and then creating a standard PCI host using ECAM.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/pci/controller/Kconfig         |   8 +
> >  drivers/pci/controller/Makefile        |   1 +
> >  drivers/pci/controller/pcie-tegra264.c | 506 +++++++++++++++++++++++++
> >  3 files changed, 515 insertions(+)
> >  create mode 100644 drivers/pci/controller/pcie-tegra264.c
> >=20
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kc=
onfig
> > index e72ac6934379..36abee65eca1 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -257,6 +257,14 @@ config PCI_TEGRA
> >  	  Say Y here if you want support for the PCIe host controller found
> >  	  on NVIDIA Tegra SoCs.
>=20
> Should the PCI_TEGRA menu item ("NVIDIA Tegra PCIe controller") and
> this text be clarified somehow to make them clearly separate?

Good point. I'm adding "(Tegra20 through Tegra186)" to the PCI_TEGRA
option description.

> > +config PCIE_TEGRA264
> > +	bool "NVIDIA Tegra264 PCIe controller"
> > +	depends on ARCH_TEGRA || COMPILE_TEST
> > +	depends on PCI_MSI
> > +	help
> > +	  Say Y here if you want support for the PCIe host controller found
> > +	  on NVIDIA Tegra264 SoCs.
>=20
> > + * PCIe host controller driver for Tegra264 SoC
> > + *
> > + * Author: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>=20
> Manikanta doesn't appear in the signed-off-by or other tags above.
> Not really an issue for me; just a question of whether this is
> accurate.

You're right. I should've added a Signed-off-by for Manikanta. I'm
dropping this line here, though, because there's already a MODULE_AUTHOR
line at the end of the file.

>=20
> > +#define PCIE_LINK_UP_DELAY	10000	/* 10 msec */
> > +#define PCIE_LINK_UP_TIMEOUT	1000000	/* 1 s */
>=20
> Use something from drivers/pci/pci.h if possible.  If not, please add
> units suffixes to the name, e.g., it looks like these are in "_US".
>=20
> PCIE_LINK_WAIT_MAX_RETRIES and PCIE_LINK_WAIT_SLEEP_MS look like
> they're used in similar ways in other drivers.

I see a bunch of implementations that use custom defines, if you don't
mind I'll have a go and unifying this a little. Most implementations
seem to use usleep_range(90000, 100000) with 10 retries.

>=20
> > +/* XAL registers */
> > +#define XAL_RC_ECAM_BASE_HI			0x00
> > +#define XAL_RC_ECAM_BASE_LO			0x04
> > +#define XAL_RC_ECAM_BUSMASK			0x08
> > +#define XAL_RC_IO_BASE_HI			0x0c
> > ...
> > +#define XTL_RC_MGMT_CLOCK_CONTROL		0x47C
>=20
> Inconsistent use of upper/lower-case hex with above.

Fixed.

> > +struct tegra264_pcie {
> > +	struct device *dev;
> > +	bool link_state;
>=20
> "link_state" being true/false doesn't read quite right because
> true/false isn't a "state".  I guess true means "link is up"?

I've renamed this field to "link_up" so it's less ambiguous.

> > +static int tegra264_pcie_parse_dt(struct tegra264_pcie *pcie)
> > +{
> > +	int err;
> > +
> > +	pcie->wake_gpio =3D devm_gpiod_get_optional(pcie->dev, "nvidia,pex-wa=
ke",
> > +						  GPIOD_IN);
> > +	if (IS_ERR(pcie->wake_gpio))
> > +		return PTR_ERR(pcie->wake_gpio);
> > +
> > +	if (pcie->wake_gpio) {
> > +		device_init_wakeup(pcie->dev, true);
> > +
> > +		err =3D gpiod_to_irq(pcie->wake_gpio);
> > +		if (err < 0) {
> > +			dev_err(pcie->dev, "failed to get wake IRQ: %d\n", err);
>=20
> Does %pe work here (and below)?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/core-api/printk-formats.rst?id=3Dv6.19#n96

It won't work in this particular case because %pe needs an ERR_PTR-
encoded error code. For the other messages it's probably better to move
to dev_err_probe() as Krzysztof suggested.

>=20
> > +static void tegra264_pcie_bpmp_set_rp_state(struct tegra264_pcie *pcie)
> > +{
> > +	struct tegra_bpmp_message msg;
> > +	struct mrq_pcie_request req;
> > +	int err;
> > +
> > +	memset(&req, 0, sizeof(req));
>=20
> I think "struct mrq_pcie_request req =3D {}" is equivalent, also for
> msg.  No real preference from me.

Me neither. "=3D {}" saves two extra lines, so I guess it wins.

>=20
> > +static void tegra264_pcie_init(struct tegra264_pcie *pcie)
> > +{
> > +	u32 value;
> > +
> > +	if (!tegra_is_silicon()) {
> > +		dev_info(pcie->dev,
> > +			 "skipping link state for PCIe #%u in simulation\n",
> > +			 pcie->ctl_id);
> > +		pcie->link_state =3D true;
> > +		return;
> > +	}
> > +
> > +	/* Poll every 10 msec for 1 sec to link up */
> > +	readl_poll_timeout(pcie->ecam + XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS,
> > +		value, value & XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS_DLL_ACTIVE,
> > +		PCIE_LINK_UP_DELAY, PCIE_LINK_UP_TIMEOUT);
> > +
> > +	if (value & XTL_RC_PCIE_CFG_LINK_CONTROL_STATUS_DLL_ACTIVE) {
> > +		/* Per PCIe r5.0, 6.6.1 wait for 100ms after DLL up */
> > +		msleep(100);
>=20
> Looks like possibly PCIE_RESET_CONFIG_WAIT_MS?

Yeah, looks about right. I'm not sure if we really need it in addition
to the polling above, but probably okay for an extra safe margin.

> > +		dev_info(pcie->dev, "PCIe #%u link is up (speed: %d)\n",
> > +			 pcie->ctl_id, (value & 0xf0000) >> 16);
> > +		pcie->link_state =3D true;
> > +		tegra264_pcie_icc_set(pcie);
> > +	} else {
> > +		dev_info(pcie->dev, "PCIe #%u link is down\n", pcie->ctl_id);
> > +
> > +		value =3D readl(pcie->xtl + XTL_RC_MGMT_CLOCK_CONTROL);
> > +
> > +		/** Set link state only when link fails and no hot-plug feature is p=
resent */
>=20
> /* (not /**), and wrap to fit in 78 columns.
>=20
> > +		if ((value & XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_T=
O_PRSNT) =3D=3D 0) {
> > +			dev_info(pcie->dev,
> > +				 "PCIe #%u link is down and not hotplug-capable, turning off\n",
> > +				 pcie->ctl_id);
> > +			tegra264_pcie_bpmp_set_rp_state(pcie);
> > +			pcie->link_state =3D false;
> > +		} else {
> > +			pcie->link_state =3D true;
> > +		}
> > +	}
> > +}
> > +
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
>=20
> Looks like this and others below could use:
>=20
>   if (!bridge)
>     return dev_err_probe(dev, -ENOMEM, "failed ...");

Guess everybody wants to use this now. I tend not to like it because it
has some issues with wrapping (because of the return, the _probe suffix
and the error code, it tends to go beyond 80 characters, cancelling out
many of the benefits). I see the extra benefit for cases where probe
deferral is a possibility, so that's where I usually do use it.

Anyway, I'll convert these since both you and Krzysztof requested it.

> > +static const struct dev_pm_ops tegra264_pcie_pm_ops =3D {
> > +	.resume_noirq =3D tegra264_pcie_resume_noirq,
> > +	.suspend_noirq =3D tegra264_pcie_suspend_noirq,
> > +};
>=20
> Should this use DEFINE_NOIRQ_DEV_PM_OPS() or similar to avoid warnings
> when CONFIG_PM_SLEEP, etc are not enabled?

Yes, that's a good point.

Thanks,
Thierry

--cft2orzwoitt2zzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmm9IsoACgkQ3SOs138+
s6ErEQ//Yhq9Tuf/TLR3gXA5rEswHhqcKO40YpFD0rJgTy/f1Y75cOceJvY41pd6
VdGxabeXQubJ6yQ3KVV7EdfLR/bAv3Y8ZIaybaaL6ahG6xcrfjf/9O0qVosv0bvg
xrpwnsGMG1RwRu8ca6Fk+QdOPo+9YvMaGhoUAA5Ekg8K8NTFDfTFjyLg4RiD/+50
CCgwoQtnm9Vi+yLmq5XeQcZejpVRB/o42qvmMgfyYwDq1ueI0d+B5ZxPGBd1Ev64
37H2xQZ8JUDQRi9c20909bLpmVnO7gGs7gX9FVYn0ccwxBRAex5gtc532t8qDLex
HdrEn854Br/Mvg7f0/k2Wo4Fq+DyGoLGLP7+bWL8IaknPE9QJ23Bjdlw/rAwrZas
S8RIEVrQO2tu9ZbQBHdcnIYvnhs5tkL3VAEVfFYKF7o8teCkAqcrEfs6yUPq2Zt3
Ph/c213YahdFMjxttkiu9dbxPn6EtAaSputXqxi8oE8mxzACsmOogVCmWpB1NRFE
UOfo473cryTDvsQy1ltnU/FbiFgznkMRyPRfJynZ8lSzTFl4MROgJ7U7jFj4VSxk
7G7txAXQaQd/eaH7QtRlP+Xu/OI7KHmooY5lhG2r7WCuih8qDbqn9v0sAXremdtv
HV0ZQa+GsOAG8NKx8WnrRefbD0It3Dxr0VaAKx0pv3QOWBTU3N8=
=8MJQ
-----END PGP SIGNATURE-----

--cft2orzwoitt2zzk--
