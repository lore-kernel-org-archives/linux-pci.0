Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35645 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbcBIOwf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 09:52:35 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 1/3] PCI: tegra: Remove unused field
Date: Tue,  9 Feb 2016 15:52:31 +0100
Message-Id: <1455029553-9460-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The num_ports field of the tegra_pcie structure is never used so it can
be safely removed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 4cb8157a4678..82d7ad3a1c3a 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -295,7 +295,6 @@ struct tegra_pcie {
 	struct tegra_msi msi;
 
 	struct list_head ports;
-	unsigned int num_ports;
 	u32 xbar_config;
 
 	struct regulator_bulk_data *supplies;
-- 
2.7.1

