Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:49466 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaERHQx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 May 2014 03:16:53 -0400
Date: Sun, 18 May 2014 03:14:32 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Linux PCI mailing list <linux-pci@vger.kernel.org>
Subject: Re: could the [x86] Kconfig content for PCI be cleaned up at all?
In-Reply-To: <CAErSpo6jn1gG=s9Vaz0_Lvf-ZKi=1QUz0WRZ55St--LBOUSZ7Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1405180307470.10223@localhost>
References: <alpine.LFD.2.11.1405170706260.536@localhost> <CAErSpo6jn1gG=s9Vaz0_Lvf-ZKi=1QUz0WRZ55St--LBOUSZ7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 17 May 2014, Bjorn Helgaas wrote:

> On Sat, May 17, 2014 at 5:29 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   digging through the current PCI code and Kconfig files and it
> > seems like some of that could be made simpler, but i'm willing to
> > be convinced otherwise.
>
> I'm sure it could be cleaned up, and it would be great if you did!
>
> I don't know the reason why all the arches source
> drivers/pci/pcie/Kconfig directly; it seems like that should be done
> from drivers/pci/Kconfig.

  that's what i thought, but i'll look more closely to see if there's
some subtlety there.

  at the very least, i can submit a patch for both:

  * .../pci/Kconfig
  * .../pci/pcie/Kconfig

that removes all the extraneous dependencies on PCI and PCIEPORTBUS,
respectively, and just wraps the files in a single "if" condition,
unless someone has a reason why that wouldn't work.  you know, along
the lines of acpi/Kconfig and many others:

  menuconfig ACPI
        bool "ACPI (Advanced Configuration and Power Interface) Support"
        ... snip ...

  if ACPI
        ... big snip, entire rest of file ...
  endif # ACPI

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
