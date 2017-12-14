Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33419 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbdLNQNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 11:13:55 -0500
Date: Thu, 14 Dec 2017 17:13:51 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com, mperttunen@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com
Subject: Re: [PATCH V3 12/12] PCI: tegra: Update flow control threshold in
 Tegra210
Message-ID: <20171214161351.GM13733@ulmo>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <1509371843-22931-13-git-send-email-mmaddireddy@nvidia.com>
 <20171212174329.GA22418@red-moon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c8UbHMnQwI7BF+TB"
In-Reply-To: <20171212174329.GA22418@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--c8UbHMnQwI7BF+TB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2017 at 05:43:29PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Oct 30, 2017 at 07:27:23PM +0530, Manikanta Maddireddy wrote:
> > Recommended update FC threshold in Tegra210 is 0x60 for best performance
> > of x1 link. Setting this to 0x60 provides the best balance between numb=
er
> > of UpdateFC and read data sent over the link.
> >=20
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > ---
> > V3:
> > * changed soc parameter name
> > V2:
> > * no change in this patch
> >=20
> >  drivers/pci/host/pci-tegra.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > index b29329226e3d..812d32cfdd0e 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -223,6 +223,7 @@
> >  #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
> >  #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
> >  #define  RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK	(0xff << 18)
> > +#define  RP_VEND_XP_UPDATE_FC_THRESHOLD_T210	(0x60 << 18)
>=20
> You define a SOC specific threshold and a update_fc_threshold bool
> variable to update it ? And what are you going to do if that's needed
> on something that it is not a T210 ? Should not this be a(nother)
> struct tegra_pcie_soc parameter instead than a macro ?
>=20
> Not that I am happy about it but this deviates from the current
> approach.
>=20
> >  #define RP_VEND_CTL0	0xf44
> >  #define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
> > @@ -323,6 +324,7 @@ struct tegra_pcie_soc {
> >  	bool update_clamp_threshold;
> >  	bool raw_violation_fixup;
> >  	bool program_deskew_time;
> > +	bool update_fc_threshold;
> >  };
> > =20
> >  static inline struct tegra_msi *to_tegra_msi(struct msi_controller *ch=
ip)
> > @@ -2231,6 +2233,13 @@ static void tegra_pcie_apply_sw_fixup(struct teg=
ra_pcie_port *port)
> >  		value |=3D RP_VEND_CTL0_DSK_RST_PULSE_WIDTH;
> >  		writel(value, port->base + RP_VEND_CTL0);
> >  	}
> > +
> > +	if (soc->update_fc_threshold) {
> > +		value =3D readl(port->base + RP_VEND_XP);
> > +		value &=3D ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
> > +		value |=3D RP_VEND_XP_UPDATE_FC_THRESHOLD_T210;
> > +		writel(value, port->base + RP_VEND_XP);
> > +	}
>=20
> If, say, a platform requires update_fc_threshold and raw_violation_fixup
> what takes precedence (ie they required programming the _same_
> registers) ? update_fc_threshold takes precedence, since it is applied
> last - but I would like you to think about this and realize that this
> per-SoC mechanism does not scale anymore.
>=20
> You should a) enforce some firmware initialization - most of the
> parameters in struct tegra_pcie_soc could have been pre-programmed
> by FW and

I don't think that's going to work. We reset the hardware during probe
(and a subsequent patchset will make it possible for this driver to be
a loadable module, which will power down the unit on driver removal or
even runtime PM suspend), so any firmware initialization will be lost
after that point and the driver has to reprogram all the registers.

> b) think about adding some DT properties to handle the PCI host bridge
> set-up.

That isn't going to solve the problem of precedence that you bring up
above. Where the data is coming from doesn't change that the order of
execution needs to be defined in the code.

Also, all of the parameters that we have in the struct tegra_pcie_soc
are SoC specific and therefore implied by the compatible string, which
is also why the current approach was chosen back at the time. The
reasoning was that if the property defines the programming model, then
it will be implied by the compatible string. If we moved that data out
into the device tree, we essentially wind up with the same problem, in
a different location. We'd still need to specify the data on a per-SoC
basis in device tree.

Thierry

--c8UbHMnQwI7BF+TB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloyozwACgkQ3SOs138+
s6GmzRAAi0olcwEdCKRBxi0BZN/+RviMx5LuSMx+6Tt8g8ZYF4wJuB2Rpq44brTN
WfB/rLo5p/zLxvsEjoWSof00TfJl1K3lxVqqTYWUczimQDBDNVVyGOUpRdkClFu5
MoYclm1vd/wc72PgCLIqJfNd9IhGM7IF2Nx06/GrpLwI5inBI5K/pdjxf5d13jFZ
m9eu19n1rOjYlBAcAlDyygEKnwJnvaHLLwhOl9iS1fExOAhlzi/Sw4Uj9uqjJzQJ
EI3ahtf5khKaLzLMFpFvyRRbjdPu9IMP+FIbysdqR7FuXBq39XbR4J380p5L3Kmc
AxgisYzrB0BrrDt7WFxwVOhq9aSqGVuNTirkzx4R6/qwUJA3//OFJnFxdYbmIVYC
X+ilee+LubKw5WPpqTJgc5JEMy4RpSatjkWeeIgUemx2vjooCi0GjmsBgRCov8tp
MugoCRkbeEdomK61g8xHForHiR7lYCL98I50WEO/D0uAp5BvAYo1LunhlKnvuaHw
ngZnzSJink8QyeX7mjN75ShxAyHHq7f3hFqr0RAjxj+rxw7BrvaBlsuKO8s+v2tz
FupYzW1mUgxUtt3Q+vr65A8rSeW2PuNLE3tectevUIG0uQ7Jw6x5nAg1PEWJG/PE
1cLDYC8PogpMk1Wob1II8Ax1d/mwwkVnkhDz152b6/Uo8uQ3fyU=
=S5VR
-----END PGP SIGNATURE-----

--c8UbHMnQwI7BF+TB--
