Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 3/3] PCI: Mark Broadcom Vulcan bridges as having
 non-compliant BARs
To: Andi Kleen <ak@linux.intel.com>,
	Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org
Date: Fri, 26 Feb 2016 09:59:04 -0600
Message-ID: <20160226155904.9113.63245.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Broadcom Vulcan bridges have a BAR 0 for internal debug registers.  But
writing certain addresses to the BAR can trigger a hardware problem in the
device.  Linux doesn't need any BARs on these devices, so we can ignore
them.

Mark these bridges as having non-compliant BARs so the PCI core doesn't
touch them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0575a1e..978c00c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3705,6 +3705,20 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * Writing to BAR 0 on Broadcom Vulcan bridges can trigger a hardware
+ * problem in the device.  Linux doesn't need any BARs on these devices, so
+ * mark the device as having non-compliant BARs so we will ignore them.
+ */
+static void quirk_bridge_brcm_vulcan_internal(struct pci_dev *pdev)
+{
+	pdev->non_compliant_bars = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x9000,
+			quirk_bridge_brcm_vulcan_internal);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x9039,
+			quirk_bridge_brcm_vulcan_internal);
+
+/*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
  */
