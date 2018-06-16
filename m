Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:41611 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932898AbeFPTfU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:35:20 -0400
Message-Id: <0f74c21aab2c69a06202b960992b4e1595bdbd7d.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 30/32] PCI: sysfs: Resume to D0 on function reset
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When performing a function reset via sysfs, the device's config space is
accessed in places such as pcie_flr() and its mmio space is accessed e.g.
in reset_ivb_igd(), so ensure accessibility by resuming the device to D0.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 0c4653c1d2ce..a3df6b57df0f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1449,7 +1449,9 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
 	if (val != 1)
 		return -EINVAL;
 
+	pm_runtime_get_sync(dev);
 	result = pci_reset_function(pdev);
+	pm_runtime_put(dev);
 	if (result < 0)
 		return result;
 
-- 
2.17.1
