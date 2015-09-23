Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42260 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbbIWRRU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 13:17:20 -0400
Date: Wed, 23 Sep 2015 18:17:07 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/6] mvebu PCI fixes and cleanups
Message-ID: <20150923171706.GL21084@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This small series contains a number of fixes and cleanups to the
mvebu PCI host code.

The first patch makes the PCIe host controller more conformant with the
requirements of the PCI specification, which requires where a device is
present, unused PCI configuration space returns zero.  This patch
ensures that is the case.

The second patch fixes the very broken idea that it's somehow legal to
read-modify-write the PCI configuration space using 32-bit accessors,
even when accessing a smaller register.  There are _multiple_ registers
in PCI space where bits are defined to be "RW1C" - which means "read,
write 1 to clear".  Registers include the PCI status register, and all
PCIe status registers.  Hardware which does not support generating 16-bit
and 8-bit configuration cycles is essentially broken and non-conformant.
Luckily, that is not true of Armada hardware.  This patch fixes it.
Tested on Armada 388.

These two patches should be considered as fixes.  I don't see a need for
them to be backported to stable kernels as there is no serious breakage
resulting from them with the driver in its current state.  The remainder
are cleanups.

Patch 3 gets rid of the open coded "of_get_available_child_count()"
implementation.

Patch 4 uses for_each_available_child_of_node(), rather than
for_each_child_of_node() and checking whether of_device_is_available()
returns true.  for_each_available_child_of_node() is meant for this.

Patch 5 makes the warning message for the lack of the "marvell,pcie-port"
property more useful, by printing the DT path of the offending node
rather than the wooly "PCIe DT node".

Lastly, patch 6 converts all the "PCIe%d.%d" and "pcie%d.%d" with the
port name string, which is a pre-prepared string of that format.  This
means we end up with a consistent name for the port being used everywhere
which is good for user experience.

 drivers/pci/host/pci-mvebu.c | 87 ++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 40 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
