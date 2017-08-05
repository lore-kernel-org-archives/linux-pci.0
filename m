Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37822 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdHEGic (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 02:38:32 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 06/10] PCI: PCI_TEST simple data
Date: Fri,  4 Aug 2017 23:37:57 -0700
Message-Id: <20170805063801.15880-7-yinghai@kernel.org>
In-Reply-To: <20170805063801.15880-1-yinghai@kernel.org>
References: <20170805063801.15880-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci_test_data.txt | 24 ++++++++++++++++++++++++
 drivers/pci/pci_test_mask.txt |  5 +++++
 2 files changed, 29 insertions(+)
 create mode 100644 drivers/pci/pci_test_data.txt
 create mode 100644 drivers/pci/pci_test_mask.txt

diff --git a/drivers/pci/pci_test_data.txt b/drivers/pci/pci_test_data.txt
new file mode 100644
index 0000000..a3cfd5d
--- /dev/null
+++ b/drivers/pci/pci_test_data.txt
@@ -0,0 +1,24 @@
+pci_bus 0000:00: root bus resource [bus 00-fe]
+pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
+pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
+pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
+pci_bus 0000:00: root bus resource [mem 0xbfa00000-0xfebfffff]
+pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4bfff]
+
+00:1a.0 0c03: 8086:1c2d (rev 04) (prog-if 20 [EHCI])
+00: 86 80 2d 1c 06 00 90 02 04 20 03 0c 00 00 00 00
+10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+20: 00 00 00 00 00 00 00 00 00 00 00 00 aa 17 cf 21
+30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
+40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+50: 01 58 c2 c9 00 00 00 00 0a 98 a0 20 00 00 00 00
+60: 20 20 a7 07 00 00 00 00 01 00 00 00 00 00 08 c0
+70: 00 00 df 3f 00 00 00 00 00 00 00 00 00 00 00 00
+80: 00 00 80 00 11 88 0c 93 30 0d 00 24 00 00 00 00
+90: 00 00 00 00 00 00 00 00 13 00 06 03 00 00 00 00
+a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+d0: 00 00 00 00 00 aa ff 00 00 00 00 00 00 00 00 00
+e0: 00 00 00 00 01 44 00 9c 06 40 0b 28 b8 a1 18 09
+f0: 00 00 00 00 88 85 80 00 87 0f 06 08 08 17 5b 20
diff --git a/drivers/pci/pci_test_mask.txt b/drivers/pci/pci_test_mask.txt
new file mode 100644
index 0000000..824afab
--- /dev/null
+++ b/drivers/pci/pci_test_mask.txt
@@ -0,0 +1,5 @@
+mask: 8086:1c2d : 1:rw 0: readonly
+00: 00 00 00 00 ff ff ff 02 04 20 03 0c 00 00 00 00
+10: 00 fc ff ff 00 00 00 00 00 00 00 00 00 00 00 00
+20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
-- 
2.9.4
