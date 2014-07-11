Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:38374 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaGKG7H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jul 2014 02:59:07 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 2/2] PCI: tegra: Fix license string
Date: Fri, 11 Jul 2014 08:58:58 +0200
Message-Id: <1405061938-2191-2-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
References: <1405061938-2191-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not
"GPLv2".

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 7df5aaf58921..14ec5b2c69e0 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1742,4 +1742,4 @@ module_platform_driver(tegra_pcie_driver);
 
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra PCIe driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
2.0.1

