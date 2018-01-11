Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5249 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeAKGIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jan 2018 01:08:24 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <cyndis@kapsi.fi>
CC: <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V6 1/7] of: Export of_pci_range_to_resource()
Date: Thu, 11 Jan 2018 11:38:02 +0530
Message-ID: <1515650888-9459-2-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
References: <1515650888-9459-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tegra PCIe host driver parses of_pci_range from device tree and converts
to resource. Export of_pci_range_to_resource() to allow Tegra PCIe host
driver to be compiled as loadable kernel module.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V2:
* commit message update
V3:
* no change in this patch
V4:
* no change in this patch
V5:
* no change in this patch
V6:
* no change in this patch

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
