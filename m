Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14739 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753795AbdKXPyW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Nov 2017 10:54:22 -0500
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <tglx@linutronix.de>
CC: <vidyas@nvidia.com>, <kthota@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 02/10] of: Export of_pci_range_to_resource()
Date: Fri, 24 Nov 2017 21:23:12 +0530
Message-ID: <1511538800-8275-3-git-send-email-mmaddireddy@nvidia.com>
In-Reply-To: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow PCI host driver to use of_pci_range_to_resource() to create a
resource from an of_pci_range.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/of/address.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 792722e7d458..9c7b2071bf2f 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -348,6 +348,7 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 	res->end = (resource_size_t)OF_BAD_ADDR;
 	return err;
 }
+EXPORT_SYMBOL(of_pci_range_to_resource);
 #endif /* CONFIG_PCI */
 
 /*
-- 
2.1.4
