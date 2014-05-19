Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:39460 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaESHBU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 03:01:20 -0400
Date: Mon, 19 May 2014 02:59:00 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Linux PCI mailing list <linux-pci@vger.kernel.org>
Subject: Re: could the [x86] Kconfig content for PCI be cleaned up at all?
In-Reply-To: <CAErSpo6jn1gG=s9Vaz0_Lvf-ZKi=1QUz0WRZ55St--LBOUSZ7Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1405190256070.31506@localhost>
References: <alpine.LFD.2.11.1405170706260.536@localhost> <CAErSpo6jn1gG=s9Vaz0_Lvf-ZKi=1QUz0WRZ55St--LBOUSZ7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 17 May 2014, Bjorn Helgaas wrote:

> On Sat, May 17, 2014 at 5:29 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   digging through the current PCI code and Kconfig files and it seems
> > like some of that could be made simpler, but i'm willing to be
> > convinced otherwise.
>
> I'm sure it could be cleaned up, and it would be great if you did!
>
> I don't know the reason why all the arches source
> drivers/pci/pcie/Kconfig directly; it seems like that should be done
> from drivers/pci/Kconfig.
>
> >   first, from arch/x86/Kconfig, rather than simply sourcing the file
> > "drivers/pci/Kconfig" (as is done with many other drivers
> > directories), that Kconfig file defines:
> >
> >   menu "Bus options (PCI etc.)"
> >
> >   config PCI
> >         bool "PCI support"
> >         default y
> >   ... snip ...
> >
> > and later on, sources the Kconfig files for PCI and PCIe individually:
> >
> >   source "drivers/pci/pcie/Kconfig"
> >
> >   source "drivers/pci/Kconfig"
> >
> > and even further down, finally sources the file for PCI hotplug after
> > PCMCIA:
> >
> >   source "drivers/pcmcia/Kconfig"
> >
> >   source "drivers/pci/hotplug/Kconfig"

   ... snip ...

> I don't know all the history behind what we have now, so I can't
> give you much advice.  I think you just have to work through the
> process of simplifying things and see whether it turns out to be
> feasible.

  one of the quirky features of the current Kconfig layout is that, in
some arch Kconfig files, the main PCI content is included, then
pcmcia, *then* PCI hotplug, which means that when you pop into
something like "make menuconfig" and wander over to the PCI menu, you
see the majority of PCI selections, then the selection for PCCard, and
*then* the choice for PCI hotplug, which strikes me as just, well, odd
and confusing since, if you deselect PCI entirely, almost everything
goes away except for (you guessed it) PCCard. (and that framebuffer
selection as well.)

  as you say, there may be some historical inertia as to why things
were done this way, but is there any *technical* reason why everything
PCI-related can't just hang off of the drivers/pci/ directory via a
single "source" directive?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
