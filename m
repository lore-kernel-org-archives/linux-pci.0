Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:43370 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab3EaEWK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 00:22:10 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so1544181pbc.1
        for <linux-pci@vger.kernel.org>; Thu, 30 May 2013 21:22:09 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Xudong Hao <xudong.hao@intel.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 2/3] PCI, ACPI: Don't glue ACPI dev with pci VFs
Date: Fri, 31 May 2013 12:21:30 +0800
Message-Id: <1369974092-11450-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>

When sriov is enabled, VF could just start after PF in pci tree.
like c1:00.0 will be PF, and c1:00.1 and after will be VF.

acpi do have dev with same ADR. that will make them get glued
wrongly.

Skip that if it is virtfn.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/pci-acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e4b1fb2..720f3a2 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -321,6 +321,10 @@ static int acpi_pci_find_device(struct device *dev, acpi_handle *handle)
 	u64	addr;
 
 	pci_dev = to_pci_dev(dev);
+	/* don't mix vf with real pci device */
+	if (pci_dev->is_virtfn)
+		return -ENODEV;
+
 	/* Please ref to ACPI spec for the syntax of _ADR */
 	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
 	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
-- 
1.8.1.2

