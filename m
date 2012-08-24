Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54263 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab2HXVZ0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Aug 2012 17:25:26 -0400
Received: by lbbgj3 with SMTP id gj3so1426016lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 24 Aug 2012 14:25:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 24 Aug 2012 15:25:04 -0600
Message-ID: <CAErSpo6dZdy5tPRsuFubE2Ctk=rtdV8J_KTRN2i2SMbY-hLN-A@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Clean up drivers/pci/remove.c
To: linux-pci@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2012 at 5:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This started as a simple conversion of list_for_each() to
> list_for_each_entry(), so I could remove the pci_dev_b() helper.
>
> In the process, I noticed that drivers/pci/remove.c is getting a little
> crufty, so I reworked it to make it more understandable.  This is a long
> series of small patches, so it might be easiest to start by looking at the
> end product, so you have some idea where I'm heading.

I applied this series (with the pcmcia fix suggested by Yinghai) to my
"next" branch.

> Here's the final version of remove.c:
> http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=blob;f=drivers/pci/remove.c/pci/remove.c;h=4f9ca9162895edd8216fda36e055949541d44012;hb=refs/heads/pci/bjorn-cleanup-remove
>
> This is based on v3.6-rc1 and replaces the 6-patch series I posted on Aug 16.
>
> I've booted this on x86, but I don't have facilities to test the
> interesting hotplug changes, so any review and/or testing is welcome.
>
> ---
>
> Bjorn Helgaas (16):
>       PCI: acpiphp: Stop disabling bridges on remove
>       PCI: acpiphp: Use common pci_stop_and_remove_bus_device()
>       pcmcia: Use common pci_stop_and_remove_bus_device()
>       PCI: Don't export stop_bus_device and remove_bus_device interfaces
>       PCI: Remove pci_stop_and_remove_behind_bridge()
>       PCI: Use list_for_each_entry() for bus->devices traversal
>       PCI: Fold stop and remove helpers into their callers
>       PCI: Stop and remove devices in one pass
>       PCI: Remove unused, commented-out, code
>       PCI: Rename local variables to conventional names
>       PCI: Leave normal LIST_POISON in deleted list entries
>       frv/PCI: Use list_for_each_entry() for bus->devices traversal
>       parisc/PCI: Enable PERR/SERR on all devices
>       parisc/PCI: Use list_for_each_entry() for bus->devices traversal
>       sgi-agp: Use list_for_each_entry() for bus->devices traversal
>       PCI: Remove unused pci_dev_b()
>
>
>  arch/frv/mb93090-mb00/pci-vdk.c    |    4 -
>  drivers/char/agp/sgi-agp.c         |    5 +
>  drivers/parisc/dino.c              |    6 +-
>  drivers/parisc/lba_pci.c           |    7 +-
>  drivers/pci/hotplug/acpiphp_glue.c |   46 -------------
>  drivers/pci/proc.c                 |   19 -----
>  drivers/pci/remove.c               |  131 ++++++------------------------------
>  drivers/pci/rom.c                  |   59 ----------------
>  drivers/pci/search.c               |    6 +-
>  drivers/pcmcia/cardbus.c           |    7 +-
>  include/linux/pci.h                |    4 -
>  11 files changed, 37 insertions(+), 257 deletions(-)
