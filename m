Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:56698 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753492Ab2DNTI2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Apr 2012 15:08:28 -0400
Message-ID: <4F89CB16.2000908@snewbury.org.uk>
Date: Sat, 14 Apr 2012 20:08:06 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Steven Newbury <steve@snewbury.org.uk>
CC: Yinghai Lu <yinghai@kernel.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity>  <4F84110E.3000400@snewbury.org.uk>  <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>  <4F8467AA.90305@snewbury.org.uk>  <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>  <4F848357.3060007@snewbury.org.uk>  <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>  <4F848E10.1090703@snewbury.org.uk>  <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>  <1334089568.4083.2.camel@Nokia-N900>  <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>  <4F84A3EC.6030903@snewbury.org.uk>  <CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>  <1334229754.30606.7.camel@Nokia-N900>   <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900> <4F89B5E8.3040906@snewbury.org.uk> <4F89BC84.50308@snewbury.org.uk> <4F89C513.3000006@snewbury.org.uk>
In-Reply-To: <4F89C513.3000006@snewbury.org.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 14/04/12 19:42, Steven Newbury wrote:
> On 14/04/12 19:05, Steven Newbury wrote:
>> On 14/04/12 18:37, Steven Newbury wrote:
>>> On 12/04/12 17:40, Steven Newbury wrote:
>>>> On Thu, 12 Apr 2012, 17:07:33 BST, Yinghai Lu 
>>>> <yinghai@kernel.org> wrote:
> 
>>>>> On Thu, Apr 12, 2012 at 4:22 AM, Steven Newbury 
>>>>> <steve@snewbury.org.uk> wrote:
>>>>>> Thanks, that fixed it! :) I had a similar patch I've been
>>>>>>  working on but I had my fix in the wrong place!
>>>>>> 
>>>>>> In the working case, initially the BIOS has set GMA to 
>>>>>> within the low system DRAM 0xC0000000 obviously invalid.
>>>>>>  This conflict is detected and it's relallocated to 
>>>>>> 0x12000000.
>>>>>> 
>>>>>> I've attempted to modify probe.c to disable 64-bit BARs
>>>>>> not allocated above 4G so they get reallocated above when
>>>>>>  possible later.  It seemed to work, but again broke GMA
>>>>>>  despite the BAR originally containing an invalid
>>>>>> address as mentioned above, it seems for some reason
>>>>>> something is different when the conflict is detected and
>>>>>> rellocated, compared to disabling it early then
>>>>>> allocating a valid value..?
>>>>>> 
>>> I've created a new quirk utilising an extra PCI resource flag
>>> to force reallocation of the resource.  It's the first
>>> approach I've had any success at.  It does work.  Only "Intel
>>> Page Flush" now gets allocated @0xe0000000!
> 
> 
>> Hopefully this should fix "Intel Flush Page"
> Need to export pci_bus_alloc_resource_fit for intel-gtt.
Nearly worked... Or at least it should have worked, but for some
reason the allocator failed to utilise 0xe0000000-0xefffffff for
04:00.0 BAR0..?


00000000-0000ffff : reserved
00010000-0009efff : System RAM
0009f000-0009ffff : reserved
000c0000-000c7fff : Video ROM
000cf000-000cffff : Adapter ROM
000f0000-000fffff : System ROM
00100000-df65a7ff : System RAM
  01000000-0136defd : Kernel code
  0136defe-0169127f : Kernel data
  0172f000-01809fff : Kernel bss
df65a800-dfffffff : reserved
  df65a800-df6fffff : pnp 00:0d
  df700000-df7fffff : pnp 00:0d
f0000000-f01fffff : PCI Bus 0000:0d
f6900000-f69fffff : PCI Bus 0000:09
  f69f0000-f69fffff : 0000:09:00.0
    f69f0000-f69fffff : tg3
f6a00000-f6bfffff : PCI Bus 0000:0d
f6c00000-f6cfffff : PCI Bus 0000:0c
  f6cfe000-f6cfffff : 0000:0c:00.0
    f6cfe000-f6cfffff : iwl4965
f6dfb700-f6dfb7ff : 0000:00:1f.3
f6dfb800-f6dfbfff : 0000:00:1f.2
  f6dfb800-f6dfbfff : ahci
f6dfc000-f6dfffff : 0000:00:1b.0
  f6dfc000-f6dfffff : ICH HD audio
f6e00000-f6efffff : 0000:00:02.0
f6f00000-f6ffffff : 0000:00:02.1
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  f8000000-fbffffff : reserved
    f8000000-fbffffff : pnp 00:0d
fec00000-fec0ffff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:08
fed18000-fed1bfff : reserved
  fed18000-fed1bfff : pnp 00:0d
fed1c000-fed1c3ff : 0000:00:1d.7
  fed1c000-fed1c3ff : ehci_hcd
fed1c400-fed1c7ff : 0000:00:1a.7
  fed1c400-fed1c7ff : ehci_hcd
fed1d000-fed1dfff : Intel Flush Page
fed20000-fed8ffff : reserved
  fed20000-fed3ffff : pnp 00:0d
  fed40000-fed44fff : pnp 00:0a
  fed45000-fed8ffff : pnp 00:0d
feda0000-feda5fff : reserved
  feda0000-feda3fff : pnp 00:0d
  feda4000-feda4fff : pnp 00:0d
  feda5000-feda5fff : pnp 00:0d
feda6000-feda6fff : pnp 00:0d
fee00000-fee0ffff : reserved
  fee00000-fee0ffff : pnp 00:0d
    fee00000-fee00fff : Local APIC
fef00000-feffffff : PCI Bus 0000:04
  fefbc000-fefbffff : 0000:04:00.1
    fefbc000-fefbffff : ICH HD audio
  fefc0000-fefdffff : 0000:04:00.0
  fefe0000-feffffff : 0000:04:00.0
ffa00000-ffbfffff : pnp 00:0d
ffc00000-ffdfffff : PCI Bus 0000:0b
ffe00000-ffffffff : reserved
  ffe00000-ffffffff : pnp 00:0d
100000000-11fffffff : System RAM
fefa00000-fefbfffff : PCI Bus 0000:09
fefc00000-fefdfffff : PCI Bus 0000:0c
fefe00000-fefffffff : PCI Bus 0000:0b
ff0000000-fffffffff : 0000:00:02.0


dmesg after docking:

ACPI: \_SB_.PCI0.PCIE.GDCK - docking
usb 3-3: new high-speed USB device number 3 using ehci_hcd
usb 3-3: New USB device found, idVendor=413c, idProduct=0058
usb 3-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 3-3:1.0: USB hub found
hub 3-3:1.0: 4 ports detected
ACPI Error: Method parse/execution failed [\SMI_] (Node
ffff88011b031550), AE_AML_INFINITE_LOOP (20120320/psparse-536)
ACPI Error: Method parse/execution failed [\_SB_.PCI0.PCIE.GDCK._DCK]
(Node ffff88011b038528), AE_AML_INFINITE_LOOP (20120320/psparse-536)
ACPI Exception: AE_AML_INFINITE_LOOP, \_SB_.PCI0.PCIE.GDCK - failed to
execute _DCK
 (20120320/dock-478)
usb 3-3.2: new high-speed USB device number 4 using ehci_hcd
usb 3-3.2: New USB device found, idVendor=413c, idProduct=0058
usb 3-3.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
hub 3-3.2:1.0: USB hub found
hub 3-3.2:1.0: 4 ports detected
pci 0000:03:08.0: [10b5:8112] type 01 class 0x060400
pci 0000:03:08.0: supports D1
pci 0000:03:08.0: PME# supported from D0 D1 D3hot
pci 0000:03:08.0: PME# disabled
pci 0000:03:08.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:03:08.0: bus configuration invalid, reconfiguring
pci 0000:03:08.0: scanning [bus 00-00] behind bridge, pass 1
pci 0000:03:08.0: find free busn in res: [bus 03]
pci 0000:03:08.0: found free busn 0 in res: [bus 03] top
pci 0000:03:08.0: find free busn in res: [bus 03]
pci 0000:03:08.0: found free busn 0 in res: [bus 03] top
pci 0000:03:08.0: find free busn in res: [bus 03]
pci 0000:03:08.0: found free busn 0 in res: [bus 03] top
pci 0000:03:08.0: find free busn in res: [bus 03]
pci 0000:03:08.0: found free busn 0 in res: [bus 03] top
pci_bus 0000:03: busn_res: extended 05 to [bus 03-08]
pci_bus 0000:04: busn_res: [bus 04-08] is updated under [bus 03-08]
pci_bus 0000:04: scanning bus pass 0
pci 0000:04:00.0: [1002:68e1] type 00 class 0x030000
pci 0000:04:00.0: reg 10: [mem 0x00000000-0x0fffffff 64bit pref]
pci 0000:04:00.0: reg 18: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:04:00.0: reg 20: [io  0x0000-0x00ff]
pci 0000:04:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
pci 0000:04:00.0: supports D1 D2
pci 0000:04:00.1: [1002:aa68] type 00 class 0x040300
pci 0000:04:00.1: reg 10: [mem 0x00000000-0x00003fff 64bit]
pci 0000:04:00.1: supports D1 D2
pci_bus 0000:04: fixups for bus pass 0
pci 0000:03:08.0: PCI bridge to [bus 04-08]
pci_bus 0000:04: bus scan returning with max=04 pass 0
pci_bus 0000:04: scanning bus pass 1
pci_bus 0000:04: fixups for bus pass 1
pci 0000:03:08.0: PCI bridge to [bus 04-08]
pci_bus 0000:04: bus scan returning with max=04 pass 1
pci_bus 0000:04: busn_res: [bus 04-08] end updated to [bus 04]
pci_bus 0000:03: busn_res: shrunk 04 to [bus 03-04]
ACPI: Delete PCI Interrupt Routing Table for 0000:04
pci 0000:03:08.0: BAR 15: can't assign mem pref (size 0x18000000)
pci 0000:03:08.0: BAR 14: assigned [mem 0xfef00000-0xfeffffff]
pci 0000:03:08.0: BAR 13: assigned [io  0x4000-0x4fff]
pci 0000:04:00.0: BAR 0: can't assign mem pref (size 0x10000000)
pci 0000:04:00.0: BAR 2: assigned [mem 0xfefe0000-0xfeffffff 64bit]
pci 0000:04:00.0: BAR 2: set to [mem 0xfefe0000-0xfeffffff 64bit] (PCI
address [0xfefe0000-0xfeffffff])
pci 0000:04:00.0: BAR 6: assigned [mem 0xfefc0000-0xfefdffff pref]
pci 0000:04:00.1: BAR 0: assigned [mem 0xfefbc000-0xfefbffff 64bit]
pci 0000:04:00.1: BAR 0: set to [mem 0xfefbc000-0xfefbffff 64bit] (PCI
address [0xfefbc000-0xfefbffff])
pci 0000:04:00.0: BAR 4: assigned [io  0x4000-0x40ff]
pci 0000:04:00.0: BAR 4: set to [io  0x4000-0x40ff] (PCI address
[0x4000-0x40ff])
pci 0000:03:08.0: PCI bridge to [bus 04-04]
pci 0000:03:08.0:   bridge window [io  0x4000-0x4fff]
pci 0000:03:08.0:   bridge window [mem 0xfef00000-0xfeffffff]
pci 0000:03:08.0: no hotplug settings from platform
pci 0000:04:00.0: no hotplug settings from platform
pci 0000:04:00.1: no hotplug settings from platform
pci 0000:03:08.0: enabling device (0000 -> 0003)
pci 0000:03:08.0: enabling bus mastering
vgaarb: device added: PCI:0000:04:00.0,decodes=io+mem,owns=none,locks=none
vgaarb: device changed decodes:
PCI:0000:00:02.0,olddecodes=io+mem,decodes=none:owns=io+mem
vgaarb: transferring owner from PCI:0000:00:02.0 to PCI:0000:04:00.0
snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
snd_hda_intel 0000:04:00.1: irq 49 for MSI/MSI-X
snd_hda_intel 0000:04:00.1: enabling bus mastering
input: HD-Audio Generic HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:1e.0/0000:03:08.0/0000:04:00.1/sound/card1/input11
[drm] radeon defaulting to kernel modesetting.
[drm] radeon kernel modesetting enabled.
radeon 0000:04:00.0: enabling device (0000 -> 0003)
radeon 0000:04:00.0: enabling bus mastering
[drm] initializing kernel modesetting (CEDAR 0x1002:0x68E1 0x1787:0x3000).
[drm] register mmio base: 0xFEFE0000
[drm] register mmio size: 131072
ATOM BIOS: B9127JMA.MFK
[drm] GPU not posted. posting now...
radeon 0000:04:00.0: VRAM: 512M 0x0000000000000000 -
0x000000001FFFFFFF (512M used)
radeon 0000:04:00.0: GTT: 512M 0x0000000020000000 - 0x000000003FFFFFFF
mtrr: zero sized request
[drm] Detected VRAM RAM=512M, BAR=0M
[drm] RAM width 64bits DDR
[TTM] Zone  kernel: Available graphics memory: 2019690 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
radeon_bo_create:132 alloc size 0M bigger than 0Mb limit
radeon 0000:04:00.0: Fatal error during GPU init
[drm] radeon: finishing device.
radeon 0000:04:00.0: no bo for sa manager
[TTM] Trying to take down uninitialized memory manager type 1
[TTM] Finalizing pool allocator
[TTM] Finalizing DMA pool allocator
[TTM] Zone  kernel: Used memory at exit: 0 kiB
[drm] radeon: ttm finalized
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+JyxUACgkQGcb56gMuC61WdwCcDYlntR5ydafo3lwHcDF6MPsD
9g0AoIYq4Rf+gK36+LTNyT7eQWLVOznf
=ckOP
-----END PGP SIGNATURE-----
