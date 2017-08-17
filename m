Return-Path: <SRS0=NXC0=7T=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=NXC0=7T=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Keith Busch <keith.busch@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	David Fugate <david.fugate@intel.com>,
	<linux-kernel@vger.kernel.org>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 3/4] x86/PCI: Use is_vmd rather than relying on the domain number
Date: Thu, 17 Aug 2017 12:10:13 -0600
Message-Id: <20170817181014.1257-4-jonathan.derrick@intel.com>
In-Reply-To: <20170817181014.1257-1-jonathan.derrick@intel.com>
References: <20170817181014.1257-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index ca4b02e5..1ed2fbf 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -628,7 +628,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
 static void quirk_no_aersid(struct pci_dev *pdev)
 {
 	/* VMD Domain */
-	if (pdev->bus->sysdata && pci_domain_nr(pdev->bus) >= 0x10000)
+	if (is_vmd(pdev->bus))
 		pdev->bus->bus_flags |= PCI_BUS_FLAGS_NO_AERSID;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
-- 
2.9.4
