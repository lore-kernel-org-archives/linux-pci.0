Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Leitner <dev@g0hl1n.net>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        bhelgaas@google.com, richard.leitner@skidata.com
Subject: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
Date: Wed, 14 Mar 2018 11:29:32 +0100
Message-Id: <20180314102933.21367-3-dev@g0hl1n.net>
In-Reply-To: <20180314102933.21367-1-dev@g0hl1n.net>
References: <20180314102933.21367-1-dev@g0hl1n.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

Replace the hardcoded PCI vendor ID of Netlogic with a definition in
pci_ids.h

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/usb/host/pci-quirks.c | 2 +-
 include/linux/pci_ids.h       | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 4f4a9f36a68e..39d163729b89 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1243,7 +1243,7 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
 	/* Skip Netlogic mips SoC's internal PCI USB controller.
 	 * This device does not need/support EHCI/OHCI handoff
 	 */
-	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
+	if (pdev->vendor == PCI_VENDOR_ID_NETLOGIC)
 		return;
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e8d1af82a688..d23a97868dee 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3067,4 +3067,6 @@
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
 
+#define PCI_VENDOR_ID_NETLOGIC		0x184e
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.11.0
