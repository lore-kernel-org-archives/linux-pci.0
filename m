Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:63070 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaHAL3S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Aug 2014 07:29:18 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so5645009pad.22
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2014 04:29:18 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@samsung.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, pratyush.anand@st.com,
	viresh.kumar@linaro.org, spk.linux@gmail.com, olof@lixom.net
Subject: [PATCH 1/1] PCI: spear: Fix build error
Date: Fri,  1 Aug 2014 16:58:34 +0530
Message-Id: <1406892514-27996-1-git-send-email-sachin.kamat@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We get the following error when built as a module. Though the general fix would
be in this case to export the below mentioned symbols, considering that
dw_pcie_host_init is marked with __init and other PCI drivers do not support
modular build, I have disabled building this driver as a module too.

ERROR: "dw_pcie_host_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_handle_msi_irq" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_msi_init" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_cfg_write" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_cfg_read" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_setup_rc" [drivers/pci/host/pcie-spear13xx.ko] undefined!
ERROR: "dw_pcie_link_up" [drivers/pci/host/pcie-spear13xx.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 8922c37..90f5cca 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -56,7 +56,7 @@ config PCI_HOST_GENERIC
 	  controller, such as the one emulated by kvmtool.
 
 config PCIE_SPEAR13XX
-	tristate "STMicroelectronics SPEAr PCIe controller"
+	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX
 	select PCIEPORTBUS
 	select PCIE_DW
-- 
1.8.1.2

