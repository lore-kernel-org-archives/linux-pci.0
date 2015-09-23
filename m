Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42264 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbbIWRRc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 13:17:32 -0400
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] pci: mvebu: provide a compliant PCI configuration space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1Zenfa-0004cy-WE@rmk-PC.arm.linux.org.uk>
Date: Wed, 23 Sep 2015 18:17:26 +0100
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI requires reads to reserved or unimplemented configuration space to
return zero and complete normally.  However, the root port software
implementation was returning 0xfffffff and PCIBIOS_BAD_REGISTER_NUMBER.
Fix this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 67ec5e1c99db..b6a096bc9422 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -515,8 +515,13 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 		break;
 
 	default:
-		*value = 0xffffffff;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+		/*
+		 * PCI defines configuration read accesses to reserved or
+		 * unimplemented registers to read as zero and complete
+		 * normally.
+		 */
+		*value = 0;
+		return PCIBIOS_SUCCESSFUL;
 	}
 
 	if (size == 2)
-- 
2.1.0

