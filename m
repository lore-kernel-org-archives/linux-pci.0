Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: Thunderbolt 3 (Skylake / Alpine Ridge) hotplug
To: Andreas Noever <andreas.noever@gmail.com>
References: <56D0085B.60402@jscinoz.so>
 <CAMxnaaU0B_47xZuD+vi0=b1_U7kPr7YVF5-Y0q3GP3ez_eo3CQ@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
From: Jack Coulter <jscinoz@jscinoz.so>
Message-ID: <56F0FE22.6050206@jscinoz.so>
Date: Tue, 22 Mar 2016 19:11:14 +1100
MIME-Version: 1.0
In-Reply-To: <CAMxnaaU0B_47xZuD+vi0=b1_U7kPr7YVF5-Y0q3GP3ez_eo3CQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bXuq4tQlAVSBdPuwDRTlUkQn2uE7BO2eC"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bXuq4tQlAVSBdPuwDRTlUkQn2uE7BO2eC
Content-Type: multipart/mixed; boundary="QHO6trbLfwQtLmXM1I1R5wX92TNT2sXXb"
From: Jack Coulter <jscinoz@jscinoz.so>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <56F0FE22.6050206@jscinoz.so>
Subject: Re: Thunderbolt 3 (Skylake / Alpine Ridge) hotplug
References: <56D0085B.60402@jscinoz.so>
 <CAMxnaaU0B_47xZuD+vi0=b1_U7kPr7YVF5-Y0q3GP3ez_eo3CQ@mail.gmail.com>
In-Reply-To: <CAMxnaaU0B_47xZuD+vi0=b1_U7kPr7YVF5-Y0q3GP3ez_eo3CQ@mail.gmail.com>

--QHO6trbLfwQtLmXM1I1R5wX92TNT2sXXb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

> That is correct. On your device TB should be handled by the firmware.
>
> Bj=C3=B6rn suggested that we might not be reacting to acpi notification=
s
> (or pci hotplug interrupts) properly. To confirm this you could try to
> issue a manual pci rescan via
>
> echo "1" > /sys/bus/pci/rescan
>
> This should make the device appear (if the issue lies with our
> handling of hotplug events).
I tried this but unfortunately no additional devices showed up, nor was
any additional dmesg output generated.

> Otherwise you might want to take a look at the ACPI tables and search
> for code which turn off thunderbolt or something like that. Does
> hotplug work under Windows (without additional drivers)?
I'm unable to comment as to whether it works under Windows - I do not
have Windows installed on this machine nor do I have sufficient
unallocated disk space to install it.


Kind regards,
Jack


--QHO6trbLfwQtLmXM1I1R5wX92TNT2sXXb--

--bXuq4tQlAVSBdPuwDRTlUkQn2uE7BO2eC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8P4iAAoJEP0XuxcIDSnPPkUP/0DMRRDfpDSQef/AGvfPb4Ea
iCwbN4FSc0A1bz3O1p7OfPv/1+mWhk016uhqBYzXdg2ONCOq1j00h9LLZ6L06nvM
VqbG+OnEg81Pm4a78+FwiIWmcCkSq1/7IjGKDQbiXFCcTvXD6TvsVbrsS13/1Vcs
7YsrO03eyqJGIMhgVbvuFz1IJfw8vI6jeofRcropKQQ8y5qOcnc6GTERUlLfBj0o
eoqcysN59Off3pofFMBMs6Uc/gntKFl0dUPKrCZSZBxqogzXT5gxGd+Y0WyZmpY6
y1T3WR40B/YEmHvFxiUZVjEBp3mfWmPFBrl0TWeGHiXumE0tSHTPx5tcu9amsdEF
FielKIb1dRDOvUrHD/whh32MFEfdCZI1m/lXo0wkDMPjBqYsGjDJRPNjA8qKViFc
qtWVlunRvMK6vKoBetqBxj/dQR8jQgPzPzKJxiw81/xWXZElFMbeHQp3uuixm39f
/Y7kgHjB35X7fp2sB6XA1nvt2H23mZx67GUJ9uNH4uHt9pwiWyPUMOlTPFaS7XCU
8j+CawyU0DNFiFTiDtHb1OvhFVB7JtmWukK6UI3bpTMLxj9CxTfhqz2bY6NEi+y9
NUdLKzHZ1sU1+vTHu9LZzMN3hysjWsd/3FWgmR1FvPK2uHH7Yk+OWjKctQMm2GRQ
VFLs9OgaNbgTlKwqri62
=TjLC
-----END PGP SIGNATURE-----

--bXuq4tQlAVSBdPuwDRTlUkQn2uE7BO2eC--
