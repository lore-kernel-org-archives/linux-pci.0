Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ondrej Zary <linux@rainbow-software.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: disable MSI on SiS 761
Date: Fri, 11 Sep 2015 23:12:17 +0200
Message-Id: <1442005937-21938-1-git-send-email-linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MSI is broken on SiS 761 chipset at least on PC Chips A31G board.
No interrupts are delivered once MSI is enabled for a device. This causes
hang on X11 start with a nVidia card installed (with nouveau driver).

Disable MSI completely for this chipset.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/pci/quirks.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e9fd0e9..6caffc3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2204,6 +2204,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3336, quirk_disab
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3351, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VT3364, quirk_disable_all_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8380_0, quirk_disable_all_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, 0x0761, quirk_disable_all_msi);
 
 /* Disable MSI on chipsets that are known to not support it */
 static void quirk_disable_msi(struct pci_dev *dev)
-- 
Ondrej Zary

