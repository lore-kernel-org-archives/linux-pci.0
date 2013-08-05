Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <dbd9b17ec3af15f16332278a095ba23d0a798b09.1375733180.git.cmetcalf@tilera.com>
In-Reply-To: <cover.1375733180.git.cmetcalf@tilera.com>
References: <cover.1375733180.git.cmetcalf@tilera.com>
From: Chris Metcalf <cmetcalf@tilera.com>
Date: Mon, 5 Aug 2013 16:06:20 -0400
Subject: [PATCH 13/20] tile PCI RC: include pci/pcie/Kconfig
To: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/tile/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index bfff769..e41a381 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -408,6 +408,8 @@ config TILE_PCI_IO
 
 source "drivers/pci/Kconfig"
 
+source "drivers/pci/pcie/Kconfig"
+
 config TILE_USB
 	tristate "Tilera USB host adapter support"
 	default y
-- 
1.8.3.1

