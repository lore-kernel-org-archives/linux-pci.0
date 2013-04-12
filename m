Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 17/29] PCI: Use for_each_pci_resource() in pci_dev_driver()
Date: Fri, 12 Apr 2013 15:44:31 -0700
Message-Id: <1365806683-26717-18-git-send-email-yinghai@kernel.org>
In-Reply-To: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
References: <1365806683-26717-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace those open code, and make code more readable.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-driver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 1fa1e48..009f6c2 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1170,9 +1170,11 @@ pci_dev_driver(const struct pci_dev *dev)
 	if (dev->driver)
 		return dev->driver;
 	else {
+		struct resource *res;
 		int i;
-		for(i=0; i<=PCI_ROM_RESOURCE; i++)
-			if (dev->resource[i].flags & IORESOURCE_BUSY)
+
+		for_each_pci_resource((struct pci_dev *)dev, res, i, PCI_STD_ROM_RES)
+			if (res->flags & IORESOURCE_BUSY)
 				return &pci_compat_driver;
 	}
 	return NULL;
-- 
1.8.1.4

