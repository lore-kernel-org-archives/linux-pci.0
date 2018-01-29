Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33149 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeA2PSr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jan 2018 10:18:47 -0500
Date: Mon, 29 Jan 2018 16:18:42 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, cyndis@kapsi.fi,
        jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com,
        rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com,
        kthota@nvidia.com, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V6 6/7] PCI: tegra: Broadcast PME_Turn_Off message before
 link goes to L2
Message-ID: <20180129151842.GA26264@ulmo>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
 <1515650888-9459-7-git-send-email-mmaddireddy@nvidia.com>
 <20180125143627.GH27888@ulmo>
 <8adc2a7d-009b-168c-07f6-b50526ce0605@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
In-Reply-To: <8adc2a7d-009b-168c-07f6-b50526ce0605@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 10:11:42AM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 25-Jan-18 8:06 PM, Thierry Reding wrote:
> > On Thu, Jan 11, 2018 at 11:38:07AM +0530, Manikanta Maddireddy wrote:
> >> Per PCIe r3.0, sec 5.3.3.2.1, PCIe root port shoould broadcast PME_Tur=
n_Off
> >> message before PCIe link goes to L2. PME_Turn_Off broadcast mechanism =
is
> >> implemented in AFI module. Each Tegra PCIe root port has its own
> >> PME_Turn_Off and PME_TO_Ack bitmap in AFI_PME register, program this
> >> register to broadcast PME_Turn_Off message.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> ---
> >> V2:
> >> * no change in this patch
> >> V3:
> >> * add PME bitmap in soc data instead of using compatible string
> >> * replace while loop with readl_poll_timeout() for polling
> >> * commit log correction
> >> V4:
> >> * no change in this patch
> >> V5:
> >> * Rebased on linux-next
> >> V6:
> >> * no change in this patch
> >>
> >>  drivers/pci/host/pci-tegra.c | 45 +++++++++++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 45 insertions(+)
> >>
> >> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra=
=2Ec
> >> index 981f126b14d6..cc33fc0fb300 100644
> >> --- a/drivers/pci/host/pci-tegra.c
> >> +++ b/drivers/pci/host/pci-tegra.c
> >> @@ -31,6 +31,7 @@
> >>  #include <linux/delay.h>
> >>  #include <linux/export.h>
> >>  #include <linux/interrupt.h>
> >> +#include <linux/iopoll.h>
> >>  #include <linux/irq.h>
> >>  #include <linux/irqdomain.h>
> >>  #include <linux/kernel.h>
> >> @@ -153,6 +154,8 @@
> >>  #define  AFI_INTR_EN_FPCI_TIMEOUT	(1 << 7)
> >>  #define  AFI_INTR_EN_PRSNT_SENSE	(1 << 8)
> >> =20
> >> +#define AFI_PCIE_PME		0xf0
> >> +
> >>  #define AFI_PCIE_CONFIG					0x0f8
> >>  #define  AFI_PCIE_CONFIG_PCIE_DISABLE(x)		(1 << ((x) + 1))
> >>  #define  AFI_PCIE_CONFIG_PCIE_DISABLE_ALL		0xe
> >> @@ -233,6 +236,8 @@
> >>  #define PADS_REFCLK_CFG_PREDI_SHIFT		8  /* 11:8 */
> >>  #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
> >> =20
> >> +#define PME_ACK_TIMEOUT 10000
> >> +
> >>  struct tegra_msi {
> >>  	struct msi_controller chip;
> >>  	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
> >> @@ -251,6 +256,8 @@ struct tegra_pcie_soc {
> >>  	u32 tx_ref_sel;
> >>  	u32 pads_refclk_cfg0;
> >>  	u32 pads_refclk_cfg1;
> >> +	u8 pme_turnoff_bit[3];
> >> +	u8 pme_ack_bit[3];
> >=20
> > This seems suboptimal to me. Perhaps a better way would be:
> >=20
> > 	struct tegra_pcie_port_soc {
> > 		struct {
> > 			u8 turnoff_bit;
> > 			u8 ack_bit;
> > 		} pme;
> > 	};
> >=20
> > And since we already have num_ports which defines exactly how many ports
> > we have:
> >=20
> > 	struct tegra_pcie_soc {
> > 		unsigned int num_ports;
> > 		const struct tegra_pcie_port_soc *ports;
> > 		...
> > 	};
> >=20
> > I suspect that as you're adding more features we may need more of this
> > data.
> >=20
> > But I'm fine to keep it like this. We can always switch to something
> > different if the above becomes too much cluttered.
> >=20
> I agree it is sub optimal. I moved pme bitmap values to soc data because
> tegra30 and tegra186 have different bitmap values. To differentiate this
> I allocated static memory in tegra_pcie_soc. I am a bit hesitant do dynam=
ic
> allocation based on num_ports because I need to use compatible string
> to distinguish between tegra30 & tegra186 in runtime. I believe it is OK
> to have trade off 16 bits to avoid these compatible check?

Sorry if I was unclear. I didn't suggest that you'd dynamically allocate
memory, instead you'd hook it up like so:

	static const struct tegra_pcie_port_soc tegra186_pcie_ports[] =3D {
		{ .turnoff_bit =3D  0, .ack_bit =3D  5 },
		{ .turnoff_bit =3D  8, .ack_bit =3D 10 },
		{ .turnoff_bit =3D 12, .ack_bit =3D 14 },
	};

And then in the existing tegra186_pcie, you'd set this:

	static const struct tegra_pcie_soc tegra186_pcie =3D {
		.num_ports =3D 3,
		.ports =3D tegra186_pcie_ports,
		...
	};

And similar for the others. I realize that this is somewhat more verbose
than your original, but I think it's more readable.

It also allows you to reuse data, such as:

	static const struct tegra_pcie_port_soc tegra20_pcie_ports[] =3D {
		{ .turnoff_bit =3D 0, .ack_bit =3D  5 },
		{ .turnoff_bit =3D 8, .ack_bit =3D 10 },
	};

	...

	static const struct tegra_pcie_soc tegra20_pcie =3D {
		.num_ports =3D 2,
		.ports =3D tegra20_pcie_ports,
		...
	};

	...

	static const struct tegra_pcie_soc tegra124_pcie =3D {
		.num_ports =3D 2,
		.ports =3D tegra20_pcie_ports,
		...
	};

	static const struct tegra_pcie_soc tegra210_pcie =3D {
		.num_ports =3D 2,
		.ports =3D tegra20_pcie_ports,
		...
	};

Of course the sharing only works as long as the port definitions don't
contain data that's different between the chips.

You could even go and derive the .num_ports as ARRAY_SIZE() of the ports
definition.

So the above does not dynamically allocate memory, it is just a more
explicit way of specifying the data. It puts the data closer together,
and thereby makes it easier to read, in my opinion.

But as I said, feel free to leave this as-is. We can easily rework this
later on or if necessary.

Thierry

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlpvO08ACgkQ3SOs138+
s6GCPg/+MH2hGE+xQ7PI84FzmIaX0w4U1cTbQ6+L0b8NL/1LO9IfQJ1VR8LonPXA
lCafGzi3rpYhUQglociWVYbrS3KRx6AcWIx7+Ag3JlCt2y1CG4MoCuGX89+qdjiv
1CzkFztqm+U9UxOMBbNgbWRF4OhoSqTpT8UpsBrGk9Fe3vTeX36+kJXc+yoIvh/P
iqYE7IQQtfQABhv4FxteVg9+YOC36JWxc7iNNryoZlyO3VHUMVpk42Fltie+thIe
yxTGrw/zAsMRVWarbN05LeNzdQZXLj5VDZuIXj8rviA45gKK4XFPOctvajYiRmei
3Z1e0IHiG+UFp1ZqIcqnXHztcvS7TXjvLnH59vaDE3UfOkTL0hmc/lTh/4J+q65q
0TDucx8R74tNU2/2arFWTv7Qv9mJkMCf82J5T5s4KXJHgYyONpJ4i9jz8OEYvQtr
7Q15affIXxifR4C8y+hywmW7UuWYLHt/dS1B2/VfIjHx7c+rJEycQzLzm+zwd6+N
QF9VDwjYCam1GBLt77cerCJYHsgJHu+vn2Y/DYrBSimeNPK3DV770mAQm1VFZHDz
RVzVr4V0+LYGc64pvQKcjZIrMetDOFj1mNGlsMeSqG9eTGkglie0PZEQyw+Q2/6N
LDUj2yL2km657WtO2gyZIBYedSSdkIXXRNEtmCOqd7KgwEosDzk=
=u+Cf
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
