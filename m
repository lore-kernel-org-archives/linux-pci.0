Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.h.duyck@redhat.com" <alexander.h.duyck@redhat.com>,
	"myron.stowe@redhat.com" <myron.stowe@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] vfio/pci: Use kernel VPD access functions
Date: Mon, 14 Sep 2015 21:34:14 +0000
Message-ID: <D7293B5C-82BC-4C9D-A06F-3BF806DC1CF2@intel.com>
References: <20150911181332.32399.74472.stgit@gimli.home>
 <80CE59CA-1B93-42FF-96D1-6276B724203F@intel.com>
In-Reply-To: <80CE59CA-1B93-42FF-96D1-6276B724203F@intel.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_B35C96C7-EFFF-4F5C-9E5D-DD122EFEFF52";
	protocol="application/pgp-signature"; micalg=pgp-sha256
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Apple-Mail=_B35C96C7-EFFF-4F5C-9E5D-DD122EFEFF52
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On Sep 11, 2015, at 6:11 PM, Rustad, Mark D <mark.d.rustad@intel.com> =
wrote:
>=20
> Superficially this looks pretty good. I need to think harder to be =
sure of the details.

This is the first time I've looked at all at any of the vfio code, but =
this is still looking good to me. Thanks for taking this on and exposing =
the vfio code to me. I hope more devices will be able to take advantage =
of the quirk and get their VPD issues resolved.

I did run this on a host with a device with VPD assigned to a guest and =
did not see any trouble when accessing it concurrently from both the =
guest and the host on the same and different functions. I don't think my =
particular environment is ideal to fully reproduce the problem (no =
writable VPD area), but my initial testing looks good.

Acked-by: Mark Rustad <mark.d.rustad@intel.com>

--
Mark Rustad, Networking Division, Intel Corporation


--Apple-Mail=_B35C96C7-EFFF-4F5C-9E5D-DD122EFEFF52
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIcBAEBCAAGBQJV9z1WAAoJEDwO/+eO4+5uyaYQAKRT8he+vAEqlubnKeNDW+eF
/Mdfg4QwbB769Bcsr6QlMUeD/MTvJoa6HYYhieOHgyUsQnL79XUn9jEjXIvdJNW1
uX4l65t1Vy7HBqP3bgEhgjRLRW0zG4ttlqOBDauMLWY5AgMRyyxVtM/Nf4rwxNNp
YdR6/SmJwBFSyjfG+ZJBP/Bbxpx5YcBkr52BoOGZ/D7ptNaF+QkDKeqzy8zSM2lh
Un8vqHLTZiYyifCqvebuc4HGGCMaZMKp58+P8m2gViG4mMroYTC+JDd6iU77vyJr
Q5SsBoRqd/vb5eew0bUHfQvN28hsa3tOUbO8kBPkgTiCIOKfHyV2CuWxRtMzVqaJ
qi/2rdLKLfEoqbrs0oND/mnFXWoiIZQwhbbBli4gj5dNiKVqBG3VJH4RUec3sbPK
uiZAX8GuLHL6YikcJiLj6hWsNKMQLgH7VyznrwSBRmI2Ay1cC2OHjsbiRZWdjfel
TF72k/3xxxNEFmfuQNQpXE7RuSYOLWzhaDoRGxTG+vSe8HKo+XJL34upSAjML/59
5hYYiITLDERiQCXLG5M3T9WMygVRLCmu9zbH1fZ/4c0qdLBj6wg9w5r0SuzAv0oK
IKI5J2lxmp/AGqbVprz3QgGQ0QEjpr1Qr/bG70Q7KG9J6pbabHbdWBEjcnU5C7rY
jK1CMqLNsrqZ6o7zUFl4
=4c9A
-----END PGP SIGNATURE-----

--Apple-Mail=_B35C96C7-EFFF-4F5C-9E5D-DD122EFEFF52--
