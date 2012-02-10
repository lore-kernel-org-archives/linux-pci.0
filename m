Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:45520 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759958Ab2BJTwF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2012 14:52:05 -0500
Date: Fri, 10 Feb 2012 11:52:02 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ingo Molnar <mingo@elte.hu>, Alessandro Rubini <rubini@gnudd.com>,
	Giancarlo Asnaghi <giancarlo.asnaghi@st.com>,
	Alan Cox <alan@linux.intel.com>, linux-pci@vger.kernel.org
Subject: Re: [rubini@gnudd.com: [PATCH V2 3/3] x86: initial support for
 sta2x11]
Message-ID: <20120210115202.33103150@jbarnes-desktop>
In-Reply-To: <20120131011928.GA5819@elte.hu>
References: <20120131011928.GA5819@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/WBdymJkhFLy0v=I.OF2FLZt"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/WBdymJkhFLy0v=I.OF2FLZt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Jan 2012 02:19:29 +0100
Ingo Molnar <mingo@elte.hu> wrote:

>=20
> This would be yours I suppose?
>=20
> Thanks,
>=20
> 	Ingo
>=20
> ----- Forwarded message from Alessandro Rubini <rubini@gnudd.com> -----
>=20
> Date: Mon, 30 Jan 2012 17:09:52 +0100
> From: Alessandro Rubini <rubini@gnudd.com>
> To: linux-kernel@vger.kernel.org
> Cc: giancarlo.asnaghi@st.com, alan@linux.intel.com, tglx@linutronix.de, m=
ingo@redhat.com,
> 	hpa@zytor.com, x86@kernel.org
> Subject: [PATCH V2 3/3] x86: initial support for sta2x11
>=20
> The "ConneXt" sta2x11 I/O Hub is a bridge from PCIe to AMBA, and is
> used as main chipset in some Atom boards.  The set of peripherals it
> exports live in an AMBA bus internal to the chip, so a custom
> remapping of addresses is needed. This is implemented by fixup calls
> for the PCI deivices, based on CONFIG_X86_DEV_DMA_OPS and
> CONFIG_X86_DMA_REMAP .
>=20
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Cc: Alan Cox <alan@linux.intel.com>

Looks like this depends on some x86 Kconfig options I don't have in my
tree, so I dropped the selects for them.  Please check it out in my
-next tree and apply any fixes on top.

Thanks,
--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/WBdymJkhFLy0v=I.OF2FLZt
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNXViAAoJEIEoDkX4Qk9hzLMQAKwMU8X/hn1l9Z05XIQl1YLe
2ZnlGwgDDJOVYTWIWuJfY+U98FTILdUlgaAKz1ICmCosblGQXhjaTAG0cEFh3EKe
8wm8sUZPaZum9RD4MS178XVqVmLpDniBpgyOOTaBg8mslntmPwrZcLEwv5vRpvWM
xjblUK+VTO6wskyysQ1XsU5wWjgtaui1GJbR2X6XJ5FJM1QkKWCS9Y1RFbFyYYdI
Vzkd0fbDkE+4NYm7BGPDkfoybZfT/bEtMUtu/+ctFjh/cL4oroGeDuezGJcfRNqv
1ns+OnZNFI6v5TPLU5/QwupDboOE/rDTiI1ymogUGPiDhR/NMUqpKExl7Jhn28al
3mfWb4/EcZKwi/J+OLbbDHEwHnfjwRMqE+oaT5xzuY3IjOnZYjyrgnjZMfCl7fKs
ltiWSxOqfhWQqCZeUaJBW+2d3YlOTXgdYIZvKHCqbYxwgKjqPef/jQfyi+iK4jBt
dw+0j7Mp895hANwz/8HkkviyUle1cRKcoY0HLxy7WJ3Y+K0wBr7puf3bSQrbQ481
sdIbAl9Tu1xKJWaqtNmzcx7OGsJHT8AUuyHMgyhaw84Z4ypUCVu8wBYiX2VESdz3
dfnnhBWyg2taB4rp5EOMxwnVIF1/EbvZr3ZUnK8vkZwiVN2UgO/e0nqUD+GAPAWS
Fpl9jOrL07K4v1tfZ1vD
=H6cZ
-----END PGP SIGNATURE-----

--Sig_/WBdymJkhFLy0v=I.OF2FLZt--
