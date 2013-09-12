Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:64794 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab3ILIUS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2013 04:20:18 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/2] PCI: remove unused "deprecated" macro PCI_MSIX_FLAGS_BIRMASK
Date: Thu, 12 Sep 2013 16:20:00 +0800
Message-ID: <1378974000-13168-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_MSIX_FLAGS_BIRMASK has been replaced by PCI_MSIX_TABLE_BIR
for better readability. Now no one uses it, remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 include/uapi/linux/pci_regs.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index baa7852..f050914 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -319,7 +319,6 @@
 #define PCI_MSIX_PBA		8	/* Pending Bit Array offset */
 #define  PCI_MSIX_PBA_BIR	0x00000007 /* BAR index */
 #define  PCI_MSIX_PBA_OFFSET	0xfffffff8 /* Offset into specified BAR */
-#define  PCI_MSIX_FLAGS_BIRMASK	(7 << 0)   /* deprecated */
 #define PCI_CAP_MSIX_SIZEOF	12	/* size of MSIX registers */
 
 /* MSI-X entry's format */
-- 
1.7.1


