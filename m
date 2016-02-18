Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: [PATCH] PCI: mvebu: Restrict build to 32-bit ARM
Date: Thu, 18 Feb 2016 14:32:10 +0100
Message-Id: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

This driver uses PCI glue that is only available on 32-bit ARM. This
used to work fine as long as ARCH_MVEBU and ARCH_DOVE were exclusively
32-bit, but that's changed now, with ARCH_MVEBU also being available
on 64-bit ARM.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 75a605426538..d1cdd9c992ac 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -14,6 +14,7 @@ config PCI_DRA7XX
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
 	depends on ARCH_MVEBU || ARCH_DOVE
+	depends on ARM
 	depends on OF
 
 config PCIE_DW
-- 
2.7.1
