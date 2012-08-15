Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59656 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab2HOUHC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 16:07:02 -0400
Date: Wed, 15 Aug 2012 22:06:55 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Rob Herring <robherring2@gmail.com>
Cc: linux-tegra@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Colin Cross <ccross@android.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 08/10] of/address: Handle #address-cells > 2 specially
Message-ID: <20120815200655.GC12870@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-9-git-send-email-thierry.reding@avionic-design.de>
 <50183DA3.8020308@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
In-Reply-To: <50183DA3.8020308@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2012 at 03:18:43PM -0500, Rob Herring wrote:
> On 07/26/2012 02:55 PM, Thierry Reding wrote:
> > When a bus specifies #address-cells > 2, of_bus_default_map() now
> > assumes that the mapping isn't for a physical address but rather an
> > identifier that needs to match exactly.
> >=20
> > This is required by bindings that use multiple cells to translate a
> > resource to the parent bus (device index, type, ...).
> >=20
> > See here for the discussion:
> >=20
> > 	https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-June/016577=
=2Ehtml
> >=20
> > Originally-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Hi Rob,

Were you going to take this through your DT tree? I'm trying to reduce
the number of patches in this series to make it more manageable and
split it into smaller chunks. There are also a couple of issues that
need to be resolved so I don't know if I can get the whole series into
shape for 3.7.

However if you don't think this patch is useful to be applied by itself
I can also carry it until the complete series is ready.

Thierry

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLAFfAAoJEN0jrNd/PrOh5nwP/AxK/PzslKGccOcl3laARCTx
BNGd42RJi51e5jv7evJFp8zLzrv2R2WZ6jEr1f0+uEgWUdELooh5UxXZ8ZfmXxqt
hVfYurGRS/gCgwSZNFitqAbp0HgebvAJGu/SptBkKFXAv5O2HegcPuMVq94BT6qV
rqU3CnU6faNxC52OarQ5SvsIjdCKUB4oK5NhevJGt8/w6EfsGpYiJOq+POBQDvMH
ivnPIbtniIcWHS41knJagd4smnD1eeGl34MWmwA70UnDzQDBIqK06HlWpJsyRO29
e5vaBErcVpnulBECSjrAftPq26Wzwrnc05OjIpnw4b93gdcnYn1yMKQpIy+wSDIu
9DKv7V4b30Bc2rixNv6Sw1hI5Mlz6++2P6+PrVJge3//eRxvMGpBYSXTxPQvcKVI
lEsERjbh4xll1XKi/Q85n74N608A3VFtB6q4SGVJB/yFEa7ebWpUeH4eh43kShuV
FmbhRfaMN1Q9bnLN0gfTtqMBBytg0rk1Nh9/kj09BeyXjohTj33lM6ocrbT4VBOW
BkpGuxWZadyRQrIj+fUA0/cWb+RITUE0ec74CeFCZP/OnreDFUY+1OQsObmJYNis
FSH1Q7Xl40m1DusKOpX5SnR4ofxQrV+MbItfRGD2lSXdA6rdRGsVrbkrtZKcvoak
7xT7xDOCUSwnNSipXO+p
=NhIa
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
