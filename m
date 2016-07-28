Return-Path: <thierry.reding@gmail.com>
Return-Path: <thierry.reding@gmail.com>
Date: Thu, 28 Jul 2016 16:18:04 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [GIT PULL] PCI: tegra: Changes for v4.8-rc1
Message-ID: <20160728141804.GD28342@ulmo.ba.sec>
References: <20160701150056.26537-3-thierry.reding@gmail.com>
 <20160726200641.GB15037@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
In-Reply-To: <20160726200641.GB15037@localhost>
List-ID: <linux-pci.vger.kernel.org>


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2016 at 03:06:41PM -0500, Bjorn Helgaas wrote:
> On Fri, Jul 01, 2016 at 05:00:56PM +0200, Thierry Reding wrote:
> > Hi Bjorn,
> >=20
> > The following changes since commit 1a695a905c18548062509178b98bc91e6751=
0864:
> >=20
> >   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/te=
gra-for-4.8-pci
> >=20
> > for you to fetch changes up to 0f32700faed919946e21e9d1dc4d74ae8f1b1226:
> >=20
> >   PCI: tegra: Correctly program PADS_REFCLK_CFG* registers (2016-06-30 =
15:30:16 +0200)
> >=20
> > There's a minor conflict between this and your pci/host-request-windows
> > branch, let me know if you'd like me to rebase on top of that.
> >=20
> > Thierry
> >=20
> > ----------------------------------------------------------------
> > PCI: tegra: Changes for v4.8-rc1
> >=20
> > A couple of cleanups and preparation work for 64-bit ARM support, as
> > well as fixes for writing the PADS_REFCLK_CFG* registers.
> >=20
> > ----------------------------------------------------------------
> > Stephen Warren (2):
> >       PCI: tegra: Actually program PADS_REFCLK_CFG* on recent SoCs
>=20
> I don't see this patch on the list.  I'll attach it below for
> completeness.
>=20
> I don't think the original changelog is quite right; I don't see
> tegra_xusb_phy_enable() being involved at all.  I replaced it with the
> following:
>=20
>     PCI: tegra: Program PADS_REFCLK_CFG* always, not just on legacy SoCs
>    =20
>     tegra_pcie_phy_power_on() calls tegra_pcie_phy_enable() only for lega=
cy
>     SoCs.  However, part of tegra_pcie_phy_enable() needs to happen in all
>     cases.  Move that code up one level into tegra_pcie_phy_power_on().
>=20
>=20
> Here's the original commit from your git tree:
>=20
> commit 0ad9be61b5af
> Author: Stephen Warren <swarren@nvidia.com>
> Date:   Fri Jun 24 08:37:03 2016 -0600
>=20
>     PCI: tegra: Actually program PADS_REFCLK_CFG* on recent SoCs
>    =20
>     On recent SoCs, tegra_pcie_phy_enable() isn't called; but instead
>     tegra_pcie_enable_controller() calls tegra_xusb_phy_enable(). However,
>     part of tegra_pcie_phy_enable() needs to happen in all cases. Move th=
at
>     code up one level into tegra_pcie_phy_power_on().
>    =20
>     Signed-off-by: Stephen Warren <swarren@nvidia.com>
>     Reviewed-by: Simon Glass <sjg@chromium.org>
>     Signed-off-by: Thierry Reding <treding@nvidia.com>

Yeah, that's fine. Thanks. FWIW, the reason why you don't see this on
the list is probably because it is the same patch that was merged into
U-Boot a few days earlier, which is also the reason why the commit
message isn't quite right. I thought I had sanitized it, but evidently
had missed the function name change.

Thanks for picking this up anyway,
Thierry

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXmhQcAAoJEN0jrNd/PrOh1JsQAIUdGEg9jMmk3N+mq4tbPxA5
C2zJjpz8j8rcpakqY4yDKU7opwcin/gjS2Q8XnE1oBmr6o9mCCmXfFrYYgzRG1r6
tSLDU4YVYiCYXdIfAfxlu3yoc3WVk847YNzik+xkuPeTNHEKfFLT5Wc8GlnS69si
6qpGyJU0+SC2pHjnOk201Cfza8zfOJ63rs3ntASq+AhbUv5xuZSBnW89MBtMsMg9
u/78wOmOUeJU3aL+OzMfhnWbH7iv1ij2UULu9sO6oGJEGWNBFi/UzzqwdQy/CQv2
v0LcIi+pWFtThwjLF/7xmfYPu/3CO+sLSkxcoCD6R9DTRBFcTF4NCikXNgFCBPoS
63mk6uF5wUdx2YOWMraWTHt33wzeqT0DLPxw51XGfvOIvPYlRpA2bIuRZpha/PNF
Mt34FQBJZPGs8gVeQ6Hq40ID7Rv3G/v57WY6NLYdBB5J7ZZ2vceAxGrKKeXKdFdl
QVLQXQU7UH2qP1c0raGTBxUJJ66fKqrjGsdttWSyDsREiw+YPLkmBOlnHzVMp+HL
QdKrvn7gBEHEhe3NYyG1nQQsjS5GgbFQ6Ha2opQFDUcZgH02TVCNq8VlVPrRnOzb
GoJnx48ed28mMEOCxo53pDVXrIiN3tyQ4VTuNkDt0+KA0DNgmvZtGRF9A8waQKSD
mknRqH1KPeTMTrVX0nHi
=X1Mo
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
