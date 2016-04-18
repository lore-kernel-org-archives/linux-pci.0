Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36877 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbcDROyd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2016 10:54:33 -0400
Date: Mon, 18 Apr 2016 16:54:29 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
Message-ID: <20160418145429.GD20508@ulmo.ba.sec>
References: <1460991105-22861-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
In-Reply-To: <1460991105-22861-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2016 at 04:51:44PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The XUSB pad controller allows PCIe lanes to be controlled individually,
> providing fine-grained control over their power state. Previous attempts
> at describing the XUSB pad controller in DT had erroneously assumed that
> all PCIe lanes were driven by the same PHY, and hence the PCI host
> controller would reference only a single PHY.
>=20
> Moving to a representation of per-lane PHYs requires that the operating
> system driver for the PCI host controller have access to the set of PHY
> devices that make up the connection of each root port in order to power
> up and down all of the lanes as necessary.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v5:
> - add per-SoC examples to clarify what properties are relevant on each
>   generation
> - clarify the rationale for moving the per-lane PHYs
>=20
> Changes in v4:
> - add additional lanes subnode when dereferencing PHYs from the XUSB pad
>   controller to reflect changes in its binding
>=20
>  .../bindings/pci/nvidia,tegra20-pcie.txt           | 224 +++++++++++++++=
+++++-
>  1 file changed, 219 insertions(+), 5 deletions(-)

Hi Bjorn,

I think I've requested this before, but in case I didn't: once you're
happy with these changes, I'd like to take them through the Tegra tree
to resolve the dependencies with the remainder of a series that involves
the pinctrl and PHY drivers as well as devicetree changes. In order to
do so I'm looking for an Acked-by.

Once applied I can provide a stable branch containing the dependencies
for you to pull into the PCI tree if necessary.

Thierry

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXFPUkAAoJEN0jrNd/PrOhELcQALkBpPAht5Ix5Ux9Wtm5aL7L
Vb2Tq5uj9ZIMjG7+nIFJyYYMOIUHmAy2pGrzlWz4cl2hlT4D+BhRiBpHhUhIBWyE
bbzhOjllgFqItDvDuyvWjmlaoOiUuTS3NVylqCO/8xx4FnGadfraHkiu+C/YMbEJ
83YsGyYyx26af+iHFZOU6LB5j423Qci2QT4FpyM3EAzjIVjJwS5+hqbcNgU/wAXI
/vIZWuvN1gFrj4LrBB5qKy2tdKTDuJpU0GpktV48czg7QtnyPvdEXS/yMC5Neyxv
f8HlDqfaJuVYYbKeXXeAKxfiVNjdZHbUNUnGkdUdnMXARTQsFTkTNkpsjDQggraF
FAkvBbeK1KhX0tGbkhhujIxzJmiymXuh8+crOb1rZZyOg1EAy5hUo+5Y99k/Mmc2
Q41d+Et8AXhvFyh1PoVzxymk1vhu/zZYZf3hYaLyAdx/Vd0DHDhD1oY6gHUvTdFt
hHQt0sU+vQJWt0iCvZgWACWzad3Irv0A7LHRfzRZO4WbvvCu8sFcQzZv4Q4Qcxho
IhpT88v27TlTJKyq92pL7hh8mm6gXMDAGrTnqIzstO8n3lP91RSjdyETdYWWug6J
UanCoIL2HHHVzWeAVL2ZuG1CIqK+yhK9Ca0uI3egyyb4gMan0b+HXbWlkH5xpCZW
eD+JCSAH1mZFGcdchxQN
=9MNZ
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
