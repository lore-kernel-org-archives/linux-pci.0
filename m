Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0056.outbound.protection.outlook.com ([65.55.169.56]:46806
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750791AbbHTDm0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Aug 2015 23:42:26 -0400
From: Jay Cornwall <jay@jcornwall.me>
To: <linux-pci@vger.kernel.org>
CC: Jay Cornwall <jay@jcornwall.me>
Subject: [PATCH RFC 1/1] PCI: Add pci_enable_atomic_request
Date: Wed, 19 Aug 2015 16:10:02 -0500
Message-ID: <1440018602-4212-2-git-send-email-jay@jcornwall.me>
In-Reply-To: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
References: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow individual drivers to control AtomicOp Requester PCIe 3.0 capability.
This is a no-op on devices which do not support AtomicOp requests.

Signed-off-by: Jay Cornwall <jay@jcornwall.me>
---
 drivers/pci/pci.c             | 23 +++++++++++++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..1b9d1a9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2410,6 +2410,29 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 }
 
 /**
+ * pci_enable_atomic_request - enable or disable AtomicOp requester
+ * @dev: the PCI device
+ */
+void pci_enable_atomic_request(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return;
+
+	switch (pci_pcie_type(dev)) {
+	/* PCIe 3.0, 6.15 specifies that endpoints and root ports are permitted
+	 * to implement AtomicOp requester capabilities. */
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_LEG_END:
+	case PCI_EXP_TYPE_RC_END:
+	case PCI_EXP_TYPE_ROOT_PORT:
+		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
+					 PCI_EXP_DEVCTL2_ATOMICOP_REQ);
+		break;
+	}
+}
+EXPORT_SYMBOL(pci_enable_atomic_request);
+
+/**
  * pci_acs_path_enable - test ACS flags from start to end in a hierarchy
  * @start: starting downstream device
  * @end: ending upstream device or NULL to search to the root bus
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..946c3ce 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1750,6 +1750,7 @@ void pci_request_acs(void);
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
 			  struct pci_dev *end, u16 acs_flags);
+void pci_enable_atomic_request(struct pci_dev *dev);
 
 #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
 #define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 413417f..d2d2e8d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -578,6 +578,7 @@
 #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
 #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
 #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
+#define  PCI_EXP_DEVCTL2_ATOMICOP_REQ	0x0040	/* Allow AtomicOp Requests */
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
-- 
1.9.1

