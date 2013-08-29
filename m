Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:49913 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab3H2Pwv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2013 11:52:51 -0400
Received: by mail-ie0-f179.google.com with SMTP id m16so920355ieq.10
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2013 08:52:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130829150723.GA32730@jtlinux>
References: <20130828133337.GA8544@jtlinux> <CAErSpo5sa2cJXOUhfe5VDzxwabf0Um42ZfBwOMhF1TbwCW9G=w@mail.gmail.com>
 <20130829082941.GA11203@jtlinux> <CAErSpo56RszdMQDOY8xCmz=1QP-osUGA71V56t9X9zY4rNAYew@mail.gmail.com>
 <20130829150723.GA32730@jtlinux>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 29 Aug 2013 09:52:30 -0600
Message-ID: <CAErSpo5nTy7bkU2_ZMR_sROz-FJF28a==eUdE3e-wZoZfzQZBw@mail.gmail.com>
Subject: Re: PCI reset problem
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 29, 2013 at 9:07 AM, Johannes Thumshirn
<johannes.thumshirn@men.de> wrote:
> On Thu, Aug 29, 2013 at 06:01:43AM -0600, Bjorn Helgaas wrote:
>> On Thu, Aug 29, 2013 at 2:29 AM, Johannes Thumshirn
>> <johannes.thumshirn@men.de> wrote:
>> > On Wed, Aug 28, 2013 at 10:50:58AM -0600, Bjorn Helgaas wrote:
>> >> [+cc Yinghai]
>> >>
>> >> On Wed, Aug 28, 2013 at 7:33 AM, Johannes Thumshirn
>> >> <johannes.thumshirn@men.de> wrote:
>> >> > Hi List,
>> >> >
>> >> > I have a rather odd problem with a PCIe swicht/bridge which does not get
>> >> > enumerated correctly. If I issue _two_ manual rescans of the PCI bus via sysfs,
>> >> > everything get setup correctly. To work around the problem I decided to make a
>> >> > platform specific PCI quirk (for the embedded system I'm on, to not break
>> >> > anything else) and issue the pci_rescan_bus() myself as a "final" fixup. However
>> >> > this does not have any effect at all.
>> >> >
>> >> > Does anyone have an idea what I could do wrong?
>> >>
>> >> A rescan doesn't really do anything differently from the initial
>> >> boot-time scan.  Maybe there's an issue with the switch taking a long
>> >> time to respond after reset?  But that doesn't seem likely, because if
>> >> you do manual rescans via sysfs, that should give plenty of time and
>> >> you wouldn't have to do it *twice*.
>> >>
>> >> Maybe there's some resource or bus number allocation issue such that
>> >> we don't even get down to the problem switch the first couple of
>> >> times?
>> >>
>> >> > Example:
>> >> > root@generic-powerpc:~# lspci -tv
>> >> > -[0000:00]---00.0-[01]--
>> >> > root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
>> >> > [...]
>> >> > root@generic-powerpc:~# lspci -tv
>> >> > -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]--
>> >> >                                            +-02.0-[04]--
>> >> >                                            \-03.0-[05]--
>> >> > root@generic-powerpc:~# echo 1 > /sys/bus/pci/rescan
>> >> > [...]
>> >> > root@generic-powerpc:~# lspci -tv
>> >> > -[0000:00]---00.0-[01-05]----00.0-[02-05]--+-01.0-[03]----00.0  Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
>> >> >                                            +-02.0-[04]--
>> >> >                                            \-03.0-[05]--+-00.0  Pericom Semiconductor Device 400e
>> >> >                                                         +-00.1  Pericom Semiconductor Device 400e
>> >> >                                                         \-00.2  Pericom Semiconductor Device 400f
>> >>
>> >> I bet that's what's happening: the first lspci shows the 00:00.0
>> >> bridge leading only to bus 01.  The second lspci shows 00:00.0 leading
>> >> to [bus 01-05], so its bus number aperture has been reconfigured.
>> >>
>> >> On x86 the BIOS typically configures all the bridges so we can see all
>> >> the devices.  But it looks like your platform doesn't, and the Linux
>> >> paths that do similar configuration are not as well exercised.
>> >>
>> >
>> > I'll have a look into my U-Boot again as well, maybe I can resolve it there.
>> >
>> >> Can you collect a complete dmesg log including initial boot and your
>> >> manual sysfs rescansand attach it to a new bugzilla report at
>> >> https://bugzilla.kernel.org/enter_bug.cgi?component=PCI&product=Drivers
>> >> ?  There might be some generic way we can fix this.
>> >>
>> >
>> > I can do, though I have to say, it's a 3.8 Kernel from Freescale's SDK. I
>> > don't really know if mainline wants to care about it.
>>
>> I don't think much has changed in this area since then, so I think
>> this issue is still relevant.
>>
>> On x86 there's a boot command option "pci=assign-busses".  I don't
>> think the boot option is implemented for other arches, so you'll
>> probably have to change the source to accomplish the same thing.  Take
>> a look at pcibios_assign_all_busses() for your platform.  If it
>> doesn't already return "true", try changing it so it does.  It looks
>> like we should try to assign bus numbers when
>> pcibios_assign_all_busses() is true.
>
> Unfortunately this didn't change anything at all. As well as adding the
> PCI_REASSIGN_ALL_RSRC flag. But while testing I've found the
> ppc_md.pcibios_fixup_resources hook. I'll try to manually assign resources in
> there or clear them and call the pci core's ressource allocation code. I'll post
> an update once I make any progress.

It's a generic problem -- there's nothing arch-specific about
assigning bus numbers -- so it would be a shame to fix this in an
arch-specific hook.

Make sure you set CONFIG_PCI_DEBUG=y to get the extra debug messages
from the probing path.

Bjorn
