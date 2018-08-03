Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:14291 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbeHCIZm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Aug 2018 04:25:42 -0400
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI: add support for Immediate Readiness
In-Reply-To: <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org>
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com> <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org>
Date: Fri, 03 Aug 2018 09:26:09 +0300
Message-ID: <874lgcufsu.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sinan Kaya <okaya@kernel.org> writes:

> On 8/2/2018 7:36 AM, Felipe Balbi wrote:
>> PCIe GEN4 defines a new bit on Status Register which tells us that, if
>> Set, a function is immediately ready after a Reset. This means that
>> all delays after a Conventional or Function Reset can be skipped.
>
> Can you give a reference to the section of the specification? or
> a pointer to the ECN?

Section 7.5.1.1.4 of PCIe GEN4 spec. Table 7-4:

Immediate Readiness =E2=80=93 This optional bit, when Set, indicates the
Function is guaranteed to be ready to successfully complete valid
configuration accesses at any time following any reset that the host is
capable of issuing Configuration Requests to this Function.

When this bit is Set, for accesses to this Function, software is exempt
from all requirements to delay configuration accesses following any type
of reset, including but not limited to the timing requirements defined
in Section 6.6.  How this guarantee is established is beyond the scope
of this document.

It is permitted that system software/firmware provide mechanisms that
supersede the indication provided by this bit, however such
software/firmware mechanisms are outside the scope of this
specification.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltj9YEACgkQzL64meEa
mQZPIQ//UPepDxS0tRfVkuXcLPDoGRCPDIo9RE5vfMpKV/GvXKEuL+b4XfdjTSjr
+R+PGx3qAbmjH03nt7wt5OtplnMoe2Yvdndx3E34XpolKCLSHhxQTCaITAUC1x4W
18mgZI/q3zSVJwjbjz9zprGMlfbw6lTvmlrbQxyMamhI00KvUqbNZui38J4MUDr8
rhoVVFSGCp45jlQaUZm+7jt8kaJi9tzfHVrwRGEavfteuYCx8CDJ1yx1ChJD6Yu2
HSEDMi+c7LPB0Kje70xRELEGbqUlcWKyFdXfFaqxvx2wNQlNgd3MzDmm7/CH03L2
LaCmRy8U+ru8UjTf91KEIZBcDlgIFCHY0i2OW7PQU0l2BSw7wQ542D1krRDkUzNJ
7Z+Hpqli9quhIQj7tzDL8io1Cmzg/NxI6zaEwMpP/sdXMzD0V5GXI3qFWxu5cBiy
bCYRMp/W/NgX+NYjRsnGzT0XQn7yLmIXnNydh6TM9b7UKWmicLQ/vSHjEr7YHlUo
mOXqm0iGAr+0TPiW1vfHT3RhqijVHqnlgDbtzGHISeomcXftjN5nxkCVThYgzoTI
KydLY44hv+Z2HwYJbuMJTTtfulMEzz+lIpN1lW9IZc7GtloZHKzbkM6E40exnb9b
gw6nLmV6c3jEmh68fly9/cn7f/imgfHs2mCEfmXG/gR3LJT233c=
=g6eO
-----END PGP SIGNATURE-----
--=-=-=--
