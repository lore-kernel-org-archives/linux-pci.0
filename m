Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57631 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeHaQN7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2018 12:13:59 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <anthony.wong@canonical.com>)
        id 1fviCN-0002Pw-NJ
        for linux-pci@vger.kernel.org; Fri, 31 Aug 2018 12:06:47 +0000
Received: by mail-pl1-f200.google.com with SMTP id 90-v6so5886210pla.18
        for <linux-pci@vger.kernel.org>; Fri, 31 Aug 2018 05:06:47 -0700 (PDT)
From: Anthony Wong <anthony.wong@ubuntu.com>
To: nic_swsd@realtek.com, bhelgaas@google.com, netdev@vger.kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH] r8169: add support for NCube 8168 network card
Date: Fri, 31 Aug 2018 20:06:42 +0800
Message-Id: <1535717202-26397-1-git-send-email-anthony.wong@ubuntu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This card identifies itself as:
  Ethernet controller [0200]: NCube Device [10ff:8168] (rev 06)
  Subsystem: TP-LINK Technologies Co., Ltd. Device [7470:3468]

Adding a new entry to rtl8169_pci_tbl makes the card work.

Link: http://launchpad.net/bugs/1788730
Cc: <stable@vger.kernel.org>
Signed-off-by: Anthony Wong <anthony.wong@ubuntu.com>
---
 drivers/net/ethernet/realtek/r8169.c | 1 +
 include/linux/pci_ids.h              | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index ac30679..b08d51b 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -218,6 +218,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8161), 0, 0, RTL_CFG_1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8167), 0, 0, RTL_CFG_0 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8168), 0, 0, RTL_CFG_1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NCUBE,	0x8168), 0, 0, RTL_CFG_1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK,	0x8169), 0, 0, RTL_CFG_0 },
 	{ PCI_VENDOR_ID_DLINK,			0x4300,
 		PCI_VENDOR_ID_DLINK, 0x4b10,		 0, 0, RTL_CFG_1 },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 6656286..d4afd80 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3088,4 +3088,6 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
+#define PCI_VENDOR_ID_NCUBE		0x10ff
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.7.4
