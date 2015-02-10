Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54DA0821.1000605@canonical.com>
Date: Tue, 10 Feb 2015 14:31:13 +0100
From: Stefan Bader <stefan.bader@canonical.com>
MIME-Version: 1.0
To: Sander Eikelenboom <linux@eikelenboom.it>
CC: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [Bugfix 0/3] Xen IRQ related hotfixes for v3.19
References: <1421720467-7709-1-git-send-email-jiang.liu@linux.intel.com> <1369609199.20150205210757@eikelenboom.it> <54D8823F.9080900@canonical.com> <54D8A446.3000008@linux.intel.com> <54D8A83B.60307@canonical.com> <54D8DBC8.3020502@canonical.com> <1703934611.20150209201527@eikelenboom.it>
In-Reply-To: <1703934611.20150209201527@eikelenboom.it>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pEoEOn1BWJ2Fn5iiB172D66Ih393i6lQM"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pEoEOn1BWJ2Fn5iiB172D66Ih393i6lQM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09.02.2015 20:15, Sander Eikelenboom wrote:
>=20
> Monday, February 9, 2015, 5:09:44 PM, you wrote:
>=20
>> On 09.02.2015 13:29, Stefan Bader wrote:
>>> On 09.02.2015 13:12, Jiang Liu wrote:
>>>> On 2015/2/9 17:47, Stefan Bader wrote:
>>>>> On 05.02.2015 21:07, Sander Eikelenboom wrote:
>>>>>>
>>>>>> Tuesday, January 20, 2015, 3:21:04 AM, you wrote:
>>>>>>
>>>>>>> Hi Thomas,
>>>>>>>         This patch set includes three hotfixes related Xen IRQ fo=
r v3.19.
>>>>>>> Sorry for the long delay to get these two regressions fixed, it r=
eally
>>>>>>> cost me some time to read and understand Xen IRQ code.
>>>>>>
>>>>>>> Patch 1 fixes the failure to register ACPI SCI interrupt on Xen
>>>>>>> domain0 by reworking acpi_gsi_to_irq(). I will backport it to v3.=
18
>>>>>>> too once it reaches the mainstream kernel.
>>>>>>
>>>>>>> Patch 2 fixes the regression in Xen PCI device passthrough(pcibac=
k).
>>>>>>> It's a temporary solution, I will send the formal fix for v3.20 a=
nd
>>>>>>> it has passed tests too.
>>>>>>
>>>>>>> Patch 3 fixes an issue found when reading code. There's no real b=
ug
>>>>>>> reports related to this issue yet.
>>>>>>
>>>>>>> Great thanks to Konrad and Sander for testing fixes for these reg=
ressions.
>>>>>>
>>>>>>> Regards,
>>>>>>> Gerry
>>>>>>
>>>>>> Hi Gerry,
>>>>>>
>>>>>> Since these patches now are: tested, reviewed and have landed into=
 mainline,
>>>>>> could you also provide the backports for 3.17 and 3.18 where requi=
red ?
>>>>>
>>>>> This would be my attempt of backporting those to 3.18 (I have not t=
ried whether
>>>>> they would apply to 3.17 as well). Those seem to work when test-boo=
ting and
>>>>> Sander said he will give them a try as well. But better check yours=
elf I did not
>>>>> mess anything up while backporting. One of the three patches seemed=
 not to be
>>>>> required at all.
>>>> I'm backporting them too, but now I will give up my patches:)
>>>>
>>>> The first one is a must, which should be applied to 3.17 and 3.18.
>>>> The second one doesn't apply to 3.17 or 3.18.
>>>> The third may be applied to v3.17 and v3.18, but it shouldn't be app=
lied
>>>> according to the stable-kernel doc because no user reports such a bu=
g yet.
>>>
>>> Hm, ok. So maybe I should retry with only patch#1 and verify that alo=
ne gets
>>> around the acpi irq and the usb problems, too. Though interestingly f=
rom the
>>> history, the acpi irq I saw in 3.17 while the usb devices started to =
fail with
>>> 3.18. I will let you know in a bit. Just want to finish another bisec=
t first.
>=20
>> So it looks like patch #1 indeed does fix both the acpi irq and my usb=
 devices.
>> Sander, do you want to verify that variant, too?
>=20
> Hi Stefan / Gerry,
>=20
> Just tested with only patch 1, ended up the same .. the reported issues=
 seem=20
> gone.

Sounds good. :) Gerry, do you want me to fwd the backport to Greg for 3.1=
8 or do
you do that? As far as I know 3.17 has nobody caring about it.

-Stefan

>=20
>=20
>> The only odd thing left in a 3.18 with the fix (regardless of using pa=
tch #1
>> only or patches #1 and #3) is that the ahci driver shows up with its p=
ci bus
>> number in /proc/interrupts. But that does not seem to have any relevan=
t downside
>> (cannot try 3.19 on that box right now for other reasons).
>=20
>> -Stefan
>=20
>> ...
>> # 57: 12441  0    0    0  xen-pirq-msi       0000:00:1f.2
>> #                                            (used to be ahci)
>=20
> This is also there on baremetal with 3.19 on intel, so not xen related:=

>  27:       1868        582       1282        555  IR-PCI-MSI-edge      =
0000:00:1f.2
>=20
> --
> Sander
>=20
>>>
>>> -Stefan
>>>
>>>> Regards
>>>> Gerry
>>>>>
>>>>> -Stefan
>>>>>
>>>>>>
>>>>>> The number of people running into these (subtle) issues with these=
 stable
>>>>>> kernels seems to be steadily increasing.
>>>>>>
>>>>>> --
>>>>>> Sander
>>>>>>
>>>>>>> Jiang Liu (3):
>>>>>>>   xen/pci: Kill function xen_setup_acpi_sci()
>>>>>>>   xen/irq, ACPI: Fix regression in xen PCI passthrough caused by
>>>>>>>     cffe0a2b5a34
>>>>>>>   xen/irq: Override ACPI IRQ management callback __acpi_unregiste=
r_gsi
>>>>>>
>>>>>>>  arch/x86/include/asm/acpi.h |    1 +
>>>>>>>  arch/x86/kernel/acpi/boot.c |   26 +++++++++++------------
>>>>>>>  arch/x86/pci/xen.c          |   49 ++---------------------------=
--------------
>>>>>>>  drivers/acpi/pci_irq.c      |    1 -
>>>>>>>  4 files changed, 16 insertions(+), 61 deletions(-)
>>>>>>
>>>>>>
>>>>>
>>>
>>>
>=20
>=20
>=20



--pEoEOn1BWJ2Fn5iiB172D66Ih393i6lQM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU2ggoAAoJEOhnXe7L7s6j6G4P/25iTLwQmG/LpLdq1ug4L8qH
/q+lgXd7U00ObdlDdES9/Z+gD1HVenKWRLvWrav3g3+saBeAmq0ZP2TFQ26THQJT
40y2aQcVzLiiXuSb1TeTNBx85qdwfehxaAym2y2dp2JLPbJ0ndW86cKxUeLNnnIY
w73gumulBWh3wFYKqqLH0SJlrYoawC2/hzWE+qG7ysRs6xcmCLx5bt0gC/TVNTI5
WNyxyq7SkGeP0XFGD8AU9mtD6MMBmDDPDs0Pkhtaik3i9FtOiJcWuSz9H4PemrOk
PFMS0SKll5dncP3T/+ZswgwJl9cnFzAOstoRw7C6Zwme++At6PGmedqsh/rX/a3A
m/t7BARs5NMgtrfpbAuSeaBkxvhRNk7/MwGw81JsoHrAloleRJPipzkfhIh5o/zt
PxRVj3FIveSWVOaIvKBesk5ETayatXKJyZE6KqD63NjusxlpH/S+5/Htygkx0tPY
kCjzoImdFPgXsfKSipZD14okjcwBR/AkUd3WxN5KyptMzHlzsZRYMU5VNbIpua0Y
iqUaEHDjTDpO254AV4hlzWxaZ70TqXYeISQVRu9x6XSoR5XiX6y0NCXReD5BQFDe
tVTtp6ecedLeGikUSQ+g6wrOT2NifE2j9YejZlHuWSxOJXu7aBo5whvpYZOuLDUD
GkxyHi+2ekWq12kA7N8I
=+HQe
-----END PGP SIGNATURE-----

--pEoEOn1BWJ2Fn5iiB172D66Ih393i6lQM--
