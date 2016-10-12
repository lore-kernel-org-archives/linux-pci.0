Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:50646 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932411AbcJLCKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2016 22:10:49 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rajat Jain <rajatja@google.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 3/3] PCI: rockchip: add COMPILE_TEST for Kconfig
Date: Wed, 12 Oct 2016 10:05:03 +0800
Message-Id: <1476237903-15076-3-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1476237903-15076-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476237903-15076-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add this could help build the driver if we enable
CONFIG_COMPILE_TEST.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d7e7c0a..096440e 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -276,7 +276,7 @@ config PCIE_ARTPEC6
 
 config PCIE_ROCKCHIP
 	bool "Rockchip PCIe controller"
-	depends on ARCH_ROCKCHIP
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
-- 
2.3.7


