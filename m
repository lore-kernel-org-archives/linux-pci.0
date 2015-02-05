Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37762 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636AbbBETZ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 5 Feb 2015 14:25:29 -0500
Date: Thu, 5 Feb 2015 20:25:22 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Takashi Iwai <tiwai@suse.de>, linux-pci@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-i2c@vger.kernel.org, Paul Walmsley <pwalmsley@nvidia.com>,
	linux-pm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>,
	Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom@nvidia.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Dylan Reid <dgreid@chromium.org>, linux-pwm@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Jingchang Lu <jingchang.lu@freescale.com>,
	Eduardo Valentin <edubezval@gmail.com>,
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
Message-ID: <20150205192521.GF15307@katana>
References: <20150130221104.4761.50643.stgit@dusk.lan>
 <20150130221104.4761.4534.stgit@dusk.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
In-Reply-To: <20150130221104.4761.4534.stgit@dusk.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul!

On Fri, Jan 30, 2015 at 03:11:04PM -0700, Paul Walmsley wrote:
> Align compatible strings for several IP blocks present on Tegra chips
> with the latest doctrine from the DT maintainers:
>=20
> http://marc.info/?l=3Ddevicetree&m=3D142255654213019&w=3D2

OK, I am not sure if I like the direction, but having a rule of thumb
here is definately a good thing. Thanks for the pointer!

So, for the I2C part:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08OhAAoJEBQN5MwUoCm211kP/1gwSZCg1BcLlL4f03sgSP7g
43ow1o5erCEDXawaJrwocF5h/w5itymPrTl0V4pFTr2isis7jsaZvt+aBXtfKbeb
gaKuqiMWxmw3iSbClMkT7rWSrM+BaLs2oJqLD6lAEW4F3YDHS0j1Rl0k5It5J230
qNgO2mCar0l7pY7QWsv5vTPBtvNDa/VUaFn+nqzGRCheobMLOiTCaFe11KTnUT2G
Fks0y8yqe5eAmd6kXSylFrp72IORLGpk+mjkZZw5PNmVF3iwcW+HhW4WGLVtdFJv
C3haV/XZ+0Vx0+E0FZslvGZJFljo2bNWhX3zqIhOX4ZEHa0xBKL7KH8+4h9Y9pkN
TGta6Gr9vsByPZbc8kIsPEvELZW0T61dYkkVs5FHnSgFa1iBxOrxxn1rVP22dyHp
koVCrWFrG0A8NLUDrv2msO4RTU7INmO7mpwTGmpcRyDWjIn0OfMPwyISjw4T4pZL
lh4tMOWsTQBboi1itXAhMk8xa97TR9qbyUwOvud/MwqVHiY8ZkQBawXGIoW+y+pO
9qLpccLwI79/l7yl7xpSQpCtylxPAESeXAulTHRYTffoAREWKQwmhPeqe4awoiZg
XGYjKiVlJBnSEYUgVXCkZi5tsqikfBH3p0VY1sKIrW5MhE2by22TTzoDVyvD2y/z
6ov2grGmesT2m3keN2oH
=5LNo
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
