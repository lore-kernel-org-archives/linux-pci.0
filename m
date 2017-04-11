Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33814 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbdDKR5M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2017 13:57:12 -0400
Received: by mail-pg0-f47.google.com with SMTP id 21so2112620pgg.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2017 10:57:12 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mason <slash.tmp@free.fr>,
        Grant Grundler <grundler@chromium.org>,
        Greg Hackmann <ghackmann@google.com>,
        Michael Davidson <md@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant
Date: Tue, 11 Apr 2017 10:56:58 -0700
Message-Id: <20170411175658.58512-1-mka@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A 64-bit value is not needed since a PCI ROM address consists in 32 bits.
This fixes a clang warning about "implicit conversion from 'unsigned
long' to 'u32'".

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- Define PCI_ROM_ADDRESS_MASK as a 32-bit constant instead of using a cast
- Updated commit message

 include/uapi/linux/pci_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 634c9c44ed6c..fff521c9458c 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -114,7 +114,7 @@
 #define PCI_SUBSYSTEM_ID	0x2e
 #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
 #define  PCI_ROM_ADDRESS_ENABLE	0x01
-#define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
+#define PCI_ROM_ADDRESS_MASK	(~0x7ffU)
 
 #define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */
 
-- 
2.12.2.715.g7642488e1d-goog
