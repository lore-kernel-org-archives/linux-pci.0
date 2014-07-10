Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:32448 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbaGJNDg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 09:03:36 -0400
From: David Vrabel <david.vrabel@citrix.com>
To: <linux-pci@vger.kernel.org>
CC: David Vrabel <david.vrabel@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<xen-devel@lists.xenproject.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 1/2] pci: export pci_probe_reset_function()
Date: Thu, 10 Jul 2014 14:03:13 +0100
Message-ID: <1404997394-15715-2-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1404997394-15715-1-git-send-email-david.vrabel@citrix.com>
References: <1404997394-15715-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The xen-pciback needs to test if a per-function reset is available so
it can provide an interface for a safe bus reset instead.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 drivers/pci/pci.c   |    1 +
 drivers/pci/pci.h   |    1 -
 include/linux/pci.h |    1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 63a54a3..950e517 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3459,6 +3459,7 @@ int pci_probe_reset_function(struct pci_dev *dev)
 {
 	return pci_dev_reset(dev, 1);
 }
+EXPORT_SYMBOL_GPL(pci_probe_reset_function);
 
 /**
  * pci_reset_function - quiesce and reset a PCI device function
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0601890..7be87d4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -28,7 +28,6 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 #endif
-int pci_probe_reset_function(struct pci_dev *dev);
 
 /**
  * struct pci_platform_pm_ops - Firmware PM callbacks
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 466bcd1..a2d9871f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -968,6 +968,7 @@ int pcie_get_mps(struct pci_dev *dev);
 int pcie_set_mps(struct pci_dev *dev, int mps);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
+int pci_probe_reset_function(struct pci_dev *slot);
 int __pci_reset_function(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
1.7.10.4

