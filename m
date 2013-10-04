Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:11394 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314Ab3JDXb2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Oct 2013 19:31:28 -0400
From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
CC: <james.hogan@imgtec.com>, <Qais.Yousef@imgtec.com>,
	Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 4/4] PCI/quirks: Convert hard-coded values to macros for PIIX4 ACPI quirks
Date: Fri, 4 Oct 2013 16:30:53 -0700
Message-ID: <1380929453-15428-5-git-send-email-dengcheng.zhu@imgtec.com>
In-Reply-To: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Get rid of a bunch of magic encodings by using macros and unify the
calculations of base/mask/size of io and mem quirks. These help code
reading easier.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 drivers/pci/quirks.c |   86 +++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 06762a8..f4ce679 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -394,6 +394,11 @@ static inline u32 piix4_acpi_quirk_size(u32 max, u32 mask)
 	return size;
 }
 
+#define PIIX4_ACPI_DEVRES_IOSIZEMASK_MASK		0xf0000
+#define PIIX4_ACPI_DEVRES_IOSIZEMASK_ADDRLINE(m)	((m) >> 16)
+#define PIIX4_ACPI_DEVRES_IOSIZE_MAX			16
+#define PIIX4_ACPI_DEVRES_IOBASEADDR_MASK		0xffff
+
 static void piix4_acpi_io_quirk(struct pci_dev *dev, const char *name,
 				unsigned int port, unsigned int enable)
 {
@@ -403,9 +408,11 @@ static void piix4_acpi_io_quirk(struct pci_dev *dev, const char *name,
 	pci_read_config_dword(dev, port, &devres);
 	if ((devres & enable) != enable)
 		return;
-	mask = (devres >> 16) & 15;
-	base = devres & 0xffff;
-	size = piix4_acpi_quirk_size(16, mask);
+
+	mask = devres & PIIX4_ACPI_DEVRES_IOSIZEMASK_MASK;
+	mask = PIIX4_ACPI_DEVRES_IOSIZEMASK_ADDRLINE(mask);
+	base = devres & PIIX4_ACPI_DEVRES_IOBASEADDR_MASK;
+	size = piix4_acpi_quirk_size(PIIX4_ACPI_DEVRES_IOSIZE_MAX, mask);
 	/*
 	 * For now we only print it out. Eventually we'll want to
 	 * reserve it (at least if it's in the 0x1000+ range), but
@@ -415,6 +422,11 @@ static void piix4_acpi_io_quirk(struct pci_dev *dev, const char *name,
 	dev_info(&dev->dev, "%s PIO at %04x-%04x\n", name, base, base + size - 1);
 }
 
+#define PIIX4_ACPI_DEVRES_MEMSIZEMASK_MASK		0x7f
+#define PIIX4_ACPI_DEVRES_MEMSIZEMASK_ADDRLINE(m)	((m) << 15)
+#define PIIX4_ACPI_DEVRES_MEMSIZE_MAX			(128 << 15)
+#define PIIX4_ACPI_DEVRES_MEMBASEADDR_MASK		0xffff8000
+
 static void piix4_acpi_mem_quirk(struct pci_dev *dev, const char *name,
 				 unsigned int port, unsigned int enable)
 {
@@ -424,9 +436,11 @@ static void piix4_acpi_mem_quirk(struct pci_dev *dev, const char *name,
 	pci_read_config_dword(dev, port, &devres);
 	if ((devres & enable) != enable)
 		return;
-	base = devres & 0xffff8000;
-	mask = (devres & 0x7f) << 15;
-	size = piix4_acpi_quirk_size(128 << 15, mask);
+
+	mask = devres & PIIX4_ACPI_DEVRES_MEMSIZEMASK_MASK;
+	mask = PIIX4_ACPI_DEVRES_MEMSIZEMASK_ADDRLINE(mask);
+	base = devres & PIIX4_ACPI_DEVRES_MEMBASEADDR_MASK;
+	size = piix4_acpi_quirk_size(PIIX4_ACPI_DEVRES_MEMSIZE_MAX, mask);
 	/*
 	 * For now we only print it out. Eventually we'll want to
 	 * reserve it, but let's get enough confirmation reports first. 
@@ -435,6 +449,30 @@ static void piix4_acpi_mem_quirk(struct pci_dev *dev, const char *name,
 	dev_info(&dev->dev, "%s MMIO at %04x-%04x\n", name, base, base + size - 1);
 }
 
+#define PIIX4_ACPI_PMBA			0x40
+#define PIIX4_ACPI_PMBA_SIZE		64
+#define PIIX4_ACPI_SMBBA		0x90
+#define PIIX4_ACPI_SMBBA_SIZE		16
+#define PIIX4_ACPI_DEVRESA		0x5c
+#define   PIIX4_ACPI_DEVRESA_EIO_EN_DEV12	(1 << 29)
+#define   PIIX4_ACPI_DEVRESA_EIO_EN_DEV13	(1 << 30)
+#define PIIX4_ACPI_DEVRESB		0x60
+#define   PIIX4_ACPI_DEVRESB_EN_DEV9		(3 << 21)
+#define PIIX4_ACPI_DEVRESC		0x64
+#define   PIIX4_ACPI_DEVRESC_EN_DEV10		(3 << 21)
+#define PIIX4_ACPI_DEVRESE		0x68
+#define   PIIX4_ACPI_DEVRESE_IO_EN_DEV12	(1 << 20)
+#define PIIX4_ACPI_DEVRESF		0x6c
+#define   PIIX4_ACPI_DEVRESF_MEM_EN_DEV12	(1 << 7)
+#define PIIX4_ACPI_DEVRESG		0x70
+#define   PIIX4_ACPI_DEVRESG_IO_EN_DEV13	(1 << 20)
+#define PIIX4_ACPI_DEVRESH		0x74
+#define   PIIX4_ACPI_DEVRESH_MEM_EN_DEV13	(1 << 7)
+#define PIIX4_ACPI_DEVRESI		0x78
+#define   PIIX4_ACPI_DEVRESI_IO_EN_GDEC0	(1 << 20)
+#define PIIX4_ACPI_DEVRESJ		0x7c
+#define   PIIX4_ACPI_DEVRESJ_IO_EN_GDEC1	(1 << 20)
+
 /*
  * PIIX4 ACPI: Two IO regions pointed to by longwords at
  *	0x40 (64 bytes of ACPI registers)
@@ -445,29 +483,39 @@ static void quirk_piix4_acpi(struct pci_dev *dev)
 {
 	u32 res_a;
 
-	quirk_io_region(dev, 0x40, 64, PCI_BRIDGE_RESOURCES, "PIIX4 ACPI");
-	quirk_io_region(dev, 0x90, 16, PCI_BRIDGE_RESOURCES+1, "PIIX4 SMB");
+	quirk_io_region(dev, PIIX4_ACPI_PMBA, PIIX4_ACPI_PMBA_SIZE,
+			PCI_BRIDGE_RESOURCES, "PIIX4 ACPI");
+	quirk_io_region(dev, PIIX4_ACPI_SMBBA, PIIX4_ACPI_SMBBA_SIZE,
+			PCI_BRIDGE_RESOURCES + 1, "PIIX4 SMB");
 
 	/* Device resource A has enables for some of the other ones */
-	pci_read_config_dword(dev, 0x5c, &res_a);
+	pci_read_config_dword(dev, PIIX4_ACPI_DEVRESA, &res_a);
 
-	piix4_acpi_io_quirk(dev, "PIIX4 devres B", 0x60, 3 << 21);
-	piix4_acpi_io_quirk(dev, "PIIX4 devres C", 0x64, 3 << 21);
+	piix4_acpi_io_quirk(dev, "PIIX4 devres B", PIIX4_ACPI_DEVRESB,
+			    PIIX4_ACPI_DEVRESB_EN_DEV9);
+	piix4_acpi_io_quirk(dev, "PIIX4 devres C", PIIX4_ACPI_DEVRESC,
+			    PIIX4_ACPI_DEVRESC_EN_DEV10);
 
 	/* Device resource D is just bitfields for static resources */
 
 	/* Device 12 enabled? */
-	if (res_a & (1 << 29)) {
-		piix4_acpi_io_quirk(dev, "PIIX4 devres E", 0x68, 1 << 20);
-		piix4_acpi_mem_quirk(dev, "PIIX4 devres F", 0x6c, 1 << 7);
+	if (res_a & PIIX4_ACPI_DEVRESA_EIO_EN_DEV12) {
+		piix4_acpi_io_quirk(dev, "PIIX4 devres E", PIIX4_ACPI_DEVRESE,
+				    PIIX4_ACPI_DEVRESE_IO_EN_DEV12);
+		piix4_acpi_mem_quirk(dev, "PIIX4 devres F", PIIX4_ACPI_DEVRESF,
+				     PIIX4_ACPI_DEVRESF_MEM_EN_DEV12);
 	}
 	/* Device 13 enabled? */
-	if (res_a & (1 << 30)) {
-		piix4_acpi_io_quirk(dev, "PIIX4 devres G", 0x70, 1 << 20);
-		piix4_acpi_mem_quirk(dev, "PIIX4 devres H", 0x74, 1 << 7);
-	}
-	piix4_acpi_io_quirk(dev, "PIIX4 devres I", 0x78, 1 << 20);
-	piix4_acpi_io_quirk(dev, "PIIX4 devres J", 0x7c, 1 << 20);
+	if (res_a & PIIX4_ACPI_DEVRESA_EIO_EN_DEV13) {
+		piix4_acpi_io_quirk(dev, "PIIX4 devres G", PIIX4_ACPI_DEVRESG,
+				    PIIX4_ACPI_DEVRESG_IO_EN_DEV13);
+		piix4_acpi_mem_quirk(dev, "PIIX4 devres H", PIIX4_ACPI_DEVRESH,
+				     PIIX4_ACPI_DEVRESH_MEM_EN_DEV13);
+	}
+	piix4_acpi_io_quirk(dev, "PIIX4 devres I", PIIX4_ACPI_DEVRESI,
+			    PIIX4_ACPI_DEVRESI_IO_EN_GDEC0);
+	piix4_acpi_io_quirk(dev, "PIIX4 devres J", PIIX4_ACPI_DEVRESJ,
+			    PIIX4_ACPI_DEVRESJ_IO_EN_GDEC1);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_3,	quirk_piix4_acpi);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82443MX_3,	quirk_piix4_acpi);
-- 
1.7.1


