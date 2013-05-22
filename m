Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:38791 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3EVNMo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 09:12:44 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] Marvell PCIe driver improvements
Date: Wed, 22 May 2013 15:12:34 +0200
Message-Id: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, Jason, Andrew, Gregory,

You'll find in this patch series 4 small patches that make various
improvements to the Marvell PCIe driver.

I'd like those improvements to be kept separated from the original
PCIe driver itself: while the PCIe driver has been around and reviewed
for a long time, those improvements are newer. And I clearly do not
want the PCIe driver to miss 3.11 because of any problem that could be
found in those additional improvements.

The main improvement being brought here is that the PCI-to-PCI bridge
logic is fixed/extended to properly support physical PCIe bridges that
are connected on a PCIe interface of a Marvell board. Without this
improvement, only the devices connected directly to the PCIe
interfaces of the board are properly enumerated. Any device that would
sit beyond a physical bridge is not visible.

The other improvements are more minor, and the patch description
should be sufficient to understand what's going on.

Those patches have been tested on both Armada 370/XP and Kirkwood.

Bjorn, with your Acked-by, could the Marvell maintainers include those
patches in their branch, merged through arm-soc? They already have the
Marvell PCIe driver itself, so I believe it makes sense to merge those
improvements through the same path.

Jason, those patches have been prepared on top of my marvell-pcie-v10
branch, I hope that's ok for you. If you want me to rebase them on
some other branch in which you have integrated the PCIe driver, don't
hesitate to tell me to do so. That said, since those patches are only
touching the driver itself and no other file, they should not cause
any conflict with other changes.

Thanks,

Thomas

Thomas Petazzoni (4):
  pci: mvebu: no longer fake the slot location of downstream devices
  pci: mvebu: allow the enumeration of devices beyond physical bridges
  pci: mvebu: emulate an empty capability list
  pci: mvebu: fix the emulation of the status register

 drivers/pci/host/pci-mvebu.c |   65 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 7 deletions(-)

-- 
1.7.9.5

