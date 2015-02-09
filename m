Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:32821 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284AbbBIQJ5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 11:09:57 -0500
Message-ID: <54D8DBC8.3020502@canonical.com>
Date: Mon, 09 Feb 2015 17:09:44 +0100
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
References: <1421720467-7709-1-git-send-email-jiang.liu@linux.intel.com> <1369609199.20150205210757@eikelenboom.it> <54D8823F.9080900@canonical.com> <54D8A446.3000008@linux.intel.com> <54D8A83B.60307@canonical.com>
In-Reply-To: <54D8A83B.60307@canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="70TMi4knANn82pumu4uQThttT0VRcQgxp"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--70TMi4knANn82pumu4uQThttT0VRcQgxp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09.02.2015 13:29, Stefan Bader wrote:
> On 09.02.2015 13:12, Jiang Liu wrote:
>> On 2015/2/9 17:47, Stefan Bader wrote:
>>> On 05.02.2015 21:07, Sander Eikelenboom wrote:
>>>>
>>>> Tuesday, January 20, 2015, 3:21:04 AM, you wrote:
>>>>
>>>>> Hi Thomas,
>>>>>         This patch set includes three hotfixes related Xen IRQ for =
v3.19.
>>>>> Sorry for the long delay to get these two regressions fixed, it rea=
lly
>>>>> cost me some time to read and understand Xen IRQ code.
>>>>
>>>>> Patch 1 fixes the failure to register ACPI SCI interrupt on Xen
>>>>> domain0 by reworking acpi_gsi_to_irq(). I will backport it to v3.18=

>>>>> too once it reaches the mainstream kernel.
>>>>
>>>>> Patch 2 fixes the regression in Xen PCI device passthrough(pciback)=
=2E
>>>>> It's a temporary solution, I will send the formal fix for v3.20 and=

>>>>> it has passed tests too.
>>>>
>>>>> Patch 3 fixes an issue found when reading code. There's no real bug=

>>>>> reports related to this issue yet.
>>>>
>>>>> Great thanks to Konrad and Sander for testing fixes for these regre=
ssions.
>>>>
>>>>> Regards,
>>>>> Gerry
>>>>
>>>> Hi Gerry,
>>>>
>>>> Since these patches now are: tested, reviewed and have landed into m=
ainline,
>>>> could you also provide the backports for 3.17 and 3.18 where require=
d ?
>>>
>>> This would be my attempt of backporting those to 3.18 (I have not tri=
ed whether
>>> they would apply to 3.17 as well). Those seem to work when test-booti=
ng and
>>> Sander said he will give them a try as well. But better check yoursel=
f I did not
>>> mess anything up while backporting. One of the three patches seemed n=
ot to be
>>> required at all.
>> I'm backporting them too, but now I will give up my patches:)
>>
>> The first one is a must, which should be applied to 3.17 and 3.18.
>> The second one doesn't apply to 3.17 or 3.18.
>> The third may be applied to v3.17 and v3.18, but it shouldn't be appli=
ed
>> according to the stable-kernel doc because no user reports such a bug =
yet.
>=20
> Hm, ok. So maybe I should retry with only patch#1 and verify that alone=
 gets
> around the acpi irq and the usb problems, too. Though interestingly fro=
m the
> history, the acpi irq I saw in 3.17 while the usb devices started to fa=
il with
> 3.18. I will let you know in a bit. Just want to finish another bisect =
first.

So it looks like patch #1 indeed does fix both the acpi irq and my usb de=
vices.
Sander, do you want to verify that variant, too?

The only odd thing left in a 3.18 with the fix (regardless of using patch=
 #1
only or patches #1 and #3) is that the ahci driver shows up with its pci =
bus
number in /proc/interrupts. But that does not seem to have any relevant d=
ownside
(cannot try 3.19 on that box right now for other reasons).

-Stefan

=2E..
# 57: 12441  0    0    0  xen-pirq-msi       0000:00:1f.2
#                                            (used to be ahci)

>=20
> -Stefan
>=20
>> Regards
>> Gerry
>>>
>>> -Stefan
>>>
>>>>
>>>> The number of people running into these (subtle) issues with these s=
table
>>>> kernels seems to be steadily increasing.
>>>>
>>>> --
>>>> Sander
>>>>
>>>>> Jiang Liu (3):
>>>>>   xen/pci: Kill function xen_setup_acpi_sci()
>>>>>   xen/irq, ACPI: Fix regression in xen PCI passthrough caused by
>>>>>     cffe0a2b5a34
>>>>>   xen/irq: Override ACPI IRQ management callback __acpi_unregister_=
gsi
>>>>
>>>>>  arch/x86/include/asm/acpi.h |    1 +
>>>>>  arch/x86/kernel/acpi/boot.c |   26 +++++++++++------------
>>>>>  arch/x86/pci/xen.c          |   49 ++-----------------------------=
------------
>>>>>  drivers/acpi/pci_irq.c      |    1 -
>>>>>  4 files changed, 16 insertions(+), 61 deletions(-)
>>>>
>>>>
>>>
>=20
>=20



--70TMi4knANn82pumu4uQThttT0VRcQgxp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU2NvPAAoJEOhnXe7L7s6jRVkP/j9qfWBiPqBfRIdQugTyAKI/
dd0iIL9mRgY1X79wyK+t3qciejEHavOAbOSWcds415sQ8rydfoKr9mq54PWqLG6b
oBKBuw2G4/NRAAGBAIDv3QJdr8V2dJGLJjwrDlSVhVQcJb+rQLvyIe6cM7u0WTtA
6Wl6hW0pQr1k2B33doUI/b2VxOeBcGgJDMn4TdvbM2z65T0xcZq8R7XlqHOwwHss
SNAenSLmMPUr3Z5wk3XYLRbicgimAsFnykBuEx7x632JeUoRp1vbjC4MElT13wI8
olYJgQ8LgEw8fWPqW7hkTIGeaziNqWSBAQg3nrGgerWs+ejT4Dzd3B1oZL7FXGPE
aj3M2v6RqnMcQ2RmcIUoxm2hHv6yM/Vv19Uoj3Z+k7M1OXqYyUGW0pkG0arEHTsC
KfNrBpWhPzNncHzEdMdFawyyOcyyxy+64oG/gfTrSM7VXIt7gG99sxEzMyUpYh48
SK3CbESuFo3GV4PvFRuj1lxzqzKPwZHUXpCIRfB6R1dwVPGJ3KvjemHC/MUtZk2Z
SvG3Mc33XgNoc+dpSj58L1V1TvVnVv2JE7w6u5ymOMbuobyoVmqE4+iy894h7toy
UcQhY7XADnmX2aNZopKJwkrYXl0YihaR1J1Qg+eC2ezHY4hBTFkcE7/YYc3ZzZkz
BqpYGGpaTKVplvRdZXUa
=I5Ip
-----END PGP SIGNATURE-----

--70TMi4knANn82pumu4uQThttT0VRcQgxp--
