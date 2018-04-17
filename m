Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35012 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeDQA26 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2018 20:28:58 -0400
Received: by mail-it0-f67.google.com with SMTP id q85-v6so14002724itc.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2018 17:28:58 -0700 (PDT)
From: Frederick Lawler <fred@fredlawl.com>
To: bhelgaas@google.com, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, dledford@redhat.com, jgg@mellanox.com
Cc: linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v3 1/2] PCI: Add PCI_EXP_LNKCTL2_TLS* macros
Date: Mon, 16 Apr 2018 19:28:24 -0500
Message-Id: <20180417002825.2737-2-fred@fredlawl.com>
In-Reply-To: <20180417002825.2737-1-fred@fredlawl.com>
References: <20180417002825.2737-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Link Control 2 register is missing macros for Target Link Speeds.
Add those in.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 include/uapi/linux/pci_regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 103ba797a8f3..18f9acacca95 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -655,6 +655,11 @@
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
+#define PCI_EXP_LNKCTL2_TLS		0x000f
+#define PCI_EXP_LNKCTL2_TLS_2_5GB	0x0001 /* Supported Speed 2.5GT/s */
+#define PCI_EXP_LNKCTL2_TLS_5_0GB	0x0002 /* Supported Speed 5GT/s */
+#define PCI_EXP_LNKCTL2_TLS_8_0GB	0x0003 /* Supported Speed 8GT/s */
+#define PCI_EXP_LNKCTL2_TLS_16_0GB	0x0004 /* Supported Speed 16GT/s */
 #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
 #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
-- 
2.17.0
