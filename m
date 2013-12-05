Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/9] PCI: Use dev_is_pci() to check whether it is pci device
Date: Thu, 5 Dec 2013 19:52:53 +0800
Message-ID: <1386244373-35796-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use dev_is_pci() instead of directly compare
pci_bus_type to check whether it is pci device.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci-acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 577074e..e0431f1 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -358,7 +358,7 @@ static void pci_acpi_cleanup(struct device *dev)
 
 static bool pci_acpi_bus_match(struct device *dev)
 {
-	return dev->bus == &pci_bus_type;
+	return dev_is_pci(dev);
 }
 
 static struct acpi_bus_type acpi_pci_bus = {
-- 
1.7.1


