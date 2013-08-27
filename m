Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57776 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab3H0TAg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2013 15:00:36 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so5265891pdj.29
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 12:00:35 -0700 (PDT)
Subject: [PATCH 2/5] PCI: Clarify PCI_EXP_TYPE_PCI_BRIDGE comment
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 27 Aug 2013 13:00:32 -0600
Message-ID: <20130827190032.16595.70813.stgit@bhelgaas-glaptop>
In-Reply-To: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
References: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI_EXP_TYPE_PCI_BRIDGE is a *PCIe* function that is a bridge to
PCI/PCI-X.  See PCIe spec r3.0, sec 7.8.2.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/pci_regs.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4b8f2e3..5bb33f4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -421,8 +421,8 @@
 #define  PCI_EXP_TYPE_ROOT_PORT 0x4	/* Root Port */
 #define  PCI_EXP_TYPE_UPSTREAM	0x5	/* Upstream Port */
 #define  PCI_EXP_TYPE_DOWNSTREAM 0x6	/* Downstream Port */
-#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCI/PCI-X Bridge */
-#define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIE Bridge */
+#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCIe to PCI/PCI-X Bridge */
+#define  PCI_EXP_TYPE_PCIE_BRIDGE 0x8	/* PCI/PCI-X to PCIe Bridge */
 #define  PCI_EXP_TYPE_RC_END	0x9	/* Root Complex Integrated Endpoint */
 #define  PCI_EXP_TYPE_RC_EC	0xa	/* Root Complex Event Collector */
 #define PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */

