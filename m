Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36450 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdHEGi3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Aug 2017 02:38:29 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 04/10] PCI: extend pci device match_driver state
Date: Fri,  4 Aug 2017 23:37:55 -0700
Message-Id: <20170805063801.15880-5-yinghai@kernel.org>
In-Reply-To: <20170805063801.15880-1-yinghai@kernel.org>
References: <20170805063801.15880-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change it from false/true to -1/0/1.

If it is set from -1, then it will never get change to 1 later.

For PCI_TEST, the simulated device does not have realy function
support except bus number and BAR setting.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 drivers/pci/bus.c              | 3 ++-
 drivers/pci/pci-driver.c       | 2 +-
 drivers/pci/probe.c            | 2 +-
 include/linux/pci.h            | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 3723037..6d706ca 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1558,7 +1558,7 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 		return -ENODEV;
 
 	/* Prevent binding other PCI device drivers to IOMMU devices */
-	iommu->dev->match_driver = false;
+	iommu->dev->match_driver = 0;
 
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
 			      &iommu->cap);
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc56cf1..e2c0bda 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -322,7 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
-	dev->match_driver = true;
+	if (dev->match_driver == 0)
+		dev->match_driver = 1;
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER) {
 		dev_warn(&dev->dev, "device attach failed (%d)\n", retval);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d51e873..c67b872 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1373,7 +1373,7 @@ static int pci_bus_match(struct device *dev, struct device_driver *drv)
 	struct pci_driver *pci_drv;
 	const struct pci_device_id *found_id;
 
-	if (!pci_dev->match_driver)
+	if (pci_dev->match_driver != 1)
 		return 0;
 
 	pci_drv = to_pci_driver(drv);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1811016..34ffbdf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2021,7 +2021,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	pci_set_msi_domain(dev);
 
 	/* Notifier could use PCI capabilities */
-	dev->match_driver = false;
+	dev->match_driver = 0;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c58a635..6e81d64 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -344,7 +344,7 @@ struct pci_dev {
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
-	bool match_driver;		/* Skip attaching driver */
+	int match_driver;		/* Skip attaching driver */
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Subtractive decode PCI bridge */
 	unsigned int	multifunction:1;/* Part of multi-function device */
-- 
2.9.4
