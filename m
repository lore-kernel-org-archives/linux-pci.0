Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.117]:23758 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754011Ab3H3N6E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Aug 2013 09:58:04 -0400
Date: Fri, 30 Aug 2013 15:58:00 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI reset problem
Message-ID: <20130830135800.GA21372@jtlinux>
References: <20130828133337.GA8544@jtlinux>
 <CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
 <20130829082941.GA11203@jtlinux>
 <CAErSpo56RszdMQDOY8xCmz=1QP-osUGA71V56t9X9zY4rNAYew@mail.gmail.com>
 <20130829150723.GA32730@jtlinux>
 <CAErSpo5nTy7bkU2_ZMR_sROz-FJF28a==eUdE3e-wZoZfzQZBw@mail.gmail.com>
 <20130830080138.GA24908@jtlinux>
 <CAErSpo4OXQr_SW2+8q3+OLqs63EHpGwgj_AHpUo_5hTy8iQm=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo4OXQr_SW2+8q3+OLqs63EHpGwgj_AHpUo_5hTy8iQm=A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 30, 2013 at 07:40:18AM -0600, Bjorn Helgaas wrote:
> On Fri, Aug 30, 2013 at 2:01 AM, Johannes Thumshirn
> <johannes.thumshirn@men.de> wrote:
> > On Thu, Aug 29, 2013 at 09:52:30AM -0600, Bjorn Helgaas wrote:
> >> On Thu, Aug 29, 2013 at 9:07 AM, Johannes Thumshirn
> >> <johannes.thumshirn@men.de> wrote:
> >> > On Thu, Aug 29, 2013 at 06:01:43AM -0600, Bjorn Helgaas wrote:
> >> >> On Thu, Aug 29, 2013 at 2:29 AM, Johannes Thumshirn
> >> >> <johannes.thumshirn@men.de> wrote:
> >> >> > On Wed, Aug 28, 2013 at 10:50:58AM -0600, Bjorn Helgaas wrote:
> >> >> >> [+cc Yinghai]
> >> >> >>
> >> >> >> On Wed, Aug 28, 2013 at 7:33 AM, Johannes Thumshirn
> >> >> >> <johannes.thumshirn@men.de> wrote:
> >> >> >> > Hi List,
> >> >> >> >
> >> >> >> > I have a rather odd problem with a PCIe swicht/bridge which does not get
> >> >> >> > enumerated correctly. If I issue _two_ manual rescans of the PCI bus via sysfs,
> >> >> >> > everything get setup correctly. To work around the problem I decided to make a
> >> >> >> > platform specific PCI quirk (for the embedded system I'm on, to not break
> >> >> >> > anything else) and issue the pci_rescan_bus() myself as a "final" fixup. However
> >> >> >> > this does not have any effect at all.
> >> >> >> >
> >> >> >> > Does anyone have an idea what I could do wrong?
> >> >> >>
> >> >> >> A rescan doesn't really do anything differently from the initial
> >> >> >> boot-time scan.  Maybe there's an issue with the switch taking a long
> >> >> >> time to respond after reset?  But that doesn't seem likely, because if
> >> >> >> you do manual rescans via sysfs, that should give plenty of time and
> >> >> >> you wouldn't have to do it *twice*.
> >> >> >>
> >> >> >> Maybe there's some resource or bus number allocation issue such that
> >> >> >> we don't even get down to the problem switch the first couple of
> >> >> >> times?
> >> >> >>
> >> >> >> > Example:
> >> >> >> > root@generic-powerpc:~# lspci -tv
> >> >> >> > -[0000:00]---00.0-[01]--
> >> >> >> > root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> >> >> >> > [...]
> >> >> >> > root@generic-powerpc:~# lspci -tv
> >> >> >> > -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]--
> >> >> >> >                                            +-02.0-[04]--
> >> >> >> >                                            \-03.0-[05]--
> >> >> >> > root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> >> >> >> > [...]
> >> >> >> > root@generic-powerpc:~# lspci -tv
> >> >> >> > -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]----00.0  Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
> >> >> >> >                                            +-02.0-[04]--
> >> >> >> >                                            \-03.0-[05]--+-00.0  Pericom Semiconductor Device 400e
> >> >> >> >                                                         +-00.1  Pericom Semiconductor Device 400e
> >> >> >> >                                                         \-00.2  Pericom Semiconductor Device 400f
> >> >> >>
> >> >> >> I bet that's what's happening: the first lspci shows the 00:00.0
> >> >> >> bridge leading only to bus 01.  The second lspci shows 00:00.0 leading
> >> >> >> to [bus 01-05], so its bus number aperture has been reconfigured.
> >> >> >>
> >> >> >> On x86 the BIOS typically configures all the bridges so we can see all
> >> >> >> the devices.  But it looks like your platform doesn't, and the Linux
> >> >> >> paths that do similar configuration are not as well exercised.
> >> >> >>
> >> >> >
> >> >> > I'll have a look into my U-Boot again as well, maybe I can resolve it there.
> >> >> >
> >> >> >> Can you collect a complete dmesg log including initial boot and your
> >> >> >> manual sysfs rescansand attach it to a new bugzilla report at
> >> >> >> https://bugzilla.kernel.org/enter_bug.cgi?component=PCI&product=Drivers
> >> >> >> ?  There might be some generic way we can fix this.
> >> >> >>
> >> >> >
> >> >> > I can do, though I have to say, it's a 3.8 Kernel from Freescale's SDK. I
> >> >> > don't really know if mainline wants to care about it.
> >> >>
> >> >> I don't think much has changed in this area since then, so I think
> >> >> this issue is still relevant.
> >> >>
> >> >> On x86 there's a boot command option "pci=assign-busses".  I don't
> >> >> think the boot option is implemented for other arches, so you'll
> >> >> probably have to change the source to accomplish the same thing.  Take
> >> >> a look at pcibios_assign_all_busses() for your platform.  If it
> >> >> doesn't already return "true", try changing it so it does.  It looks
> >> >> like we should try to assign bus numbers when
> >> >> pcibios_assign_all_busses() is true.
> >> >
> >> > Unfortunately this didn't change anything at all. As well as adding the
> >> > PCI_REASSIGN_ALL_RSRC flag. But while testing I've found the
> >> > ppc_md.pcibios_fixup_resources hook. I'll try to manually assign resources in
> >> > there or clear them and call the pci core's ressource allocation code. I'll post
> >> > an update once I make any progress.
> >>
> >> It's a generic problem -- there's nothing arch-specific about
> >> assigning bus numbers -- so it would be a shame to fix this in an
> >> arch-specific hook.
> >>
> >> Make sure you set CONFIG_PCI_DEBUG=y to get the extra debug messages
> >> from the probing path.
> >>
> >> Bjorn
> >
> > @ Bjorn:
> >
> > OK, I'll change my focus to drivers/pci then.
> >
> > CONFIG_PCI_DEBUG is on.
> >
> > --snip--
> > Found FSL PCI host bridge at 0x00000000fe200000. Firmware bus number: 0->5
> > PCI host bridge /pcie@fe200000 (primary) ranges:
> >  MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000
> >   IO 0x00000000f8000000..0x00000000f800ffff -> 0x0000000000000000
> > /pcie@fe200000: PCICSRBAR @ 0xff000000
> > PCI: Probing PCI hardware
> > fsl-pci fe200000.pcie: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff]
> > pci_bus 0000:00: root bus resource [bus 00-ff]
> > pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > pci 0000:00:00.0: PCI bridge to [bus 01]
> > pci 0000:00:00.0:   bridge window [io  0x0000-0xffff]
> > pci 0000:00:00.0:   bridge window [mem 0x80000000-0x9fffffff]
> > --snip--
>
> It saves time if you include the complete dmesg rather than snipping
> parts out of it (unless you need to strip out secret proprietary info,
> of course).
>
> > To me this looks like the bridge is set up correctly. But it fails to enumerate
> > subsequent bridges (please correct me if I'm wrong here).
>
> The "pci 0000:00:00.0: PCI bridge to [bus 01]" means the bridge is
> configured for only a single bus (bus 01) behind it.  You have a lot
> more stuff there, so the bridge has to be reconfigured before we can
> see it all.  Apparently this does happen when you do the rescans, so
> it would be useful to see the dmesg log that includes those.
> Eventually you'll see a similar line that says "pci 0000:00:00.0: PCI
> bridge to [bus 01-05]".
>
> Bjorn

--snip--
root@generic-powerpc:~# lspci
00:00.0 PCI bridge: Freescale Semiconductor Inc P4080 (rev 20)
[root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
pci_bus 0000:00: scanning bus
pcieport 0000:00:00.0: scanning [bus 01-01] behind bridge, pass 0
pcieport 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: scanning bus
pci 0000:01:00.0: [12d8:400a] type 01 class 0x060400
pci 0000:01:00.0: calling pcibios_fixup_resources+0x0/0x100
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:02: busn_res: can not insert [bus 02-ff] under [bus 01] (conflicts with (null) [bus 01])
pci_bus 0000:02: scanning bus
pci 0000:02:01.0: [12d8:400a] type 01 class 0x060400
pci 0000:02:01.0: calling pcibios_fixup_resources+0x0/0x100
pci 0000:02:01.0: supports D1 D2
pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:01.0: PME# disabled
pci 0000:02:02.0: [12d8:400a] type 01 class 0x060400
pci 0000:02:02.0: calling pcibios_fixup_resources+0x0/0x100
pci 0000:02:02.0: supports D1 D2
pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:02.0: PME# disabled
pci 0000:02:03.0: [12d8:400a] type 01 class 0x060400
pci 0000:02:03.0: calling pcibios_fixup_resources+0x0/0x100
pci 0000:02:03.0: supports D1 D2
pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:03.0: PME# disabled
pci_bus 0000:02: fixups for bus
pci 0000:01:00.0: PCI bridge to [bus 02-ff]
pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]
pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 0
pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:03: scanning bus
pci_bus 0000:03: fixups for bus
pci 0000:02:01.0: PCI bridge to [bus 03-ff]
pci 0000:02:01.0:   bridge window [io  0x0000-0x0fff]
pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci_bus 0000:03: bus scan returning with max=03
pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
pci_bus 0000:03: [bus 03] partially hidden behind bridge 0000:01 [bus 01-02]
pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:04: scanning bus
pci_bus 0000:04: fixups for bus
pci 0000:02:02.0: PCI bridge to [bus 04-ff]
pci 0000:02:02.0:   bridge window [io  0x0000-0x0fff]
pci 0000:02:02.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:02:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci_bus 0000:04: bus scan returning with max=04
pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
pci_bus 0000:04: [bus 04] partially hidden behind bridge 0000:01 [bus 01-02]
pci 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:05: scanning bus
pci_bus 0000:05: fixups for bus
pci 0000:02:03.0: PCI bridge to [bus 05-ff]
pci 0000:02:03.0:   bridge window [io  0x0000-0x0fff]
pci 0000:02:03.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:02:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
pci_bus 0000:05: bus scan returning with max=05
pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
pci_bus 0000:05: [bus 05] partially hidden behind bridge 0000:01 [bus 01-02]
pci_bus 0000:02: bus scan returning with max=05
pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
pci_bus 0000:01: bus scan returning with max=05
pci_bus 0000:01: busn_res: [bus 01-05] end can not be updated to 05
pci_bus 0000:00: bus scan returning with max=05
pcieport 0000:00:00.0: bridge window [mem 0x00100000-0x003fffff 64bit pref] to [bus 01-05] add_size 200000
pcieport 0000:00:00.0: res[9]=[mem 0x00100000-0x003fffff 64bit pref] get_res_add_size add_size 200000
pcieport 0000:00:00.0: BAR 9: can't assign mem pref (size 0x500000)
pci 0000:01:00.0: BAR 8: assigned [mem 0x80000000-0x802fffff]
pci 0000:01:00.0: BAR 9: assigned [mem 0x80300000-0x805fffff 64bit pref]
pci 0000:01:00.0: BAR 7: assigned [io  0x1000-0x3fff]
pci 0000:02:01.0: BAR 8: assigned [mem 0x80000000-0x800fffff]
pci 0000:02:01.0: BAR 9: assigned [mem 0x80300000-0x803fffff 64bit pref]
pci 0000:02:02.0: BAR 8: assigned [mem 0x80100000-0x801fffff]
pci 0000:02:02.0: BAR 9: assigned [mem 0x80400000-0x804fffff 64bit pref]
pci 0000:02:03.0: BAR 8: assigned [mem 0x80200000-0x802fffff]
pci 0000:02:03.0: BAR 9: assigned [mem 0x80500000-0x805fffff 64bit pref]
pci 0000:02:01.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:02:02.0: BAR 7: assigned [io  0x2000-0x2fff]
pci 0000:02:03.0: BAR 7: assigned [io  0x3000-0x3fff]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
pci 0000:02:01.0:   bridge window [mem 0x80000000-0x800fffff]
pci 0000:02:01.0:   bridge window [mem 0x80300000-0x803fffff 64bit pref]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:02:02.0:   bridge window [io  0x2000-0x2fff]
pci 0000:02:02.0:   bridge window [mem 0x80100000-0x801fffff]
pci 0000:02:02.0:   bridge window [mem 0x80400000-0x804fffff 64bit pref]
pci 0000:02:03.0: PCI bridge to [bus 05]
pci 0000:02:03.0:   bridge window [io  0x3000-0x3fff]
pci 0000:02:03.0:   bridge window [mem 0x80200000-0x802fffff]
pci 0000:02:03.0:   bridge window [mem 0x80500000-0x805fffff 64bit pref]
pci 0000:01:00.0: PCI bridge to [bus 02-05]
pci 0000:01:00.0:   bridge window [io  0x1000-0x3fff]
pci 0000:01:00.0:   bridge window [mem 0x80000000-0x802fffff]
pci 0000:01:00.0:   bridge window [mem 0x80300000-0x805fffff 64bit pref]
pci 0000:01:00.0: enabling device (0000 -> 0003)
pci 0000:01:00.0: enabling bus mastering
pci 0000:02:01.0: enabling device (0000 -> 0003)
pci 0000:02:01.0: enabling bus mastering
pci 0000:02:02.0: enabling device (0000 -> 0003)
pci 0000:02:02.0: enabling bus mastering
pci 0000:02:03.0: enabling device (0000 -> 0003)
pci 0000:02:03.0: enabling bus mastering
root@generic-powerpc:~# ~.Connected.
Connected.

Disconnected.
--snip--


This is what I get on boot with pci flag PCI_REASSIGN_ALL_BUS added.

--snip--
Found FSL PCI host bridge at 0x00000000fe200000. Firmware bus number: 0->5
PCI host bridge /pcie@fe200000 (primary) ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000
  IO 0x00000000f8000000..0x00000000f800ffff -> 0x0000000000000000
/pcie@fe200000: PCICSRBAR @ 0xff000000
PCI: Probing PCI hardware
fsl-pci fe200000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x80000000-0x9fffffff]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
pci_bus 0000:00: scanning bus
pci 0000:00:00.0: [1957:0401] type 01 class 0x0b2000
pci 0000:00:00.0: calling quirk_freescale_class+0x0/0x48
pci 0000:00:00.0: Setting PCI class for FSL PCI host bridge
pci 0000:00:00.0: reg 10: [mem 0xff000000-0xffffffff]
pci 0000:00:00.0: calling fixup_hide_host_resource_fsl+0x0/0x6c
pci 0000:00:00.0: calling pcibios_fixup_resources+0x0/0x100
pci 0000:00:00.0: calling quirk_fsl_pcie_header+0x0/0x84
pci 0000:00:00.0: supports D1 D2
pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:00.0: PME# disabled
pci_bus 0000:00: fixups for bus
pci 0000:00:00.0: scanning [bus 01-05] behind bridge, pass 0
pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
pci_bus 0000:01: scanning bus
pci_bus 0000:01: fixups for bus
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:00.0:   bridge window [mem 0x80000000-0x801fffff]
pci_bus 0000:01: bus scan returning with max=01
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci_bus 0000:00: bus scan returning with max=01
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will remap
PCI 0000:00 Cannot reserve Legacy IO [io  0x0000-0x0fff]
pci 0000:00:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000
pci 0000:00:00.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] get_res_add_size add_size 200000
pci 0000:00:00.0: BAR 0: can't assign mem (size 0x1000000)
pci 0000:00:00.0: BAR 9: can't assign mem pref (size 0x200000)
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x0000-0xffff]
pci 0000:00:00.0:   bridge window [mem 0x80000000-0x9fffffff]
pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
pci_bus 0000:00: resource 5 [mem 0x80000000-0x9fffffff]
pci_bus 0000:01: resource 0 [io  0x0000-0xffff]
pci_bus 0000:01: resource 1 [mem 0x80000000-0x9fffffff]
--snip--

Thanks,
Johannes
