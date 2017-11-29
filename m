Return-Path: <SRS0=ofcB=C3=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=ofcB=C3=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86/PCI: only enable a 64bit BAR on single socket AMD Family 15h systems
Date: Wed, 29 Nov 2017 15:12:28 +0100
Message-Id: <20171129141229.6107-3-christian.koenig@amd.com>
In-Reply-To: <20171129141229.6107-1-christian.koenig@amd.com>
References: <20171129141229.6107-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

When we have a multi socket system each CPU core needs the same setup. Since
this is tricky to do in the fixup code disable enabling a 64bit BAR on multi
socket systems for now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e857b3ac5755..c817ab85dc82 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -664,6 +664,16 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	unsigned i;
 	u32 base, limit, high;
 	struct resource *res, *conflict;
+	struct pci_dev *other;
+
+	/* Check that we are the only device of that type */
+	other = pci_get_device(dev->vendor, dev->device, NULL);
+	if (other != dev ||
+	    (other = pci_get_device(dev->vendor, dev->device, other))) {
+		/* This is a multi socket system, don't touch it for now */
+		pci_dev_put(other);
+		return;
+	}
 
 	for (i = 0; i < 8; i++) {
 		pci_read_config_dword(dev, AMD_141b_MMIO_BASE(i), &base);
@@ -718,10 +728,10 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 
 	pci_bus_add_resource(dev->bus, res, 0);
 }
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1401, pci_amd_enable_64bit_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1401, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
 
 #endif
-- 
2.11.0
