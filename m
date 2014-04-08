Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19617 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932483AbaDHTxf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 15:53:35 -0400
Date: Tue, 8 Apr 2014 21:52:41 +0200
From: Thierry Reding <treding@nvidia.com>
To: Stephen Warren <swarren@wwwdotorg.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Ian Campbell" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC 1/5] PCI: tegra: Overhaul regulator usage
Message-ID: <20140408195240.GA21978@ulmo.nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
 <1396622969-17837-2-git-send-email-treding@nvidia.com>
 <53444AE3.6030603@wwwdotorg.org>
MIME-Version: 1.0
In-Reply-To: <53444AE3.6030603@wwwdotorg.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2014 at 09:15:47PM +0200, Stephen Warren wrote:
> On 04/04/2014 08:49 AM, Thierry Reding wrote:
> > The current usage of regulators for the Tegra PCIe block is wrong. It
> > doesn't accurately reflect the actual supply inputs of the IP block and
> > therefore isn't as flexible as it should be. Rectify this by describing
> > all possible supply inputs in the device tree binding documentation and
> > deprecate the old supply properties.
>=20
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.=
txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>=20
> > +Power supplies for Tegra30:
> ...
> > +- Optional:
> > +  - If port 0 is enabled:
> > +    - avdd-pexa-supply: Power supply for analog PCIe logic. Must suppl=
y 1.05 V.
> > +    - vdd-pexa-supply: Power supply for digital PCIe I/O. Must supply =
1.05 V.
> > +  - If at least one of ports 1 and 2 is enabled:
> > +    - avdd-pexb-supply: Power supply for analog PCIe logic. Must suppl=
y 1.05 V.
> > +    - vdd-pexb-supply: Power supply for digital PCIe I/O. Must supply =
1.05 V.
>=20
> Did you get confirmation from HW/... that the mapping from pexa/b to
> PCIe ports you document above is correct? IIRC the two supplies might be
> related to lanes rather than ports?

Not yet, which is the primary reason this is still RFC. Just wanted to
get early feedback on the general direction of the series.

Thierry

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRFOIAAoJEN0jrNd/PrOhZU0P/iltRyWXE6iWnZZVX1EYUVAb
LNiPmwwHPktFIa74iifEeb9wqzNT52Pb3StDa8gM93AtuBtpDtgUC/Rgs3drxj/B
S+ZSNuk/x0jJeoao8GhdGI1Pg1eAVUoI+rTXdMZ3JMT32cJp2KlQdFP5vUYy7DYw
DWygqk5WaiXt++hRpAIrpc2RwlHzcdPJt2q0zv6CUzCpguQQckMALr0MpbWYMZBG
rbvIQoI/yyaJ1/ikjwLWPFsAOzIAy2S9U87I9t0dmS/e3kdls8JI+T5zqe6OGBPn
CWsynOu4wWtKUudt6nPwQhozuHHuOz9h+4EFCwKBz/rCC5cyRx8Fx6e1CVpVzy8J
nWPEYQ2lDaCGRZpTLp/KcRRJFmAa6rwQHUySW6u/FKWmjqb9/UI1xC/c7et7s17h
w8c3AVSDi6gdBk5i2YFWSR6r3jNSJRo8g9NuAIntmuGEdorL20T7LK/W37s9IMCE
Zm7/QB58+PGbVoFR0BleFccNmgYR/JmCho+F7LKfTUdh4up+GRwp3PR9l3UrQ6bn
+2dWm2rk4P4iemQqDLWMuC+Jaevbqbuz/GehABwk5mpllTIiEaHYOrJQCtgizSLj
ZTXZCWKeDmGc63UzKqweAOpRQMc5hJh6x397+ZpgCdyv7E8OIlF4P8ng24TrIEyB
7MuIwe+tUg+xnpqWVhVd
=wgYI
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
