Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:57673 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab3H0TAn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2013 15:00:43 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so5230610pbc.32
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 12:00:43 -0700 (PDT)
Subject: [PATCH 3/5] PCI: Remove obsolete comment reference to
 pci_pcie_cap2()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 27 Aug 2013 13:00:40 -0600
Message-ID: <20130827190040.16595.42583.stgit@bhelgaas-glaptop>
In-Reply-To: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
References: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_pcie_cap2() was replaced by pcie_capability_read_word() and similar
functions, so update the comment.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/pci_regs.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 5bb33f4..591bb3b 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -544,10 +544,12 @@
 #define PCI_EXP_RTSTA_PME	0x10000 /* PME status */
 #define PCI_EXP_RTSTA_PENDING	0x20000 /* PME pending */
 /*
- * Note that the following PCI Express 'Capability Structure' registers
- * were introduced with 'Capability Version' 0x2 (v2).  These registers
- * do not exist on devices with Capability Version 1.  Use pci_pcie_cap2()
- * to use these fields safely.
+ * The Device Capabilities 2, Device Status 2, Device Control 2,
+ * Link Capabilities 2, Link Status 2, Link Control 2,
+ * Slot Capabilities 2, Slot Status 2, and Slot Control 2 registers
+ * are only present on devices with PCIe Capability version 2.
+ * Use pcie_capability_read_word() and similar interfaces to use them
+ * safely.
  */
 #define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
 #define  PCI_EXP_DEVCAP2_ARI		0x20	/* Alternative Routing-ID */

