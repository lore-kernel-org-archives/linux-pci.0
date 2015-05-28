Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from serverkommune.de ([176.9.61.43]:57657 "EHLO
	smtp.serverkommune.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbbE1J3x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2015 05:29:53 -0400
Message-ID: <5566DE4F.5080306@lastlog.de>
Date: Thu, 28 May 2015 11:22:23 +0200
From: Joachim Schiele <js@lastlog.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: linux-pci@vger.kernel.org
Subject: Re: lenovo T530+Nvida GTX 660 TI eGPU via PE4H
References: <mebuq3$mqo$1@ger.gmane.org>	 <CAErSpo4AS0LRas_nYsp3ZL=4wx=Avtq_mX_W_ZcEMUf2hkDm6Q@mail.gmail.com>	 <mecob7$pof$1@ger.gmane.org> <mjqftk$jp4$1@ger.gmane.org> <1432787230.5794.9.camel@redhat.com>
In-Reply-To: <1432787230.5794.9.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7Io4WsslSBQALIkCfBqVcc5kkGSxvgogi"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Io4WsslSBQALIkCfBqVcc5kkGSxvgogi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ah nice! thanks for reporting back. i'm looking forward to testing your
cmdline this weekend.

On 28.05.2015 06:27, Alex Williamson wrote:
> On Sat, 2015-05-23 at 20:12 +0200, Joachim Schiele wrote:
>> just wanted to report that i got the external graphics card to work wi=
th
>> native windows 7 and setup 1.x + pci compaction!
>>
>> see:
>>   http://blog.lastlog.de/posts/setup-1.x/
>>
>> i hope to get it also working in linux host using kvm+win7 as guest so=
on.
>=20
> I just setup something similar, using the EXP GDC "Beast" rather than
> the PE4H.  My Lenovo T530 only leaves 390MB for MMIO space and doesn't
> provide any 64bit space via ACPI.  I also need to fiddle with the
> switches to delay the card so the laptop doesn't hang during BIOS boot.=

> I pass pci=3Dnocrs,realloc on the kernel commandline in order to get th=
e
> GPU programmed.  I've only actually tested it with KVM/VFIO GPU
> assignment and it seems to work well, or at least as well as can be
> expected over a x1 5GT/s link.  Thanks,
>=20
> Alex
>=20
>> On 18.03.2015 21:48, Joachim Schiele wrote:
>>> hi,
>>>
>>> i've run with pci=3Drealloc two tests, the results are here (also the=

>>> dmesg) outputs:
>>>
>>> https://lastlog.de/wiki/index.php/T530%2BNvida_GTX_660_TI_eGPU_via_PE=
4H#debugging_using_pci.3Drealloc
>>>
>>> thanks in advance,
>>> joachim schiele
>>>
>>>
>>> On 18.03.2015 18:06, Bjorn Helgaas wrote:
>>>> [+cc Alex]
>>>>
>>>> Hi Joachim,
>>>>
>>>> Thanks a lot for the bug report.
>>>>
>>>> On Wed, Mar 18, 2015 at 8:32 AM, Joachim Schiele <js@lastlog.de> wro=
te:
>>>>> hi,
>>>>>
>>>>> =3D=3D=3D question =3D=3D=3D
>>>>> with the setup described below, i can't pass the graphics adapter i=
nto a
>>>>> KVM guest as described below.
>>>>>
>>>>> is the BAR stuff in the listing an error i wuld have to fix in orde=
r to
>>>>> get my eGPU running? if so, what could i do about it
>>>>
>>>> Yes.  If we can't assign resources to the BARs, we can't enable the
>>>> device.  If you boot with "pci=3Drealloc", Linux will try harder to
>>>> assign space (including moving other devices to make space if
>>>> necessary).
>>>>
>>>>> i've seen that the
>>>>> laptop will hang on boot if the eGPU is powered on system startup.
>>>>
>>>> It's possible the BIOS is hanging because it tried to assign space f=
or
>>>> the eGPU but failed.
>>>>
>>>>> i can
>>>>> see the adapter after hotplugging it using lspci and i never see an=

>>>>> image on the external display.
>>>>
>>>> The device will appear in lspci even if we can't assign space for it=
=2E
>>>> In that case the device would not work, even though it appears in
>>>> lspci.
>>>>
>>>> So please try "pci=3Drealloc".  Also, please collect a complete dmes=
g
>>>> log and "lspci -vv" output (with eGPU attached).  That will contain
>>>> the information needed to see whether it's possible even in principl=
e
>>>> to make this work.
>>>>
>>>>> my config is this:
>>>>> sudo qemu-system-x86_64 -enable-kvm \
>>>>> -m 8192 \
>>>>> -M q35 \
>>>>> -cpu host,kvm=3Doff \
>>>>> -smp 4,sockets=3D1,cores=3D4,threads=3D1 \
>>>>> -vga none \
>>>>> -vnc none \
>>>>> -device
>>>>> ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,chassi=
s=3D1,id=3Droot.1 \
>>>>> -device
>>>>> vfio-pci,host=3D04:00.0,bus=3Droot.1,addr=3D00.0,multifunction=3Don=
,x-vga=3Don \
>>>>> -device vfio-pci,host=3D04:00.1,bus=3Droot.1,addr=3D00.1 \
>>>>> -drive
>>>>> file=3D/home/joachim/en_windows_7_professional_x64_dvd_X15-65805.is=
o,id=3Disocd
>>>>> -device ide-cd,bus=3Dide.1,drive=3Disocd \
>>>>> -drive file=3D/var/lib/libvirt/images/win7.qcow2,format=3Dqcow2,id=3D=
hdd
>>>>> -device ide-hd,bus=3Dide.0,drive=3Dhdd \
>>>>> -bios /usr/share/seabios/bios.bin \
>>>>> -soundhw ac97
>>>>>
>>>>> =3D=3D=3D when hotplugging the eGPU =3D=3D=3D
>>>>> i want to use a Nvidia GTX 660 TI as an eGPU using PE4H and when i
>>>>> hotplug the ePCI adapter i get this log on a 3.18 ubuntu kernel:
>>>>>
>>>>> [  960.145002] vgaarb: device changed decodes:
>>>>> PCI:0000:00:02.0,olddecodes=3Dnone,decodes=3Dio+mem:owns=3Dnone
>>>>> [  966.574858] pci 0000:04:00.0: [10de:1183] type 00 class 0x030000=

>>>>> [  966.574892] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x00ffff=
ff]
>>>>> [  966.574921] pci 0000:04:00.0: reg 0x14: [mem 0x00000000-0x07ffff=
ff
>>>>> 64bit pref]
>>>>> [  966.574950] pci 0000:04:00.0: reg 0x1c: [mem 0x00000000-0x01ffff=
ff
>>>>> 64bit pref]
>>>>> [  966.574963] pci 0000:04:00.0: reg 0x24: [io  0x0000-0x007f]
>>>>> [  966.574974] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0007ff=
ff pref]
>>>>> [  966.575224] vgaarb: device added:
>>>>> PCI:0000:04:00.0,decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
>>>>> [  966.575227] vgaarb: device changed decodes:
>>>>> PCI:0000:00:02.0,olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone
>>>>> [  966.575327] pci 0000:04:00.1: [10de:0e0a] type 00 class 0x040300=

>>>>> [  966.575356] pci 0000:04:00.1: reg 0x10: [mem 0x00000000-0x00003f=
ff]
>>>>> [  966.998345] pci 0000:04:00.0: BAR 1: no space for [mem size
>>>>> 0x08000000 64bit pref]
>>>>> [  966.998350] pci 0000:04:00.0: BAR 1: failed to assign [mem size
>>>>> 0x08000000 64bit pref]
>>>>> [  966.998353] pci 0000:04:00.0: BAR 3: no space for [mem size
>>>>> 0x02000000 64bit pref]
>>>>> [  966.998355] pci 0000:04:00.0: BAR 3: failed to assign [mem size
>>>>> 0x02000000 64bit pref]
>>>>> [  966.998357] pci 0000:04:00.0: BAR 0: no space for [mem size 0x01=
000000]
>>>>> [  966.998358] pci 0000:04:00.0: BAR 0: failed to assign [mem size
>>>>> 0x01000000]
>>>>> [  966.998360] pci 0000:04:00.0: BAR 6: assigned [mem
>>>>> 0xf1400000-0xf147ffff pref]
>>>>> [  966.998363] pci 0000:04:00.1: BAR 0: assigned [mem 0xf1480000-0x=
f1483fff]
>>>>> [  966.998369] pci 0000:04:00.1: BAR 0: error updating (0xf1480000 =
!=3D
>>>>> 0xffffffff)
>>>>> [  966.998373] pci 0000:04:00.0: BAR 5: assigned [io  0x3000-0x307f=
]
>>>>> [  966.998379] pci 0000:04:00.0: BAR 5: error updating (0x003001 !=3D=

>>>>> 0xffffffff)
>>>>> [  966.998392] pcieport 0000:00:1c.2: Max Payload Size set to  128/=
 128
>>>>> (was  128), Max Read Rq  128
>>>>> [  966.998403] pci 0000:04:00.0: Max Payload Size set to 16384/ 256=
 (was
>>>>> 16384), Max Read Rq 16384
>>>>> [  966.998414] pci 0000:04:00.1: Max Payload Size set to 16384/ 256=
 (was
>>>>> 16384), Max Read Rq 16384
>>>>> [  966.998472] pci-stub 0000:04:00.0: claimed by stub
>>>>> [  966.998495] pci-stub 0000:04:00.1: claimed by stub
>>>>> [  967.099040] pcieport 0000:00:1c.2: Max Payload Size set to  128/=
 128
>>>>> (was  128), Max Read Rq  128
>>>>> [  967.099059] pci-stub 0000:04:00.0: Max Payload Size set to  128/=
 256
>>>>> (was  128), Max Read Rq  512
>>>>> [  967.099075] pci-stub 0000:04:00.1: Max Payload Size set to  128/=
 256
>>>>> (was  128), Max Read Rq  512
>>>>> [ 7735.938854] vgaarb: device changed decodes:
>>>>> PCI:0000:00:02.0,olddecodes=3Dnone,decodes=3Dio+mem:owns=3Dnone
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> more at:
>>>>>
>>>>> https://lastlog.de/wiki/index.php/T530%2BNvida_GTX_660_TI_eGPU_via_=
PE4H
>>>>>
>>>>> i derived the scripts i'm using from this guide:
>>>>> http://www.pugetsystems.com/labs/articles/Multiheaded-NVIDIA-Gaming=
-using-Ubuntu-14-04-KVM-585/
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-pci=
" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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


--7Io4WsslSBQALIkCfBqVcc5kkGSxvgogi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVZt5PAAoJEJhk1bLGrIdw1DMQAK0HiC9kHa27HYuH9gpvHW88
4XI61dl5TyTqwiq55Xvl7r3Yoa8nsUGA3CGRT7Gq9jSWIHIgzlmf6isPN6OuvkZe
0i8SwAcIhvXjCZ7BPljfdC6RIFg65XEwA5Nb+3LT/Gtxh1tZ7ZY1toQAExfRvJ2Q
Rk5Zxo6LU8e4SV4zCa75Hu7jEj2QN0vt28lNst+jBck1pL4fYT9aeuRIoxn3so8z
hXE7sbAp2gS4MCv/bQs10RNethk2AO8VgS40w7olW2RGffyOFUy9WUn/11euGkj1
An0Qrdp4zotm/PV0m2L0zpOA/bY6eLDRfZYectKHQ3D2/vYdVMzjhInOA21nAljy
vvHImEdZQUr9INJsAzWmoeQQnjamUr90NYW6c1zCRPJDOYG3FR/LzK+hNx78CumN
2pt1A3oPSoIGTJJG9ehnZUGNYOcJBOrVOtiwt9ciWocug1D9XlAO+t/WvCoupkHy
A3+LNK59iqasyIrVeHLY2i4cx+QcAW09EyKjeRKpwlAZKkpL15U1As/YNytHhi2d
OngUBkfqIG9UC0B+t4to8GZqw+yP6WjaZiRbWj+LDD9l7MeVgm4R5ntqOhJAsKvZ
3ASEe9bLD2t53HfKnEoXDKHvwNkCowrdkQLx27lcUF3vFpUggLqtlcfRNitHFqth
5NK+IK6xd1eGn3UNrQnE
=IJWu
-----END PGP SIGNATURE-----

--7Io4WsslSBQALIkCfBqVcc5kkGSxvgogi--
