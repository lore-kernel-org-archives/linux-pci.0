Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42373 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbaGWRwt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 13:52:49 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	kernel@pengutronix.de
Subject: [PATCH 4/4] PCI: imx6: move to module_init
Date: Wed, 23 Jul 2014 19:52:41 +0200
Message-Id: <1406137961-14684-5-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This effectively reverts f216f57ffe6eede3c8a763add65d331e688f8c56
"PCI: imx6: Probe the PCIe in fs_initcall()" as the ressource
allocation issue that prevented the driver from working properly
at module_initcall level is now fixed in pcie-designware.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a568efaa331c..0fc2ba8ea006 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -609,7 +609,7 @@ static int __init imx6_pcie_init(void)
 {
 	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
 }
-fs_initcall(imx6_pcie_init);
+module_init(imx6_pcie_init);
 
 MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");
 MODULE_DESCRIPTION("Freescale i.MX6 PCIe host controller driver");
-- 
2.0.1

