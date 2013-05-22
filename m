Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:38818 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3EVNMr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 09:12:47 -0400
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
Subject: [PATCH 4/4] pci: mvebu: fix the emulation of the status register
Date: Wed, 22 May 2013 15:12:38 +0200
Message-Id: <1369228358-32580-5-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In a PCI configuration header, the 'devsel' bits of the status
register are read-only, and indicate the timing of the secondary
interface. Currently, we implement them as read/write, so when the
Linux PCI core writes all 1's to this register, it gets 11b as the
'devsel' value, which is reserved.

This commit fixes the PCI-to-PCI bridge emulation of the Marvell PCIe
driver to ensure those bits remain set to 00b, which indicate a fast
devsel decoding.

This allows to fix the lspci -v output from:

  Flags: bus master, 66MHz, user-definable features, ?? devsel, latency 0

to:

  Flags: bus master, 66MHz, user-definable features, fast devsel, latency 0

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index c887598..d730bf4 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -490,6 +490,11 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
 	case PCI_COMMAND:
 		bridge->command = value & 0xffff;
 		bridge->status = value >> 16;
+		/*
+		 * The devsel bits are read-only, and we want to keep
+		 * them set to 0
+		 */
+		bridge->status &= ~PCI_STATUS_DEVSEL_MASK;
 		break;
 
 	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
-- 
1.7.9.5

