Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754949AbdBVSoy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Feb 2017 13:44:54 -0500
Date: Wed, 22 Feb 2017 12:44:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Partial BAR Address Allocation
Message-ID: <20170222184440.GA2132@bhelgaas-glaptop.roam.corp.google.com>
References: <35c6bec9-58e8-a1f7-5a85-d80c23480d32@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35c6bec9-58e8-a1f7-5a85-d80c23480d32@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 22, 2017 at 01:03:32PM -0500, Sinan Kaya wrote:
> We are carrying a big burden on our firmware to accommodate 32 bit
> non-prefetchable memory for supporting all BAR types. 
> 
> Endpoint drivers usually try to allocate both a 64 bit and a 32 bit
> BAR address for different platforms but they don't usually need both
> of them. 
> 
> I think the behavior changes from card to card. 
> 
> I'm looking for a way to get rid of 32 bit BAR addresses and support
> 64 bit BAR addresses only. 
> 
> I want to see the current state of the kernel. Do we know if all
> resources need to be assigned before a driver can become functional.
> I have seen some patches to relax this but I don't know the current
> status.

The kernel tries to assign space for all BARs because it doesn't know
what the driver will require.  It is possible for a driver to claim a
device even if the kernel was unable to assign space for all the BARs.

However, pci_enable_device() will fail if any BARs are unassigned.  If
a driver only requires I/O BARs or only requires memory BARs, it can
use pci_enable_device_io() or pci_enable_device_mem() instead.  Those
will succeed as long as all the I/O BARs (or all the memory BARs) are
assigned.

There is no way for a driver to say "I only need this memory BAR and
not the other ones."  The reason is because the PCI_COMMAND_MEMORY bit
enables *all* the memory BARs; there's no way to enable memory BARs
selectively.  If we enable memory BARs and one of them is unassigned,
that unassigned BAR is enabled, and the device will respond at
whatever address the register happens to contain, and that may cause
conflicts.

I'm not sure this answers your question.  Do you want to get rid of
32-bit BAR addresses because your host bridge doesn't have a window to
32-bit PCI addresses?  It's typical for a bridge to support a window
to the 32-bit PCI space as well as one to the 64-bit PCI space.  Often
it performs address translation for the 32-bit window so it doesn't
have to be in the 32-bit area on the CPU side, e.g., you could have
something like this where we have three host bridges and the 2-4GB
space on each PCI root bus is addressable:

  pci_bus 0000:00: root bus resource [mem 0x1080000000-0x10ffffffff] (bus address [0x80000000-0xffffffff])
  pci_bus 0001:00: root bus resource [mem 0x1180000000-0x11ffffffff] (bus address [0x80000000-0xffffffff])
  pci_bus 0002:00: root bus resource [mem 0x1280000000-0x12ffffffff] (bus address [0x80000000-0xffffffff])

Bjorn
