Return-Path: <SRS0=jdO8=CB=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=jdO8=CB=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	helgaas@kernel.org
Subject: [PATCH 4/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 70h-7fh) Processors
Date: Fri,  3 Nov 2017 14:52:44 +0100
Message-Id: <1509717164-1946-4-git-send-email-christian.koenig@amd.com>
In-Reply-To: <1509717164-1946-1-git-send-email-christian.koenig@amd.com>
References: <1509717164-1946-1-git-send-email-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Just add the extra PCI-ID to the existing fixup.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 arch/x86/pci/fixup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 3eebb0e..894d73d 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -639,7 +639,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
  * configuring host bridge windows using the _PRS and _SRS methods.
  *
  * But this is rarely implemented, so we manually enable a large 64bit BAR for
- * PCIe device on AMD Family 15h (Models 00h-1fh, 30h-3fh, 60h-6fh) Processors
+ * PCIe device on AMD Family 15h (Models 00h-1fh, 30h-3fh, 60h-7fh) Processors
  * here.
  */
 static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
@@ -699,6 +699,7 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1401, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x141b, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
 
 #endif
-- 
2.7.4
