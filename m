Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:40257 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab2BUQXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Feb 2012 11:23:23 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
To: linux-kernel@vger.kernel.org
CC: Anthony PERARD <anthony.perard@citrix.com>,
	linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	QEMU-devel <qemu-devel@nongnu.org>
Subject: PCI: Add PCI_EXP_TYPE_PCIE_BRIDGE value
Date: Tue, 21 Feb 2012 16:22:10 +0000
Message-ID: <1329841330-14902-1-git-send-email-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

---
 include/linux/pci_regs.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index e41a10f..4b608f5 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -391,6 +391,7 @@
 #define  PCI_EXP_TYPE_UPSTREAM	0x5	/* Upstream Port */
 #define  PCI_EXP_TYPE_DOWNSTREAM 0x6	/* Downstream Port */
 #define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCI/PCI-X Bridge */
+#define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIE Bridge */
 #define  PCI_EXP_TYPE_RC_END	0x9	/* Root Complex Integrated Endpoint */
 #define  PCI_EXP_TYPE_RC_EC	0xa	/* Root Complex Event Collector */
 #define PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
-- 
tg: (27e74da..) add-new-pci-value (depends on: master)
