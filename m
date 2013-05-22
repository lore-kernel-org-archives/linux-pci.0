Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:38810 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab3EVNMq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 09:12:46 -0400
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
Subject: [PATCH 3/4] pci: mvebu: emulate an empty capability list
Date: Wed, 22 May 2013 15:12:37 +0200
Message-Id: <1369228358-32580-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, our PCI-to-PCI bridge emulation doesn't emulate a proper
capability list, which leads 'lspci -v' to show:

  Capabilities: [fc] <chain broken>

In order to fix this, this commit improve the PCI-to-PCI bridge
emulation to emulate an empty capability list. It might be later
extended to expose things like the PCI Express Capability header, but
an empty capability list is sufficient for now.

lspci -v now shows the much nicer:

  Capabilities: [40] #00 [0000]

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index c21ca84..c887598 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -440,6 +440,16 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 		*value = 0;
 		break;
 
+	case PCI_CAPABILITY_LIST:
+		/* Offset of the capability list */
+		*value = 0x40;
+		break;
+
+	case 0x40:
+		/* We have no element in our capability list */
+		*value = 0;
+		break;
+
 	default:
 		*value = 0xffffffff;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
-- 
1.7.9.5

