Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.176]:33145 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753642Ab3H2Igh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2013 04:36:37 -0400
Date: Thu, 29 Aug 2013 10:29:42 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Johannes Thumshirn <johannes.thumshirn@men.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: PCI reset problem
Message-ID: <20130829082941.GA11203@jtlinux>
References: <20130828133337.GA8544@jtlinux>
 <CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 28, 2013 at 10:50:58AM -0600, Bjorn Helgaas wrote:
> [+cc Yinghai]
>
> On Wed, Aug 28, 2013 at 7:33 AM, Johannes Thumshirn
> <johannes.thumshirn@men.de> wrote:
> > Hi List,
> >
> > I have a rather odd problem with a PCIe swicht/bridge which does not get
> > enumerated correctly. If I issue _two_ manual rescans of the PCI bus via sysfs,
> > everything get setup correctly. To work around the problem I decided to make a
> > platform specific PCI quirk (for the embedded system I'm on, to not break
> > anything else) and issue the pci_rescan_bus() myself as a "final" fixup. However
> > this does not have any effect at all.
> >
> > Does anyone have an idea what I could do wrong?
>
> A rescan doesn't really do anything differently from the initial
> boot-time scan.  Maybe there's an issue with the switch taking a long
> time to respond after reset?  But that doesn't seem likely, because if
> you do manual rescans via sysfs, that should give plenty of time and
> you wouldn't have to do it *twice*.
>
> Maybe there's some resource or bus number allocation issue such that
> we don't even get down to the problem switch the first couple of
> times?
>
> > Example:
> > root@generic-powerpc:~# lspci -tv
> > -[0000:00]---00.0-[01]--
> > root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> > [...]
> > root@generic-powerpc:~# lspci -tv
> > -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]--
> >                                            +-02.0-[04]--
> >                                            \-03.0-[05]--
> > root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
> > [...]
> > root@generic-powerpc:~# lspci -tv
> > -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]----00.0  Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
> >                                            +-02.0-[04]--
> >                                            \-03.0-[05]--+-00.0  Pericom Semiconductor Device 400e
> >                                                         +-00.1  Pericom Semiconductor Device 400e
> >                                                         \-00.2  Pericom Semiconductor Device 400f
>
> I bet that's what's happening: the first lspci shows the 00:00.0
> bridge leading only to bus 01.  The second lspci shows 00:00.0 leading
> to [bus 01-05], so its bus number aperture has been reconfigured.
>
> On x86 the BIOS typically configures all the bridges so we can see all
> the devices.  But it looks like your platform doesn't, and the Linux
> paths that do similar configuration are not as well exercised.
>

I'll have a look into my U-Boot again as well, maybe I can resolve it there.

> Can you collect a complete dmesg log including initial boot and your
> manual sysfs rescansand attach it to a new bugzilla report at
> https://bugzilla.kernel.org/enter_bug.cgi?component=PCI&product=Drivers
> ?  There might be some generic way we can fix this.
>

I can do, though I have to say, it's a 3.8 Kernel from Freescale's SDK. I
don't really know if mainline wants to care about it.

> Bjorn
>
> > "My" rescan quirk:
> > #if CONFIG_PCI
> > static DEFINE_MUTEX(rescan_mutex);
> > static void xm51_fixup_bridge(struct pci_dev *dev)
> > {
> >         struct pci_bus *b = NULL;
> >
> >         mutex_lock(&rescan_mutex);
> >         while((b = pci_find_next_bus(b)) != NULL)
> >                 pci_rescan_bus(b);
> >         mutex_unlock(&rescan_mutex);
> > }
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, 0x0401, xm51_fixup_bridge);
> > #endif
> >
> >
> > Thanks in advance,
> > Johannes
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

Johannes
