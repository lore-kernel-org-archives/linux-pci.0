Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754030AbcHXQug (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Aug 2016 12:50:36 -0400
Date: Wed, 24 Aug 2016 11:50:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: divakar <divakar.chitturi@hpe.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: pci_enable_device error
Message-ID: <20160824165031.GB23914@localhost>
References: <2771432.urgYcWSoQk@div_linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2771432.urgYcWSoQk@div_linux>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 04:24:37PM -0700, divakar wrote:
> Hi
> 
> I am trying to enable the pci device in the driver by calling the 
> function, pci_enable_device and i get the below error. 
> 
> fpga_pci_uio_driver 0000:4e:00.0: can't enable device: BAR 0 [mem 
> 0x00000000-0x000fffff 64bit pref] not claimed
> fpga_pci_uio_driver 0000:4e:00.0: Failed to enable fpga_pci_uio device 
> rc=-22
> fpga_pci_uio_driver: probe of 0000:4e:00.0 failed with error -22
> 
> I am guessing its coming from pci_enable_resource function in 
> pci_setup.c. ( trying to setup debug env to trace exact location)
> if (!r->parent) {
>                          dev_err(&dev->dev, "can't enable device: BAR %d 
> %pR not claimed\n",
>                                  i, r);
>                          return -EINVAL;
>            	}
> 
> I am not sure why this condition is false. I am running kernel 3.19 and 
> this is a pcie endpoint device sitting on one of the port of the pcie 
> switch. Below is the dmesg output for the pcie switch port. 
> 
> [   13.586987] pci 0000:4b:04.0: PCI bridge to [bus 4e]
> [   13.591069] pci 0000:4b:04.0:   bridge window [mem 0xc7c00000-0xc7ffffff 
> 64bit pref]
> 
> lspci output for my device
> lspci -v -s 4e:00.0
> 4e:00.0 Non-VGA unclassified device:  Company Device 0180 
> (rev 01)
>         Flags: fast devsel
>         Memory at <unassigned> (64-bit, prefetchable) [size=1M]
>         Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
>         Capabilities: [78] Power Management version 3
>         Capabilities: [80] Express Endpoint, MSI 00
>         Capabilities: [100] Multi-Function Virtual Channel <?>
> 
> The other device on different port of the switch work fine. That device 
> driver also calls pci_enable_device(dev).
> 
> I found a thread http://www.spinics.net/lists/linux-pci/msg49725.html 
> discussing something similar. Should i apply any patch to solve it? or 
> am i missing something?

There's no address space assigned for BAR 0 of the 4e:00.0 device, so
we can't enable it.  A full dmesg log will show whether this is
because we ran out of address space or some other cause.

Bjorn
