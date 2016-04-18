Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34529 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbcDROsN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 10:48:13 -0400
Date: Mon, 18 Apr 2016 16:48:09 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
Message-ID: <20160418144809.GC20508@ulmo.ba.sec>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
 <56E98F2E.5010307@wwwdotorg.org>
 <20160413162203.GB30129@ulmo.ba.sec>
 <570E7C38.3070005@wwwdotorg.org>
 <20160414152905.GB3366@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
In-Reply-To: <20160414152905.GB3366@ulmo.ba.sec>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 14, 2016 at 05:29:05PM +0200, Thierry Reding wrote:
> On Wed, Apr 13, 2016 at 11:04:56AM -0600, Stephen Warren wrote:
> > On 04/13/2016 10:22 AM, Thierry Reding wrote:
> > > On Wed, Mar 16, 2016 at 10:51:58AM -0600, Stephen Warren wrote:
> > > > On 03/08/2016 08:48 AM, Thierry Reding wrote:
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >=20
> > > > > Changes to the pad controller device tree binding have required t=
hat
> > > > > each lane be associated with a separate PHY.
> > > >=20
> > > > I still don't think this has anything to do with DT bindings. Rathe=
r, the
> > > > definition of a PHY (in HW and the Linux PHY subsystem) is a single=
 lane.
> > > > That fact then requires drivers to support a PHY per lane rather th=
an a
> > > > single multi-lane PHY, and equally means the DT bindings must be wr=
itten
> > > > according to the correct definition of a PHY.
> > > >=20
> > > > Still, I suppose the commit description is fine as is.
> > >=20
> > > I've reworded the commit message to give a more accurate rationale for
> > > the change. I'll be posting a v5 soon.
> > >=20
> > > > > Update the PCI host bridge
> > > > > device tree binding to allow each root port to define the list of=
 PHYs
> > > > > required to drive the lanes associated with it.
> > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20=
-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > > >=20
> > > > > +Required properties for Tegra124 and later:
> > > > > +- phys: Must contain an phandle to a PHY for each entry in phy-n=
ames.
> > > > > +- phy-names: Must include an entry for each active lane. Note th=
at the number
> > > > > +  of entries does not have to (though usually will) be equal to =
the specified
> > > > > +  number of lanes in the nvidia,num-lanes property. Entries are =
of the form
> > > > > +  "pcie-N": where N ranges from 0 to the value specified in nvid=
ia,num-lanes.
> > > >=20
> > > > When would the number of PHYs not equal the number of lanes? I thou=
ght the
> > > > whole point of this patch was to switch to per-lane PHYs? Perhaps I=
'm just
> > > > misremembering some exception, so there may be no need to change th=
is.
> > >=20
> > > This is useful to support the case where we want to connect a x1 or x2
> > > device to a root port that is configured to drive more lanes. It's a
> > > rather unusual configuration, but it would be possible for example to
> > > have an onboard x1 ethernet card, but the board layout is such that it
> > > runs in x1/x2 mode, with the ethernet card connected to the x2 port.
> >=20
> > Does the controller HW actually work correctly in such a mode?
>=20
> I think it does, and up until a few minutes ago I was even sure that I
> had tested it once. But looking at the various boards that I have I
> don't think I actually have test equipment that's wired the proper way
> to test this.
>=20
> > Obviously a fully initialized x4 controller has to correctly handle bei=
ng
> > attached solely to a x1 device. However, that's a different case to sim=
ply
> > not initializing 3 of the 4 PHYs. It's plausible the controller handles=
 this
> > just fine, or that it hangs up or otherwise misbehaves if some of the P=
HYs
> > aren't enabled and hence it can't even detect whether something is atta=
ched
> > to them or not. Either way, adding your explanation into the binding wo=
uld
> > be useful to highlight the reason for the special case.
>=20
> Perhaps for now it would be better to make the binding stricter. The
> wording could be relaxed if we ever determine that it still works
> correctly with a number of PHYs smaller than the number of lanes.

Going over the patches again I realized that Jetson TK1 is actually one
such case. The PCI host bridge controller is configured to run root port
0 using two lanes, and root port 1 using one lane. However, only one
lane is connected to each port. Root port 0 goes to the miniPCIe slot,
which takes a single lane (PEX4), while root port 1 goes to the onboard
NIC, which takes a single lane (PEX2) as well. x1 + x1 is an unsupported
configuration for the root complex, though, hence why it is configured
to be x2 + x1.

I've tested that both the onboard NIC as well as a miniPCIe card work
correctly with the setup.

So I think the wording in the binding, as well as the example, are
correct. So I left the original wording in place, but instead added a
couple more examples so that we have one per SoC generation, which will
hopefully clarify what properties should and shouldn't be used.

Thierry

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXFPOnAAoJEN0jrNd/PrOhe90P/RQkdtw7v450sx3y/I4LIkTC
GIr3Wqr/TrBlmMojqt7buyqgLcBbcCQrDCdC4NKv2F8cC0mw0PEcUr7VbzjApMcd
PN/ZwfCsbTwBkqaThjL4H4Nshx34Q8ePUFAf8iq/ZxrU/NHQFNFxeKlO+eHChdlS
1IR/WTk2QEqixWIoe85rZrFKLxVCCDV5FVlFADzRQkG1H7lvPI3Xb8G0RS7A2899
XNQfWzMvDF9Bk7srMcd2guVp4CtlnQrcquvE3evUCiN5dxINd5q4gNJ7yFlLbrip
fTFG7iQOQ6oWfLnt0FyDg5T3zZJ7hskm24x0GjYgdekX8CMRcwRbrGEJCIeABtBk
b1oZ9dVlCYegurLUPBMjXaSkqZSOyIBRyPQXdEvQtuIHHbg9CErgmSIYjkJ1y1N8
L1GXMneMpsFIrWkVH0i+6FWfBqgCQt9skRpVR5Azili73EhamHLetjdXiQYq/5GV
Dj+vqKF6PDwmjdqBYZn0ow9PeEJAm7pfkNhQWGl8jBAP7CYdrvkLUcACatB6n1o7
SyiufscgVr41nmYlVZ2yeWQR9xfh62CI5hBHeLxKnbW8CLfIkR5YFLrGfRhHkmYt
mlej0bz7ogNWYiX1ZG7Ijhzjkp/jlOBNtoz5tsWtts7ydS/LhlayznEahSisMkx0
sMr0p4XzJe8ByS074qiT
=NC8e
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
