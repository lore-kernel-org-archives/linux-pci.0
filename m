Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36767 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649AbcDNP3K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2016 11:29:10 -0400
Date: Thu, 14 Apr 2016 17:29:05 +0200
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
Message-ID: <20160414152905.GB3366@ulmo.ba.sec>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
 <56E98F2E.5010307@wwwdotorg.org>
 <20160413162203.GB30129@ulmo.ba.sec>
 <570E7C38.3070005@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
In-Reply-To: <570E7C38.3070005@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2016 at 11:04:56AM -0600, Stephen Warren wrote:
> On 04/13/2016 10:22 AM, Thierry Reding wrote:
> > On Wed, Mar 16, 2016 at 10:51:58AM -0600, Stephen Warren wrote:
> > > On 03/08/2016 08:48 AM, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Changes to the pad controller device tree binding have required that
> > > > each lane be associated with a separate PHY.
> > >=20
> > > I still don't think this has anything to do with DT bindings. Rather,=
 the
> > > definition of a PHY (in HW and the Linux PHY subsystem) is a single l=
ane.
> > > That fact then requires drivers to support a PHY per lane rather than=
 a
> > > single multi-lane PHY, and equally means the DT bindings must be writ=
ten
> > > according to the correct definition of a PHY.
> > >=20
> > > Still, I suppose the commit description is fine as is.
> >=20
> > I've reworded the commit message to give a more accurate rationale for
> > the change. I'll be posting a v5 soon.
> >=20
> > > > Update the PCI host bridge
> > > > device tree binding to allow each root port to define the list of P=
HYs
> > > > required to drive the lanes associated with it.
> > >=20
> > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-p=
cie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> > >=20
> > > > +Required properties for Tegra124 and later:
> > > > +- phys: Must contain an phandle to a PHY for each entry in phy-nam=
es.
> > > > +- phy-names: Must include an entry for each active lane. Note that=
 the number
> > > > +  of entries does not have to (though usually will) be equal to th=
e specified
> > > > +  number of lanes in the nvidia,num-lanes property. Entries are of=
 the form
> > > > +  "pcie-N": where N ranges from 0 to the value specified in nvidia=
,num-lanes.
> > >=20
> > > When would the number of PHYs not equal the number of lanes? I though=
t the
> > > whole point of this patch was to switch to per-lane PHYs? Perhaps I'm=
 just
> > > misremembering some exception, so there may be no need to change this.
> >=20
> > This is useful to support the case where we want to connect a x1 or x2
> > device to a root port that is configured to drive more lanes. It's a
> > rather unusual configuration, but it would be possible for example to
> > have an onboard x1 ethernet card, but the board layout is such that it
> > runs in x1/x2 mode, with the ethernet card connected to the x2 port.
>=20
> Does the controller HW actually work correctly in such a mode?

I think it does, and up until a few minutes ago I was even sure that I
had tested it once. But looking at the various boards that I have I
don't think I actually have test equipment that's wired the proper way
to test this.

> Obviously a fully initialized x4 controller has to correctly handle being
> attached solely to a x1 device. However, that's a different case to simply
> not initializing 3 of the 4 PHYs. It's plausible the controller handles t=
his
> just fine, or that it hangs up or otherwise misbehaves if some of the PHYs
> aren't enabled and hence it can't even detect whether something is attach=
ed
> to them or not. Either way, adding your explanation into the binding would
> be useful to highlight the reason for the special case.

Perhaps for now it would be better to make the binding stricter. The
wording could be relaxed if we ever determine that it still works
correctly with a number of PHYs smaller than the number of lanes.

Thierry

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXD7dAAAoJEN0jrNd/PrOhUt0QAKGglDYSP4eAtVBraPIjawy1
8/5SaSs925dpZvYDI5dpBR90ScHDi3g8L7CFU2S5LYqxnIailE368CT0PJXzwl63
mfbRX0msqO4obxKw3JVoAtfjYw6vRQn9FOH1IcBCY+IMVMjqcH65qkOpjvlgz6nX
zBqShtJvyUgRb7y31dZ6a4adRQ+y9mSd+aDbUDVc+OFrY5Cvz4hy2AtyTFwZMXwp
Lon2+oFBSohz1+UZvd5tndAZ8A5c15cU+2/eTEsWEcy0ASj9Sy9nsj58/hHpDz1t
cM7yHtK9rOdldlQlnb7Zyea3JQZmvMX2Yc6OdYY4vEvuH6SoA1AzLtQcRKRWOBwA
Vqo+EhpB9BpZVACweauDx7f+/GLifHyFQdoAl4DBL2fMA0zvgmwqvoZQtBfWqRZ8
m7WtUI3nbXBt7qokao7vBVdcPeOErqKXHD1YBtKYPB19mdYuO2NvIKJl5QyQmSU6
8X4X1grnaFPcNBuVJQ7igcsi5QUt7G/4wCw/qeGQrZtYotOV3fTQr3WHwFnDRswP
yOwXNigMJwyvl/k4yaL3hhcJ6BmSOBZwlPTgmcK7VVmzkp0fgIlovTZCHJmltkWE
hKfRrUYNWSvW3R6rj+89/3/rLHLKF2qcCqt7aN1dAqiQeNlXZaHKbKkDAQzole6N
umcOmzQHGfJhrhqRoY38
=ETlq
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
