Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34618 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbcKYK5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2016 05:57:51 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v4 08/10] PCI: tegra: Enable the driver on 64-bit ARM
Date: Fri, 25 Nov 2016 11:57:16 +0100
Message-Id: <20161125105718.3866-8-thierry.reding@gmail.com>
In-Reply-To: <20161125105718.3866-1-thierry.reding@gmail.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

The Tegra PCI host controller driver no longer relies on any of the 32-
bit ARM glue for PCI, so it can be enabled on 64-bit configurations.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 14dc4053860e..9a109dad0d63 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -69,7 +69,7 @@ config PCI_IMX6
 
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
-	depends on ARCH_TEGRA && !ARM64
+	depends on ARCH_TEGRA
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
-- 
2.10.2

