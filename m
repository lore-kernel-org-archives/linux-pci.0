Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41190 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341AbaLJObW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Dec 2014 09:31:22 -0500
Date: Wed, 10 Dec 2014 15:31:17 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Alexandre Courbot <gnurou@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: tegra: apply relaxed ordering fixup only on
 Tegra
Message-ID: <20141210143116.GA15316@ulmo.nvidia.com>
References: <1415907457-3147-1-git-send-email-l.stach@pengutronix.de>
 <1415907457-3147-2-git-send-email-l.stach@pengutronix.de>
 <CAAVeFu+sYnhMEmDSPvinbP-BQQnqAu6rpEVgaLx25Y3UtGVUwQ@mail.gmail.com>
 <1418120897.2741.1.camel@pengutronix.de>
 <20141210121339.GA23558@ulmo.nvidia.com>
 <1418214220.7616.7.camel@pengutronix.de>
 <20141210141130.GG23558@ulmo.nvidia.com>
 <1418220955.7616.9.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <1418220955.7616.9.camel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 03:15:55PM +0100, Lucas Stach wrote:
> Am Mittwoch, den 10.12.2014, 15:11 +0100 schrieb Thierry Reding:
> > On Wed, Dec 10, 2014 at 01:23:40PM +0100, Lucas Stach wrote:
> > > Am Mittwoch, den 10.12.2014, 13:13 +0100 schrieb Thierry Reding:
> > > > On Tue, Dec 09, 2014 at 11:28:17AM +0100, Lucas Stach wrote:
> > > > > Am Dienstag, den 09.12.2014, 12:23 +0900 schrieb Alexandre Courbo=
t:
> > > > > > Hi Lucas,
> > > > > >=20
> > > > > > Apologies for taking so long to come back to this. The patch lo=
oks ok
> > > > > > to me, just a minor comment about the Tegra PCI detection:
> > > > > >=20
> > > > > > On Fri, Nov 14, 2014 at 4:37 AM, Lucas Stach <l.stach@pengutron=
ix.de> wrote:
> > > > > > > The fixup to enable relaxed ordering on all PCI devices was
> > > > > > > executed unconditionally if the Tegra PCI host driver was
> > > > > > > built into the kernel. This doesn't play nice with a
> > > > > > > multiplatform kernel executed on other platforms which
> > > > > > > may not need this fixup.
> > > > > > >
> > > > > > > Make sure to only apply the fixup if the root port is
> > > > > > > a Tegra.
> > > > > > >
> > > > > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > > > ---
> > > > > > >  drivers/pci/host/pci-tegra.c | 26 +++++++++++++++++++++++++-
> > > > > > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/=
pci-tegra.c
> > > > > > > index 3d43874319be..d5a14f22ebb8 100644
> > > > > > > --- a/drivers/pci/host/pci-tegra.c
> > > > > > > +++ b/drivers/pci/host/pci-tegra.c
> > > > > > > @@ -647,10 +647,34 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_N=
VIDIA, 0x0bf1, tegra_pcie_fixup_class);
> > > > > > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_=
pcie_fixup_class);
> > > > > > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_=
pcie_fixup_class);
> > > > > > >
> > > > > > > +static int tegra_pcie_root_is_tegra(struct pci_dev *dev)
> > > > > > > +{
> > > > > > > +       struct pci_bus *bus =3D dev->bus;
> > > > > > > +       struct pci_dev *root_bridge;
> > > > > > > +
> > > > > > > +       /* walk up the PCIe hierarchy to the first level belo=
w the root bus */
> > > > > > > +       while (bus->parent && bus->parent->self)
> > > > > > > +               bus =3D bus->parent;
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * If there is no bridge on the bus the passed device=
 is the root
> > > > > > > +        * bridge itself.
> > > > > > > +        */
> > > > > > > +       root_bridge =3D bus->self ? bus->self : dev;
> > > > > > > +       if (root_bridge->vendor =3D=3D PCI_VENDOR_ID_NVIDIA &&
> > > > > > > +           (root_bridge->device =3D=3D 0x0bf0 || root_bridge=
->device =3D=3D 0x0bf1 ||
> > > > > > > +            root_bridge->device =3D=3D 0x0e1c || root_bridge=
->device =3D=3D 0x0e1d ||
> > > > > > > +            root_bridge->device =3D=3D 0x0e12 || root_bridge=
->device =3D=3D 0x0e13))
> > > > > > > +               return 1;
> > > > > >=20
> > > > > > I am not very familiar with PCI so sorry if these are stupid
> > > > > > questions, but where do these device IDs come from? Are they ne=
eded at
> > > > > > all, e.g. can't you just test against root_bridge->vendor =3D=3D
> > > > > > PCI_VENDOR_ID_NVIDIA to detect a NVIDIA root? Is the list susce=
ptible
> > > > > > to increase as new chips get released? If that's the case, how =
can we
> > > > > > make sure we won't forget to update it?
> > > > > >=20
> > > > >=20
> > > > > The device IDs are assigned by NVIDIA HW for the different Tegra =
PCI
> > > > > generation/link width combinations. Note that the K1 TRM is wrong=
 as it
> > > > > still lists the T30 device IDs, instead of the ones used on K1.
> > > > >=20
> > > > > While we technically could test only against vendor=3D=3Dnvidia I=
 don't
> > > > > think it is entirely safe. As this is a PCI fixup it will get exe=
cuted
> > > > > on every device running a kernel including this PCI host bridge d=
river.=20
> > > > >=20
> > > > > So only testing for the vendor assumes that every ARM device with=
 a PCI
> > > > > host bridge built by NVIDIA will be a Tegra. Do you think this is=
 a
> > > > > reasonable assertion? I'm on the fence here.
> > > > > =20
> > > > > > If you need to test against the device ID, it might be more leg=
ible
> > > > > > (and easier to update) if you use a switch case, e.g:
> > > > > >=20
> > > > > >     if (root_bridge->vendor !=3D PCI_VENDOR_ID_NVIDIA)
> > > > > >         return 0;
> > > > > >     switch (root_bridge->device) {
> > > > > >     case 0x0bf0:
> > > > > >     case 0x0bf1:
> > > > > >     case 0x0e1c:
> > > > > >     case 0x0e1d:
> > > > > >     case 0x0e12:
> > > > > >     case 0x0e12:
> > > > > >         return 1;
> > > > > >     default:
> > > > > >         return 0;
> > > > > >     }
> > > > > >=20
> > > > > Right, this looks nicer and easier to extend. I'll have to think =
about
> > > > > if we need the device IDs at all and respin accordingly.
> > > >=20
> > > > I think using the device ID is fine. If nothing else it'll at least
> > > > document the various device IDs. Perhaps you could extend this patch
> > > > with comments as to which device ID maps to which SoC. Or better yet
> > > > add them to include/linux/pci_ids.h with names matching the SoC.
> > > >=20
> > > The IDs used by the Tegra root ports are not shared between multiple
> > > drivers, so no way for them to go into that file.
> >=20
> > Since when has that been a requirement? Randomly grepping for a couple
> > of the IDs defined in that file they are either not used at all or in a
> > single driver.
> >=20
> It's stated right in the header of that file and I've seen quite a few
> occasions where this rule has been enforced. If there are entries in
> there that are only used by a single driver that's either legacy entries
> or bad review.

Oh well. We could still have a list with symbolic names in the Tegra
driver to clarify which device ID belongs to which SoC. But both a
comment or a symbolic name are fine with me.

Thierry

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUiFk0AAoJEN0jrNd/PrOhEewP/1+wgoIDiuYcIwTQ0ir/PNKZ
si8Jsh3hU2LLrb+iv92enhC/CAXeDrrS0G0hgS1oYFmMnWWECvqgZfrVsHGEXcyu
123BJ99Un2DPuuGuunYB/xHl7ySFXFOi7dTlD77cZgU3PiVx5724JaabfjhVc7Xa
WYOMJ3xrw0RC/p3ZelZ84yab+fLpR2LIuDdib/hvT6H4jcGk70Hgnw3064+ZlpKu
Qn5sFyiUZcXRlK3dbrNackhKwb5VzN4woDBv0vrIlWdzSrbWM1n1mODCxfuMVCKm
NqV4HQuOV1ucOGtJI/t1157Ftob18mPQdwaaGqujQPNkqbkbjrsOvNK39RPnrCDh
3JXU7s2oeDsOBd1h/cEkCEjqqNR54ITW17Nj6XqwelsewQpQCaARjNAoqgob2iZB
5uveZKAeAYyJc8T1gXNjjkFGaazpBdRFoDKuCkVbHNnszyypYlRuIIIVwMPccveB
RpHVbqpqSrAHT+9HmmUhiLc+lTC9SYWHHt7XEyf6/hpCRb9T+zyewgRfZ/rE5nzC
+hzFX/6b4k5Y/0plxTU7Yj4p3aGnGwpB41a9U/3r+75/6frG7o5YOdTlxo8pt/6R
2qeOz5clhPm6hudh3UgIiN3M0i5dccARDtJsgd8hiDS2o3upuuyGjQl7SwQmYU1F
JltpyIAfl6ziu7dfYhwS
=KfWu
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
