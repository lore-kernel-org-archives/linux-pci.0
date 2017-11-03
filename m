Return-Path: <SRS0=Tsn0=CB=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=Tsn0=CB=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	helgaas@kernel.org
Subject: [PATCH 1/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00h-0fh) Processors
Date: Fri,  3 Nov 2017 14:51:34 +0100
Message-Id: <1509717097-1847-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

Just add the extra PCI-ID to the existing fixup.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 7b6bd76..1d2238d 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -639,7 +639,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
  * configuring host bridge windows using the _PRS and _SRS methods.
  *
  * But this is rarely implemented, so we manually enable a large 64bit BAR for
- * PCIe device on AMD Family 15h (Models 30h-3fh) Processors here.
+ * PCIe device on AMD Family 15h (Models 00h-0fh, 30h-3fh) Processors here.
  */
 static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 {
@@ -696,5 +696,6 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 	pci_bus_add_resource(dev->bus, res, 0);
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
 
 #endif
-- 
2.7.4
