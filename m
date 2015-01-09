Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:47656 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbbAIL65 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jan 2015 06:58:57 -0500
Date: Fri, 9 Jan 2015 12:58:54 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: tegra: apply relaxed ordering fixup only on
 Tegra
Message-ID: <20150109115853.GI16465@ulmo>
References: <1418929903-8506-1-git-send-email-l.stach@pengutronix.de>
 <1418929903-8506-2-git-send-email-l.stach@pengutronix.de>
 <20150109113213.GE16465@ulmo>
 <1420803918.16381.9.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wjoFZxbW4tu+iR6v"
In-Reply-To: <1420803918.16381.9.camel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 12:45:18PM +0100, Lucas Stach wrote:
> Am Freitag, den 09.01.2015, 12:32 +0100 schrieb Thierry Reding:
> > On Thu, Dec 18, 2014 at 08:11:43PM +0100, Lucas Stach wrote:
> > > The fixup to enable relaxed ordering on all PCI devices was
> > > executed unconditionally if the Tegra PCI host driver was
> > > built into the kernel. This doesn't play nice with a
> > > multiplatform kernel executed on other platforms which
> > > may not need this fixup.
> > >=20
> > > Make sure to only apply the fixup if the root port is
> > > a Tegra.
> > >=20
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > > v2:
> > > - split out PCI hierarchy walk
> > > - separate code from data by moving PCI IDs into own structure
> > > ---
> > >  drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++++-
> > >  1 file changed, 33 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegr=
a.c
> > > index 333a57afacc4..b77f417e1a3c 100644
> > > --- a/drivers/pci/host/pci-tegra.c
> > > +++ b/drivers/pci/host/pci-tegra.c
> > > @@ -635,10 +635,42 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0=
x0bf1, tegra_pcie_fixup_class);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fix=
up_class);
> > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fix=
up_class);
> > > =20
> > > +static const struct pci_device_id tegra_rootport_ids[] =3D {
> > > +	{
> > > +		/* Tegra20 4 lane root port */
> > > +		.vendor =3D PCI_VENDOR_ID_NVIDIA, .device =3D 0x0bf0,
> > > +		.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID
> > > +	}, {
> > > +		/* Tegra20 2 lane root port */
> > > +		.vendor =3D PCI_VENDOR_ID_NVIDIA, .device =3D 0x0bf1,
> > > +		.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID
> >=20
> > The number of lanes is configurable, so I'm not sure exactly what this
> > comment is supposed to indicate. Are you saying that port 0 has 0x0bf0
> > and port 1 has 0x0bf1 as device IDs.
> >=20
>=20
> No, the device ID of the root port is dependent on the number of lanes
> configured for the specific port. So if you have a 4x1 configuration you
> will get to see a single device with ID 0x0bf0, in a 2x2 configuration
> you will see 2 devices with ID 0x0bf1.

Okay, that's interesting to know. My ack remains valid in that case:

Acked-by: Thierry Reding <treding@nvidia.com>

--wjoFZxbW4tu+iR6v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUr8J9AAoJEN0jrNd/PrOhQPoP/jow147LxL7KeIg7QanmTSZk
DbmSvCZxpGXh5BWUVnIS1i0c7EE61dMJd92WtWo0kfDEsTF9v0nhBOl7b0kXORsf
9YrSR/Kp4pBApxeYZZo9wQzZLtY5KlxCJ+v2M8JY4McnQQcBk8cVafCaI5juviQn
e5rgIHsz7Y2xe3njp9Uef68WR/2okabQLYNe6Mtq6hORo/qkq/7YrVRaMnw9asfX
+2fU+9W5gOSU0iw34e4T313Ro7TL2/3/szozWccb8aTgiO8SBTRUfSPa/eQoUCb8
t2ARN08mGyHF1NqTyT/QEol4TPeM5Sbv/FmJct2SEVMlMAjnDu5OCJtj0Ao2YRn2
A0Fcv51pWz9eQahEZJMPKTphC4HeDFltVJp/azpo0mo0r+x8qzsKFiqgpmk2xgls
0E5/NskaC4bNkUuda+ft9uy276bD3CptfkcF/qO5H17+tCJqHnlHQ1ZpJH19v+w7
SWAhIeUpYU3L98/aq63XU/YQNhnA4C2e0uG7HfMPdzp0O9XK2IjHbDzV2OtaeHpG
TBsMPyNgOR7y+gEZmLLqeEm1N02H2AU05vxDwLJaWbKDFRRiadRgC5jmfTw0BJs+
JoMnhGxenlD6w4U8KQL6B6GvNBe3ZStmDtl1g9YCCoWGrb6NMRHTr52SAsv/IIT9
bF5BuAJs9SjOdkfOvWnq
=MqNn
-----END PGP SIGNATURE-----

--wjoFZxbW4tu+iR6v--
