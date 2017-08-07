Return-Path: <SRS0=ZMnZ=7J=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=ZMnZ=7J=intel.com=jonathan.derrick@kernel.org>
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
Subject: [PATCH 3/3] iommu: prevent VMD child devices from being remapping targets
Date: Mon,  7 Aug 2017 13:57:13 -0600
Message-Id: <20170807195713.10963-3-jonathan.derrick@intel.com>
In-Reply-To: <20170807195713.10963-1-jonathan.derrick@intel.com>
References: <20170807195713.10963-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

VMD child devices must use the VMD endpoint's ID as the DMA source.
Because of this, there needs to be a way to link the parent VMD
endpoint's DMAR domain to the VMD child devices' DMAR domain such that
attaching and detaching child devices modify the endpoint's DMAR mapping
and prevents early detaching.

This is outside the scope of VMD, so disable binding child devices to
prevent unforeseen issues. This functionality may be implemented in the
future.

This patch prevents VMD child devices from returning an IOMMU, which
prevents it from exposing iommu_group sysfs directories and subsequent
binding by userspace-access drivers such as VFIO.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 687f18f..651a6cd 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -905,6 +905,11 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 		 * the PF instead to find the IOMMU. */
 		pf_pdev = pci_physfn(pdev);
 		dev = &pf_pdev->dev;
+
+		/* VMD child devices currently cannot be handled individually */
+		if (pci_bus_is_vmd(pdev->bus))
+			return NULL;
+
 		segment = pci_domain_nr(pdev->bus);
 	} else if (has_acpi_companion(dev))
 		dev = &ACPI_COMPANION(dev)->dev;
-- 
2.9.4
