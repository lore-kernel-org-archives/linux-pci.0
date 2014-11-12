Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:42095 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbaKLNxo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 08:53:44 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 2/2] PCI: tegra: Add Kconfig help text
Date: Wed, 12 Nov 2014 14:53:38 +0100
Message-Id: <1415800418-22957-2-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1415800418-22957-1-git-send-email-thierry.reding@gmail.com>
References: <1415800418-22957-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Add a standard help text to the Kconfig entry for the Tegra PCIe host
controller driver.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 9c56137e5e5e..9dbb1fc68bc9 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -33,6 +33,9 @@ config PCI_IMX6
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA && !ARM64
+	help
+	  Say Y here if you want support for the PCIe host controller found
+	  on NVIDIA Tegra SoCs.
 
 config PCI_RCAR_GEN2
 	bool "Renesas R-Car Gen2 Internal PCI controller"
-- 
2.1.3

