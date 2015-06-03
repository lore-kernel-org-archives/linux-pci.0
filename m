Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from serverkommune.de ([176.9.61.43]:50393 "EHLO
	smtp.serverkommune.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbbFCOIO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2015 10:08:14 -0400
Message-ID: <556F0A46.3010604@lastlog.de>
Date: Wed, 03 Jun 2015 16:08:06 +0200
From: Joachim Schiele <js@lastlog.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: linux-pci@vger.kernel.org
Subject: Re: lenovo T530+Nvida GTX 660 TI eGPU via PE4H
References: <mebuq3$mqo$1@ger.gmane.org>		 <CAErSpo4AS0LRas_nYsp3ZL=4wx=Avtq_mX_W_ZcEMUf2hkDm6Q@mail.gmail.com>		 <mecob7$pof$1@ger.gmane.org> <mjqftk$jp4$1@ger.gmane.org>	 <1432787230.5794.9.camel@redhat.com> <mkn0aa$ph8$1@ger.gmane.org> <1433339727.3510.23.camel@redhat.com>
In-Reply-To: <1433339727.3510.23.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="23srsBQmUBnScVNjbwHhxWn2dIVSo23Vq"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--23srsBQmUBnScVNjbwHhxWn2dIVSo23Vq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.06.2015 15:55, Alex Williamson wrote:
> On Wed, 2015-06-03 at 15:43 +0200, Joachim Schiele wrote:
>> On 28.05.2015 06:27, Alex Williamson wrote:
>>> On Sat, 2015-05-23 at 20:12 +0200, Joachim Schiele wrote:
>>>> just wanted to report that i got the external graphics card to work =
with
>>>> native windows 7 and setup 1.x + pci compaction!
>>>>
>>>> see:
>>>>   http://blog.lastlog.de/posts/setup-1.x/
>>>>
>>>> i hope to get it also working in linux host using kvm+win7 as guest =
soon.
>>>
>>> I just setup something similar, using the EXP GDC "Beast" rather than=

>>> the PE4H.  My Lenovo T530 only leaves 390MB for MMIO space and doesn'=
t
>>> provide any 64bit space via ACPI.  I also need to fiddle with the
>>> switches to delay the card so the laptop doesn't hang during BIOS boo=
t.
>>
>> are you using the 'nvidia gtx 660 ti' or 'nvidia gtx 660' or something=
 else?
>>
>> what i'm curious about is why i get the 'nvidia gtx 660' working but n=
ot
>> the 'nvidia gtx 660 ti'. both have 2gb of ram.
>>
>> maybe there is some white/blacklisting of pcie IDs in the kernel
>> somewhere and the 'nvidia gtx 660 ti' didn't make it there yet?
>>
>> all i get to see is stuff like:
>>
>> (quote from an earlier attempt to get the 'nvidia gtx 660 ti' to work)=
:
>> [  966.575224] vgaarb: device added:
>> PCI:0000:04:00.0,decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
>> [  966.575227] vgaarb: device changed decodes:
>> PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone
>> [  966.575327] pci 0000:04:00.1: [10de:0e0a] type 00 class 0x040300
>> [  966.575356] pci 0000:04:00.1: reg 0x10: [mem 0x00000000-0x00003fff]=

>> [  966.998345] pci 0000:04:00.0: BAR 1: no space for [mem size
>> 0x08000000 64bit pref]
>> [  966.998350] pci 0000:04:00.0: BAR 1: failed to assign [mem size
>> 0x08000000 64bit pref]
>> [  966.998353] pci 0000:04:00.0: BAR 3: no space for [mem size
>> 0x02000000 64bit pref]
>> [  966.998355] pci 0000:04:00.0: BAR 3: failed to assign [mem size
>> 0x02000000 64bit pref]
>> [  966.998357] pci 0000:04:00.0: BAR 0: no space for [mem size 0x01000=
000]
>> [  966.998358] pci 0000:04:00.0: BAR 0: failed to assign [mem size
>> 0x01000000]
>> [  966.998360] pci 0000:04:00.0: BAR 6: assigned [mem
>> 0xf1400000-0xf147ffff pref]
>> [  966.998363] pci 0000:04:00.1: BAR 0: assigned [mem 0xf1480000-0xf14=
83fff]
>> [  966.998369] pci 0000:04:00.1: BAR 0: error updating (0xf1480000 !=3D=

>> 0xffffffff)
>> [  966.998373] pci 0000:04:00.0: BAR 5: assigned [io  0x3000-0x307f]
>> [  966.998379] pci 0000:04:00.0: BAR 5: error updating (0x003001 !=3D
>> 0xffffffff)
>>
>>
>>> I pass pci=3Dnocrs,realloc on the kernel commandline in order to get =
the
>>> GPU programmed.  I've only actually tested it with KVM/VFIO GPU
>>> assignment and it seems to work well, or at least as well as can be
>>> expected over a x1 5GT/s link.  Thanks,
>>
>> i've been playing with pci=3Dnocrs,realloc a lot lately but that didn'=
t
>> make it work.
>=20
> You need to boot with the card attached, perhaps even stalling at the
> grub boot loader to make sure you've passed the delay configured by the=

> onboard switches that hide the card past bios boot.  Your dmesg
> timestamps above seem to imply you're trying to hot-plug the card later=
,
> but there's not sufficient space for it.
>=20
> I tested with a lowly GT 635,=20

good to know

> but I guarantee there are no
> white/blacklist in the kernel for basic resource assignment of devices.=

> Thanks,

ah fine. then the problem is probably card/bios specific


>>>> On 18.03.2015 21:48, Joachim Schiele wrote:
>>>>> hi,
>>>>>
>>>>> i've run with pci=3Drealloc two tests, the results are here (also t=
he
>>>>> dmesg) outputs:
>>>>>
>>>>> https://lastlog.de/wiki/index.php/T530%2BNvida_GTX_660_TI_eGPU_via_=
PE4H#debugging_using_pci.3Drealloc
>>>>>
>>>>> thanks in advance,
>>>>> joachim schiele
>>>>>
>>>>>
>>>>> On 18.03.2015 18:06, Bjorn Helgaas wrote:
>>>>>> [+cc Alex]
>>>>>>
>>>>>> Hi Joachim,
>>>>>>
>>>>>> Thanks a lot for the bug report.
>>>>>>
>>>>>> On Wed, Mar 18, 2015 at 8:32 AM, Joachim Schiele <js@lastlog.de> w=
rote:
>>>>>>> hi,
>>>>>>>
>>>>>>> =3D=3D=3D question =3D=3D=3D
>>>>>>> with the setup described below, i can't pass the graphics adapter=
 into a
>>>>>>> KVM guest as described below.
>>>>>>>
>>>>>>> is the BAR stuff in the listing an error i wuld have to fix in or=
der to
>>>>>>> get my eGPU running? if so, what could i do about it
>>>>>>
>>>>>> Yes.  If we can't assign resources to the BARs, we can't enable th=
e
>>>>>> device.  If you boot with "pci=3Drealloc", Linux will try harder t=
o
>>>>>> assign space (including moving other devices to make space if
>>>>>> necessary).
>>>>>>
>>>>>>> i've seen that the
>>>>>>> laptop will hang on boot if the eGPU is powered on system startup=
=2E
>>>>>>
>>>>>> It's possible the BIOS is hanging because it tried to assign space=
 for
>>>>>> the eGPU but failed.
>>>>>>
>>>>>>> i can
>>>>>>> see the adapter after hotplugging it using lspci and i never see =
an
>>>>>>> image on the external display.
>>>>>>
>>>>>> The device will appear in lspci even if we can't assign space for =
it.
>>>>>> In that case the device would not work, even though it appears in
>>>>>> lspci.
>>>>>>
>>>>>> So please try "pci=3Drealloc".  Also, please collect a complete dm=
esg
>>>>>> log and "lspci -vv" output (with eGPU attached).  That will contai=
n
>>>>>> the information needed to see whether it's possible even in princi=
ple
>>>>>> to make this work.
>>>>>>
>>>>>>> my config is this:
>>>>>>> sudo qemu-system-x86_64 -enable-kvm \
>>>>>>> -m 8192 \
>>>>>>> -M q35 \
>>>>>>> -cpu host,kvm=3Doff \
>>>>>>> -smp 4,sockets=3D1,cores=3D4,threads=3D1 \
>>>>>>> -vga none \
>>>>>>> -vnc none \
>>>>>>> -device
>>>>>>> ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,chas=
sis=3D1,id=3Droot.1 \
>>>>>>> -device
>>>>>>> vfio-pci,host=3D04:00.0,bus=3Droot.1,addr=3D00.0,multifunction=3D=
on,x-vga=3Don \
>>>>>>> -device vfio-pci,host=3D04:00.1,bus=3Droot.1,addr=3D00.1 \
>>>>>>> -drive
>>>>>>> file=3D/home/joachim/en_windows_7_professional_x64_dvd_X15-65805.=
iso,id=3Disocd
>>>>>>> -device ide-cd,bus=3Dide.1,drive=3Disocd \
>>>>>>> -drive file=3D/var/lib/libvirt/images/win7.qcow2,format=3Dqcow2,i=
d=3Dhdd
>>>>>>> -device ide-hd,bus=3Dide.0,drive=3Dhdd \
>>>>>>> -bios /usr/share/seabios/bios.bin \
>>>>>>> -soundhw ac97
>>>>>>>
>>>>>>> =3D=3D=3D when hotplugging the eGPU =3D=3D=3D
>>>>>>> i want to use a Nvidia GTX 660 TI as an eGPU using PE4H and when =
i
>>>>>>> hotplug the ePCI adapter i get this log on a 3.18 ubuntu kernel:
>>>>>>>
>>>>>>> [  960.145002] vgaarb: device changed decodes:
>>>>>>> PCI:0000:00:02.0,olddecodes=3Dnone,decodes=3Dio+mem:owns=3Dnone
>>>>>>> [  966.574858] pci 0000:04:00.0: [10de:1183] type 00 class 0x0300=
00
>>>>>>> [  966.574892] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x00ff=
ffff]
>>>>>>> [  966.574921] pci 0000:04:00.0: reg 0x14: [mem 0x00000000-0x07ff=
ffff
>>>>>>> 64bit pref]
>>>>>>> [  966.574950] pci 0000:04:00.0: reg 0x1c: [mem 0x00000000-0x01ff=
ffff
>>>>>>> 64bit pref]
>>>>>>> [  966.574963] pci 0000:04:00.0: reg 0x24: [io  0x0000-0x007f]
>>>>>>> [  966.574974] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0007=
ffff pref]
>>>>>>> [  966.575224] vgaarb: device added:
>>>>>>> PCI:0000:04:00.0,decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
>>>>>>> [  966.575227] vgaarb: device changed decodes:
>>>>>>> PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone
>>>>>>> [  966.575327] pci 0000:04:00.1: [10de:0e0a] type 00 class 0x0403=
00
>>>>>>> [  966.575356] pci 0000:04:00.1: reg 0x10: [mem 0x00000000-0x0000=
3fff]
>>>>>>> [  966.998345] pci 0000:04:00.0: BAR 1: no space for [mem size
>>>>>>> 0x08000000 64bit pref]
>>>>>>> [  966.998350] pci 0000:04:00.0: BAR 1: failed to assign [mem siz=
e
>>>>>>> 0x08000000 64bit pref]
>>>>>>> [  966.998353] pci 0000:04:00.0: BAR 3: no space for [mem size
>>>>>>> 0x02000000 64bit pref]
>>>>>>> [  966.998355] pci 0000:04:00.0: BAR 3: failed to assign [mem siz=
e
>>>>>>> 0x02000000 64bit pref]
>>>>>>> [  966.998357] pci 0000:04:00.0: BAR 0: no space for [mem size 0x=
01000000]
>>>>>>> [  966.998358] pci 0000:04:00.0: BAR 0: failed to assign [mem siz=
e
>>>>>>> 0x01000000]
>>>>>>> [  966.998360] pci 0000:04:00.0: BAR 6: assigned [mem
>>>>>>> 0xf1400000-0xf147ffff pref]
>>>>>>> [  966.998363] pci 0000:04:00.1: BAR 0: assigned [mem 0xf1480000-=
0xf1483fff]
>>>>>>> [  966.998369] pci 0000:04:00.1: BAR 0: error updating (0xf148000=
0 !=3D
>>>>>>> 0xffffffff)
>>>>>>> [  966.998373] pci 0000:04:00.0: BAR 5: assigned [io  0x3000-0x30=
7f]
>>>>>>> [  966.998379] pci 0000:04:00.0: BAR 5: error updating (0x003001 =
!=3D
>>>>>>> 0xffffffff)
>>>>>>> [  966.998392] pcieport 0000:00:1c.2: Max Payload Size set to  12=
8/ 128
>>>>>>> (was  128), Max Read Rq  128
>>>>>>> [  966.998403] pci 0000:04:00.0: Max Payload Size set to 16384/ 2=
56 (was
>>>>>>> 16384), Max Read Rq 16384
>>>>>>> [  966.998414] pci 0000:04:00.1: Max Payload Size set to 16384/ 2=
56 (was
>>>>>>> 16384), Max Read Rq 16384
>>>>>>> [  966.998472] pci-stub 0000:04:00.0: claimed by stub
>>>>>>> [  966.998495] pci-stub 0000:04:00.1: claimed by stub
>>>>>>> [  967.099040] pcieport 0000:00:1c.2: Max Payload Size set to  12=
8/ 128
>>>>>>> (was  128), Max Read Rq  128
>>>>>>> [  967.099059] pci-stub 0000:04:00.0: Max Payload Size set to  12=
8/ 256
>>>>>>> (was  128), Max Read Rq  512
>>>>>>> [  967.099075] pci-stub 0000:04:00.1: Max Payload Size set to  12=
8/ 256
>>>>>>> (was  128), Max Read Rq  512
>>>>>>> [ 7735.938854] vgaarb: device changed decodes:
>>>>>>> PCI:0000:00:02.0,olddecodes=3Dnone,decodes=3Dio+mem:owns=3Dnone
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> more at:
>>>>>>>
>>>>>>> https://lastlog.de/wiki/index.php/T530%2BNvida_GTX_660_TI_eGPU_vi=
a_PE4H
>>>>>>>
>>>>>>> i derived the scripts i'm using from this guide:
>>>>>>> http://www.pugetsystems.com/labs/articles/Multiheaded-NVIDIA-Gami=
ng-using-Ubuntu-14-04-KVM-585/
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-p=
ci" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>>
>>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-pci"=
 in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" i=
n
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20


--=20
Joachim Schiele

blog: http://blog.lastlog.de
wiki: http://lastlog.de
jabber: josh@jabber.ccc.de
GPG: C6AC8770


--23srsBQmUBnScVNjbwHhxWn2dIVSo23Vq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVbwpGAAoJEJhk1bLGrIdwYZsQAJ57fEnxz2pYnGY44YOVjC0o
K0og/x5MU9g+ih3Z3cCzOabCt1RLJ86TYHlinzkTJHUJeeS7Pn0Hsab2dvzQoHis
bFMpgrhzuj7gRVxvMxFTIjNzzp1yH+gp6xjuLdhHKpApzhOeNXdCqpkfSFiQ8F/F
t1Wke59g+aSM0gf530BfBiyy+IYVKkDvn+g14+jEoyj6ZhF8jDEOpQ4dT219oACq
i2Q6ATMU2Q8gkfgtJctJWbwfYuAUQuSyy3BxVsQqjQhNrbYD0Ez+vihBws3ruSEx
NsOfEa2FAg68SUNO+na2z9tbBt96/budHBhMLh277EiJ3tA8Ez/pY4K0Om+/aycj
ZTi1L59UVu3V8xGCtcPHbXAzZ32Y3FNr19cSsEwqrO22ZzIKduqYnWdCr7KbI6pe
yRk9szLiEDmpvriTCMbcjRHrTKrpfp32r45pl99H/7OrfAezyp8kElwc86Qk86lZ
tQjbPAXvPXoB+48YkIKRhw4po355o8XR8huePEJR1ElczW12D+ZOzDpk63C5vo4F
Q0ysWh4zpHQFMX4cj2/xnjFZeYojqLRuLb08Jv++q4Y9te1NAYCY6CATKdePcIT6
YOXnetPuWlQmlXbHmN1qAOVBsu7Z0MHmgjAPHfjdRgIV3mcesMHvhrAuX+Vwyf0v
1a+8h2FuLJrzFwlUc4/1
=E8Pg
-----END PGP SIGNATURE-----

--23srsBQmUBnScVNjbwHhxWn2dIVSo23Vq--
