Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32949 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933014AbbJHQ0f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Oct 2015 12:26:35 -0400
Date: Thu, 8 Oct 2015 11:26:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] mvebu PCI fixes and cleanups
Message-ID: <20151008162631.GE3885@localhost>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 23, 2015 at 06:17:07PM +0100, Russell King - ARM Linux wrote:
> This small series contains a number of fixes and cleanups to the
> mvebu PCI host code.
> 
> The first patch makes the PCIe host controller more conformant with the
> requirements of the PCI specification, which requires where a device is
> present, unused PCI configuration space returns zero.  This patch
> ensures that is the case.
> 
> The second patch fixes the very broken idea that it's somehow legal to
> read-modify-write the PCI configuration space using 32-bit accessors,
> even when accessing a smaller register.  There are _multiple_ registers
> in PCI space where bits are defined to be "RW1C" - which means "read,
> write 1 to clear".  Registers include the PCI status register, and all
> PCIe status registers.  Hardware which does not support generating 16-bit
> and 8-bit configuration cycles is essentially broken and non-conformant.
> Luckily, that is not true of Armada hardware.  This patch fixes it.
> Tested on Armada 388.
> 
> These two patches should be considered as fixes.  I don't see a need for
> them to be backported to stable kernels as there is no serious breakage
> resulting from them with the driver in its current state.  The remainder
> are cleanups.
> 
> Patch 3 gets rid of the open coded "of_get_available_child_count()"
> implementation.
> 
> Patch 4 uses for_each_available_child_of_node(), rather than
> for_each_child_of_node() and checking whether of_device_is_available()
> returns true.  for_each_available_child_of_node() is meant for this.
> 
> Patch 5 makes the warning message for the lack of the "marvell,pcie-port"
> property more useful, by printing the DT path of the offending node
> rather than the wooly "PCIe DT node".
> 
> Lastly, patch 6 converts all the "PCIe%d.%d" and "pcie%d.%d" with the
> port name string, which is a pre-prepared string of that format.  This
> means we end up with a consistent name for the port being used everywhere
> which is good for user experience.
> 
>  drivers/pci/host/pci-mvebu.c | 87 ++++++++++++++++++++++++--------------------
>  1 file changed, 47 insertions(+), 40 deletions(-)

Applied to pci/host-mvebu for v4.4, with Tested-by Thomas and Andrew
and Reviewed-by Thomas.  Thanks, Russell!

Bjorn
