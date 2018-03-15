Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36449 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeCOQta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Mar 2018 12:49:30 -0400
Date: Thu, 15 Mar 2018 17:49:27 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: mark PM functions as __maybe_unused
Message-ID: <20180315164927.GA31871@ulmo>
References: <20180315161901.772729-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
In-Reply-To: <20180315161901.772729-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 05:18:39PM +0100, Arnd Bergmann wrote:
> The new PM support causes a warning when CONFIG_PM is disabled:
>=20
> drivers/pci/host/pci-tegra.c:2482:12: error: 'tegra_pcie_pm_resume' defin=
ed but not used [-Werror=3Dunused-function]
>  static int tegra_pcie_pm_resume(struct device *dev)
> drivers/pci/host/pci-tegra.c:2463:12: error: 'tegra_pcie_pm_suspend' defi=
ned but not used [-Werror=3Dunused-function]
>  static int tegra_pcie_pm_suspend(struct device *dev)
>=20
> Marking the functions as __maybe_unused lets the compiler drop them
> silently instead.
>=20
> Fixes: b90b44154023 ("PCI: tegra: Add power management support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/host/pci-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqqpBcACgkQ3SOs138+
s6GZZxAAgfh++fLMiINh7+QqGgjQs3u1OPUCZvgOAB2ovdTlu4I4mB13sH2XqtyS
dLeiEyGpGc23vtJLfOgD7JrwEb5PZyQ1Boxz5L+58yVIgks/gOwvZ+ghxefc5J8M
m+rl8VjPb54DYWgAUrxTXC4cPS60ATGuEJAeX3YXpQfVc89lWy7alt8PjUGOdmH1
qd8p/tn3KF+SpnvTgO7DlcEpwFT0FgiMMORxtCrmJUg6IoAGI3pmndSYvkggzgud
wodK+XKk1Tyg3BBbg+qKzMmi3W1cs80F3AJdPMngz4o3OTcUSOY8WI2tUZDiQkqy
B1H23XNadB7pnBr5ijkmF1scM+dPiP6PwxYlhXmxhcU+oLZzh4UqbWymidAS/GhL
XA6Tc4uHq+K012B6/18AQdYmj9N6mAz5ZiH2Z6QE/1pE9SyjMDVwvfoqtBPpcULU
X5E/G60zNcflKTPskSkjHQA689b1SqqWaWW9iF8Wlx6PyTmsWEPXZsksOsTMYKO5
6PbGuHxj5DwveBgr9txz1lQAIC/SfrD3Py6hOu5k1IZxK4UPo+JSiJeytY6exkyR
Zaevz/ZyZHKu9zFKQkf/wB+mU1qEWCcVRwHYIJh9Ar5zr69qeO/W+WQk7lzepD+U
RkztyJRpWM4Bxx0b+zVKlc6KiT/6eOR6sR7IxvaHD3StfRQUT88=
=7CmL
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
