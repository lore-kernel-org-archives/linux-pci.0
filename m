Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:43221 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932354AbeE2Jma (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 May 2018 05:42:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ryder Lee <ryder.lee@mediatek.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Rob Herring <robh@kernel.org>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: mvebu: add MVEBU_MBUS dependency
Date: Tue, 29 May 2018 11:41:51 +0200
Message-Id: <20180529094204.3945660-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enabling the PCI_MVEBU driver for compile testing caused a build failure
on ARM randconfig builds:

drivers/pci/host/pci-mvebu.c: In function 'mvebu_pcie_del_windows':
drivers/pci/host/pci-mvebu.c:341:3: error: implicit declaration of function 'mvebu_mbus_del_window'; did you mean 'mvebu_pcie_del_windows'? [-Werror=implicit-function-declaration]
   mvebu_mbus_del_window(base, sz);
   ^~~~~~~~~~~~~~~~~~~~~
   mvebu_pcie_del_windows
drivers/pci/host/pci-mvebu.c: In function 'mvebu_pcie_add_windows':
drivers/pci/host/pci-mvebu.c:364:9: error: implicit declaration of function 'mvebu_mbus_add_window_remap_by_id'; did you mean 'mvebu_pcie_add_windows'? [-Werror=implicit-function-declaration]
   ret = mvebu_mbus_add_window_remap_by_id(target, attribute, base,
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         mvebu_pcie_add_windows
drivers/pci/host/pci-mvebu.c: In function 'mvebu_pcie_probe':
drivers/pci/host/pci-mvebu.c:1209:2: error: implicit declaration of function 'mvebu_mbus_get_pcie_mem_aperture'; did you mean 'mvebu_mbus_get_io_win_info'? [-Werror=implicit-function-declaration]
drivers/pci/host/pci-mvebu.c:1215:2: error: implicit declaration of function 'mvebu_mbus_get_pcie_io_aperture'; did you mean 'mvebu_mbus_get_io_win_info'? [-Werror=implicit-function-declaration]

The problem is that the mbus helper functions are not declared in the
header. There are two ways of solving this: we can change the header
to provide empty stub functions for CONFIG_MVEBU_MBUS=n, or we can
add back the dependency here.

I picked the second option since that is simpler, but it somewhat
defeats the purpose of the original patch because we still cannot
compile test on other platforms this way.

Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index fa51d0893384..5340950f4b98 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -6,6 +6,7 @@ menu "PCI host controller drivers"
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
 	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
+	depends on MVEBU_MBUS
 	depends on ARM
 	depends on OF
 
-- 
2.9.0
