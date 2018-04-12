Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55616 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753102AbeDLVIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2018 17:08:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id b127so990809wmf.5
        for <linux-pci@vger.kernel.org>; Thu, 12 Apr 2018 14:08:14 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Add two more values for PCIe Max_Read_Request_Size
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Message-ID: <90260d62-e136-44a3-a35b-19fac1bcfb20@gmail.com>
Date: Thu, 12 Apr 2018 23:08:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds missing values for the max read request size.
E.g. network driver r8169 uses a value of 4K.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/uapi/linux/pci_regs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 0c79eac5..699257fb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -506,6 +506,8 @@
 #define  PCI_EXP_DEVCTL_READRQ_256B  0x1000 /* 256 Bytes */
 #define  PCI_EXP_DEVCTL_READRQ_512B  0x2000 /* 512 Bytes */
 #define  PCI_EXP_DEVCTL_READRQ_1024B 0x3000 /* 1024 Bytes */
+#define  PCI_EXP_DEVCTL_READRQ_2048B 0x4000 /* 2048 Bytes */
+#define  PCI_EXP_DEVCTL_READRQ_4096B 0x5000 /* 4096 Bytes */
 #define  PCI_EXP_DEVCTL_BCR_FLR 0x8000  /* Bridge Configuration Retry / FLR */
 #define PCI_EXP_DEVSTA		10	/* Device Status */
 #define  PCI_EXP_DEVSTA_CED	0x0001	/* Correctable Error Detected */
-- 
2.17.0
