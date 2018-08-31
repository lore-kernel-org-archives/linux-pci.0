Return-Path: <SRS0=81jy=LO=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=81jy=LO=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	<linux-pci@vger.kernel.org>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI/VMD: Set up firmware first if capable
Date: Thu, 30 Aug 2018 18:30:03 -0600
Message-Id: <1535675403-2903-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1535675403-2903-1-git-send-email-jonathan.derrick@intel.com>
References: <1535675403-2903-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Some VMD devices will want to use firmware first error-handling on the
entire domain. This is detected by the BIOS setting the VMD endpoint's
interface to 0x1.

Detect this condition and propogate it to the entire domain.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/common.c        | 17 ++++++++++++++++-
 drivers/pci/controller/vmd.c | 25 ++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index d4ec117..f07f2e4 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -663,8 +663,23 @@ static void set_dma_domain_ops(struct pci_dev *pdev) {}
 
 static void set_dev_domain_options(struct pci_dev *pdev)
 {
-	if (is_vmd(pdev->bus))
+	if (is_vmd(pdev->bus)) {
+		struct pci_host_bridge *hb;
+		struct pci_dev *vmd;
+
 		pdev->hotplug_user_indicators = 1;
+
+		/*
+		 * The VMD endpoint is not PCIe, so will fail
+		 * pcie_aer_get_firmware_first(). Set and get the raw member
+		 * instead.
+		 */
+		hb = pci_find_host_bridge(pdev->bus);
+		vmd = to_pci_dev(hb->dev.parent);
+
+		pdev->__aer_firmware_first = vmd->__aer_firmware_first;
+		pdev->__aer_firmware_first_valid = vmd->__aer_firmware_first_valid;
+	}
 }
 
 int pcibios_add_device(struct pci_dev *dev)
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index fd2dbd7..74a1a04 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -44,6 +44,11 @@ enum vmd_features {
 	 * bus numbering
 	 */
 	VMD_FEAT_HAS_BUS_RESTRICTIONS	= (1 << 1),
+
+	/*
+	 * Device may request firmware first error-handling on the domain
+	 */
+	VMD_FEAT_HAS_FIRMWARE_FIRST	= (1 << 2),
 };
 
 /*
@@ -633,6 +638,23 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 			busn_start = 128;
 	}
 
+	/*
+	 * Certain VMD devices may request firmware first error-handling
+	 * support on the domain. These domains are virtual and not described
+	 * by ACPI, so we must set it explicitly. This sets firmware first on
+	 * the endpoint and has a corresponding domain setting in
+	 * arch/x86/pci/common.c
+	 */
+	if (features & VMD_FEAT_HAS_FIRMWARE_FIRST) {
+		u8 interface;
+
+		pci_read_config_byte(vmd->dev, PCI_CLASS_PROG, &interface);
+		if (interface == 0x1) {
+			vmd->dev->__aer_firmware_first = 1;
+			vmd->dev->__aer_firmware_first_valid = 1;
+		}
+	}
+
 	res = &vmd->dev->resource[VMD_CFGBAR];
 	vmd->resources[0] = (struct resource) {
 		.name  = "VMD CFGBAR",
@@ -860,7 +882,8 @@ static int vmd_resume(struct device *dev)
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_HAS_FIRMWARE_FIRST,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
1.8.3.1
