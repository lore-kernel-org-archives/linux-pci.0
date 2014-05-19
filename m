Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:53910 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbaESNRb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 09:17:31 -0400
Received: by mail-ig0-f178.google.com with SMTP id hl10so3500419igb.5
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 06:17:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.11.1405190256070.31506@localhost>
References: <alpine.LFD.2.11.1405170706260.536@localhost> <CAErSpo6jn1gG=s9Vaz0_Lvf-ZKi=1QUz0WRZ55St--LBOUSZ7Q@mail.gmail.com>
 <alpine.LFD.2.11.1405190256070.31506@localhost>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 19 May 2014 07:17:10 -0600
Message-ID: <CAErSpo6apP+kv0sVGj4mgqdWHw78hLs7HcEbBdFYsommEaP8_w@mail.gmail.com>
Subject: Re: could the [x86] Kconfig content for PCI be cleaned up at all?
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Linux PCI mailing list <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 19, 2014 at 12:59 AM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
> On Sat, 17 May 2014, Bjorn Helgaas wrote:
>
>> On Sat, May 17, 2014 at 5:29 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>> >
>> >   digging through the current PCI code and Kconfig files and it seems
>> > like some of that could be made simpler, but i'm willing to be
>> > convinced otherwise.
>>
>> I'm sure it could be cleaned up, and it would be great if you did!
>>
>> I don't know the reason why all the arches source
>> drivers/pci/pcie/Kconfig directly; it seems like that should be done
>> from drivers/pci/Kconfig.
>>
>> >   first, from arch/x86/Kconfig, rather than simply sourcing the file
>> > "drivers/pci/Kconfig" (as is done with many other drivers
>> > directories), that Kconfig file defines:
>> >
>> >   menu "Bus options (PCI etc.)"
>> >
>> >   config PCI
>> >         bool "PCI support"
>> >         default y
>> >   ... snip ...
>> >
>> > and later on, sources the Kconfig files for PCI and PCIe individually:
>> >
>> >   source "drivers/pci/pcie/Kconfig"
>> >
>> >   source "drivers/pci/Kconfig"
>> >
>> > and even further down, finally sources the file for PCI hotplug after
>> > PCMCIA:
>> >
>> >   source "drivers/pcmcia/Kconfig"
>> >
>> >   source "drivers/pci/hotplug/Kconfig"
>
>    ... snip ...
>
>> I don't know all the history behind what we have now, so I can't
>> give you much advice.  I think you just have to work through the
>> process of simplifying things and see whether it turns out to be
>> feasible.
>
>   one of the quirky features of the current Kconfig layout is that, in
> some arch Kconfig files, the main PCI content is included, then
> pcmcia, *then* PCI hotplug, which means that when you pop into
> something like "make menuconfig" and wander over to the PCI menu, you
> see the majority of PCI selections, then the selection for PCCard, and
> *then* the choice for PCI hotplug, which strikes me as just, well, odd
> and confusing since, if you deselect PCI entirely, almost everything
> goes away except for (you guessed it) PCCard. (and that framebuffer
> selection as well.)
>
>   as you say, there may be some historical inertia as to why things
> were done this way, but is there any *technical* reason why everything
> PCI-related can't just hang off of the drivers/pci/ directory via a
> single "source" directive?

Not that I'm aware of.  Give it a try and we'll see what happens.

Bjorn
