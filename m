Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Knig <christian.koenig@amd.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-iommu@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org
Subject: [Bugfix v4 1/2] iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices
Date: Fri,  9 Oct 2015 22:07:31 +0800
Message-Id: <1444399652-25920-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1444399652-25920-1-git-send-email-jiang.liu@linux.intel.com>
References: <1444386214-26319-1-git-send-email-joro@8bytes.org>
 <1444399652-25920-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

AMD IOMMU driver makes use of IOMMU PCI devices, so prevent binding other
PCI drivers to IOMMU PCI devices.

This fixes a bug reported by Boris that system suspend/resume gets broken
on AMD platforms. For more information, please refer to:
	https://lkml.org/lkml/2015/9/26/89

Fixes: 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")
Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 drivers/iommu/amd_iommu_init.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5ef347a13cb5..1b066e7d144d 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1256,6 +1256,9 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	if (!iommu->dev)
 		return -ENODEV;
 
+	/* Prevent binding other PCI device drivers to IOMMU devices */
+	iommu->dev->match_driver = false;
+
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
 			      &iommu->cap);
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_RANGE_OFFSET,
-- 
1.7.10.4

