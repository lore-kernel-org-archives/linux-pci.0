Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:48742 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbaFRHXN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jun 2014 03:23:13 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Wed, 18 Jun 2014 12:53:09 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0DE4DE0056
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2014 12:54:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5I7O5GF22020308
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2014 12:54:05 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5I7N2G3005220
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2014 12:53:02 +0530
Date: Wed, 18 Jun 2014 15:22:56 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: don't UNSET resource even reassign fails
Message-ID: <20140618072256.GA3343@yanx>
References: <1402918182-13082-1-git-send-email-yan@linux.vnet.ibm.com>
 <CAErSpo5KepA52w0G2aa2y0-5W32FAkxoVQ+Kdo+hHsR2270Oxw@mail.gmail.com>
 <20140617054457.GA30758@yanx>
 <CAErSpo5jn1LVCK5x8a2tHCodb9aLqVOdOfSDzQxUwOONn+A-Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
In-Reply-To: <CAErSpo5jn1LVCK5x8a2tHCodb9aLqVOdOfSDzQxUwOONn+A-Dw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 17, 2014 at 12:10:28PM -0600, Bjorn Helgaas wrote:
> On Mon, Jun 16, 2014 at 11:44 PM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> > On Mon, Jun 16, 2014 at 02:44:34PM -0600, Bjorn Helgaas wrote:
> >>
> >> Please attach a complete dmesg log so I can look at this in more
> >> detail.  Thanks!
> >>
> >
> > It again appeared in the new machine and cards so it may not proper to
> > send complete dmesg in public list. Attachment is an excerpt related to
> > resource assignment.
> 
> Just remove the identifying information like vendor/device IDs and
> dmidecode info.  You can use something like this to make it easy:
> 
> dmesg | sed -r 's/(pci ....:..:..\..:
> \[)....:....(\].*)/\1VVVV:DDDD\2/' | sed -r 's/(DMI:).*/\1 (removed)/'
> 
> I still want to see the details about the kernel version, host bridge,
> device enumeration, initial BAR values, BAR sizing, bridge topology,
> etc.  It makes more work for me when people extract out the things
> they think I should be interested in because I'm interested in lots of
> things, and sometimes I don't even know all those things until I see
> them.
> 

All right. All PCI related messages are kept with identification masked.

Thanks,
Guo Chao

> Bjorn
> 

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pci-log

[    0.000000] Linux version 3.16.0-rc1 (gcc version 4.8.2 20131017 (Red Hat 4.8.2-1) (GCC) ) #4 SMP Mon Jun 16 06:05:11 EDT 2014
[    0.000000] Initializing IODA2 OPAL PHB /pciex@3fffe40000000
[    0.000000] PCI host bridge /pciex@3fffe40000000 (primary) ranges:
[    0.000000]  MEM 0x0003d00800000000..0x0003d0087ffeffff -> 0x0000000080000000 
[    0.000000]   256 (0) PE's M32: 0x80000000 [segment=0x800000] IO: 0x0 [segment=0x0]
[    0.000000]   Allocated bitmap for 2040 MSIs (base IRQ 0x800)
[    0.000000] Initializing IODA2 OPAL PHB /pciex@3fffe40100000
[    0.000000] PCI host bridge /pciex@3fffe40100000  ranges:
[    0.000000]  MEM 0x0003d01800000000..0x0003d0187ffeffff -> 0x0000000080000000 
[    0.000000]   256 (0) PE's M32: 0x80000000 [segment=0x800000] IO: 0x0 [segment=0x0]
[    0.000000]   Allocated bitmap for 2040 MSIs (base IRQ 0x1000)
[    0.000000] Initializing IODA2 OPAL PHB /pciex@3fffe40400000
[    0.000000] PCI host bridge /pciex@3fffe40400000  ranges:
[    0.000000]  MEM 0x0003d04800000000..0x0003d0487ffeffff -> 0x0000000080000000 
[    0.000000]   256 (0) PE's M32: 0x80000000 [segment=0x800000] IO: 0x0 [segment=0x0]
[    0.000000]   Allocated bitmap for 2040 MSIs (base IRQ 0x2800)
[    0.000000] Initializing IODA2 OPAL PHB /pciex@3fffe40500000
[    0.000000] PCI host bridge /pciex@3fffe40500000  ranges:
[    0.000000]  MEM 0x0003d05800000000..0x0003d0587ffeffff -> 0x0000000080000000 
[    0.000000]   256 (0) PE's M32: 0x80000000 [segment=0x800000] IO: 0x0 [segment=0x0]
[    0.000000]   Allocated bitmap for 2040 MSIs (base IRQ 0x3000)
[    0.000000] Initializing IODA2 OPAL PHB /pciex@3fffe42000000
[    0.000000] PCI host bridge /pciex@3fffe42000000  ranges:
[    0.000000]  MEM 0x0003d20800000000..0x0003d2087ffeffff -> 0x0000000080000000 
[    0.000000]   256 (0) PE's M32: 0x80000000 [segment=0x800000] IO: 0x0 [segment=0x0]
[    0.000000]   Allocated bitmap for 2040 MSIs (base IRQ 0x20800)
[    0.000000] Initializing IODA2 OPAL PHB /pciex@3fffe42100000
[    0.000000] PCI host bridge /pciex@3fffe42100000  ranges:
[    0.000000]  MEM 0x0003d21800000000..0x0003d2187ffeffff -> 0x0000000080000000 
[    0.000000]   256 (0) PE's M32: 0x80000000 [segment=0x800000] IO: 0x0 [segment=0x0]
[    0.000000]   Allocated bitmap for 2040 MSIs (base IRQ 0x21000)
[    0.000000] Initializing IODA2 OPAL PHB /pciex@3fffe42400000
[    0.000000] PCI host bridge /pciex@3fffe42400000  ranges:
[    0.000000]  MEM 0x0003d24800000000..0x0003d2487ffeffff -> 0x0000000080000000 
[    0.000000]   256 (0) PE's M32: 0x80000000 [segment=0x800000] IO: 0x0 [segment=0x0]
[    0.000000]   Allocated bitmap for 2040 MSIs (base IRQ 0x22800)
[    0.000000] Initializing IODA2 OPAL PHB /pciex@3fffe42500000
[    0.000000] PCI host bridge /pciex@3fffe42500000  ranges:
[    0.000000]  MEM 0x0003d25800000000..0x0003d2587ffeffff -> 0x0000000080000000 
[    0.000000]   256 (0) PE's M32: 0x80000000 [segment=0x800000] IO: 0x0 [segment=0x0]
[    0.000000]   Allocated bitmap for 2040 MSIs (base IRQ 0x23000)
[    0.000000] Kernel command line: root=UUID=64b7c0fa-f126-4a4a-87cc-1c44bfd3c38e ro debug rd.md=0 rd.lvm=0 rd.dm=0 vconsole.font=latarcyrheb-sun16 vconsole.keymap=us rd.luks=0
[    1.333409] PCI: Probing PCI hardware
[    1.333451] PCI: I/O resource not set for host bridge /pciex@3fffe40000000 (domain 0)
[    1.333574] PCI host bridge to bus 0000:00
[    1.333615] pci_bus 0000:00: root bus resource [mem 0x3d00800000000-0x3d0087ffeffff] (bus address [0x80000000-0xfffeffff])
[    1.333711] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.333763] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
[    1.333860] pci 0000:00:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.334058] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.334297] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.334378] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    1.334440] PCI: I/O resource not set for host bridge /pciex@3fffe40100000 (domain 1)
[    1.334557] PCI host bridge to bus 0001:00
[    1.334595] pci_bus 0001:00: root bus resource [mem 0x3d01800000000-0x3d0187ffeffff] (bus address [0x80000000-0xfffeffff])
[    1.334690] pci_bus 0001:00: root bus resource [bus 00-ff]
[    1.334739] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to ff
[    1.334824] pci 0001:00:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.335014] pci 0001:00:00.0: PME# supported from D0 D3hot D3cold
[    1.335270] pci 0001:01:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.335358] pci 0001:01:00.0: reg 0x10: [mem 0x3d01801800000-0x3d0180183ffff]
[    1.335638] pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
[    1.335823] pci 0001:00:00.0: PCI bridge to [bus 01-09]
[    1.335885] pci 0001:00:00.0:   bridge window [mem 0x3d01800000000-0x3d01801ffffff]
[    1.335966] pci 0001:00:00.0:   bridge window [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.336235] pci 0001:02:01.0: [VVVV:DDDD] type 01 class 0x060400
[    1.336531] pci 0001:02:01.0: PME# supported from D0 D3hot D3cold
[    1.336724] pci 0001:02:08.0: [VVVV:DDDD] type 01 class 0x060400
[    1.337020] pci 0001:02:08.0: PME# supported from D0 D3hot D3cold
[    1.337212] pci 0001:02:09.0: [VVVV:DDDD] type 01 class 0x060400
[    1.337508] pci 0001:02:09.0: PME# supported from D0 D3hot D3cold
[    1.337686] pci 0001:01:00.0: PCI bridge to [bus 02-09]
[    1.337750] pci 0001:01:00.0:   bridge window [mem 0x3d01800000000-0x3d018017fffff]
[    1.337832] pci 0001:01:00.0:   bridge window [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.338123] pci 0001:02:01.0: PCI bridge to [bus 03-07]
[    1.338186] pci 0001:02:01.0:   bridge window [mem 0x3d01800000000-0x3d018007fffff]
[    1.338267] pci 0001:02:01.0:   bridge window [mem 0x3d01802000000-0x3d018027fffff 64bit pref]
[    1.338497] pci 0001:08:00.0: [VVVV:DDDD] type 00 class 0x010400
[    1.338592] pci 0001:08:00.0: reg 0x10: [mem 0x3d01800800000-0x3d0180080ffff 64bit]
[    1.338688] pci 0001:08:00.0: reg 0x18: [mem 0x3d01800810000-0x3d0180081ffff 64bit]
[    1.338804] pci 0001:08:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.338998] pci 0001:08:00.0: PME# supported from D0 D3hot D3cold
[    1.339150] pci 0001:08:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.339233] pci 0001:08:00.0: reg 0x174: [mem 0x00000000-0x0000ffff 64bit]
[    1.339397] pci 0001:02:08.0: PCI bridge to [bus 08]
[    1.339460] pci 0001:02:08.0:   bridge window [mem 0x3d01800800000-0x3d01800ffffff]
[    1.339540] pci 0001:02:08.0:   bridge window [mem 0x3d01802800000-0x3d01802ffffff 64bit pref]
[    1.339778] pci 0001:09:00.0: [VVVV:DDDD] type 00 class 0x010400
[    1.339872] pci 0001:09:00.0: reg 0x10: [mem 0x3d01801000000-0x3d0180100ffff 64bit]
[    1.339967] pci 0001:09:00.0: reg 0x18: [mem 0x3d01801010000-0x3d0180101ffff 64bit]
[    1.340083] pci 0001:09:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.340278] pci 0001:09:00.0: PME# supported from D0 D3hot D3cold
[    1.340428] pci 0001:09:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.340512] pci 0001:09:00.0: reg 0x174: [mem 0x00000000-0x0000ffff 64bit]
[    1.340675] pci 0001:02:09.0: PCI bridge to [bus 09]
[    1.340738] pci 0001:02:09.0:   bridge window [mem 0x3d01801000000-0x3d018017fffff]
[    1.340819] pci 0001:02:09.0:   bridge window [mem 0x3d01803000000-0x3d018037fffff 64bit pref]
[    1.340955] pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 09
[    1.341048] PCI: I/O resource not set for host bridge /pciex@3fffe40400000 (domain 2)
[    1.341167] PCI host bridge to bus 0002:00
[    1.341205] pci_bus 0002:00: root bus resource [mem 0x3d04800000000-0x3d0487ffeffff] (bus address [0x80000000-0xfffeffff])
[    1.341300] pci_bus 0002:00: root bus resource [bus 00-ff]
[    1.341349] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to ff
[    1.341436] pci 0002:00:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.341633] pci 0002:00:00.0: PME# supported from D0 D3hot D3cold
[    1.341998] pci 0002:01:00.0: [VVVV:DDDD] type 00 class 0x0c0400
[    1.342491] pci 0002:01:00.0: reg 0x10: [mem 0x3d04800100000-0x3d04800107fff 64bit pref]
[    1.343472] pci 0002:01:00.0: reg 0x20: [mem 0x3d04800110000-0x3d04800110fff 64bit pref]
[    1.343804] pci 0002:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.345248] pci 0002:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.346594] pci 0002:01:00.1: [VVVV:DDDD] type 00 class 0x0c0400
[    1.347077] pci 0002:01:00.1: reg 0x10: [mem 0x3d04800108000-0x3d0480010ffff 64bit pref]
[    1.348450] pci 0002:01:00.1: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.349827] pci 0002:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.351102] pci 0002:00:00.0: PCI bridge to [bus 01]
[    1.351173] pci 0002:00:00.0:   bridge window [mem 0x3d04800000000-0x3d048007fffff 64bit pref]
[    1.351324] pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to 01
[    1.351405] PCI: I/O resource not set for host bridge /pciex@3fffe40500000 (domain 3)
[    1.351524] PCI host bridge to bus 0003:00
[    1.351562] pci_bus 0003:00: root bus resource [mem 0x3d05800000000-0x3d0587ffeffff] (bus address [0x80000000-0xfffeffff])
[    1.351657] pci_bus 0003:00: root bus resource [bus 00-ff]
[    1.351706] pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to ff
[    1.351793] pci 0003:00:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.351991] pci 0003:00:00.0: PME# supported from D0 D3hot D3cold
[    1.352254] pci 0003:01:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.352343] pci 0003:01:00.0: reg 0x10: [mem 0x3d05810800000-0x3d0581083ffff]
[    1.352634] pci 0003:01:00.0: PME# supported from D0 D3hot D3cold
[    1.352824] pci 0003:00:00.0: PCI bridge to [bus 01-07]
[    1.352887] pci 0003:00:00.0:   bridge window [mem 0x3d0580e000000-0x3d05810ffffff]
[    1.352968] pci 0003:00:00.0:   bridge window [mem 0x3d05800000000-0x3d0580dffffff 64bit pref]
[    1.353231] pci 0003:02:01.0: [VVVV:DDDD] type 01 class 0x060400
[    1.353537] pci 0003:02:01.0: PME# supported from D0 D3hot D3cold
[    1.353734] pci 0003:02:08.0: [VVVV:DDDD] type 01 class 0x060400
[    1.354041] pci 0003:02:08.0: PME# supported from D0 D3hot D3cold
[    1.354237] pci 0003:02:09.0: [VVVV:DDDD] type 01 class 0x060400
[    1.354545] pci 0003:02:09.0: PME# supported from D0 D3hot D3cold
[    1.354754] pci 0003:02:10.0: [VVVV:DDDD] type 01 class 0x060400
[    1.355062] pci 0003:02:10.0: PME# supported from D0 D3hot D3cold
[    1.355260] pci 0003:02:11.0: [VVVV:DDDD] type 01 class 0x060400
[    1.355568] pci 0003:02:11.0: PME# supported from D0 D3hot D3cold
[    1.355734] pci 0003:01:00.0: PCI bridge to [bus 02-07]
[    1.355798] pci 0003:01:00.0:   bridge window [mem 0x3d0580e000000-0x3d058107fffff]
[    1.355880] pci 0003:01:00.0:   bridge window [mem 0x3d05800000000-0x3d0580dffffff 64bit pref]
[    1.356314] pci 0003:03:00.0: [VVVV:DDDD] type 00 class 0x0c0330
[    1.356415] pci 0003:03:00.0: reg 0x10: [mem 0x3d0580e000000-0x3d0580e00ffff 64bit]
[    1.356513] pci 0003:03:00.0: reg 0x18: [mem 0x3d0580e010000-0x3d0580e011fff 64bit]
[    1.356766] pci 0003:03:00.0: supports D1 D2
[    1.356814] pci 0003:03:00.0: PME# supported from D0 D1 D2 D3hot
[    1.356988] pci 0003:02:01.0: PCI bridge to [bus 03]
[    1.357051] pci 0003:02:01.0:   bridge window [mem 0x3d0580e000000-0x3d0580e7fffff]
[    1.357291] pci 0003:04:00.0: [VVVV:DDDD] type 00 class 0x010400
[    1.357388] pci 0003:04:00.0: reg 0x10: [mem 0x3d0580e800000-0x3d0580e80ffff 64bit]
[    1.357484] pci 0003:04:00.0: reg 0x18: [mem 0x3d0580e810000-0x3d0580e81ffff 64bit]
[    1.357603] pci 0003:04:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.357803] pci 0003:04:00.0: PME# supported from D0 D3hot D3cold
[    1.357958] pci 0003:04:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.358044] pci 0003:04:00.0: reg 0x174: [mem 0x00000000-0x0000ffff 64bit]
[    1.358214] pci 0003:02:08.0: PCI bridge to [bus 04]
[    1.358277] pci 0003:02:08.0:   bridge window [mem 0x3d0580e800000-0x3d0580effffff]
[    1.358358] pci 0003:02:08.0:   bridge window [mem 0x3d0580c000000-0x3d0580c7fffff 64bit pref]
[    1.358742] pci 0003:05:00.0: [VVVV:DDDD] type 00 class 0x028000
[    1.359012] pci 0003:05:00.0: reg 0x10: [mem 0x3d0580f000000-0x3d0580f0fffff 64bit]
[    1.359233] pci 0003:05:00.0: reg 0x18: [mem 0x3d05800000000-0x3d05807ffffff 64bit pref]
[    1.359583] pci 0003:05:00.0: reg 0x30: [mem 0x00000000-0x000fffff pref]
[    1.360931] pci 0003:05:00.0: reg 0x134: [mem 0x00000000-0x07ffffff 64bit pref]
[    1.361283] pci 0003:02:09.0: PCI bridge to [bus 05]
[    1.361347] pci 0003:02:09.0:   bridge window [mem 0x3d0580f000000-0x3d0580f7fffff]
[    1.361430] pci 0003:02:09.0:   bridge window [mem 0x3d05800000000-0x3d0580bffffff 64bit pref]
[    1.361687] pci 0003:06:00.0: [VVVV:DDDD] type 00 class 0x020000
[    1.361790] pci 0003:06:00.0: reg 0x10: [mem 0x3d0580ca00000-0x3d0580ca0ffff 64bit pref]
[    1.361888] pci 0003:06:00.0: reg 0x18: [mem 0x3d0580ca10000-0x3d0580ca1ffff 64bit pref]
[    1.361986] pci 0003:06:00.0: reg 0x20: [mem 0x3d0580ca20000-0x3d0580ca2ffff 64bit pref]
[    1.362074] pci 0003:06:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.362327] pci 0003:06:00.0: PME# supported from D0 D3hot D3cold
[    1.362544] pci 0003:06:00.1: [VVVV:DDDD] type 00 class 0x020000
[    1.362645] pci 0003:06:00.1: reg 0x10: [mem 0x3d0580ca30000-0x3d0580ca3ffff 64bit pref]
[    1.362742] pci 0003:06:00.1: reg 0x18: [mem 0x3d0580ca40000-0x3d0580ca4ffff 64bit pref]
[    1.362842] pci 0003:06:00.1: reg 0x20: [mem 0x3d0580ca50000-0x3d0580ca5ffff 64bit pref]
[    1.362930] pci 0003:06:00.1: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.363183] pci 0003:06:00.1: PME# supported from D0 D3hot D3cold
[    1.363380] pci 0003:06:00.2: [VVVV:DDDD] type 00 class 0x020000
[    1.363480] pci 0003:06:00.2: reg 0x10: [mem 0x3d0580ca60000-0x3d0580ca6ffff 64bit pref]
[    1.363578] pci 0003:06:00.2: reg 0x18: [mem 0x3d0580ca70000-0x3d0580ca7ffff 64bit pref]
[    1.363676] pci 0003:06:00.2: reg 0x20: [mem 0x3d0580ca80000-0x3d0580ca8ffff 64bit pref]
[    1.363764] pci 0003:06:00.2: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.364015] pci 0003:06:00.2: PME# supported from D0 D3hot D3cold
[    1.364211] pci 0003:06:00.3: [VVVV:DDDD] type 00 class 0x020000
[    1.364312] pci 0003:06:00.3: reg 0x10: [mem 0x3d0580ca90000-0x3d0580ca9ffff 64bit pref]
[    1.364410] pci 0003:06:00.3: reg 0x18: [mem 0x3d0580caa0000-0x3d0580caaffff 64bit pref]
[    1.364507] pci 0003:06:00.3: reg 0x20: [mem 0x3d0580cab0000-0x3d0580cabffff 64bit pref]
[    1.364595] pci 0003:06:00.3: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.364847] pci 0003:06:00.3: PME# supported from D0 D3hot D3cold
[    1.364995] pci 0003:02:10.0: PCI bridge to [bus 06]
[    1.365058] pci 0003:02:10.0:   bridge window [mem 0x3d0580f800000-0x3d0580fffffff]
[    1.365141] pci 0003:02:10.0:   bridge window [mem 0x3d0580c800000-0x3d0580cffffff 64bit pref]
[    1.365412] pci 0003:07:00.0: [VVVV:DDDD] type 00 class 0x020000
[    1.365512] pci 0003:07:00.0: reg 0x10: [mem 0x3d0580d200000-0x3d0580d20ffff 64bit pref]
[    1.365610] pci 0003:07:00.0: reg 0x18: [mem 0x3d0580d210000-0x3d0580d21ffff 64bit pref]
[    1.365708] pci 0003:07:00.0: reg 0x20: [mem 0x3d0580d220000-0x3d0580d22ffff 64bit pref]
[    1.365796] pci 0003:07:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.366048] pci 0003:07:00.0: PME# supported from D0 D3hot D3cold
[    1.366262] pci 0003:07:00.1: [VVVV:DDDD] type 00 class 0x020000
[    1.366363] pci 0003:07:00.1: reg 0x10: [mem 0x3d0580d230000-0x3d0580d23ffff 64bit pref]
[    1.366461] pci 0003:07:00.1: reg 0x18: [mem 0x3d0580d240000-0x3d0580d24ffff 64bit pref]
[    1.366559] pci 0003:07:00.1: reg 0x20: [mem 0x3d0580d250000-0x3d0580d25ffff 64bit pref]
[    1.366647] pci 0003:07:00.1: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.366899] pci 0003:07:00.1: PME# supported from D0 D3hot D3cold
[    1.367105] pci 0003:07:00.2: [VVVV:DDDD] type 00 class 0x020000
[    1.367207] pci 0003:07:00.2: reg 0x10: [mem 0x3d0580d260000-0x3d0580d26ffff 64bit pref]
[    1.367305] pci 0003:07:00.2: reg 0x18: [mem 0x3d0580d270000-0x3d0580d27ffff 64bit pref]
[    1.367402] pci 0003:07:00.2: reg 0x20: [mem 0x3d0580d280000-0x3d0580d28ffff 64bit pref]
[    1.367490] pci 0003:07:00.2: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.367742] pci 0003:07:00.2: PME# supported from D0 D3hot D3cold
[    1.367938] pci 0003:07:00.3: [VVVV:DDDD] type 00 class 0x020000
[    1.368039] pci 0003:07:00.3: reg 0x10: [mem 0x3d0580d290000-0x3d0580d29ffff 64bit pref]
[    1.368137] pci 0003:07:00.3: reg 0x18: [mem 0x3d0580d2a0000-0x3d0580d2affff 64bit pref]
[    1.368239] pci 0003:07:00.3: reg 0x20: [mem 0x3d0580d2b0000-0x3d0580d2bffff 64bit pref]
[    1.368327] pci 0003:07:00.3: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.368579] pci 0003:07:00.3: PME# supported from D0 D3hot D3cold
[    1.368727] pci 0003:02:11.0: PCI bridge to [bus 07]
[    1.368791] pci 0003:02:11.0:   bridge window [mem 0x3d05810000000-0x3d058107fffff]
[    1.368873] pci 0003:02:11.0:   bridge window [mem 0x3d0580d000000-0x3d0580d7fffff 64bit pref]
[    1.369072] pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to 07
[    1.369235] PCI: I/O resource not set for host bridge /pciex@3fffe42000000 (domain 4)
[    1.369353] PCI host bridge to bus 0004:00
[    1.369392] pci_bus 0004:00: root bus resource [mem 0x3d20800000000-0x3d2087ffeffff] (bus address [0x80000000-0xfffeffff])
[    1.369487] pci_bus 0004:00: root bus resource [bus 00-ff]
[    1.369536] pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to ff
[    1.369622] pci 0004:00:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.369822] pci 0004:00:00.0: PME# supported from D0 D3hot D3cold
[    1.370093] pci 0004:01:00.0: [VVVV:DDDD] type 00 class 0x020000
[    1.370192] pci 0004:01:00.0: reg 0x10: [mem 0x3d20800000000-0x3d208007fffff 64bit pref]
[    1.370288] pci 0004:01:00.0: reg 0x18: [mem 0x3d20800800000-0x3d20800ffffff 64bit pref]
[    1.370385] pci 0004:01:00.0: reg 0x20: [mem 0x3d20802100000-0x3d2080210ffff 64bit pref]
[    1.370471] pci 0004:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.370717] pci 0004:01:00.0: PME# supported from D0 D3hot
[    1.370862] pci 0004:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.370988] pci 0004:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.371179] pci 0004:01:00.1: [VVVV:DDDD] type 00 class 0x020000
[    1.371278] pci 0004:01:00.1: reg 0x10: [mem 0x3d20801000000-0x3d208017fffff 64bit pref]
[    1.371375] pci 0004:01:00.1: reg 0x18: [mem 0x3d20801800000-0x3d20801ffffff 64bit pref]
[    1.371473] pci 0004:01:00.1: reg 0x20: [mem 0x3d20802110000-0x3d2080211ffff 64bit pref]
[    1.371560] pci 0004:01:00.1: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.371801] pci 0004:01:00.1: PME# supported from D0 D3hot
[    1.371928] pci 0004:01:00.1: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.372054] pci 0004:01:00.1: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.372207] pci 0004:00:00.0: PCI bridge to [bus 01]
[    1.372279] pci 0004:00:00.0:   bridge window [mem 0x3d20800000000-0x3d208027fffff 64bit pref]
[    1.372430] pci_bus 0004:00: busn_res: [bus 00-ff] end is updated to 01
[    1.372501] PCI: I/O resource not set for host bridge /pciex@3fffe42100000 (domain 5)
[    1.372621] PCI host bridge to bus 0005:00
[    1.372659] pci_bus 0005:00: root bus resource [mem 0x3d21800000000-0x3d2187ffeffff] (bus address [0x80000000-0xfffeffff])
[    1.372754] pci_bus 0005:00: root bus resource [bus 00-ff]
[    1.372805] pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to ff
[    1.372892] pci 0005:00:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.373092] pci 0005:00:00.0: PME# supported from D0 D3hot D3cold
[    1.373364] pci 0005:01:00.0: [VVVV:DDDD] type 00 class 0x020000
[    1.373463] pci 0005:01:00.0: reg 0x10: [mem 0x3d21800000000-0x3d218007fffff 64bit pref]
[    1.373560] pci 0005:01:00.0: reg 0x18: [mem 0x3d21800800000-0x3d21800ffffff 64bit pref]
[    1.373657] pci 0005:01:00.0: reg 0x20: [mem 0x3d21804100000-0x3d2180410ffff 64bit pref]
[    1.373743] pci 0005:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    1.373987] pci 0005:01:00.0: PME# supported from D0 D3hot D3cold
[    1.374144] pci 0005:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.374271] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.374459] pci 0005:01:00.1: [VVVV:DDDD] type 00 class 0x020000
[    1.374558] pci 0005:01:00.1: reg 0x10: [mem 0x3d21801000000-0x3d218017fffff 64bit pref]
[    1.374654] pci 0005:01:00.1: reg 0x18: [mem 0x3d21801800000-0x3d21801ffffff 64bit pref]
[    1.374751] pci 0005:01:00.1: reg 0x20: [mem 0x3d21804110000-0x3d2180411ffff 64bit pref]
[    1.374838] pci 0005:01:00.1: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    1.375076] pci 0005:01:00.1: PME# supported from D0 D3hot D3cold
[    1.375213] pci 0005:01:00.1: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.375340] pci 0005:01:00.1: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.375530] pci 0005:01:00.2: [VVVV:DDDD] type 00 class 0x020000
[    1.375629] pci 0005:01:00.2: reg 0x10: [mem 0x3d21802000000-0x3d218027fffff 64bit pref]
[    1.375725] pci 0005:01:00.2: reg 0x18: [mem 0x3d21802800000-0x3d21802ffffff 64bit pref]
[    1.375821] pci 0005:01:00.2: reg 0x20: [mem 0x3d21804120000-0x3d2180412ffff 64bit pref]
[    1.375908] pci 0005:01:00.2: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    1.376147] pci 0005:01:00.2: PME# supported from D0 D3hot D3cold
[    1.376357] pci 0005:01:00.3: [VVVV:DDDD] type 00 class 0x020000
[    1.376456] pci 0005:01:00.3: reg 0x10: [mem 0x3d21803000000-0x3d218037fffff 64bit pref]
[    1.376552] pci 0005:01:00.3: reg 0x18: [mem 0x3d21803800000-0x3d21803ffffff 64bit pref]
[    1.376648] pci 0005:01:00.3: reg 0x20: [mem 0x3d21804130000-0x3d2180413ffff 64bit pref]
[    1.376735] pci 0005:01:00.3: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[    1.376975] pci 0005:01:00.3: PME# supported from D0 D3hot D3cold
[    1.377144] pci 0005:00:00.0: PCI bridge to [bus 01]
[    1.377216] pci 0005:00:00.0:   bridge window [mem 0x3d21800000000-0x3d218047fffff 64bit pref]
[    1.377398] pci_bus 0005:00: busn_res: [bus 00-ff] end is updated to 01
[    1.377479] PCI: I/O resource not set for host bridge /pciex@3fffe42400000 (domain 6)
[    1.377608] PCI host bridge to bus 0006:00
[    1.377647] pci_bus 0006:00: root bus resource [mem 0x3d24800000000-0x3d2487ffeffff] (bus address [0x80000000-0xfffeffff])
[    1.377742] pci_bus 0006:00: root bus resource [bus 00-ff]
[    1.377792] pci_bus 0006:00: busn_res: [bus 00-ff] end is updated to ff
[    1.377879] pci 0006:00:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.378085] pci 0006:00:00.0: PME# supported from D0 D3hot D3cold
[    1.378454] pci 0006:01:00.0: [VVVV:DDDD] type 00 class 0x020000
[    1.379812] pci 0006:01:00.0: reg 0x10: [mem 0x3d24800300000-0x3d24800307fff 64bit pref]
[    1.382801] pci 0006:01:00.0: reg 0x20: [mem 0x3d24800330000-0x3d24800330fff 64bit pref]
[    1.383705] pci 0006:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.386915] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.390551] pci 0006:01:00.1: [VVVV:DDDD] type 00 class 0x020000
[    1.391901] pci 0006:01:00.1: reg 0x10: [mem 0x3d24800308000-0x3d2480030ffff 64bit pref]
[    1.396130] pci 0006:01:00.1: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.399247] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.402883] pci 0006:01:00.2: [VVVV:DDDD] type 00 class 0x020000
[    1.404231] pci 0006:01:00.2: reg 0x10: [mem 0x3d24800310000-0x3d24800317fff 64bit pref]
[    1.408459] pci 0006:01:00.2: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.411572] pci 0006:01:00.2: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.415194] pci 0006:01:00.3: [VVVV:DDDD] type 00 class 0x020000
[    1.416543] pci 0006:01:00.3: reg 0x10: [mem 0x3d24800318000-0x3d2480031ffff 64bit pref]
[    1.420790] pci 0006:01:00.3: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.423908] pci 0006:01:00.3: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.427521] pci 0006:01:00.4: [VVVV:DDDD] type 00 class 0x0c0400
[    1.428866] pci 0006:01:00.4: reg 0x10: [mem 0x3d24800320000-0x3d24800327fff 64bit pref]
[    1.433097] pci 0006:01:00.4: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.436237] pci 0006:01:00.4: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.440395] pci 0006:01:00.5: [VVVV:DDDD] type 00 class 0x0c0400
[    1.441774] pci 0006:01:00.5: reg 0x10: [mem 0x3d24800328000-0x3d2480032ffff 64bit pref]
[    1.446001] pci 0006:01:00.5: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.449126] pci 0006:01:00.5: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.452710] pci 0006:00:00.0: PCI bridge to [bus 01]
[    1.452783] pci 0006:00:00.0:   bridge window [mem 0x3d24800000000-0x3d248007fffff 64bit pref]
[    1.453164] pci_bus 0006:00: busn_res: [bus 00-ff] end is updated to 01
[    1.453283] PCI: I/O resource not set for host bridge /pciex@3fffe42500000 (domain 7)
[    1.453543] PCI host bridge to bus 0007:00
[    1.453586] pci_bus 0007:00: root bus resource [mem 0x3d25800000000-0x3d2587ffeffff] (bus address [0x80000000-0xfffeffff])
[    1.453681] pci_bus 0007:00: root bus resource [bus 00-ff]
[    1.453732] pci_bus 0007:00: busn_res: [bus 00-ff] end is updated to ff
[    1.453820] pci 0007:00:00.0: [VVVV:DDDD] type 01 class 0x060400
[    1.454028] pci 0007:00:00.0: PME# supported from D0 D3hot D3cold
[    1.454306] pci 0007:01:00.0: [VVVV:DDDD] type 00 class 0x010400
[    1.454408] pci 0007:01:00.0: reg 0x10: [mem 0x3d25800000000-0x3d2580003ffff 64bit]
[    1.454506] pci 0007:01:00.0: reg 0x18: [mem 0x3d25801000000-0x3d25801ffffff 64bit pref]
[    1.454627] pci 0007:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.454799] pci 0007:01:00.0: PME# supported from D0 D3hot D3cold
[    1.454955] pci 0007:00:00.0: PCI bridge to [bus 01]
[    1.455019] pci 0007:00:00.0:   bridge window [mem 0x3d25800000000-0x3d258007fffff]
[    1.455100] pci 0007:00:00.0:   bridge window [mem 0x3d25800800000-0x3d25801ffffff 64bit pref]
[    1.455233] pci_bus 0007:00: busn_res: [bus 00-ff] end is updated to 01
[    1.455824] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.455890] pci_bus 0000:00: resource 4 [mem 0x3d00800000000-0x3d0087ffeffff]
[    1.455976] pci 0001:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 03-07] add_size 1000
[    1.456061] pci 0001:02:01.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 03-07] add_size 800000
[    1.456156] pci 0001:02:01.0: bridge window [mem 0x00800000-0x007fffff] to [bus 03-07] add_size 800000
[    1.456254] pci 0001:02:08.0: bridge window [io  0x1000-0x0fff] to [bus 08] add_size 1000
[    1.456326] pci 0001:02:08.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 08] add_size 800000
[    1.456435] pci 0001:02:09.0: bridge window [io  0x1000-0x0fff] to [bus 09] add_size 1000
[    1.456508] pci 0001:02:09.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 09] add_size 800000
[    1.456617] pci 0001:02:01.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.456689] pci 0001:02:08.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.456761] pci 0001:02:09.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.456833] pci 0001:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-09] add_size 3000
[    1.456917] pci 0001:02:01.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
[    1.457022] pci 0001:02:08.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
[    1.457117] pci 0001:02:09.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
[    1.457212] pci 0001:01:00.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 02-09] add_size 1800000
[    1.457308] pci 0001:02:01.0: res[14]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
[    1.457391] pci 0001:01:00.0: bridge window [mem 0x00800000-0x017fffff] to [bus 02-09] add_size 800000
[    1.457487] pci 0001:01:00.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 3000
[    1.457559] pci 0001:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01-09] add_size 3000
[    1.457644] pci 0001:01:00.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 1800000
[    1.457740] pci 0001:00:00.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 01-09] add_size 1800000
[    1.457836] pci 0001:01:00.0: res[14]=[mem 0x00800000-0x017fffff] get_res_add_size add_size 800000
[    1.457920] pci 0001:00:00.0: bridge window [mem 0x00800000-0x01ffffff] to [bus 01-09] add_size 800000
[    1.458004] pci 0001:00:00.0: res[14]=[mem 0x00800000-0x01ffffff] get_res_add_size add_size 800000
[    1.458088] pci 0001:00:00.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 1800000
[    1.458183] pci 0001:00:00.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 3000
[    1.458258] pci 0001:00:00.0: BAR 14: assigned [mem 0x3d01800000000-0x3d01801ffffff]
[    1.458333] pci 0001:00:00.0: BAR 15: assigned [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.458417] pci 0001:00:00.0: BAR 13: can't assign io (size 0x3000)
[    1.458478] pci 0001:00:00.0: BAR 13: can't assign io (size 0x3000)
[    1.458540] pci 0001:01:00.0: res[14]=[mem 0x00800000-0x017fffff] get_res_add_size add_size 800000
[    1.458625] pci 0001:01:00.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 1800000
[    1.458719] pci 0001:01:00.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 3000
[    1.458793] pci 0001:01:00.0: BAR 14: assigned [mem 0x3d01800000000-0x3d018017fffff]
[    1.458868] pci 0001:01:00.0: BAR 15: assigned [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.458951] pci 0001:01:00.0: BAR 0: assigned [mem 0x3d01801800000-0x3d0180183ffff]
[    1.459028] pci 0001:01:00.0: BAR 13: can't assign io (size 0x3000)
[    1.459089] pci 0001:01:00.0: BAR 13: can't assign io (size 0x3000)
[    1.459152] pci 0001:02:01.0: res[14]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
[    1.459237] pci 0001:02:01.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
[    1.459332] pci 0001:02:08.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
[    1.459427] pci 0001:02:09.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
[    1.459521] pci 0001:02:01.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.459593] pci 0001:02:08.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.459664] pci 0001:02:09.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.459737] pci 0001:02:01.0: BAR 14: assigned [mem 0x3d01800000000-0x3d018007fffff]
[    1.459809] pci 0001:02:01.0: BAR 15: assigned [mem 0x3d01802000000-0x3d018027fffff 64bit pref]
[    1.459892] pci 0001:02:08.0: BAR 14: assigned [mem 0x3d01800800000-0x3d01800ffffff]
[    1.459965] pci 0001:02:08.0: BAR 15: assigned [mem 0x3d01802800000-0x3d01802ffffff 64bit pref]
[    1.460049] pci 0001:02:09.0: BAR 14: assigned [mem 0x3d01801000000-0x3d018017fffff]
[    1.460122] pci 0001:02:09.0: BAR 15: assigned [mem 0x3d01803000000-0x3d018037fffff 64bit pref]
[    1.460205] pci 0001:02:01.0: BAR 13: can't assign io (size 0x1000)
[    1.460266] pci 0001:02:08.0: BAR 13: can't assign io (size 0x1000)
[    1.460326] pci 0001:02:09.0: BAR 13: can't assign io (size 0x1000)
[    1.460388] pci 0001:02:09.0: BAR 13: can't assign io (size 0x1000)
[    1.460448] pci 0001:02:08.0: BAR 13: can't assign io (size 0x1000)
[    1.460508] pci 0001:02:01.0: BAR 13: can't assign io (size 0x1000)
[    1.460569] pci 0001:02:01.0: PCI bridge to [bus 03-07]
[    1.460623] pci 0001:02:01.0:   bridge window [mem 0x3d01800000000-0x3d018007fffff]
[    1.460700] pci 0001:02:01.0:   bridge window [mem 0x3d01802000000-0x3d018027fffff 64bit pref]
[    1.460816] pci 0001:08:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.460900] pci 0001:08:00.0: reg 0x174: [mem 0x00000000-0x0000ffff 64bit]
[    1.460985] pci 0001:08:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.461047] pci 0001:08:00.0: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 200000
[    1.461142] pci 0001:08:00.0: res[9]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 200000
[    1.461238] pci 0001:08:00.0: BAR 6: assigned [mem 0x3d01800800000-0x3d0180081ffff pref]
[    1.461311] pci 0001:08:00.0: BAR 0: assigned [mem 0x3d01800820000-0x3d0180082ffff 64bit]
[    1.461398] pci 0001:08:00.0: BAR 2: assigned [mem 0x3d01800830000-0x3d0180083ffff 64bit]
[    1.461509] pci 0001:08:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.461569] pci 0001:08:00.0: BAR 7: assigned [mem 0x3d01800840000-0x3d01800a3ffff 64bit]
[    1.461679] pci 0001:08:00.0: reg 0x174: [mem 0x00000000-0x0000ffff 64bit]
[    1.461741] pci 0001:08:00.0: BAR 9: assigned [mem 0x3d01800a40000-0x3d01800c3ffff 64bit]
[    1.461827] pci 0001:02:08.0: PCI bridge to [bus 08]
[    1.461882] pci 0001:02:08.0:   bridge window [mem 0x3d01800800000-0x3d01800ffffff]
[    1.461958] pci 0001:02:08.0:   bridge window [mem 0x3d01802800000-0x3d01802ffffff 64bit pref]
[    1.462072] pci 0001:09:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.462156] pci 0001:09:00.0: reg 0x174: [mem 0x00000000-0x0000ffff 64bit]
[    1.462241] pci 0001:09:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.462301] pci 0001:09:00.0: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 200000
[    1.462397] pci 0001:09:00.0: res[9]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 200000
[    1.462491] pci 0001:09:00.0: BAR 6: assigned [mem 0x3d01801000000-0x3d0180101ffff pref]
[    1.462564] pci 0001:09:00.0: BAR 0: assigned [mem 0x3d01801020000-0x3d0180102ffff 64bit]
[    1.462651] pci 0001:09:00.0: BAR 2: assigned [mem 0x3d01801030000-0x3d0180103ffff 64bit]
[    1.462761] pci 0001:09:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.462822] pci 0001:09:00.0: BAR 7: assigned [mem 0x3d01801040000-0x3d0180123ffff 64bit]
[    1.462931] pci 0001:09:00.0: reg 0x174: [mem 0x00000000-0x0000ffff 64bit]
[    1.462992] pci 0001:09:00.0: BAR 9: assigned [mem 0x3d01801240000-0x3d0180143ffff 64bit]
[    1.463079] pci 0001:02:09.0: PCI bridge to [bus 09]
[    1.463134] pci 0001:02:09.0:   bridge window [mem 0x3d01801000000-0x3d018017fffff]
[    1.463209] pci 0001:02:09.0:   bridge window [mem 0x3d01803000000-0x3d018037fffff 64bit pref]
[    1.463300] pci 0001:01:00.0: PCI bridge to [bus 02-09]
[    1.463353] pci 0001:01:00.0:   bridge window [mem 0x3d01800000000-0x3d018017fffff]
[    1.463429] pci 0001:01:00.0:   bridge window [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.463519] pci 0001:00:00.0: PCI bridge to [bus 01-09]
[    1.463573] pci 0001:00:00.0:   bridge window [mem 0x3d01800000000-0x3d01801ffffff]
[    1.463648] pci 0001:00:00.0:   bridge window [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.463739] pci_bus 0001:00: resource 4 [mem 0x3d01800000000-0x3d0187ffeffff]
[    1.463811] pci_bus 0001:01: resource 1 [mem 0x3d01800000000-0x3d01801ffffff]
[    1.463882] pci_bus 0001:01: resource 2 [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.463954] pci_bus 0001:02: resource 1 [mem 0x3d01800000000-0x3d018017fffff]
[    1.464025] pci_bus 0001:02: resource 2 [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.464097] pci_bus 0001:03: resource 1 [mem 0x3d01800000000-0x3d018007fffff]
[    1.464168] pci_bus 0001:03: resource 2 [mem 0x3d01802000000-0x3d018027fffff 64bit pref]
[    1.464240] pci_bus 0001:08: resource 1 [mem 0x3d01800800000-0x3d01800ffffff]
[    1.464311] pci_bus 0001:08: resource 2 [mem 0x3d01802800000-0x3d01802ffffff 64bit pref]
[    1.464383] pci_bus 0001:09: resource 1 [mem 0x3d01801000000-0x3d018017fffff]
[    1.464454] pci_bus 0001:09: resource 2 [mem 0x3d01803000000-0x3d018037fffff 64bit pref]
[    1.464542] pci 0002:00:00.0: BAR 14: assigned [mem 0x3d04800000000-0x3d048007fffff]
[    1.464614] pci 0002:00:00.0: BAR 15: assigned [mem 0x3d04800800000-0x3d04800ffffff 64bit pref]
[    1.465132] pci 0002:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.465629] pci 0002:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.466126] pci 0002:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.466624] pci 0002:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.467121] pci 0002:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.467195] pci 0002:01:00.0: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 140000
[    1.467289] pci 0002:01:00.1: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 140000
[    1.467385] pci 0002:01:00.0: BAR 6: assigned [mem 0x3d04800000000-0x3d0480007ffff pref]
[    1.467456] pci 0002:01:00.1: BAR 6: assigned [mem 0x3d04800080000-0x3d048000fffff pref]
[    1.467953] pci 0002:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.468026] pci 0002:01:00.0: BAR 7: assigned [mem 0x3d04800800000-0x3d0480093ffff 64bit pref]
[    1.468834] pci 0002:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.468909] pci 0002:01:00.1: BAR 7: assigned [mem 0x3d04800940000-0x3d04800a7ffff 64bit pref]
[    1.469282] pci 0002:01:00.0: BAR 0: assigned [mem 0x3d04800a80000-0x3d04800a87fff 64bit pref]
[    1.469635] pci 0002:01:00.1: BAR 0: assigned [mem 0x3d04800a88000-0x3d04800a8ffff 64bit pref]
[    1.469981] pci 0002:01:00.0: BAR 4: assigned [mem 0x3d04800a90000-0x3d04800a90fff 64bit pref]
[    1.470334] pci 0002:00:00.0: PCI bridge to [bus 01]
[    1.470390] pci 0002:00:00.0:   bridge window [mem 0x3d04800000000-0x3d048007fffff]
[    1.470465] pci 0002:00:00.0:   bridge window [mem 0x3d04800800000-0x3d04800ffffff 64bit pref]
[    1.470556] pci_bus 0002:00: resource 4 [mem 0x3d04800000000-0x3d0487ffeffff]
[    1.470628] pci_bus 0002:01: resource 1 [mem 0x3d04800000000-0x3d048007fffff]
[    1.470701] pci_bus 0002:01: resource 2 [mem 0x3d04800800000-0x3d04800ffffff 64bit pref]
[    1.470803] pci 0003:02:08.0: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
[    1.470876] pci 0003:02:08.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 04] add_size 800000
[    1.470986] pci 0003:02:09.0: bridge window [io  0x1000-0x0fff] to [bus 05] add_size 1000
[    1.471060] pci 0003:02:09.0: bridge window [mem 0x08000000-0x0fffffff 64bit pref] to [bus 05] add_size 1f8000000
[    1.471169] pci 0003:02:10.0: bridge window [io  0x1000-0x0fff] to [bus 06] add_size 1000
[    1.471258] pci 0003:02:11.0: bridge window [io  0x1000-0x0fff] to [bus 07] add_size 1000
[    1.471345] pci 0003:02:08.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.471417] pci 0003:02:09.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.471489] pci 0003:02:10.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.471560] pci 0003:02:11.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.471633] pci 0003:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-07] add_size 4000
[    1.471716] pci 0003:02:08.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
[    1.471811] pci 0003:02:09.0: res[15]=[mem 0x08000000-0x0fffffff 64bit pref] get_res_add_size add_size 1f8000000
[    1.471907] pci 0003:01:00.0: bridge window [mem 0x04000000-0x0fffffff 64bit pref] to [bus 02-07] add_size 1f8000000
[    1.472015] pci 0003:01:00.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 4000
[    1.472088] pci 0003:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01-07] add_size 4000
[    1.472171] pci 0003:01:00.0: res[15]=[mem 0x04000000-0x0fffffff 64bit pref] get_res_add_size add_size 1f8000000
[    1.472267] pci 0003:00:00.0: bridge window [mem 0x04000000-0x0fffffff 64bit pref] to [bus 01-07] add_size 1f8000000
[    1.472362] pci 0003:00:00.0: res[15]=[mem 0x04000000-0x0fffffff 64bit pref] get_res_add_size add_size 1f8000000
[    1.472458] pci 0003:00:00.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 4000
[    1.472529] pci 0003:00:00.0: BAR 15: can't assign mem pref (size 0x204000000)
[    1.472602] pci 0003:00:00.0: BAR 14: assigned [mem 0x3d05800000000-0x3d05802ffffff]
[    1.472673] pci 0003:00:00.0: BAR 13: can't assign io (size 0x4000)
[    1.472734] pci 0003:00:00.0: BAR 15: assigned [mem 0x3d05800000000-0x3d0580bffffff 64bit pref]
[    1.472818] pci 0003:00:00.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580effffff]
[    1.472890] pci 0003:00:00.0: BAR 15: can't assign mem pref (size 0xc000000)
[    1.472962] pci 0003:00:00.0: failed to add 1f8000000 res[15]=[mem size 0x0c000000 64bit pref]
[    1.473046] pci 0003:00:00.0: BAR 13: can't assign io (size 0x4000)
[    1.473107] pci 0003:01:00.0: res[15]=[mem 0x04000000-0x0fffffff 64bit pref] get_res_add_size add_size 1f8000000
[    1.473203] pci 0003:01:00.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 4000
[    1.473275] pci 0003:01:00.0: BAR 15: can't assign mem pref (size 0x204000000)
[    1.473348] pci 0003:01:00.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580e7fffff]
[    1.473420] pci 0003:01:00.0: BAR 0: assigned [mem 0x3d0580e800000-0x3d0580e83ffff]
[    1.473495] pci 0003:01:00.0: BAR 13: can't assign io (size 0x4000)
[    1.473557] pci 0003:01:00.0: BAR 15: assigned [mem 0x3d05800000000-0x3d0580bffffff 64bit pref]
[    1.473641] pci 0003:01:00.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580e7fffff]
[    1.473712] pci 0003:01:00.0: BAR 0: assigned [mem 0x3d0580e800000-0x3d0580e83ffff]
[    1.473791] pci 0003:01:00.0: BAR 15: can't assign mem pref (size 0xc000000)
[    1.473863] pci 0003:01:00.0: failed to add 1f8000000 res[15]=[mem size 0x0c000000 64bit pref]
[    1.473946] pci 0003:01:00.0: BAR 13: can't assign io (size 0x4000)
[    1.474011] pci 0003:02:09.0: res[15]=[mem 0x08000000-0x0fffffff 64bit pref] get_res_add_size add_size 1f8000000
[    1.474105] pci 0003:02:08.0: res[15]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
[    1.474200] pci 0003:02:08.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.474272] pci 0003:02:09.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.474343] pci 0003:02:10.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.474415] pci 0003:02:11.0: res[13]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
[    1.474488] pci 0003:02:09.0: BAR 15: can't assign mem pref (size 0x200000000)
[    1.474561] pci 0003:02:01.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580c7fffff]
[    1.474632] pci 0003:02:08.0: BAR 14: assigned [mem 0x3d0580c800000-0x3d0580cffffff]
[    1.474705] pci 0003:02:08.0: BAR 15: assigned [mem 0x3d05800000000-0x3d058007fffff 64bit pref]
[    1.474788] pci 0003:02:09.0: BAR 14: assigned [mem 0x3d0580d000000-0x3d0580d7fffff]
[    1.474859] pci 0003:02:10.0: BAR 14: assigned [mem 0x3d0580d800000-0x3d0580dffffff]
[    1.474932] pci 0003:02:10.0: BAR 15: assigned [mem 0x3d05800800000-0x3d05800ffffff 64bit pref]
[    1.475015] pci 0003:02:11.0: BAR 14: assigned [mem 0x3d0580e000000-0x3d0580e7fffff]
[    1.475087] pci 0003:02:11.0: BAR 15: assigned [mem 0x3d05801000000-0x3d058017fffff 64bit pref]
[    1.475169] pci 0003:02:08.0: BAR 13: can't assign io (size 0x1000)
[    1.475229] pci 0003:02:09.0: BAR 13: can't assign io (size 0x1000)
[    1.475289] pci 0003:02:10.0: BAR 13: can't assign io (size 0x1000)
[    1.475350] pci 0003:02:11.0: BAR 13: can't assign io (size 0x1000)
[    1.475412] pci 0003:02:09.0: BAR 15: assigned [mem 0x3d05800000000-0x3d05807ffffff 64bit pref]
[    1.475495] pci 0003:02:01.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580c7fffff]
[    1.475567] pci 0003:02:08.0: BAR 14: assigned [mem 0x3d0580c800000-0x3d0580cffffff]
[    1.475639] pci 0003:02:09.0: BAR 14: assigned [mem 0x3d0580d000000-0x3d0580d7fffff]
[    1.475711] pci 0003:02:10.0: BAR 14: assigned [mem 0x3d0580d800000-0x3d0580dffffff]
[    1.475782] pci 0003:02:10.0: BAR 15: assigned [mem 0x3d05808000000-0x3d058087fffff 64bit pref]
[    1.475866] pci 0003:02:11.0: BAR 14: assigned [mem 0x3d0580e000000-0x3d0580e7fffff]
[    1.475938] pci 0003:02:11.0: BAR 15: assigned [mem 0x3d05808800000-0x3d05808ffffff 64bit pref]
[    1.476020] pci 0003:02:11.0: BAR 13: can't assign io (size 0x1000)
[    1.476081] pci 0003:02:10.0: BAR 13: can't assign io (size 0x1000)
[    1.476143] pci 0003:02:09.0: BAR 15: can't assign mem pref (size 0x8000000)
[    1.476214] pci 0003:02:09.0: failed to add 1f8000000 res[15]=[mem size 0x08000000 64bit pref]
[    1.476298] pci 0003:02:09.0: BAR 13: can't assign io (size 0x1000)
[    1.476358] pci 0003:02:08.0: BAR 15: assigned [mem 0x3d05809000000-0x3d058097fffff 64bit pref]
[    1.476441] pci 0003:02:08.0: BAR 13: can't assign io (size 0x1000)
[    1.476503] pci 0003:03:00.0: BAR 0: assigned [mem 0x3d0580c000000-0x3d0580c00ffff 64bit]
[    1.476591] pci 0003:03:00.0: BAR 2: assigned [mem 0x3d0580c010000-0x3d0580c011fff 64bit]
[    1.476680] pci 0003:02:01.0: PCI bridge to [bus 03]
[    1.476734] pci 0003:02:01.0:   bridge window [mem 0x3d0580c000000-0x3d0580c7fffff]
[    1.476842] pci 0003:04:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.476927] pci 0003:04:00.0: reg 0x174: [mem 0x00000000-0x0000ffff 64bit]
[    1.477013] pci 0003:04:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.477077] pci 0003:04:00.0: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 200000
[    1.477172] pci 0003:04:00.0: res[9]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 200000
[    1.477267] pci 0003:04:00.0: BAR 6: assigned [mem 0x3d0580c800000-0x3d0580c81ffff pref]
[    1.477339] pci 0003:04:00.0: BAR 0: assigned [mem 0x3d0580c820000-0x3d0580c82ffff 64bit]
[    1.477428] pci 0003:04:00.0: BAR 2: assigned [mem 0x3d0580c830000-0x3d0580c83ffff 64bit]
[    1.477539] pci 0003:04:00.0: reg 0x16c: [mem 0x00000000-0x0000ffff 64bit]
[    1.477600] pci 0003:04:00.0: BAR 7: assigned [mem 0x3d0580c840000-0x3d0580ca3ffff 64bit]
[    1.477714] pci 0003:04:00.0: reg 0x174: [mem 0x00000000-0x0000ffff 64bit]
[    1.477775] pci 0003:04:00.0: BAR 9: assigned [mem 0x3d0580ca40000-0x3d0580cc3ffff 64bit]
[    1.477863] pci 0003:02:08.0: PCI bridge to [bus 04]
[    1.477918] pci 0003:02:08.0:   bridge window [mem 0x3d0580c800000-0x3d0580cffffff]
[    1.477993] pci 0003:02:08.0:   bridge window [mem 0x3d05809000000-0x3d058097fffff 64bit pref]
[    1.478234] pci 0003:05:00.0: reg 0x134: [mem 0x00000000-0x07ffffff 64bit pref]
[    1.478307] pci 0003:05:00.0: res[9]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 1f8000000
[    1.478403] pci 0003:05:00.0: BAR 2: assigned [mem 0x3d05800000000-0x3d05807ffffff 64bit pref]
[    1.478732] pci 0003:05:00.0: reg 0x134: [mem 0x00000000-0x07ffffff 64bit pref]
[    1.478805] pci 0003:05:00.0: BAR 9: can't assign mem pref (size 0x1f8000000)
[    1.478880] pci 0003:05:00.0: BAR 0: assigned [mem 0x3d0580d000000-0x3d0580d0fffff 64bit]
[    1.479048] pci 0003:05:00.0: BAR 6: assigned [mem 0x3d0580d100000-0x3d0580d1fffff pref]
[    1.479121] pci 0003:05:00.0: BAR 2: assigned [mem 0x3d05800000000-0x3d05807ffffff 64bit pref]
[    1.479303] pci 0003:05:00.0: BAR 0: assigned [mem 0x3d0580d000000-0x3d0580d0fffff 64bit]
[    1.479473] pci 0003:05:00.0: BAR 6: assigned [mem 0x3d0580d100000-0x3d0580d1fffff pref]
[    1.479696] pci 0003:05:00.0: reg 0x134: [mem 0x00000000-0x07ffffff 64bit pref]
[    1.479769] pci 0003:05:00.0: BAR 9: can't assign mem pref (size 0x1f8000000)
[    1.479840] pci 0003:02:09.0: PCI bridge to [bus 05]
[    1.479895] pci 0003:02:09.0:   bridge window [mem 0x3d0580d000000-0x3d0580d7fffff]
[    1.479971] pci 0003:02:09.0:   bridge window [mem size 0x08000000 64bit pref]
[    1.480055] pci 0003:06:00.0: BAR 6: assigned [mem 0x3d0580d800000-0x3d0580d87ffff pref]
[    1.480128] pci 0003:06:00.1: BAR 6: assigned [mem 0x3d0580d880000-0x3d0580d8fffff pref]
[    1.480200] pci 0003:06:00.2: BAR 6: assigned [mem 0x3d0580d900000-0x3d0580d97ffff pref]
[    1.480274] pci 0003:06:00.3: BAR 6: assigned [mem 0x3d0580d980000-0x3d0580d9fffff pref]
[    1.480347] pci 0003:06:00.0: BAR 0: assigned [mem 0x3d05808000000-0x3d0580800ffff 64bit pref]
[    1.480447] pci 0003:06:00.0: BAR 2: assigned [mem 0x3d05808010000-0x3d0580801ffff 64bit pref]
[    1.480548] pci 0003:06:00.0: BAR 4: assigned [mem 0x3d05808020000-0x3d0580802ffff 64bit pref]
[    1.480647] pci 0003:06:00.1: BAR 0: assigned [mem 0x3d05808030000-0x3d0580803ffff 64bit pref]
[    1.480748] pci 0003:06:00.1: BAR 2: assigned [mem 0x3d05808040000-0x3d0580804ffff 64bit pref]
[    1.480848] pci 0003:06:00.1: BAR 4: assigned [mem 0x3d05808050000-0x3d0580805ffff 64bit pref]
[    1.480949] pci 0003:06:00.2: BAR 0: assigned [mem 0x3d05808060000-0x3d0580806ffff 64bit pref]
[    1.481049] pci 0003:06:00.2: BAR 2: assigned [mem 0x3d05808070000-0x3d0580807ffff 64bit pref]
[    1.481149] pci 0003:06:00.2: BAR 4: assigned [mem 0x3d05808080000-0x3d0580808ffff 64bit pref]
[    1.481250] pci 0003:06:00.3: BAR 0: assigned [mem 0x3d05808090000-0x3d0580809ffff 64bit pref]
[    1.481350] pci 0003:06:00.3: BAR 2: assigned [mem 0x3d058080a0000-0x3d058080affff 64bit pref]
[    1.481450] pci 0003:06:00.3: BAR 4: assigned [mem 0x3d058080b0000-0x3d058080bffff 64bit pref]
[    1.481550] pci 0003:02:10.0: PCI bridge to [bus 06]
[    1.481604] pci 0003:02:10.0:   bridge window [mem 0x3d0580d800000-0x3d0580dffffff]
[    1.481680] pci 0003:02:10.0:   bridge window [mem 0x3d05808000000-0x3d058087fffff 64bit pref]
[    1.481773] pci 0003:07:00.0: BAR 6: assigned [mem 0x3d0580e000000-0x3d0580e07ffff pref]
[    1.481846] pci 0003:07:00.1: BAR 6: assigned [mem 0x3d0580e080000-0x3d0580e0fffff pref]
[    1.481917] pci 0003:07:00.2: BAR 6: assigned [mem 0x3d0580e100000-0x3d0580e17ffff pref]
[    1.481989] pci 0003:07:00.3: BAR 6: assigned [mem 0x3d0580e180000-0x3d0580e1fffff pref]
[    1.482062] pci 0003:07:00.0: BAR 0: assigned [mem 0x3d05808800000-0x3d0580880ffff 64bit pref]
[    1.482161] pci 0003:07:00.0: BAR 2: assigned [mem 0x3d05808810000-0x3d0580881ffff 64bit pref]
[    1.482262] pci 0003:07:00.0: BAR 4: assigned [mem 0x3d05808820000-0x3d0580882ffff 64bit pref]
[    1.482361] pci 0003:07:00.1: BAR 0: assigned [mem 0x3d05808830000-0x3d0580883ffff 64bit pref]
[    1.482461] pci 0003:07:00.1: BAR 2: assigned [mem 0x3d05808840000-0x3d0580884ffff 64bit pref]
[    1.482561] pci 0003:07:00.1: BAR 4: assigned [mem 0x3d05808850000-0x3d0580885ffff 64bit pref]
[    1.482661] pci 0003:07:00.2: BAR 0: assigned [mem 0x3d05808860000-0x3d0580886ffff 64bit pref]
[    1.482762] pci 0003:07:00.2: BAR 2: assigned [mem 0x3d05808870000-0x3d0580887ffff 64bit pref]
[    1.482862] pci 0003:07:00.2: BAR 4: assigned [mem 0x3d05808880000-0x3d0580888ffff 64bit pref]
[    1.482962] pci 0003:07:00.3: BAR 0: assigned [mem 0x3d05808890000-0x3d0580889ffff 64bit pref]
[    1.483061] pci 0003:07:00.3: BAR 2: assigned [mem 0x3d058088a0000-0x3d058088affff 64bit pref]
[    1.483162] pci 0003:07:00.3: BAR 4: assigned [mem 0x3d058088b0000-0x3d058088bffff 64bit pref]
[    1.483261] pci 0003:02:11.0: PCI bridge to [bus 07]
[    1.483316] pci 0003:02:11.0:   bridge window [mem 0x3d0580e000000-0x3d0580e7fffff]
[    1.483392] pci 0003:02:11.0:   bridge window [mem 0x3d05808800000-0x3d05808ffffff 64bit pref]
[    1.483482] pci 0003:01:00.0: PCI bridge to [bus 02-07]
[    1.483536] pci 0003:01:00.0:   bridge window [mem 0x3d0580c000000-0x3d0580e7fffff]
[    1.483612] pci 0003:01:00.0:   bridge window [mem size 0x0c000000 64bit pref]
[    1.483690] pci 0003:00:00.0: PCI bridge to [bus 01-07]
[    1.483744] pci 0003:00:00.0:   bridge window [mem 0x3d0580c000000-0x3d0580effffff]
[    1.483820] pci 0003:00:00.0:   bridge window [mem size 0x0c000000 64bit pref]
[    1.483899] pci_bus 0003:00: resource 4 [mem 0x3d05800000000-0x3d0587ffeffff]
[    1.483971] pci_bus 0003:01: resource 1 [mem 0x3d0580c000000-0x3d0580effffff]
[    1.484043] pci_bus 0003:01: resource 2 [mem size 0x0c000000 64bit pref]
[    1.484102] pci_bus 0003:02: resource 1 [mem 0x3d0580c000000-0x3d0580e7fffff]
[    1.484174] pci_bus 0003:02: resource 2 [mem size 0x0c000000 64bit pref]
[    1.484234] pci_bus 0003:03: resource 1 [mem 0x3d0580c000000-0x3d0580c7fffff]
[    1.484305] pci_bus 0003:04: resource 1 [mem 0x3d0580c800000-0x3d0580cffffff]
[    1.484377] pci_bus 0003:04: resource 2 [mem 0x3d05809000000-0x3d058097fffff 64bit pref]
[    1.484449] pci_bus 0003:05: resource 1 [mem 0x3d0580d000000-0x3d0580d7fffff]
[    1.484520] pci_bus 0003:05: resource 2 [mem size 0x08000000 64bit pref]
[    1.484580] pci_bus 0003:06: resource 1 [mem 0x3d0580d800000-0x3d0580dffffff]
[    1.484652] pci_bus 0003:06: resource 2 [mem 0x3d05808000000-0x3d058087fffff 64bit pref]
[    1.484723] pci_bus 0003:07: resource 1 [mem 0x3d0580e000000-0x3d0580e7fffff]
[    1.484795] pci_bus 0003:07: resource 2 [mem 0x3d05808800000-0x3d05808ffffff 64bit pref]
[    1.484882] pci 0004:00:00.0: bridge window [mem 0x00800000-0x02ffffff 64bit pref] to [bus 01] add_size 1800000
[    1.484978] pci 0004:00:00.0: res[15]=[mem 0x00800000-0x02ffffff 64bit pref] get_res_add_size add_size 1800000
[    1.485074] pci 0004:00:00.0: BAR 14: assigned [mem 0x3d20800000000-0x3d208007fffff]
[    1.485146] pci 0004:00:00.0: BAR 15: assigned [mem 0x3d20800800000-0x3d208047fffff 64bit pref]
[    1.485255] pci 0004:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.485352] pci 0004:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.485449] pci 0004:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.485545] pci 0004:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.485642] pci 0004:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.485738] pci 0004:01:00.1: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.485834] pci 0004:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.485931] pci 0004:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.486027] pci 0004:01:00.1: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.486123] pci 0004:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.486197] pci 0004:01:00.0: res[11]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 800000
[    1.486292] pci 0004:01:00.1: res[11]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 800000
[    1.486387] pci 0004:01:00.0: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 400000
[    1.486481] pci 0004:01:00.1: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 400000
[    1.486577] pci 0004:01:00.0: BAR 0: assigned [mem 0x3d20800800000-0x3d20800ffffff 64bit pref]
[    1.486676] pci 0004:01:00.0: BAR 2: assigned [mem 0x3d20801000000-0x3d208017fffff 64bit pref]
[    1.486776] pci 0004:01:00.1: BAR 0: assigned [mem 0x3d20801800000-0x3d20801ffffff 64bit pref]
[    1.486875] pci 0004:01:00.1: BAR 2: assigned [mem 0x3d20802000000-0x3d208027fffff 64bit pref]
[    1.486974] pci 0004:01:00.0: BAR 6: assigned [mem 0x3d20800000000-0x3d2080007ffff pref]
[    1.487046] pci 0004:01:00.1: BAR 6: assigned [mem 0x3d20800080000-0x3d208000fffff pref]
[    1.487145] pci 0004:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.487218] pci 0004:01:00.0: BAR 11: assigned [mem 0x3d20802800000-0x3d20802ffffff 64bit pref]
[    1.487341] pci 0004:01:00.1: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.487414] pci 0004:01:00.1: BAR 11: assigned [mem 0x3d20803000000-0x3d208037fffff 64bit pref]
[    1.487513] pci 0004:01:00.0: BAR 4: assigned [mem 0x3d20803800000-0x3d2080380ffff 64bit pref]
[    1.487636] pci 0004:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.487710] pci 0004:01:00.0: BAR 7: assigned [mem 0x3d20803810000-0x3d20803c0ffff 64bit pref]
[    1.487810] pci 0004:01:00.1: BAR 4: assigned [mem 0x3d20803c10000-0x3d20803c1ffff 64bit pref]
[    1.487933] pci 0004:01:00.1: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.488006] pci 0004:01:00.1: BAR 7: assigned [mem 0x3d20803c20000-0x3d2080401ffff 64bit pref]
[    1.488106] pci 0004:00:00.0: PCI bridge to [bus 01]
[    1.488161] pci 0004:00:00.0:   bridge window [mem 0x3d20800000000-0x3d208007fffff]
[    1.488237] pci 0004:00:00.0:   bridge window [mem 0x3d20800800000-0x3d208047fffff 64bit pref]
[    1.488330] pci_bus 0004:00: resource 4 [mem 0x3d20800000000-0x3d2087ffeffff]
[    1.488402] pci_bus 0004:01: resource 1 [mem 0x3d20800000000-0x3d208007fffff]
[    1.488474] pci_bus 0004:01: resource 2 [mem 0x3d20800800000-0x3d208047fffff 64bit pref]
[    1.488562] pci 0005:00:00.0: bridge window [mem 0x00800000-0x04ffffff 64bit pref] to [bus 01] add_size 1800000
[    1.488659] pci 0005:00:00.0: res[15]=[mem 0x00800000-0x04ffffff 64bit pref] get_res_add_size add_size 1800000
[    1.488754] pci 0005:00:00.0: BAR 14: assigned [mem 0x3d21800000000-0x3d218007fffff]
[    1.488827] pci 0005:00:00.0: BAR 15: assigned [mem 0x3d21800800000-0x3d218067fffff 64bit pref]
[    1.488937] pci 0005:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.489034] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.489130] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.489226] pci 0005:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.489324] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.489420] pci 0005:01:00.1: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.489516] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.489613] pci 0005:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.489709] pci 0005:01:00.1: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.489807] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.489904] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.490000] pci 0005:01:00.1: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.490098] pci 0005:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.490194] pci 0005:01:00.1: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.490292] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.490390] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.490486] pci 0005:01:00.1: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.490583] pci 0005:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.490680] pci 0005:01:00.1: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.490778] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.490852] pci 0005:01:00.0: res[11]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 800000
[    1.490947] pci 0005:01:00.1: res[11]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 800000
[    1.491042] pci 0005:01:00.0: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 400000
[    1.491136] pci 0005:01:00.1: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 400000
[    1.491232] pci 0005:01:00.0: BAR 0: assigned [mem 0x3d21800800000-0x3d21800ffffff 64bit pref]
[    1.491331] pci 0005:01:00.0: BAR 2: assigned [mem 0x3d21801000000-0x3d218017fffff 64bit pref]
[    1.491431] pci 0005:01:00.1: BAR 0: assigned [mem 0x3d21801800000-0x3d21801ffffff 64bit pref]
[    1.491529] pci 0005:01:00.1: BAR 2: assigned [mem 0x3d21802000000-0x3d218027fffff 64bit pref]
[    1.491629] pci 0005:01:00.2: BAR 0: assigned [mem 0x3d21802800000-0x3d21802ffffff 64bit pref]
[    1.491728] pci 0005:01:00.2: BAR 2: assigned [mem 0x3d21803000000-0x3d218037fffff 64bit pref]
[    1.491828] pci 0005:01:00.3: BAR 0: assigned [mem 0x3d21803800000-0x3d21803ffffff 64bit pref]
[    1.491927] pci 0005:01:00.3: BAR 2: assigned [mem 0x3d21804000000-0x3d218047fffff 64bit pref]
[    1.492026] pci 0005:01:00.0: BAR 6: assigned [mem 0x3d21800000000-0x3d2180003ffff pref]
[    1.492099] pci 0005:01:00.1: BAR 6: assigned [mem 0x3d21800040000-0x3d2180007ffff pref]
[    1.492170] pci 0005:01:00.2: BAR 6: assigned [mem 0x3d21800080000-0x3d218000bffff pref]
[    1.492242] pci 0005:01:00.3: BAR 6: assigned [mem 0x3d218000c0000-0x3d218000fffff pref]
[    1.492338] pci 0005:01:00.0: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.492410] pci 0005:01:00.0: BAR 11: assigned [mem 0x3d21804800000-0x3d21804ffffff 64bit pref]
[    1.492534] pci 0005:01:00.1: reg 0x1f4: [mem 0x00000000-0x0001ffff 64bit pref]
[    1.492606] pci 0005:01:00.1: BAR 11: assigned [mem 0x3d21805000000-0x3d218057fffff 64bit pref]
[    1.492705] pci 0005:01:00.0: BAR 4: assigned [mem 0x3d21805800000-0x3d2180580ffff 64bit pref]
[    1.492829] pci 0005:01:00.0: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.492900] pci 0005:01:00.0: BAR 7: assigned [mem 0x3d21805810000-0x3d21805c0ffff 64bit pref]
[    1.493000] pci 0005:01:00.1: BAR 4: assigned [mem 0x3d21805c10000-0x3d21805c1ffff 64bit pref]
[    1.493123] pci 0005:01:00.1: reg 0x1e4: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.493196] pci 0005:01:00.1: BAR 7: assigned [mem 0x3d21805c20000-0x3d2180601ffff 64bit pref]
[    1.493295] pci 0005:01:00.2: BAR 4: assigned [mem 0x3d21806020000-0x3d2180602ffff 64bit pref]
[    1.493394] pci 0005:01:00.3: BAR 4: assigned [mem 0x3d21806030000-0x3d2180603ffff 64bit pref]
[    1.493495] pci 0005:00:00.0: PCI bridge to [bus 01]
[    1.493549] pci 0005:00:00.0:   bridge window [mem 0x3d21800000000-0x3d218007fffff]
[    1.493624] pci 0005:00:00.0:   bridge window [mem 0x3d21800800000-0x3d218067fffff 64bit pref]
[    1.493716] pci_bus 0005:00: resource 4 [mem 0x3d21800000000-0x3d2187ffeffff]
[    1.493787] pci_bus 0005:01: resource 1 [mem 0x3d21800000000-0x3d218007fffff]
[    1.493859] pci_bus 0005:01: resource 2 [mem 0x3d21800800000-0x3d218067fffff 64bit pref]
[    1.493947] pci 0006:00:00.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref] to [bus 01] add_size 800000
[    1.494044] pci 0006:00:00.0: res[15]=[mem 0x00800000-0x00ffffff 64bit pref] get_res_add_size add_size 800000
[    1.494139] pci 0006:00:00.0: BAR 14: assigned [mem 0x3d24800000000-0x3d248007fffff]
[    1.494211] pci 0006:00:00.0: BAR 15: assigned [mem 0x3d24800800000-0x3d248017fffff 64bit pref]
[    1.495607] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.496967] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.498342] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.499700] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.501061] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.502429] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.503783] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.505138] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.506498] pci 0006:01:00.2: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.507876] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.509237] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.510595] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.511949] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.513313] pci 0006:01:00.2: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.514671] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.516032] pci 0006:01:00.3: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.517391] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.518760] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.520122] pci 0006:01:00.2: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.521488] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.522850] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.524213] pci 0006:01:00.2: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.525579] pci 0006:01:00.3: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.526937] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.528301] pci 0006:01:00.4: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.529684] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.531042] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.532416] pci 0006:01:00.2: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.533772] pci 0006:01:00.3: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.535145] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.536497] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.537855] pci 0006:01:00.2: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.539244] pci 0006:01:00.3: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.540605] pci 0006:01:00.4: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.541990] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.543350] pci 0006:01:00.5: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.544721] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.546070] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.547427] pci 0006:01:00.2: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.548795] pci 0006:01:00.3: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.550157] pci 0006:01:00.4: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.550232] pci 0006:01:00.0: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 500000
[    1.550327] pci 0006:01:00.1: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 500000
[    1.550421] pci 0006:01:00.2: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 140000
[    1.550516] pci 0006:01:00.3: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 140000
[    1.550612] pci 0006:01:00.4: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 140000
[    1.550708] pci 0006:01:00.5: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit pref] get_res_add_size add_size 140000
[    1.550802] pci 0006:01:00.0: BAR 6: assigned [mem 0x3d24800000000-0x3d2480007ffff pref]
[    1.550875] pci 0006:01:00.1: BAR 6: assigned [mem 0x3d24800080000-0x3d248000fffff pref]
[    1.550948] pci 0006:01:00.2: BAR 6: assigned [mem 0x3d24800100000-0x3d2480017ffff pref]
[    1.551021] pci 0006:01:00.3: BAR 6: assigned [mem 0x3d24800180000-0x3d248001fffff pref]
[    1.551094] pci 0006:01:00.4: BAR 6: assigned [mem 0x3d24800200000-0x3d2480027ffff pref]
[    1.551167] pci 0006:01:00.5: BAR 6: assigned [mem 0x3d24800280000-0x3d248002fffff pref]
[    1.552539] pci 0006:01:00.0: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.552612] pci 0006:01:00.0: BAR 7: assigned [mem 0x3d24800800000-0x3d24800cfffff 64bit pref]
[    1.787460] pci 0006:01:00.1: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.787599] pci 0006:01:00.1: BAR 7: assigned [mem 0x3d24800d00000-0x3d248011fffff 64bit pref]
[    1.789904] pci 0006:01:00.2: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.790041] pci 0006:01:00.2: BAR 7: assigned [mem 0x3d24801200000-0x3d2480133ffff 64bit pref]
[    1.792353] pci 0006:01:00.3: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.792426] pci 0006:01:00.3: BAR 7: assigned [mem 0x3d24801340000-0x3d2480147ffff 64bit pref]
[    1.794659] pci 0006:01:00.4: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.794800] pci 0006:01:00.4: BAR 7: assigned [mem 0x3d24801480000-0x3d248015bffff 64bit pref]
[    1.797118] pci 0006:01:00.5: reg 0x160: [mem 0x00000000-0x0000ffff 64bit pref]
[    1.797257] pci 0006:01:00.5: BAR 7: assigned [mem 0x3d248015c0000-0x3d248016fffff 64bit pref]
[    1.798276] pci 0006:01:00.0: BAR 0: assigned [mem 0x3d24801700000-0x3d24801707fff 64bit pref]
[    1.799210] pci 0006:01:00.1: BAR 0: assigned [mem 0x3d24801708000-0x3d2480170ffff 64bit pref]
[    1.800131] pci 0006:01:00.2: BAR 0: assigned [mem 0x3d24801710000-0x3d24801717fff 64bit pref]
[    1.801066] pci 0006:01:00.3: BAR 0: assigned [mem 0x3d24801718000-0x3d2480171ffff 64bit pref]
[    1.801988] pci 0006:01:00.4: BAR 0: assigned [mem 0x3d24801720000-0x3d24801727fff 64bit pref]
[    1.802904] pci 0006:01:00.5: BAR 0: assigned [mem 0x3d24801728000-0x3d2480172ffff 64bit pref]
[    1.803836] pci 0006:01:00.0: BAR 4: assigned [mem 0x3d24801730000-0x3d24801730fff 64bit pref]
[    1.804767] pci 0006:00:00.0: PCI bridge to [bus 01]
[    1.804822] pci 0006:00:00.0:   bridge window [mem 0x3d24800000000-0x3d248007fffff]
[    1.804897] pci 0006:00:00.0:   bridge window [mem 0x3d24800800000-0x3d248017fffff 64bit pref]
[    1.804988] pci_bus 0006:00: resource 4 [mem 0x3d24800000000-0x3d2487ffeffff]
[    1.805060] pci_bus 0006:01: resource 1 [mem 0x3d24800000000-0x3d248007fffff]
[    1.888874] pci_bus 0006:01: resource 2 [mem 0x3d24800800000-0x3d248017fffff 64bit pref]
[    1.889005] pci 0007:00:00.0: BAR 15: assigned [mem 0x3d25800000000-0x3d25800ffffff 64bit pref]
[    1.889104] pci 0007:00:00.0: BAR 14: assigned [mem 0x3d25801000000-0x3d258017fffff]
[    1.889180] pci 0007:01:00.0: BAR 2: assigned [mem 0x3d25800000000-0x3d25800ffffff 64bit pref]
[    1.889285] pci 0007:01:00.0: BAR 0: assigned [mem 0x3d25801000000-0x3d2580103ffff 64bit]
[    1.889375] pci 0007:01:00.0: BAR 6: assigned [mem 0x3d25801040000-0x3d2580105ffff pref]
[    1.889450] pci 0007:00:00.0: PCI bridge to [bus 01]
[    1.889505] pci 0007:00:00.0:   bridge window [mem 0x3d25801000000-0x3d258017fffff]
[    1.889582] pci 0007:00:00.0:   bridge window [mem 0x3d25800000000-0x3d25800ffffff 64bit pref]
[    1.889674] pci_bus 0007:00: resource 4 [mem 0x3d25800000000-0x3d2587ffeffff]
[    1.889746] pci_bus 0007:01: resource 1 [mem 0x3d25801000000-0x3d258017fffff]
[    1.895533] pci_bus 0007:01: resource 2 [mem 0x3d25800000000-0x3d25800ffffff 64bit pref]
[    1.895609] pci 0000:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.895924] pci 0000:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.896240] pci 0001:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.896553] pci 0001:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.896865] pci 0001:02     : [PE# 003] Secondary bus 2 associated with PE#3
[    1.897242] pci 0001:03     : [PE# 004] Secondary bus 3 associated with PE#4
[    1.897620] pci 0001:08     : [PE# 005] Secondary bus 8 associated with PE#5
[    1.897998] pci 0001:09     : [PE# 006] Secondary bus 9 associated with PE#6
[    1.898375] pci 0002:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.898752] pci 0002:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.899129] pci 0003:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.902148] pci 0003:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.902459] pci 0003:02     : [PE# 003] Secondary bus 2 associated with PE#3
[    1.902771] pci 0003:03     : [PE# 004] Secondary bus 3 associated with PE#4
[    1.903082] pci 0003:04     : [PE# 005] Secondary bus 4 associated with PE#5
[    1.903457] pci 0003:05     : [PE# 006] Secondary bus 5 associated with PE#6
[    1.903833] pci 0003:06     : [PE# 007] Secondary bus 6 associated with PE#7
[    1.904209] pci 0003:07     : [PE# 008] Secondary bus 7 associated with PE#8
[    1.904585] pci 0004:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.904961] pci 0004:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.905340] pci 0005:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.905716] pci 0005:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.906091] pci 0006:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.908330] pci 0006:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.908644] pci 0007:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.908956] pci 0007:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.910245] PCI: Domain 0000 has 8 available 32-bit DMA segments
[    1.910359] PCI: 0 PE# for a total weight of 0
[    1.910452] PCI: Domain 0001 has 8 available 32-bit DMA segments
[    1.910567] PCI: 2 PE# for a total weight of 30
[    1.910661] pci 0001:08     : [PE# 005] Assign DMA32 space
[    1.910755] pci 0001:08     : [PE# 005] Setting up 32-bit TCE table at 0..80000000
[    1.985733] IOMMU table initialized, virtual merging enabled
[    1.985829] pci 0001:08     : [PE# 005] Enabling 64-bit DMA bypass
[    1.985906] pci 0001:09     : [PE# 006] Assign DMA32 space
[    1.985967] pci 0001:09     : [PE# 006] Setting up 32-bit TCE table at 0..80000000
[    2.060932] pci 0001:09     : [PE# 006] Enabling 64-bit DMA bypass
[    2.060995] PCI: Domain 0002 has 8 available 32-bit DMA segments
[    2.061055] PCI: 1 PE# for a total weight of 20
[    2.061104] pci 0002:01     : [PE# 002] Assign DMA32 space
[    2.061153] pci 0002:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    2.136036] pci 0002:01     : [PE# 002] Enabling 64-bit DMA bypass
[    2.136113] PCI: Domain 0003 has 8 available 32-bit DMA segments
[    2.136173] PCI: 5 PE# for a total weight of 115
[    2.136222] pci 0003:06     : [PE# 007] Assign DMA32 space
[    2.136270] pci 0003:06     : [PE# 007] Setting up 32-bit TCE table at 0..80000000
[    2.211156] pci 0003:06     : [PE# 007] Enabling 64-bit DMA bypass
[    2.211251] pci 0003:07     : [PE# 008] Assign DMA32 space
[    2.211316] pci 0003:07     : [PE# 008] Setting up 32-bit TCE table at 0..80000000
[    2.286236] pci 0003:07     : [PE# 008] Enabling 64-bit DMA bypass
[    2.286299] pci 0003:04     : [PE# 005] Assign DMA32 space
[    2.286347] pci 0003:04     : [PE# 005] Setting up 32-bit TCE table at 0..80000000
[    2.361231] pci 0003:04     : [PE# 005] Enabling 64-bit DMA bypass
[    2.361373] pci 0003:03     : [PE# 004] Assign DMA32 space
[    2.361466] pci 0003:03     : [PE# 004] Setting up 32-bit TCE table at 0..80000000
[    2.436439] pci 0003:03     : [PE# 004] Enabling 64-bit DMA bypass
[    2.436502] pci 0003:05     : [PE# 006] Assign DMA32 space
[    2.436551] pci 0003:05     : [PE# 006] Setting up 32-bit TCE table at 0..80000000
[    2.511432] pci 0003:05     : [PE# 006] Enabling 64-bit DMA bypass
[    2.511514] PCI: Domain 0004 has 8 available 32-bit DMA segments
[    2.511574] PCI: 1 PE# for a total weight of 20
[    2.511622] pci 0004:01     : [PE# 002] Assign DMA32 space
[    2.511671] pci 0004:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    2.586803] pci 0004:01     : [PE# 002] Enabling 64-bit DMA bypass
[    2.586895] PCI: Domain 0005 has 8 available 32-bit DMA segments
[    2.586970] PCI: 1 PE# for a total weight of 40
[    2.587031] pci 0005:01     : [PE# 002] Assign DMA32 space
[    2.587079] pci 0005:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    2.662575] pci 0005:01     : [PE# 002] Enabling 64-bit DMA bypass
[    2.662651] PCI: Domain 0006 has 8 available 32-bit DMA segments
[    2.662711] PCI: 1 PE# for a total weight of 60
[    2.662759] pci 0006:01     : [PE# 002] Assign DMA32 space
[    2.662808] pci 0006:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    2.743344] pci 0006:01     : [PE# 002] Enabling 64-bit DMA bypass
[    2.743421] PCI: Domain 0007 has 8 available 32-bit DMA segments
[    2.743492] PCI: 1 PE# for a total weight of 15
[    2.743540] pci 0007:01     : [PE# 002] Assign DMA32 space
[    2.743589] pci 0007:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    2.824102] pci 0007:01     : [PE# 002] Enabling 64-bit DMA bypass
[    2.828092] EEH: PCI Enhanced I/O Error Handling Enabled
[    2.828141] PCI: Probing PCI hardware done
[    2.880327] pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.880412] pci 0003:00:00.0: Error enabling bridge (-22), continuing
[    2.880480] pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.880563] pci 0003:00:00.0: Error enabling bridge (-22), continuing
[    2.880627] pci 0003:01:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.880710] pci 0003:01:00.0: Error enabling bridge (-22), continuing
[    2.880775] pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.880859] pci 0003:00:00.0: Error enabling bridge (-22), continuing
[    2.880923] pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.881006] pci 0003:00:00.0: Error enabling bridge (-22), continuing
[    2.881069] pci 0003:01:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.881153] pci 0003:01:00.0: Error enabling bridge (-22), continuing

--+HP7ph2BbKc20aGI--

