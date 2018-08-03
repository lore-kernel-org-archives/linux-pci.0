Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:50326 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732250AbeHCQf3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Aug 2018 12:35:29 -0400
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Cc: Nadav Haklai <nadavh@marvell.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 0/6] PCI: mvebu: cleanup and improvements
Date: Fri,  3 Aug 2018 16:38:42 +0200
Message-Id: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

This is the v2 of the pci-mvebu cleanup and improvements, mainly
aiming at using pci_host_bridge.

Since v1, the changes are:

 - Rebase on v4.18-rc1 to make sure the patches apply

 - Add a patch fixing the I/O space end calculation (using
   resource_size() as the .end address of a resource is not correct)

 - Only remap the I/O space if there is a PCI I/O aperture described
   in the DT.

 - Use resource_size() in the loop mapping the I/O space, as suggested
   by Lorenzo.

 - Use pci_add_resource() instead of pci_add_resource_offset(), as
   suggested by Lorenzo.

 - Revert to using pci_ioremap_io(), since we need to map with a
   special memory type on Armada platforms, and pci_remap_iospace()
   doesn't allow to do that. Noticed by Lorenzo.

Thanks!

Thomas

Thomas Petazzoni (6):
  PCI: mvebu: Remove redundant platform_set_drvdata() call
  PCI: mvebu: fix I/O space end address calculation
  PCI: mvebu: only remap I/O space if configured
  PCI: mvebu: use resource_size() to remap I/O space
  PCI: mvebu: Convert to use pci_host_bridge directly
  PCI: mvebu: Drop bogus comment above mvebu_pcie_map_registers()

 drivers/pci/controller/pci-mvebu.c | 153 +++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 85 deletions(-)

-- 
2.14.4
