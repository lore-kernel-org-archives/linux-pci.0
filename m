Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41747 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760378AbdDSHWY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Apr 2017 03:22:24 -0400
Date: Wed, 19 Apr 2017 09:22:16 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yinghai Lu <yinghai@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: Freeze PME scan before suspending devices
Message-ID: <20170419072216.2chcdfpl6dxfgxgs@ninjato>
References: <03aaf3220cccbabb7db86aa4eb10d1147add5c34.1492536769.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vrppktrdlacnrucw"
In-Reply-To: <03aaf3220cccbabb7db86aa4eb10d1147add5c34.1492536769.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--vrppktrdlacnrucw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 08:44:30PM +0200, Lukas Wunner wrote:
> Laurent Pinchart reported that the Renesas R-Car H2 Lager board
> (r8a7790) crashes during suspend tests.  Geert Uytterhoeven managed to
> reproduce the issue on an M2-W Koelsch board (r8a7791):
>=20
> It occurs when the PME scan runs, once per second.  During PME scan, the
> PCI host bridge (rcar-pci) registers are accessed while its module clock
> has already been disabled, leading to the crash.

Cool! I stumbled over this while testing I2C suspend behaviour the last
days, and I can confirm that the crash is gone with this patch on my
Lager board. Thanks!

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--vrppktrdlacnrucw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3ECQACgkQFA3kzBSg
KbbrtRAApyiV+w4DYRzMCbFEqiSVQb4o2MN85OcmFPluzuBoMVu5VHtuiEYgg2Ix
H9lCDH40zc3tMHnNxqI83LtGYwU9l3V0KzGRbSdm0oISXMj5IdXIdTblexsok6vY
H5ayeNmnkpn72v19xpCorV1SvgoierVkZTRHy3XGKYUwiX/F8WBMZORkQc6gw/RR
A8pNnMbP8AsYEhkVKL8EJYmKHb149kgfwVMOGEkqgrjhu/RrNcxaVV4M3vgtW/CJ
fBlazFlcqIM07tvvk6YaKkeOGPOLvEjTz16qIQSi8BIiGe2kEDGAZ6mjZUNtUlIk
3l+ytPAUi2WLBCcoF37uLJ9zmY4slp6lp2311HN0ES6sKyvO7yDqvA1PGpg7Gb6e
hDIdohOuaBM7e93pTURR50hWK79DVIiFXAD/hRIbpMvodWWITmwivvtHs+MZHjt0
LLyftjD4XeDit8yXQnbA0svZW+OZMofhQnIy9PGwljIizA9/IB5K5E8DQbJ4KHOv
7u/OhrZ0Qn3dDUYPvpd7ZiCFqghePl/qlro2H1o7xkgAhQpG4uaxG9otcnx1xvQv
xLPxHRSF+WzLDi+9RbtSi9YzdA6gQvbXL2Ec5B9kfqCoTIj1YgTSVJFeHniG4kn5
FuhkTsBbkM3eMGuADrTOsJfslyLOaDYmc6rre8JWrMnpn7pnbHk=
=iwyu
-----END PGP SIGNATURE-----

--vrppktrdlacnrucw--
