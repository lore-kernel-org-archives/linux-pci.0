Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:11394 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab3JDXb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Oct 2013 19:31:27 -0400
From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <james.hogan@imgtec.com>, <Qais.Yousef@imgtec.com>,
	Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 2/4] PCI/quirks: Rename piix4_[io|mem]_quirk to add acpi
Date: Fri, 4 Oct 2013 16:30:51 -0700
Message-ID: <1380929453-15428-3-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Rename piix4_[io|mem]_quirk to piix4_acpi_[io|mem]_quirk because these 2
functions only deal with the function 3 (power management) of PIIX4.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 drivers/pci/quirks.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3e7e489..a2b66c3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -380,7 +380,8 @@ static void quirk_ali7101_acpi(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
 
-static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
+static void piix4_acpi_io_quirk(struct pci_dev *dev, const char *name,
+				unsigned int port, unsigned int enable)
 {
 	u32 devres;
 	u32 mask, size, base;
@@ -406,7 +407,8 @@ static void piix4_io_quirk(struct pci_dev *dev, const char *name, unsigned int p
 	dev_info(&dev->dev, "%s PIO at %04x-%04x\n", name, base, base + size - 1);
 }
 
-static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int port, unsigned int enable)
+static void piix4_acpi_mem_quirk(struct pci_dev *dev, const char *name,
+				 unsigned int port, unsigned int enable)
 {
 	u32 devres;
 	u32 mask, size, base;
@@ -447,23 +449,23 @@ static void quirk_piix4_acpi(struct pci_dev *dev)
 	/* Device resource A has enables for some of the other ones */
 	pci_read_config_dword(dev, 0x5c, &res_a);
 
-	piix4_io_quirk(dev, "PIIX4 devres B", 0x60, 3 << 21);
-	piix4_io_quirk(dev, "PIIX4 devres C", 0x64, 3 << 21);
+	piix4_acpi_io_quirk(dev, "PIIX4 devres B", 0x60, 3 << 21);
+	piix4_acpi_io_quirk(dev, "PIIX4 devres C", 0x64, 3 << 21);
 
 	/* Device resource D is just bitfields for static resources */
 
 	/* Device 12 enabled? */
 	if (res_a & (1 << 29)) {
-		piix4_io_quirk(dev, "PIIX4 devres E", 0x68, 1 << 20);
-		piix4_mem_quirk(dev, "PIIX4 devres F", 0x6c, 1 << 7);
+		piix4_acpi_io_quirk(dev, "PIIX4 devres E", 0x68, 1 << 20);
+		piix4_acpi_mem_quirk(dev, "PIIX4 devres F", 0x6c, 1 << 7);
 	}
 	/* Device 13 enabled? */
 	if (res_a & (1 << 30)) {
-		piix4_io_quirk(dev, "PIIX4 devres G", 0x70, 1 << 20);
-		piix4_mem_quirk(dev, "PIIX4 devres H", 0x74, 1 << 7);
+		piix4_acpi_io_quirk(dev, "PIIX4 devres G", 0x70, 1 << 20);
+		piix4_acpi_mem_quirk(dev, "PIIX4 devres H", 0x74, 1 << 7);
 	}
-	piix4_io_quirk(dev, "PIIX4 devres I", 0x78, 1 << 20);
-	piix4_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
+	piix4_acpi_io_quirk(dev, "PIIX4 devres I", 0x78, 1 << 20);
+	piix4_acpi_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443MX_3,	quirk_piix4_acpi);
-- 
1.7.1


