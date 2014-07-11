Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:34501 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaGKG7D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 02:59:03 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 1/2] PCI: mvebu: Fix license string
Date: Fri, 11 Jul 2014 08:58:57 +0200
Message-Id: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not
"GPLv2".

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index ce23e0f076b6..a8c6f1a92e0f 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1094,4 +1094,4 @@ module_platform_driver(mvebu_pcie_driver);
 
 MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
 MODULE_DESCRIPTION("Marvell EBU PCIe driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
2.0.1

