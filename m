Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19026 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdKYTcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Nov 2017 14:32:45 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 2/9] of: Export of_pci_range_to_resource()
Date: Sun, 26 Nov 2017 01:02:06 +0530
Message-ID: <1511638333-22951-3-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra PCIe host driver parses of_pci_range from device tree and converts
to resource. Export of_pci_range_to_resource() to allow Tegra PCIe host
driver to be compiled as loadable kernel module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2:
* commit message update

 drivers/of/address.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index fa6cabfc3cb9..8d9b93f8701a 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -361,6 +361,7 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 	res->end = (resource_size_t)OF_BAD_ADDR;
 	return err;
 }
+EXPORT_SYMBOL(of_pci_range_to_resource);
 #endif /* CONFIG_PCI */
 
 /*
-- 
2.1.4
