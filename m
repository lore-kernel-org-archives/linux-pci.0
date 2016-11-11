Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI/VMD: Select SRCU
Date: Fri, 11 Nov 2016 15:50:57 -0700
Message-Id: <1478904657-11342-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1478904657-11342-1-git-send-email-jonathan.derrick@intel.com>
References: <1478904657-11342-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

VMD now uses SRCU, so we must qualify that it is part of the kernel.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d7e7c0a..80ffa66 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -287,6 +287,7 @@ config PCIE_ROCKCHIP
 
 config VMD
 	depends on PCI_MSI && X86_64
+	select SRCU
 	tristate "Intel Volume Management Device Driver"
 	default N
 	---help---
-- 
1.8.3.1
