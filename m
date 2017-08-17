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
Subject: [PATCH v2 4/4] iommu: Prevent VMD child devices from being remapping targets
Date: Thu, 17 Aug 2017 12:10:14 -0600
Message-Id: <20170817181014.1257-5-jonathan.derrick@intel.com>
In-Reply-To: <20170817181014.1257-1-jonathan.derrick@intel.com>
References: <20170817181014.1257-1-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

VMD child devices must use the VMD endpoint's ID as the requester.
Because of this, there needs to be a way to link the parent VMD
endpoint's iommu group and associated mappings to the VMD child devices
such that attaching and detaching child devices modify the endpoint's
mappings, while preventing early detaching on a singular device removal
or unbinding.

The reassignment of individual VMD child devices devices to VMs is
outside the scope of VMD, but may be implemented in the future. For now
it is best to prevent any such attempts.

This patch prevents VMD child devices from returning an IOMMU, which
prevents it from exposing an iommu_group sysfs directories and allowing
subsequent binding by userspace-access drivers such as VFIO.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 687f18f..94353a6e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -901,6 +901,11 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 		struct pci_dev *pf_pdev;
 
 		pdev = to_pci_dev(dev);
+
+		/* VMD child devices currently cannot be handled individually */
+		if (is_vmd(pdev->bus))
+			return NULL;
+
 		/* VFs aren't listed in scope tables; we need to look up
 		 * the PF instead to find the IOMMU. */
 		pf_pdev = pci_physfn(pdev);
-- 
2.9.4
