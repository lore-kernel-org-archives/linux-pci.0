Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:52818 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805Ab3LIV1q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Dec 2013 16:27:46 -0500
Date: Mon, 9 Dec 2013 14:27:44 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Stop clearing bridge Secondary Status when
 setting up I/O aperture
Message-ID: <20131209212744.GK5429@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001954.27659.78163.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131209193332.GB20199@obsidianresearch.com>
 <CAErSpo4Q-sjiCUs3UbQWdPhOTdxfJP1ay1MugxTPT1E2=TkpJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4Q-sjiCUs3UbQWdPhOTdxfJP1ay1MugxTPT1E2=TkpJw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 09, 2013 at 01:15:52PM -0700, Bjorn Helgaas wrote:

> Is there actually some spec requirement about the access sizes that
> must be supported by the hardware?  If there is something, I'll gladly
> keep the 32-bit access, but if it's only a tegra/mvebu-specific
> restriction, then I think it needs to be handled in the PCI config
> accessors for that hardware.

The host register interface is not specified by any standard.

I looked a for a bit and found other drivers with the same problem:
  arch/arm/mach-cns3xxx/pcie.c
  arch/arm/mach-iop13xx/pci.c
  arch/arm/mach-ks8695/pci.c
  arch/arm/mach-sa1100/pci-nanoengine.c
 [..]

I stopped looking after that point..

> This spec statement (PCI (not PCIe) r3.0, sec 3.2.2.3.4) makes it
> sound like tegra/mvebu is non-conforming and should deal with this
> specially:
> 
> "A function must not restrict the size of the access it supports in
> Configuration Space. The configuration commands, like other commands,
> allow data to be accessed using any combination of bytes (including a
> byte, word, DWORD, or non-contiguous bytes) and multiple data phases
> in a burst. The target is required to handle any combination of byte
> enables."

This verbage is talking about the target/responder, not the host. Any
target must respond to all possible sizes for all possible config
registers, including combinations that even x86 can't issue (like a BE
pattern of b0110)

> I think the tegra/mvebu accessors should be able to use the address
> and access size to figure out what we're trying to do.  If we're doing
> a WORD write to PCI_IO_BASE, it can turn that into: 32-bit read, clear
> the upper 16 bits (secondary status), insert the PCI_IO_BASE part,
> 32-bit write.  If we're doing a 16-bit write to PCI_SEC_STATUS, it can
> turn that into: 32-bit read, insert upper 16 bits (secondary status),
> leave lower 16 bits alone, 32-bit write.

Seems reasonable, but this obviously shouldn't be open coded in every
driver..

Maybe pci_ops should gain a read32/write32 and HW that can only do 32
bit access should not define read/write. The core code could provide
read/write functions to do the bit mangling for all possibilities?
That would be very clear what is going on.

Jason
