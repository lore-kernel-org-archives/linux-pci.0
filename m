Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34924 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbbGNTpH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 15:45:07 -0400
Received: by obbop1 with SMTP id op1so12793340obb.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 12:45:06 -0700 (PDT)
Subject: [PATCH 1/2] PCI: Fix pcie_port_device_resume() comment
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Jiang Liu <jiang.liu@huawei.com>
Date: Tue, 14 Jul 2015 14:45:03 -0500
Message-ID: <20150714194503.13471.65928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714193757.13471.77973.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714193757.13471.77973.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function comment claimed this was pcie_port_device_suspend(), but it's
really pcie_port_device_resume().  Perils of cut and paste.

Use the correct function name in the comment.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 2f0ce66..88122dc 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -448,7 +448,7 @@ static int resume_iter(struct device *dev, void *data)
 }
 
 /**
- * pcie_port_device_suspend - resume port services associated with a PCIe port
+ * pcie_port_device_resume - resume port services associated with a PCIe port
  * @dev: PCI Express port to handle
  */
 int pcie_port_device_resume(struct device *dev)

