Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:51296 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbaDWGse (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Apr 2014 02:48:34 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so362688eek.36
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2014 23:48:33 -0700 (PDT)
Message-ID: <5357623F.7080805@monstr.eu>
Date: Wed, 23 Apr 2014 08:48:31 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [Resend] pcibios_add_platform_entries usage
References: <alpine.LFD.2.11.1403281931410.1516@denkbrett> <alpine.LFD.2.11.1404141101500.1529@denkbrett> <20140414173541.GA4417@google.com> <alpine.LFD.2.11.1404141958120.1561@denkbrett> <alpine.LFD.2.11.1404171938190.1588@denkbrett> <1397768575.32730.70.camel@pasglop> <alpine.LFD.2.11.1404181154450.1609@denkbrett> <1397856690.32730.110.camel@pasglop> <alpine.LFD.2.11.1404221024550.1607@denkbrett>
In-Reply-To: <alpine.LFD.2.11.1404221024550.1607@denkbrett>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Cf6aVhcdJi4gNr5rcG6t04EQOHfXKgvQ2"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cf6aVhcdJi4gNr5rcG6t04EQOHfXKgvQ2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/22/2014 10:26 AM, Sebastian Ott wrote:
> On Sat, 19 Apr 2014, Benjamin Herrenschmidt wrote:
>> On Fri, 2014-04-18 at 12:10 +0200, Sebastian Ott wrote:
>>> On Fri, 18 Apr 2014, Benjamin Herrenschmidt wrote:
>>>> On Thu, 2014-04-17 at 19:46 +0200, Sebastian Ott wrote:
>>>>
>>>>> pci: move open fabric devspec attribute to pci common code
>>>>>
>>>>> Move the devspec OF attribute to pci common code's set of device
>>>>> attributes since it's not architecture dependent.
>>>>> As a side effect microblaze and powerpc no longer need to use
>>>>> pcibios_add_platform_entries.
>>>>>
>>>>> Link: https://lkml.kernel.org/r/alpine.LFD.2.11.1404141101500.1529@=
denkbrett
>>>>> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
>>>>
>>>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>
>>>> (Pending you've compile tested it on powerpc, I'm on vacation and
>>>> haven't done it :)
>>>
>>> I did:
>>> make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64-4.3.2- g5_defconfig
>>> make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64-4.3.2-
>>>
>>> and failed with:
>>>   CC      arch/powerpc/lib/xor_vmx.o
>>> In file included from include/linux/list.h:4,
>>>                  from include/linux/preempt.h:10,
>>>                  from arch/powerpc/lib/xor_vmx.c:22:
>>> include/linux/types.h:29: error: both =E2=80=98unsigned=E2=80=99 and =
=E2=80=98_Bool=E2=80=99 in declaration specifiers
>>> cc1: warnings being treated as errors
>>> include/linux/types.h:29: error: useless type name in empty declarati=
on
>>
>> Not sure what's up here, did you try with a more recent compiler ? 4.3=

>> is pretty ancient by kernel standards.
>>
>> You can find cross compilers there:
>>
>> https://www.kernel.org/pub/tools/crosstool/
>>
>> They aren't the newest either but they should work.
>=20
> Yes. That did the trick.

Hope that you did the same for microblaze or just push the repo/branch wi=
th these
patches to zero-day testing system and you got the results.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--Cf6aVhcdJi4gNr5rcG6t04EQOHfXKgvQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNXYj8ACgkQykllyylKDCF/qwCfcqgAWr88tz6i6Gi7tmJUWihV
KbUAoJ5DqOLKIm0s7NQbJWxKPBFg2S5u
=xnn7
-----END PGP SIGNATURE-----

--Cf6aVhcdJi4gNr5rcG6t04EQOHfXKgvQ2--
