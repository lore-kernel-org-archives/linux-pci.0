Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58194 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759670AbbBIMaC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 07:30:02 -0500
Message-ID: <54D8A83B.60307@canonical.com>
Date: Mon, 09 Feb 2015 13:29:47 +0100
From: Stefan Bader <stefan.bader@canonical.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [Bugfix 0/3] Xen IRQ related hotfixes for v3.19
References: <1421720467-7709-1-git-send-email-jiang.liu@linux.intel.com> <1369609199.20150205210757@eikelenboom.it> <54D8823F.9080900@canonical.com> <54D8A446.3000008@linux.intel.com>
In-Reply-To: <54D8A446.3000008@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cP3TqM45m5iocT53JKQeK872ME9TjDI9Q"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cP3TqM45m5iocT53JKQeK872ME9TjDI9Q
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09.02.2015 13:12, Jiang Liu wrote:
> On 2015/2/9 17:47, Stefan Bader wrote:
>> On 05.02.2015 21:07, Sander Eikelenboom wrote:
>>>
>>> Tuesday, January 20, 2015, 3:21:04 AM, you wrote:
>>>
>>>> Hi Thomas,
>>>>         This patch set includes three hotfixes related Xen IRQ for v=
3.19.
>>>> Sorry for the long delay to get these two regressions fixed, it real=
ly
>>>> cost me some time to read and understand Xen IRQ code.
>>>
>>>> Patch 1 fixes the failure to register ACPI SCI interrupt on Xen
>>>> domain0 by reworking acpi_gsi_to_irq(). I will backport it to v3.18
>>>> too once it reaches the mainstream kernel.
>>>
>>>> Patch 2 fixes the regression in Xen PCI device passthrough(pciback).=

>>>> It's a temporary solution, I will send the formal fix for v3.20 and
>>>> it has passed tests too.
>>>
>>>> Patch 3 fixes an issue found when reading code. There's no real bug
>>>> reports related to this issue yet.
>>>
>>>> Great thanks to Konrad and Sander for testing fixes for these regres=
sions.
>>>
>>>> Regards,
>>>> Gerry
>>>
>>> Hi Gerry,
>>>
>>> Since these patches now are: tested, reviewed and have landed into ma=
inline,
>>> could you also provide the backports for 3.17 and 3.18 where required=
 ?
>>
>> This would be my attempt of backporting those to 3.18 (I have not trie=
d whether
>> they would apply to 3.17 as well). Those seem to work when test-bootin=
g and
>> Sander said he will give them a try as well. But better check yourself=
 I did not
>> mess anything up while backporting. One of the three patches seemed no=
t to be
>> required at all.
> I'm backporting them too, but now I will give up my patches:)
>=20
> The first one is a must, which should be applied to 3.17 and 3.18.
> The second one doesn't apply to 3.17 or 3.18.
> The third may be applied to v3.17 and v3.18, but it shouldn't be applie=
d
> according to the stable-kernel doc because no user reports such a bug y=
et.

Hm, ok. So maybe I should retry with only patch#1 and verify that alone g=
ets
around the acpi irq and the usb problems, too. Though interestingly from =
the
history, the acpi irq I saw in 3.17 while the usb devices started to fail=
 with
3.18. I will let you know in a bit. Just want to finish another bisect fi=
rst.

-Stefan

> Regards
> Gerry
>>
>> -Stefan
>>
>>>
>>> The number of people running into these (subtle) issues with these st=
able
>>> kernels seems to be steadily increasing.
>>>
>>> --
>>> Sander
>>>
>>>> Jiang Liu (3):
>>>>   xen/pci: Kill function xen_setup_acpi_sci()
>>>>   xen/irq, ACPI: Fix regression in xen PCI passthrough caused by
>>>>     cffe0a2b5a34
>>>>   xen/irq: Override ACPI IRQ management callback __acpi_unregister_g=
si
>>>
>>>>  arch/x86/include/asm/acpi.h |    1 +
>>>>  arch/x86/kernel/acpi/boot.c |   26 +++++++++++------------
>>>>  arch/x86/pci/xen.c          |   49 ++------------------------------=
-----------
>>>>  drivers/acpi/pci_irq.c      |    1 -
>>>>  4 files changed, 16 insertions(+), 61 deletions(-)
>>>
>>>
>>



--cP3TqM45m5iocT53JKQeK872ME9TjDI9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU2KhFAAoJEOhnXe7L7s6j2zQP/iRef4ONjJl8S3/aIHP4ER7D
z1jt31X+4MEYt4NgjlpKFDOgDSZNrOj45YBsGdnpsvKwhaA2/bk2bl0TR10tjCpf
kpoZ3QOFS7+ZgGrBRM0r8kMcSCwJKOoJ0B4RBAurmgWUrz3WJrl6uxeL3vUjGdAf
ZWTee/9kWp7mD/6C2it9CASWuCTvWgcwYXT4sDiei8BLnE8ZKKzwF85y+Q4u7sDv
rzCskT4A93ub4IvXSyH2hjrfaAukprZeqRBBeBb1O3bPhCpzKedFkSMZSJtFQ9zA
WEya2xn/CTplydVJIWA7uf3qrvH3q48n2wCIwok6LJHzI+1jNsGWoXvnCEpVTRqn
VMt7eXMQem1nxlbjueuJOpklG4Z6hR46WqOFjZeraDbtPW9qnzqBVUa5H7x5msYn
ALsWyKX+hR7x3KCBzCE0YB5Jubz/L69qid54mgdlJ4/UaH7A0H8uXaxz0w/KmiMm
WHqNCFoy+1IRpmklSEPeqAGD5X7w6It0RZPXjzfygRaI066x+3HdD5l+hjHXd7nF
+0znHk8chr42K+qkm+sYAk45x/5rxvONh554wpHLMYW+RaoEzKHHJiAoEm8xgBo9
ulMEJam3cU3r8srbFJ+PbAXAlPmA2voIQHE05MlPcBITJJBNr0cmqZzFRfGx3ry/
ygwNCPmM6c2cdo83zQ0i
=p/b3
-----END PGP SIGNATURE-----

--cP3TqM45m5iocT53JKQeK872ME9TjDI9Q--
