Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <201605301337.u4UDY6WZ028713@mx0a-001b2d01.pphosted.com>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	joro@8bytes.org, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	eric.auger@linaro.org, will.deacon@arm.com,
	gwshan@linux.vnet.ibm.com, alistair@popple.id.au,
	ruscur@russell.cc, kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: [PATCH v2 4/6] iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu driver initialization
Date: Mon, 30 May 2016 21:32:11 +0800
In-Reply-To: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some iommu drivers would be initialized after PCI device
enumeration. So PCI_BUS_FLAGS_MSI_REMAP would not be set
when probing PCI devices although IOMMU enables capability
of IRQ remapping. This patch tests this capability and
set the flag when iommu driver is initialized.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/iommu/iommu.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b9df141..e6159ab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -872,6 +872,14 @@ static int add_iommu_group(struct device *dev, void *data)
 	const struct iommu_ops *ops = cb->ops;
 	int ret;
 
+	/*
+	 * Set PCI_BUS_FLAGS_MSI_REMAP for all PCI buses when IOMMU
+	 * have capability of IRQ remapping.
+	 */
+	if (dev_is_pci(dev) && ops->capable &&
+			ops->capable(IOMMU_CAP_INTR_REMAP))
+		to_pci_dev(dev)->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+
 	if (!ops->add_device)
 		return 0;
 
-- 
1.7.9.5
