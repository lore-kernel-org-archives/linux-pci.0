Return-Path: <linux-kernel-owner@vger.kernel.org>
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Add PCI ID and quirk for Intersil/Techwell TW686[4589] AV capture cards.
Date: Fri, 19 Jun 2015 10:00:15 +0200
Message-ID: <m3vbekruuo.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Intersil/Techwell TW686[4589]-based video capture cards have an empty
(zero) class code. Fix it.

Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3662,6 +3662,26 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
+ * class code. Fix it.
+ */
+
+static void quirk_tw686x_class(struct pci_dev *pdev)
+{
+	/* Use "Multimedia controller" class */
+	pdev->class = 0x048001;
+	dev_info(&pdev->dev, "TW686x PCI class workaround enabled\n");
+}
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6864, PCI_CLASS_NOT_DEFINED, 0,
+			      quirk_tw686x_class);
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6865, PCI_CLASS_NOT_DEFINED, 0,
+			      quirk_tw686x_class);
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6868, PCI_CLASS_NOT_DEFINED, 0,
+			      quirk_tw686x_class);
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 0,
+			      quirk_tw686x_class);
+
+/*
  * AMD has indicated that the devices below do not support peer-to-peer
  * in any system where they are found in the southbridge with an AMD
  * IOMMU in the system.  Multifunction devices that do not support
