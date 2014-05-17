Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:55627 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030185AbaEQRba (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 17 May 2014 13:31:30 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so2000381igq.1
        for <linux-pci@vger.kernel.org>; Sat, 17 May 2014 10:31:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.11.1405170706260.536@localhost>
References: <alpine.LFD.2.11.1405170706260.536@localhost>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 17 May 2014 11:31:09 -0600
Message-ID: <CAErSpo6jn1gG=s9Vaz0_Lvf-ZKi=1QUz0WRZ55St--LBOUSZ7Q@mail.gmail.com>
Subject: Re: could the [x86] Kconfig content for PCI be cleaned up at all?
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Linux PCI mailing list <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 17, 2014 at 5:29 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   digging through the current PCI code and Kconfig files and it seems
> like some of that could be made simpler, but i'm willing to be
> convinced otherwise.

I'm sure it could be cleaned up, and it would be great if you did!

I don't know the reason why all the arches source
drivers/pci/pcie/Kconfig directly; it seems like that should be done
from drivers/pci/Kconfig.

>   first, from arch/x86/Kconfig, rather than simply sourcing the file
> "drivers/pci/Kconfig" (as is done with many other drivers
> directories), that Kconfig file defines:
>
>   menu "Bus options (PCI etc.)"
>
>   config PCI
>         bool "PCI support"
>         default y
>   ... snip ...
>
> and later on, sources the Kconfig files for PCI and PCIe individually:
>
>   source "drivers/pci/pcie/Kconfig"
>
>   source "drivers/pci/Kconfig"
>
> and even further down, finally sources the file for PCI hotplug after
> PCMCIA:
>
>   source "drivers/pcmcia/Kconfig"
>
>   source "drivers/pci/hotplug/Kconfig"
>
> given the dependencies, could all of this not be encapsulated in the
> top-level Kconfig files under drivers/pci?
>
>   next, in drivers/Makefile, pci code is pulled in with the single
> statement:
>
>   obj-$(CONFIG_PCI)               += pci/
>
> given that, can't one drop all the "depends on PCI" directives from
> the file drivers/pci/Kconfig? or just wrap the whole file in a "if
> PCI" test? (unless there's something i'm missing here.)
>
>   and could the same thing not be said for the pcie/ subdirectory?
> drivers/pci/Makefile contains the line:
>
>   obj-$(CONFIG_PCIEPORTBUS) += pcie/
>
> with the dependency in drivers/pci/pcie/Kconfig:
>
>   config PCIEPORTBUS
>         bool "PCI Express Port Bus support"
>         depends on PCI
>
> suggesting that drivers/pci/pcie/Kconfig could also be simplified
> quite a bit by dropping redundant dependency directives.
>
>   thoughts?

I don't know all the history behind what we have now, so I can't give
you much advice.  I think you just have to work through the process of
simplifying things and see whether it turns out to be feasible.

Bjorn
