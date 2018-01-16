Return-Path: <SRS0=1ozF=EL=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=1ozF=EL=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] x86/PCI: apply the AMD window fixup on resume as well
Date: Tue, 16 Jan 2018 10:43:17 +0100
Message-Id: <20180116094317.1603-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

We need to reprogram the register content during resume.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Tom St Denis <tom.stdenis@amd.com>
---
 arch/x86/pci/fixup.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index f6a26e3cb476..8f3b1a6278e6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -662,11 +662,11 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
  */
 static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 {
+	static const char *name = "PCI Bus 0000:00";
+	struct resource *res, *conflict;
 	u32 base, limit, high;
 	struct pci_dev *other;
-	struct resource *res;
 	unsigned i;
-	int r;
 
 	if (!(pci_probe & PCI_BIG_ROOT_WINDOW))
 		return;
@@ -707,21 +707,26 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	 * Allocate a 256GB window directly below the 0xfd00000000 hardware
 	 * limit (see AMD Family 15h Models 30h-3Fh BKDG, sec 2.4.6).
 	 */
-	res->name = "PCI Bus 0000:00";
+	res->name = name;
 	res->flags = IORESOURCE_PREFETCH | IORESOURCE_MEM |
 		IORESOURCE_MEM_64 | IORESOURCE_WINDOW;
 	res->start = 0xbd00000000ull;
 	res->end = 0xfd00000000ull - 1;
 
-	r = request_resource(&iomem_resource, res);
-	if (r) {
+	conflict = request_resource_conflict(&iomem_resource, res);
+	if (conflict) {
 		kfree(res);
-		return;
-	}
+		if (conflict->name != name)
+			return;
 
-	dev_info(&dev->dev, "adding root bus resource %pR (tainting kernel)\n",
-		 res);
-	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		/* We are resuming from suspend, just reprogram the regs. */
+		res = conflict;
+	} else {
+		dev_info(&dev->dev, "adding root bus resource %pR (tainting kernel)\n",
+			 res);
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		pci_bus_add_resource(dev->bus, res, 0);
+	}
 
 	base = ((res->start >> 8) & AMD_141b_MMIO_BASE_MMIOBASE_MASK) |
 		AMD_141b_MMIO_BASE_RE_MASK | AMD_141b_MMIO_BASE_WE_MASK;
@@ -733,13 +738,16 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	pci_write_config_dword(dev, AMD_141b_MMIO_HIGH(i), high);
 	pci_write_config_dword(dev, AMD_141b_MMIO_LIMIT(i), limit);
 	pci_write_config_dword(dev, AMD_141b_MMIO_BASE(i), base);
-
-	pci_bus_add_resource(dev->bus, res, 0);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1401, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1401, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
 
 #endif
-- 
2.11.0
