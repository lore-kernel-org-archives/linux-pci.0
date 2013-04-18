Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:57134 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935794Ab3DRRlQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Apr 2013 13:41:16 -0400
Date: Thu, 18 Apr 2013 11:41:12 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Andrew Murray <andrew.murray@arm.com>
Cc: linux-pci@vger.kernel.org, linux@arm.linux.org.uk,
	linux-arm-kernel@lists.infradead.org
Subject: Re: I/O and multiple PCI buses
Message-ID: <20130418174112.GA1127@obsidianresearch.com>
References: <20130418152747.GA19258@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130418152747.GA19258@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 18, 2013 at 04:27:48PM +0100, Andrew Murray wrote:
> I'm trying to understand PCI I/O addressing in the kernel... (again)
> 
> I understand that ideally you want to give PCI bus addresses to PCI
> devices in the range of 0K to 64K. This seems to be achieved in
> pcibios_init_resources in arm's kernel/bios32.c implementation.

The ideal world (for small scale systems) is to have only one PCI host
bridge, and multiple root port bridges. This way the 0->64k range can
be shared between all the ports and this problem doesn't come up. Look
at how the new tegra and marvell work in this regard.

There are two motivations to use the low space.. Firstly some HW is
just broken with 32 bit IO because x86 doesn't use it. Secondly, the
legacy ISA 'no-BAR' or subtractive decode IO addresses are fixed (eg
0x3bx is VGA related) and the HW needs to be able to route them to the
VGA card, independently of the PCI compliant BAR based IO routing.

> What happens if you want to add another root bus? In this
> implementation the start address of the io_res is now 64K and as
> sys->io_offset is set to 0 the bus addresses under this second root
> bus will be 64K-128K - which I assume may break some things.

In this case you want to set io_offset for each host bridge to
translate 64k*nr -> 0 (ie, don't set it to 0) and IO map the right 64k
of MMIO space to 64k*nr to make this work.

The translation should look like:
  Linux driver does IO to 64k+1
  ARM io port wrapper translates 64k+1 to (IO base + 64k+1) virtual address
  TLB translates (IO base + 64k+1) to physical X+1
  HW converts physical X+1 to PCI IO transaction with IO address 1

The io_offset, which impacts pci_add_resource_offset, is used to tell
the Linux PCI core that BAR address 1, is actually seen in Linux as
IO 64k+1.

But, if you do this, I really recommend using separate PCI domains. It
is very wonky to see a single PCI bus hierarchy with overlapping
BAR addresses. Using proper bridges and sharing the space like x86
does is vastly preferred, IMHO.

> And to allow subsequent busses to use I/O starting from 0, you'd have to set
> sys->io_offset to 64K*nr and adapt functions such as pci_iomap to use the
> offset?

I think all the support is already there? The translation happens in
the PCI core when working with BARs, the Linux struct resource layer
already has io_offset included. The only impact the offset has is in
how the PCI core deals with BARs.

Regards,
Jason
