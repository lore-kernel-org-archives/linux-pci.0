Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 31 Jan 2015 15:28:27 -0400
From: Eduardo Valentin <edubezval@gmail.com>
To: Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>,
	linux-pci@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-i2c@vger.kernel.org, Paul Walmsley <pwalmsley@nvidia.com>,
	linux-pm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>,
	Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Dylan Reid <dgreid@chromium.org>, linux-pwm@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Jingchang Lu <jingchang.lu@freescale.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sean Paul <seanpaul@chromium.org>, linux-tegra@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	John Crispin <blogic@openwrt.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Tuomas Tynkkynen <ttynkkynen@nvidia.com>,
	Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 2/3] Documentation: DT bindings: add more Tegra chip
 compatible strings
Message-ID: <20150131192826.GD17425@developer.hsd1.ca.comcast.net>
References: <20150130221104.4761.50643.stgit@dusk.lan>
 <20150130221104.4761.4534.stgit@dusk.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
In-Reply-To: <20150130221104.4761.4534.stgit@dusk.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Paul!

On Fri, Jan 30, 2015 at 03:11:04PM -0700, Paul Walmsley wrote:
> Align compatible strings for several IP blocks present on Tegra chips
> with the latest doctrine from the DT maintainers:
>=20
> http://marc.info/?l=3Ddevicetree&m=3D142255654213019&w=3D2
>=20
> The primary objective here is to avoid checkpatch warnings, per:
>=20
> http://marc.info/?l=3Dlinux-tegra&m=3D142201349727836&w=3D2
>=20
> DT binding text files have been updated for the following IP blocks:
>=20
> - PCIe
> - SOR
> - SoC timers
> - AHB "gizmo"
> - APB_MISC
> - pinmux control
> - UART
> - PWM
> - I2C
> - SPI
> - RTC
> - PMC
> - eFuse
> - AHCI
> - HDA
> - XUSB_PADCTRL
> - SDHCI
> - SOC_THERM
> - AHUB
> - I2S
> - EHCI
> - USB PHY
>=20
> N.B. The nvidia,tegra20-timer compatible string is removed from the
> nvidia,tegra30-timer.txt documentation file because it's already
> mentioned in the nvidia,tegra20-timer.txt documentation file.
>=20
> This second version takes into account the following requests from
> Rob Herring <robherring2@gmail.com>:
>=20
> - Per-IP block patches have been combined into a single patch
>=20
> - Explicit documentation about which compatible strings are actually
>   matched by the driver has been removed.  In its place is implicit
>   documentation that loosely follows Rob's prescribed format:
>=20
>   "Must contain '"nvidia,<chip>-pcie", "nvidia,tegra20-pcie"' where
>    <chip> is tegra30, tegra132, ..." [...]  "You should attempt to
>    document known values of <chip> if you use it"
>=20
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Dylan Reid <dgreid@chromium.org>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Jingchang Lu <jingchang.lu@freescale.com>
> Cc: John Crispin <blogic@openwrt.org>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: "Terje Bergstr=F6m" <tbergstrom@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-ahb.txt      |    5 ++++-
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |    6 +++++-
>  .../devicetree/bindings/ata/tegra-sata.txt         |    4 +++-
>  .../bindings/fuse/nvidia,tegra20-fuse.txt          |   10 +++++-----
>  .../bindings/gpu/nvidia,tegra20-host1x.txt         |    8 ++++++--
>  .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |   10 +++++-----
>  .../bindings/misc/nvidia,tegra20-apbmisc.txt       |    9 ++++-----
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |    6 +++++-
>  .../bindings/pci/nvidia,tegra20-pcie.txt           |    8 ++++----
>  .../bindings/pinctrl/nvidia,tegra124-pinmux.txt    |    3 ++-
>  .../pinctrl/nvidia,tegra124-xusb-padctl.txt        |    4 +++-
>  .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |    7 ++++---
>  .../devicetree/bindings/rtc/nvidia,tegra20-rtc.txt |    4 +++-
>  .../devicetree/bindings/serial/of-serial.txt       |    5 ++++-
>  .../bindings/sound/nvidia,tegra30-ahub.txt         |    5 ++++-
>  .../bindings/sound/nvidia,tegra30-hda.txt          |    4 +++-
>  .../bindings/sound/nvidia,tegra30-i2s.txt          |    5 ++++-
>  .../bindings/spi/nvidia,tegra114-spi.txt           |    4 +++-
>  .../devicetree/bindings/thermal/tegra-soctherm.txt |    4 +++-

<cut>

> diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt=
 b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
> index ecf3ed76cd46..6b68cd150405 100644
> --- a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
> +++ b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
> @@ -7,7 +7,9 @@ notifications. It is also used to manage emergency shutdo=
wn in an
>  overheating situation.
> =20
>  Required properties :
> -- compatible : "nvidia,tegra124-soctherm".
> +- compatible : For Tegra124, must contain "nvidia,tegra124-soctherm".
> +  For Tegra132, must contain "nvidia,tegra132-soctherm".
> +  For Tegra210, must contain "nvidia,tegra210-soctherm".
>  - reg : Should contain 1 entry:
>    - SOCTHERM register set
>  - interrupts : Defines the interrupt used by SOCTHERM

Considering that this is going into a single patch, you may add my

Acked-by: Eduardo Valentin <edubezval@gmail.com>

for what concerns the thermal bindings.

Cheers,

Eduardo Valentin

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUzSzSAAoJEMLUO4d9pOJW2r8IAIntMubcsR1dU9t8k5aTxxEY
Wj9nTv/wXimGjSqq1xHkolDtqE7y0WXYKzSewFf6UWreYG5dNo88bjM3SYLZCG2C
Gk7ShwpVeUJ+SLPw+aKK0RimMhlb3Bf86VUdfBAcKMGPnmIElcAkio6LG1uhpyJh
iJEfnOc9V9wUe60dFplUlTH+V3THlTL/6LAaRMCcGJ83powxY/R2q8NspFeB7Ahv
fZ6cvGjfa4MPgeCjudvoe5Df4zUvgDJBxvfq1eUxgmcMlWUfOEfzkW1sDHyziFFT
nAqdwTNunJ7SZeCWo0Vv4cWlB+bAd90Pym2jcvdZO2p7fN+07DEQTk+v12lpRCI=
=wkfu
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
