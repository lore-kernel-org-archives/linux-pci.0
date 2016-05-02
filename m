Return-Path: <thierry.reding@gmail.com>
Return-Path: <thierry.reding@gmail.com>
Date: Mon, 2 May 2016 08:47:57 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, catalin.marinas@arm.com,
	linux-pci@vger.kernel.org, will.deacon@arm.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com,
	robert.richter@caviumnetworks.com, msalter@redhat.com,
	Liviu.Dudau@arm.com, jchandra@broadcom.com,
	linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
	Suravee.Suthikulpanit@amd.com
Subject: Re: [RFC] experimental pci_register_host API
Message-ID: <20160502064757.GA27465@ulmo.ba.sec>
References: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
In-Reply-To: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
List-ID: <linux-pci.vger.kernel.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 30, 2016 at 01:01:36AM +0200, Arnd Bergmann wrote:
> As mentioned in another thread, I have tried to come up with
> a way to make the PCI host driver registration more flexible
> and simpler.
>=20
> We have actually discussed this multiple times in the past,
> but always ended up elsewhere, so this is a proof of concept
> work, leaving all the existing interfaces in place, and
> adding a way to allocate a pci_host_bridge structure from
> a driver and register that after filling out all the interesting
> fields.
>=20
> This is not tested at all, and certainly not meant for
> inclusion until the concept has been discussed better.
>=20
> Please have a look.

Hi Arnd,

I like this idea very much and welcome the timing. After the longer than
expected XUSB detour I was going to look at PCI next. Making the driver
work on both 32-bit and 64-bit ARM is the first thing that needs solving
but once that's in place it should be fairly trivial to add support for
Tegra X1 on top.

=46rom a quick glance I think this series is a really good starting point.
I had a couple of questions, but I'll ask them as replies to each patch
for context.

Thierry

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXJvgaAAoJEN0jrNd/PrOhWREQAMBSQNTeW3hQ8PcsNHOGkUL2
OzxPNYDkeFkbgbnRAErjyyieHX2p2TMxtpU60En4/JVdnyatRBJUtpWRzVhLv3jb
cv98XnJ5t6MPu0+GVKU0TqamfPD0ab5zJWAANtY7aZ/bTu26MwJzq/hfxkLlx3S2
Xsw6bTF923YbbkTaKHlHNC726r9idSAtmEHPw51jOr08bVmGzs5aspR/LMatVK74
T0s2FDPblbq89pzZoRQDzENyfvxH7kFTlYhXKe4KCG0+Too3xECznI74/AU/LxzZ
ijdxEw7heRMATHEfhDf9YfzX2dF7Fo7h6V7Q2Ql3hhTJK4QyZz4JA6Qb6MQoYMvl
A8M5QQ6DaHMiS+IgI1EU6X1P17vTqs/a7Q2cs32a0DzskTaz5jmry1+Blrw8BpAt
kjsLUv0cGARf/9A/hP61FoMAf+V9QqRQdG+VXB45HbVVCqVEal190bSfYlooc4cM
IHj8UcCz2JBRZWbDSdEMNgvOTWSL+dAV8Ka8cJUq/X6jJFma9lZ4n51dUPLR3fS0
o88hfe6NMEbW6vIHn7EM/sfhaBk7EcERBBOl3zUj37wqk9jILPCPs1Co5OQuUezv
GvFbPi9cG8t5qJSLiSfJmp2+6T2N837myP9Qhslqt8PKO5c66vlvr9vkQwc4jJkJ
ZQirgMBEganTXcJ2Nlno
=WPBb
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
