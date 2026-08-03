Received: from a3-29.smtp-out.eu-west-1.amazonses.com (a3-29.smtp-out.eu-west-1.amazonses.com [54.240.3.29])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7DC42BC46
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.3.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780127; cv=none; b=RXfF6N8BnSOkNFwWW0ieXM7UGmJIqgfGO8cNmir67Pmld7J9Cmm4NsRgBsdAj1jG5gtGMmzHSwIbW7itBV6WW+WTJEfCQYpt0THCbLJ5SPo3B2WBv4MliqAugFmbGa8gawfGglz0/wioBr1UlYo9K1Zzn+4iR+YSgx86ave/d5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780127; c=relaxed/simple;
	bh=KgterPoxw9dAEPSlS2JU1vS0yxNirL+H1I734yneVuM=;
	h=In-Reply-To:From:To:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=MYcWhWP8isaBxiRTCbaVsNIbVUb5y5jbCDi3ozk/RAsZ611apDdcjrjhAvPXqHTxaBnuEWgU2KLofch4njsTHrV9HqERMv9jmvdqm95httCHODVRadk0THmonxELs7sCHD6CdgGA008b+KJ/MSDX0jRFlzVTy+4bvWm9rsIlwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=choiharam.com; spf=pass smtp.mailfrom=send.choiharam.com; dkim=pass (1024-bit key) header.d=choiharam.com header.i=@choiharam.com header.b=DM4Z1VdD; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ExPvSmHc; arc=none smtp.client-ip=54.240.3.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=choiharam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.choiharam.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=choiharam.com header.i=@choiharam.com header.b="DM4Z1VdD";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ExPvSmHc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=choiharam.com; t=1785780122;
	h=In-Reply-To:From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=KgterPoxw9dAEPSlS2JU1vS0yxNirL+H1I734yneVuM=;
	b=DM4Z1VdDKOmK15+6PRvCb0x7hH7veeJxkSMh7oG1tFksqf0sst+UTXSz4lco01+F
	wF9fdVXGD8B/Gg2/kNNK239VR1ItjNWxoVIfPCO3ZWpwrOya0RL2o/5Llmj0bN2DjPJ
	SO0eF1jeTpIdJPhR8IwhdyNRQLETaQYUmzazwTJg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1785780122;
	h=In-Reply-To:From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=KgterPoxw9dAEPSlS2JU1vS0yxNirL+H1I734yneVuM=;
	b=ExPvSmHc9Swpf5Fa1i04xy9tXlb9WDPTb9iduavuoFd72TcL723O4lIRPiuYkvST
	vsCfJg4sgiDRRQoIc91X3qER4GSZXxlcLLiP8FVcLF4kLmCWYy0BAZek3aALnnAZwKY
	iXlu2jJXcArxe3rxiBnk44o4tr0wEHzpbsB9cp+Y=
X-Forwarded-Encrypted: i=1;
 AHgh+RrVBRnkJR0Tdn3LTgm6K9wvUcvLvtxmfutV2IXAajoivs01NMCqsIvrJqy/VFK30UPCYVz+6F5vYFw=@vger.kernel.org
X-Gm-Message-State:
 AOJu0YzmzvwCk6qu+Tdol8U7wp+zeKKE8CADhE2TndRF8LoRJtda9Bt5
 cSdhG1tgOqqQFHGCNTo36IFx/MgRfOLjYS5VKgOv61miNRSgPwnZhIm0r1iW4tpKfuGRQ7ltucG
 ROAYnj3CBrTRYY2/vWBgHlS4BnFyrTmw=
X-Received: by 2002:a05:600c:3549:b0:498:14d3:562f with SMTP id
 5b1f17b1804b1-49814d35701mr160647975e9.15.1785780119555; Mon, 03 Aug 2026
 11:01:59 -0700 (PDT)
In-Reply-To:
 <CAErSpo6ULQzMitKRWRkjigWA551bm-6FBLQsGtw6=+=jZ-wkxQ@mail.gmail.com>
X-Gmail-Original-Message-ID:
 <CAAKWd2_MZSC=A2EHuEw3=eECr1QfaqrhYawW=njt5muk=5sA_A@mail.gmail.com>
X-Gm-Features:
 AUfX_myHWnoiQxKxHUkd7syIXoUUP7irUsx5LwDQOfZEpr5y6qZ9HtnSUuGRlNg
From: Haram Choi <haram@choiharam.com>
To: linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] 7.1: apple-gmux backlight dead on MacBookPro13,3
 - PCI bridge left with VGA enable set and VGA 16-bit decode cleared,
 aliasing legacy VGA I/O over the gmux ports
Message-ID: <0102019fc8ca30ae-e841e7ee-63d5-4659-ae38-0a70bf451ea1-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 3 Aug 2026 18:02:01 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.EpC9yjino5Os4TD+7+raLa11nzZLZvHiwV019QcZvg/F5tRE61/OoDvSLCzTswf7FgUYGClMifYLSHlPtef6pX2oIiUiWIw7D3iBfeLsACYDdVP2XYMjQqpq9pquO8y/Ll8CCsU3paAfc5BSRIugOpXQgvi1qP9naMr/nZxXEn4=:1.eu-west-1.mn4CV6NdxyxonKM+/Hjvd874GJxbRQyaS3Zo0NapPlc=:AmazonSES
X-SES-Outgoing: 2026.08.03-54.240.3.29

Resending to linux-pci as requested.

Since the first mail I have narrowed =
this down further, and in doing
so found that my original description of =
the root cause was partly
wrong. The corrected analysis is below. The short=
 version:

  - The regression is that PCI_BRIDGE_CTL_VGA (bit 3) on the =
root port
00:01.0 is left SET after the VGA arbiter has settled with
decodes=3Dnone for both VGA devices. On 6.12 and 6.16 it ends CLEAR.

  - The 16-bit decode bit (bit 4) is not the cause. The kernel never
writes it. It only determines whether a bridge that is already
forwarding legacy VGA does so with 10 or 16 address bits.

  - The subject line therefore misattributes the cause. The aliasing
is a consequence, not the trigger. I have kept the subject unchanged
so the thread stays intact.

I have a v7.1.5 build with instrumentation in =
drivers/pci/pci.c and
drivers/pci/vgaarb.c ready to boot; I will follow up =
in this thread
with the traces.

## Summary

Since Linux 7.1 the backlight =
on a MacBookPro13,3 (15" 2016, Touch
Bar) cannot be controlled at all. =
apple_gmux still probes successfully
during boot, but the VGA arbiter =
leaves PCI_BRIDGE_CTL_VGA set on the
root port 00:01.0. With legacy VGA =
forwarding enabled and only 10
address bits decoded, 0x3c0-0x3df aliases =
onto 0x7c0-0x7df, which is
exactly where the gmux indexed protocol =
registers live. The bridge
claims those cycles and forwards them to the =
dGPU. Every gmux read
returns 0xff and every gmux write is swallowed.

- Last known good: 6.16.10 (Arch linux 6.16.10.arch1-1)
- Also good:       6.12.51 (Arch linux-lts 6.12.51-1)
- Bad:             7.1.5   (Arch linux 7.1.5.arch1-2)

## Hardware

DMI: Apple Inc. MacBookPro13,3/Mac-A5C67F76ED83108C,
     BIOS 529.120.1.0.0 03/14/2024

00:01.0 PCI bridge [0604]: Intel =
6th-10th Gen Core Processor PCIe
        Controller (x16) [8086:1901] (rev =
07)
00:02.0 VGA compatible controller [0300]: Intel Skylake-H GT2
        [HD Graphics 530] [8086:191b] (rev 06)   -> i915
01:00.0 VGA compatible controller [0300]: AMD Baffin
        [Radeon Pro 455] [1002:67ef] (rev c7)    -> amdgpu

gmux: PNP HID APP000B, "Found gmux version 4.0.29 [indexed]"
      PNP resource 0x700-0x7fe

Note that 00:02.0 (i915) is not behind =
00:01.0, but 01:00.0 (amdgpu) is.

## Symptom

  $ cat =
/sys/class/backlight/gmux_backlight/actual_brightness
  16777215

16777215 is 0x00ffffff, which is GMUX_BRIGHTNESS_MASK applied to an
all-ones I/O read. Writes to brightness have no effect. brightnessctl,
the Touch Bar brightness keys and the desktop brightness slider all
fail, because all three go through this single backlight device.

## Root cause

PCI_BRIDGE_CONTROL (offset 0x3e) of 00:01.0, read after boot=
 has settled:

  6.12.51-lts   : 0x0012   SERR | VGA_16BIT,  VGA enable =
CLEAR  -> works
  7.1.5-arch1-2 : 0x000a   SERR | VGA enable, VGA_16BIT =
CLEAR   -> broken

I originally read this as "VGA_16BIT was cleared". That =
is not what
matters. I tested all four combinations of bit 3 and bit 4 at =
runtime
on 7.1.5 via setpci, reading actual_brightness after each change:

  bit3 VGA_en   bit4 16BIT   value    actual_brightness   result
  -----------   ----------   ------   -----------------   ------
       1             1       0x001a          808          works
       0             1       0x0012          808          works
       1             0       0x000a       16777215        BROKEN
       0             0       0x0002          808          works

Only the single combination "VGA enable set, 16-bit decode clear"
breaks gmux, which is exactly what the PCI-to-PCI Bridge specification
predicts: bit 4 only has meaning while bit 3 is set. So the regression
is that bit 3 is left set, not that bit 4 is clear.

This also matches the code. PCI_BRIDGE_CTL_VGA_16BIT does not appear
anywhere in the v7.1.5 tree; it is not even defined in
include/uapi/linux/pci_regs.h, where the bit list goes straight from
PCI_BRIDGE_CTL_VGA (0x08) to PCI_BRIDGE_CTL_MASTER_ABORT (0x20). The
kernel never reads or writes bit 4, so bit 4 cannot be the regression.

PCI_BRIDGE_CTL_VGA is written in exactly one place,
pci_set_vga_state() in drivers/pci/pci.c, which has exactly two
callers, both in drivers/pci/vgaarb.c.

With bit 3 set and bit 4 clear, =
address bits [15:10] are ignored for
legacy VGA I/O, so:

  0x3b0-0x3bb  ->  0x7b0-0x7bb
  0x3c0-0x3df  ->  0x7c0-0x7df

apple-gmux uses these ports on this machine:

  GMUX_PORT_READ         =
0x7d0     (aliases 0x3d0)
  GMUX_PORT_WRITE        0x7d4     (aliases =
0x3d4)
  index magic sequence   0x7cc     (aliases 0x3cc)
                         0x7cd     (aliases 0x3cd)
                        =
 0x7ce     (aliases 0x3ce)

All of them fall inside the aliased window, so =
the bridge steals them.

## Direct verification via /dev/port on 7.1.5

Before:

  inb(0x7cc) =3D ff   inb(0x7cd) =3D ff   inb(0x7ce) =3D ff
  inb(0x7d0) =3D ff   inb(0x7d4) =3D ff

Clearing VGA enable, or setting =
16-bit decode, either one is sufficient:

  # setpci -s 00:01.0 =
BRIDGE_CONTROL=3D0000:0008    # clear bit 3
  or
  # setpci -s 00:01.0 =
BRIDGE_CONTROL=3D0010:0010    # set bit 4

After (gmux_is_indexed() magic =
sequence, write 0xaa/0x55/0x00 then read back):

  outb(0x7cc, 0xaa); =
outb(0x7cd, 0x55); outb(0x7ce, 0x00)
  inb(0x7cc) =3D aa   inb(0x7cd) =3D =
55        -> gmux responds

Then:

  # modprobe -r apple_gmux && modprobe =
apple_gmux
  apple_gmux: Found gmux version 4.0.29 [indexed]

  # cat /sys/class/backlight/gmux_backlight/actual_brightness
  118

118 is the value the panel had actually been stuck at the whole time,
which confirms that no write had ever reached the hardware. Writing
100 / 400 / 700 / 1023 afterwards changes the panel brightness,
visually confirmed.

## Boot timeline

7.1.5-arch1-2 (broken):

  [  7.947] pci 0000:00:02.0: vgaarb: setting as boot VGA device
  [  7.947] pci 0000:00:02.0: vgaarb: VGA device added:
                               decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
  [  7.947] pci 0000:01:00.0: vgaarb: setting as boot VGA device
                               (overriding previous)
  [  7.948] pci 0000:01:00.0: vgaarb: VGA device added:
                               decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
  [  8.005] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
  [  9.494] apple_gmux: Found gmux version 4.0.29 [indexed]
  [ 10.059] i915 0000:00:02.0: vgaarb: VGA decodes changed:
                               olddecodes=3Dio+mem,decodes=3Dio:owns=3Dio+m=
em
  [ 11.150] i915 0000:00:02.0: vgaarb: VGA decodes changed:
                               olddecodes=3Dio,decodes=3Dnone:owns=3Dio+mem
  [ 11.150] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
                               olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dno=
ne

6.16.10-arch1-1 (good):

  [  6.785] pci 0000:00:02.0: vgaarb: VGA =
device added:
                               decodes=3Dio+mem,owns=3Dio+mem=
,locks=3Dnone
  [  6.785] pci 0000:01:00.0: vgaarb: setting as boot VGA =
device
                               (overriding previous)
  [  6.785] pci 0000:01:00.0: vgaarb: VGA device added:
                               decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
  [  6.839] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
  [  8.339] apple_gmux: Found gmux version 4.0.29 [indexed]
  [  8.348] i915 0000:00:02.0: vgaarb: VGA decodes changed:
                               olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio=
+mem
  [  8.349] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
                               olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dno=
ne

6.12.51-lts (good):

  [  8.480] apple_gmux: Found gmux version 4.0.29 =
[indexed]
  [  8.487] i915 0000:00:02.0: vgaarb: VGA decodes changed:
                               olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio=
+mem
  [  8.489] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed:
                               olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dno=
ne

Two differences stand out:

1. On 7.1.5, 00:02.0 gets "setting as boot =
VGA device". On 6.16 it
does not, even though 01:00.0 still says =
"(overriding previous)" in
both.

2. On 6.12 and 6.16 the i915 legacy =
decode goes io+mem -> none in a
single step. On 7.1.5 it goes io+mem -> io,=
 and then about 1.1 seconds
later io -> none.

The final arbiter state is =
decodes=3Dnone for both devices on all three
kernels, yet only on 7.1.5 =
does the bridge end up with
PCI_BRIDGE_CTL_VGA set.

## Suspected commit

Of the commits you listed for v6.16..v7.1 in drivers/pci/vgaarb.c, the
one that best fits is:

  94555ea9a048 ("PCI/VGA: Pass errors from =
pci_set_vga_state() up")

pci_set_vga_state() writes PCI_BRIDGE_CONTROL on =
each bridge in the
path and only afterwards reads the register back, =
returning -EIO if
VGA enable did not stick. It returns from inside the walk=
, so bridges
further up the path are left unprocessed and the ones already =
written
stay written.

That error used to be discarded by __vga_tryget(). =
After 94555ea9a048
it aborts the function:

    err =3D =
pci_set_vga_state(vgadev->pdev, true, pci_bits, flags);
    if (err)
        return ERR_PTR(err);

    vgadev->owns |=3D wants;          /* now =
skipped on error */

and likewise for the conflict path, where =
"conflict->owns &=3D ~match"
is skipped. Either way the arbiter's =
bookkeeping stops matching what
was actually programmed into the bridge, so=
 the later transition to
decodes=3Dnone never issues the matching =
pci_set_vga_state(..., false,
...) that would clear PCI_BRIDGE_CTL_VGA. The=
 bridge stays enabled.

The two-step i915 decode transition on 7.1.5 is =
consistent with an
operation that aborted partway and was retried.

Two other candidates I have not excluded, both of which change which
device is selected as the boot VGA device and could explain difference
(1) above:

  337bf13aa9dd ("PCI/VGA: Replace vga_is_firmware_default() =
with a
                 screen info check")
  fd390ff14451 ("PCI/VGA: Don't=
 assume the only VGA device on a system
                 is boot_vga")

I believe 2a93c9851b2b ("PCI/VGA: Pass vga_get_uninterruptible()
errors to userspace") can be excluded, since it only changes the
/dev/vga_arbiter write path, which is not used on this KMS-only
system.

## Workaround

  # setpci -s 00:01.0 BRIDGE_CONTROL=3D0000:0008
  # modprobe -r apple_gmux && modprobe apple_gmux

Clearing VGA enable is =
enough, and is what 6.12 and 6.16 end up with
anyway. This machine is KMS =
only and "amdgpu: vgaarb: deactivate vga
console" has already happened, so =
nothing depends on legacy VGA
forwarding here.

(I had previously been =
using BRIDGE_CONTROL=3D0010:0010, setting 16-bit
decode. That also works, =
but it masks the symptom rather than
restoring the pre-7.1 state.)

## Open question

I cannot explain why bit 4 reads as 1 on 6.12 and 0 on 7.=
1.5, given
that the kernel never writes it. The only full-register =
overwrites of
PCI_BRIDGE_CONTROL I can find are drivers/pci/setup-bus.c:907
(bus->bridge_ctl) and drivers/pci/probe.c:1571, neither of which
tracks bit 4. This does not affect the analysis above, since bit 4 is
harmless while bit 3 is clear, but it may be of interest.

## Notes

- The breakage happens after apple_gmux has already probed, so the
driver reports no error. The failure is silent.
- drivers/platform/x86/appl=
e-gmux.c only received cosmetic changes
during the 7.1 cycle, so this looks=
 like a PCI / vgaarb side issue
rather than a driver bug.
- A machine with a discrete GPU behind 00:01.0 and gmux at 0x700-0x7fe
is the affected shape. MacBookPro13,1 and 13,2 have no dGPU and no
bridge in the path, so they are presumably unaffected.

I am happy to test patches or revert candidates on this machine.


2026=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 6:01, =
Bjorn Helgaas <bhelgaas@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Thanks for the report.  It does look like vgaarb.c is the most likely =
culprit.  There are only a few commits to that file between v6.16 and v7.1.=
  If you have time, it would be helpful to identify the specific one that =
broke this.  Here's what git log v6.16..v7.1 said:
>
> 94555ea9a048 PCI/VGA: Pass errors from pci_set_vga_state() up
> 2a93c9851b2b PCI/VGA: Pass vga_get_uninterruptible() errors to userspace
> bf4afc53b77a Convert 'alloc_obj' family to use the new default GFP_KERNEL=
 argument
> 69050f8d6d07 treewide: Replace kmalloc with kmalloc_obj for =
non-scalar types
> 0c61526621ec Merge tag 'efi-next-for-v7.0' of git://git.=
kernel.org/pub/scm/linux/kernel/git/efi/efi
> fd390ff14451 PCI/VGA: Don't =
assume the only VGA device on a system is boot_vga
> a41e0ab394e4 sysfb: =
Replace screen_info with sysfb_primary_display
> a78835b86a44 PCI/VGA: =
Select SCREEN_INFO on X86
> 337bf13aa9dd PCI/VGA: Replace =
vga_is_firmware_default() with a screen info check
>
> I think the convert, treewide, and merge commits are unlikely.
>
> Can you please resend this report to linux-pci@vger.kernel.org?
>
> On Fri, Jul 31, 2026 at 5:57=E2=80=AFPM Haram Choi <haram@choiharam.com> =
wrote:
>>
>> # [REGRESSION] 7.1: apple-gmux backlight dead on MacBookPro13,=
3 - PCI bridge left with VGA enable set and VGA 16-bit decode cleared, =
aliasing legacy VGA I/O over the gmux ports
>>
>> ## Summary
>>
>> Since Linux 7.1 the backlight on a MacBookPro13,3 (15" 2016, Touch Bar) =
cannot be controlled at all. `apple_gmux` still probes successfully during =
boot, but a few hundred milliseconds later the VGA arbiter reprograms =
`PCI_BRIDGE_CONTROL` of the root port `00:01.0` into a state where the =
bridge decodes legacy VGA I/O with only 10 address bits. `0x3c0-0x3df` then=
 aliases onto `0x7c0-0x7df`, which is exactly where the gmux "indexed" =
protocol registers live, so the bridge claims those cycles and forwards =
them to the dGPU. Every gmux read returns `0xff` and every gmux write is =
swallowed.
>>
>> - Last known good: 6.16.10 (Arch `linux` 6.16.10.arch1-1)
>> - Also good: 6.12.51 (Arch `linux-lts` 6.12.51-1)
>> - Bad: 7.1.5 (Arch `linux` 7.1.5.arch1-2)
>>
>> ## Hardware
>>
>> ```
>> DMI: Apple Inc. MacBookPro13,3/Mac-A5C67F76ED83108C, BIOS 529.120.1.0.0 =
03/14/2024
>>
>> 00:01.0 PCI bridge [0604]: Intel 6th-10th Gen Core =
Processor PCIe Controller (x16) [8086:1901] (rev 07)
>> 00:02.0 VGA compatible controller [0300]: Intel Skylake-H GT2 [HD =
Graphics 530] [8086:191b] (rev 06)   -> i915
>> 01:00.0 VGA compatible =
controller [0300]: AMD Baffin [Radeon Pro 455] [1002:67ef] (rev c7)        =
     -> amdgpu
>>
>> gmux: PNP HID APP000B, "Found gmux version 4.0.29 =
[indexed]"
>> ```
>>
>> ## Symptom
>>
>> ```
>> $ cat =
/sys/class/backlight/gmux_backlight/actual_brightness
>> 16777215
>> ```
>>
>> 16777215 is `0x00ffffff`, which is `GMUX_BRIGHTNESS_MASK` applied to an =
all-ones I/O read. Writes to `brightness` have no effect. `brightnessctl`, =
the Touch Bar brightness keys and the desktop brightness slider all fail, =
because all three go through this single backlight device.
>>
>> ## Root cause
>>
>> `PCI_BRIDGE_CONTROL` (offset 0x3e) of `00:01.0`, =
read after boot has settled:
>>
>> ```
>> 6.12.51-lts   : 0x0012   bit1 =
SERR, bit4 VGA_16BIT set, bit3 VGA enable clear   -> works
>> 6.16.10-arch1 : (not read at register level, but backlight works)
>> 7.1.5-arch1-2 : 0x000a   bit1 SERR, bit3 VGA enable set, bit4 VGA_16BIT =
clear   -> broken
>> ```
>>
>> With `PCI_BRIDGE_CTL_VGA` set and =
`PCI_BRIDGE_CTL_VGA_16BIT` clear, the bridge ignores address bits [15:10] =
for legacy VGA I/O, so the ranges alias:
>>
>> ```
>> 0x3b0-0x3bb  ->  =
0x7b0-0x7bb
>> 0x3c0-0x3df  ->  0x7c0-0x7df
>> ```
>>
>> apple-gmux uses the following ports on this machine (PNP resource =
`0x700-0x7fe`):
>>
>> ```
>> GMUX_PORT_READ         0x7d0
>> GMUX_PORT_WRITE        0x7d4
>> index magic sequence   0x7cc / 0x7cd / =
0x7ce
>> ```
>>
>> All of them fall inside the aliased window, so the =
bridge steals them.
>>
>> ## Direct verification via /dev/port on 7.1.5
>>
>> Before:
>>
>> ```
>> inb(0x7cc) =3D ff   inb(0x7cd) =3D ff   inb(0x7ce) =
=3D ff
>> inb(0x7d0) =3D ff   inb(0x7d4) =3D ff
>> ```
>>
>> Set only the 16-bit decode bit, nothing else:
>>
>> ```
>> # setpci -s 00:01.0 BRIDGE_CONTROL=3D0010:0010
>> ```
>>
>> After (gmux_is_indexed() magic sequence, write 0xaa/0x55/0x00 then read =
back):
>>
>> ```
>> outb(0x7cc, 0xaa); outb(0x7cd, 0x55); outb(0x7ce, 0x00)
>> inb(0x7cc) =3D aa   inb(0x7cd) =3D 55        -> gmux responds
>> ```
>>
>> Then:
>>
>> ```
>> # modprobe -r apple_gmux && modprobe apple_gmux
>> apple_gmux: Found gmux version 4.0.29 [indexed]
>>
>> # cat /sys/class/backlight/gmux_backlight/actual_brightness
>> 118
>> ```
>>
>> 118 is the value the panel had actually been stuck at the =
whole time, which confirms that no write had ever reached the hardware. =
Writing 100 / 400 / 700 / 1023 afterwards changes the panel brightness, =
visually confirmed.
>>
>> ## Boot timeline
>>
>> 7.1.5-arch1-2 (broken):
>>
>> ```
>> [  7.947] pci 0000:00:02.0: vgaarb: setting as boot VGA device
>> [  7.947] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem,=
owns=3Dio+mem,locks=3Dnone
>> [  7.947] pci 0000:01:00.0: vgaarb: setting =
as boot VGA device (overriding previous)
>> [  7.948] pci 0000:01:00.0: =
vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
>> [  8.005] amdgpu 0000:01:00.0: vgaarb: deactivate vga console
>> [  9.494] apple_gmux: Found gmux version 4.0.29 [indexed]          <-- =
probe still OK
>> [ 10.059] i915 0000:00:02.0: vgaarb: VGA decodes changed:=
 olddecodes=3Dio+mem,decodes=3Dio:owns=3Dio+mem
>> [ 11.150] i915 =
0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=3Dio,=
decodes=3Dnone:owns=3Dio+mem
>> [ 11.150] amdgpu 0000:01:00.0: vgaarb: VGA =
decodes changed: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone
>> ```
>>
>> 6.16.10-arch1-1 (good):
>>
>> ```
>> [  6.785] pci 0000:00:02.0: vgaarb:=
 VGA device added: decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
>> [  6.785] pci 0000:01:00.0: vgaarb: setting as boot VGA device =
(overriding previous)
>> [  6.785] pci 0000:01:00.0: vgaarb: VGA device =
added: decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
>> [  6.839] amdgpu =
0000:01:00.0: vgaarb: deactivate vga console
>> [  8.339] apple_gmux: Found=
 gmux version 4.0.29 [indexed]
>> [  8.348] i915 0000:00:02.0: vgaarb: VGA =
decodes changed: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
>> [  8.349] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed: =
olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone
>> ```
>>
>> 6.12.51-lts (good):
>>
>> ```
>> [  8.480] apple_gmux: Found gmux =
version 4.0.29 [indexed]
>> [  8.487] i915 0000:00:02.0: vgaarb: VGA =
decodes changed: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
>> [  8.489] amdgpu 0000:01:00.0: vgaarb: VGA decodes changed: =
olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dnone
>> ```
>>
>> The relevant difference: on 6.12 and 6.16 the i915 legacy decode goes
>> `io+mem -> none` in a single step. On 7.1.5 it goes `io+mem -> io` and =
then, about 1.1 seconds later, `io -> none`. The final arbiter state is =
`decodes=3Dnone` for both devices on all three kernels, yet only on 7.1.5 =
does the bridge end up with `PCI_BRIDGE_CTL_VGA` set and =
`PCI_BRIDGE_CTL_VGA_16BIT` cleared. The intermediate `decodes=3Dio` state =
appears to leave the bridge in the 10-bit aliasing configuration and the =
subsequent transition to `none` does not undo it.
>>
>> `drivers/platform/x86/apple-gmux.c` only received cosmetic changes =
during the 7.1 cycle, so this looks like a PCI / vgaarb side change rather =
than a driver bug.
>>
>> ## Workaround
>>
>> ```
>> # setpci -s 00:01.0 =
BRIDGE_CONTROL=3D0010:0010
>> # modprobe -r apple_gmux && modprobe =
apple_gmux
>> ```
>>
>> Setting the 16-bit decode bit is enough. This =
machine is KMS only and
>> `amdgpu: vgaarb: deactivate vga console` has =
already happened, so nothing depends on 10-bit legacy VGA I/O aliasing here=
.
>>
>> ## Notes
>>
>> - The breakage happens after `apple_gmux` has =
already probed, so the driver reports no error. The failure is silent.
>> - A machine with a discrete GPU behind `00:01.0` and gmux at =
`0x700-0x7fe` is the affected shape. MacBookPro13,1 and 13,2 have no dGPU =
and no bridge in the path, so they are presumably unaffected.
>>
>> #regzbot introduced: v6.16..v7.1
>>
