Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.148]:14185 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752453Ab3H3IBn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Aug 2013 04:01:43 -0400
Date: Fri, 30 Aug 2013 10:01:39 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI reset problem
Message-ID: <20130830080138.GA24908@jtlinux>
References: <20130828133337.GA8544@jtlinux>
 <CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
 <20130829082941.GA11203@jtlinux>
 <CAErSpo56RszdMQDOY8xCmz=1QP-osUGA71V56t9X9zY4rNAYew@mail.gmail.com>
 <20130829150723.GA32730@jtlinux>
 <CAErSpo5nTy7bkU2_ZMR_sROz-FJF28a==eUdE3e-wZoZfzQZBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo5nTy7bkU2_ZMR_sROz-FJF28a==eUdE3e-wZoZfzQZBw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 29, 2013 at 09:52:30AM -0600, Bjorn Helgaas wrote:
> On Thu, Aug 29, 2013 at 9:07 AM, Johannes Thumshirn
> <johannes.thumshirn@men.de> wrote:
> > On Thu, Aug 29, 2013 at 06:01:43AM -0600, Bjorn Helgaas wrote:
> >> On Thu, Aug 29, 2013 at 2:29 AM, Johannes Thumshirn
> >> <johannes.thumshirn@men.de> wrote:
> >> > On Wed, Aug 28, 2013 at 10:50:58AM -0600, Bjorn Helgaas wrote:
> >> >> [+cc Yinghai]
> >> >>
> >> >> On Wed, Aug 28, 2013 at 7:33 AM, Johannes Thumshirn
> >> >> <johannes.thumshirn@men.de> wrote:
> >> >> > Hi List,
> >> >> >
> >> >> > I have a rather odd problem with a PCIe swicht/bridge which does not get
> >> >> > enumerated correctly. If I issue _two_ manual rescans of the PCI bus via sysfs,
> >> >> > everything get setup correctly. To work around the problem I decided to make a
> >> >> > platform specific PCI quirk (for the embedded system I'm on, to not break
> >> >> > anything else) and issue the pci_rescan_bus() myself as a "final" fixup. However
> >> >> > this does not have any effect at all.
> >> >> >
> >> >> > Does anyone have an idea what I could do wrong?
> >> >>
> >> >> A rescan doesn't really do anything differently from the initial
> >> >> boot-time scan.  Maybe there's an issue with the switch taking a long
> >> >> time to respond after reset?  But that doesn't seem likely, because if
> >> >> you do manual rescans via sysfs, that should give plenty of time and
> >> >> you wouldn't have to do it *twice*.
> >> >>
> >> >> Maybe there's some resource or bus number allocation issue such that
> >> >> we don't even get down to the problem switch the first couple of
> >> >> times?
> >> >>
> >> >> > Example:
> >> >> > root@generic-powerpc:~# lspci -tv
> >> >> > -[0000:00]---00.0-[01]--
> >> >> > root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> >> >> > [...]
> >> >> > root@generic-powerpc:~# lspci -tv
> >> >> > -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]--
> >> >> >                                            +-02.0-[04]--
> >> >> >                                            \-03.0-[05]--
> >> >> > root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> >> >> > [...]
> >> >> > root@generic-powerpc:~# lspci -tv
> >> >> > -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]----00.0  Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
> >> >> >                                            +-02.0-[04]--
> >> >> >                                            \-03.0-[05]--+-00.0  Pericom Semiconductor Device 400e
> >> >> >                                                         +-00.1  Pericom Semiconductor Device 400e
> >> >> >                                                         \-00.2  Pericom Semiconductor Device 400f
> >> >>
> >> >> I bet that's what's happening: the first lspci shows the 00:00.0
> >> >> bridge leading only to bus 01.  The second lspci shows 00:00.0 leading
> >> >> to [bus 01-05], so its bus number aperture has been reconfigured.
> >> >>
> >> >> On x86 the BIOS typically configures all the bridges so we can see all
> >> >> the devices.  But it looks like your platform doesn't, and the Linux
> >> >> paths that do similar configuration are not as well exercised.
> >> >>
> >> >
> >> > I'll have a look into my U-Boot again as well, maybe I can resolve it there.
> >> >
> >> >> Can you collect a complete dmesg log including initial boot and your
> >> >> manual sysfs rescansand attach it to a new bugzilla report at
> >> >> https://bugzilla.kernel.org/enter_bug.cgi?component=PCI&product=Drivers
> >> >> ?  There might be some generic way we can fix this.
> >> >>
> >> >
> >> > I can do, though I have to say, it's a 3.8 Kernel from Freescale's SDK. I
> >> > don't really know if mainline wants to care about it.
> >>
> >> I don't think much has changed in this area since then, so I think
> >> this issue is still relevant.
> >>
> >> On x86 there's a boot command option "pci=assign-busses".  I don't
> >> think the boot option is implemented for other arches, so you'll
> >> probably have to change the source to accomplish the same thing.  Take
> >> a look at pcibios_assign_all_busses() for your platform.  If it
> >> doesn't already return "true", try changing it so it does.  It looks
> >> like we should try to assign bus numbers when
> >> pcibios_assign_all_busses() is true.
> >
> > Unfortunately this didn't change anything at all. As well as adding the
> > PCI_REASSIGN_ALL_RSRC flag. But while testing I've found the
> > ppc_md.pcibios_fixup_resources hook. I'll try to manually assign resources in
> > there or clear them and call the pci core's ressource allocation code. I'll post
> > an update once I make any progress.
>
> It's a generic problem -- there's nothing arch-specific about
> assigning bus numbers -- so it would be a shame to fix this in an
> arch-specific hook.
>
> Make sure you set CONFIG_PCI_DEBUG=y to get the extra debug messages
> from the probing path.
>
> Bjorn

@ Bjorn:

OK, I'll change my focus to drivers/pci then.

CONFIG_PCI_DEBUG is on.

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
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [io  0x0000-0xffff]
pci 0000:00:00.0:   bridge window [mem 0x80000000-0x9fffffff]
--snip--

To me this looks like the bridge is set up correctly. But it fails to enumerate
subsequent bridges (please correct me if I'm wrong here).

The resources match my configuration in U-Boot. IO @ 0x0000-0xffff and MEM @
0x80000000-0x9fffffff.

@ Yinghai

I'll test on mainline and then check pci-busn-alloc, but I have this strange
feeling that it could be an interaction with Freescale's DPAA Ethernet, which is
not yet merged into mainline.


Thanks a lot,
Johannes
