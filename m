Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34937 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab3IPHq5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 03:46:57 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT700BZKK9MQ0T0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 16 Sep 2013 16:46:56 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: Fix comment typo for PCI_EXP_LNKCTL_LABIE
Date: Mon, 16 Sep 2013 16:46:55 +0900
Message-id: <000001ceb2b0$ea66ffd0$bf34ff70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix trivial typo for PCI_EXP_LNKCTL_LABIE comment.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/uapi/linux/pci_regs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index baa7852..18384bc 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -485,7 +485,7 @@
 #define  PCI_EXP_LNKCTL_CLKREQ_EN 0x0100 /* Enable clkreq */
 #define  PCI_EXP_LNKCTL_HAWD	0x0200	/* Hardware Autonomous Width Disable */
 #define  PCI_EXP_LNKCTL_LBMIE	0x0400	/* Link Bandwidth Management Interrupt Enable */
-#define  PCI_EXP_LNKCTL_LABIE	0x0800	/* Lnk Autonomous Bandwidth Interrupt Enable */
+#define  PCI_EXP_LNKCTL_LABIE	0x0800	/* Link Autonomous Bandwidth Interrupt Enable */
 #define PCI_EXP_LNKSTA		18	/* Link Status */
 #define  PCI_EXP_LNKSTA_CLS	0x000f	/* Current Link Speed */
 #define  PCI_EXP_LNKSTA_CLS_2_5GB 0x0001 /* Current Link Speed 2.5GT/s */
-- 
1.7.10.4


