Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53249 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224AbbFQGGR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Jun 2015 02:06:17 -0400
Message-ID: <55810E42.4080500@ti.com>
Date: Wed, 17 Jun 2015 09:05:54 +0300
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Borislav Petkov <bp@suse.de>,
	linux-fbdev <linux-fbdev@vger.kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	Andy Lutomirski <luto@amacapital.net>,
	<linux-pci@vger.kernel.org>
Subject: Re: [Cocci] [PATCH v3 0/4] pci: add and use pci_ioremap_wc_bar()
References: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com> <CAB=NE6VYvd-Au58QRJprCquuvJkY9NYe1x8FmbW7qAhVrVE=QQ@mail.gmail.com> <20150519175310.GH23057@wotan.suse.de> <CAB=NE6UsMMoPhkKof+VN7ZUCd81VxrwP9nqHDUj5Lr3DJLm3bA@mail.gmail.com> <CAB=NE6UdW2d6zO1hYbTnPcoZWt8+Yg5KdWE_bdqAuR_ysey_+A@mail.gmail.com> <557FCD1A.4020105@ti.com> <20150616190504.GH11147@wotan.suse.de>
In-Reply-To: <20150616190504.GH11147@wotan.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bHKNgDXgGvhid6M81pc8ijc6i5GvW6h73"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--bHKNgDXgGvhid6M81pc8ijc6i5GvW6h73
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On 16/06/15 22:05, Luis R. Rodriguez wrote:

> Can the fbdev parts go through Bjorn's tree? We last discussed if the s=
eries
> was important to be fully merged or not by v4.2 and I recentlty provide=
d a
> long winded review of the entire series to help maintainers pick and ch=
oose
> and decide [1].
>=20
> Based on this can the fbdev patches from both of these series go throug=
h Bjorn's tree?

Yes, they can go through Bjorn's tree if there are no non-trivial
conflicts with the main fbdev stuff. linux-next should contain all the
fbdev patches going for 4.2.

 Tomi


--bHKNgDXgGvhid6M81pc8ijc6i5GvW6h73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgQ5CAAoJEPo9qoy8lh71Gs8P/0GkgK8a+Dj9rYw4YtmRKYRo
dyM8OCUPY3JvFLf3h/TZUe9jJpsHkAq2dzSuBYKGPPjNvqi26t/oCfb8crLqUpTO
QQ1g8lmqD7VsoqicVuwLET42J2O9Q0v9LU9Mk8SHuU+2MS2qsKoVRqyrcA0OyJ2f
F4XnpnRWfm25FwvxqhBlQmf3Qk3/0la6f+Nd//l5UyKw8fcPPajDp47vnrTTSJu9
n0y+nj8X0xw/onG/K3ywRmAmnspbEIGW/Z2kdxBPKwh+drDbCia+Zeyuc7VAJQwq
Ym9qNr13HcSpUn5hcv8mnrMqomEA51uvPyDv+cma8f38vmf5/eZ9lT93RfiRSuWW
q16JrbBsJer/dmomw+5U0V0iyFMgjZBq4AAuRJfgwIgzs1g156LwnxS3iQpNgwYR
R+38c2dgV+ssJ/TKMTPSwTbFUoqQWYu+kkrpmXyb6Fl6BArr1Mb1x6+0Sydmgjy5
nAF++5jnEgbiRSJ1xMsohvdraTB4q90XYRyYoJ9pXU3RYZY75IX0vld+8MwvhfgS
AS2DfYC503mRko/T0ffGRwbqG5lINRhM22euCfCwZe8kOB2IOPKMp6RcrfjXbd05
+/9hTj+3pScHwXmCjLgkGq3Xc/c6IOu5qTr6ssSP41Ij6Vos9AFQPfkV8I32ePV1
GbXnKC2IETXlEEi1s5yb
=HAX8
-----END PGP SIGNATURE-----

--bHKNgDXgGvhid6M81pc8ijc6i5GvW6h73--
