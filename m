Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:45665 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965039Ab3E2JDI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 May 2013 05:03:08 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: fix trivial typo for PCI_EXP_LNKCAP_CLKPM
Date: Wed, 29 May 2013 17:01:52 +0800
Message-ID: <1369818112-33136-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix trivial typo for PCI_EXP_LNKCAP_CLKPM comment.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 include/uapi/linux/pci_regs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 864e324..c3cc01d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -468,7 +468,7 @@
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
 #define  PCI_EXP_LNKCAP_L1EL	0x00038000 /* L1 Exit Latency */
-#define  PCI_EXP_LNKCAP_CLKPM	0x00040000 /* L1 Clock Power Management */
+#define  PCI_EXP_LNKCAP_CLKPM	0x00040000 /* Clock Power Management */
 #define  PCI_EXP_LNKCAP_SDERC	0x00080000 /* Surprise Down Error Reporting Capable */
 #define  PCI_EXP_LNKCAP_DLLLARC	0x00100000 /* Data Link Layer Link Active Reporting Capable */
 #define  PCI_EXP_LNKCAP_LBNC	0x00200000 /* Link Bandwidth Notification Capability */
-- 
1.7.1


