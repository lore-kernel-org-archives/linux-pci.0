Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0118.outbound.protection.outlook.com ([207.46.100.118]:14112
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752480AbaJTFzr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Oct 2014 01:55:47 -0400
From: Richard Zhu <richard.zhu@freescale.com>
To: <linux-pci@vger.kernel.org>
CC: <shawn.guo@freescale.com>, <festevam@gmail.com>,
	<l.stach@pengutronix.de>, <tharvey@gateworks.com>,
	<m-karicheri2@ti.com>, Richard Zhu <r65037@freescale.com>,
	Richard Zhu <richard.zhu@freescale.com>
Subject: [PATCH v8 2/9] PCI: designware: Fix one potential assignment error of cfg start
Date: Mon, 20 Oct 2014 13:25:17 +0800
Message-ID: <1413782724-30795-3-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
References: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Zhu <r65037@freescale.com>

if va_cfg0_base/va_cfg1_base are initialized by
designware core, the pp->cfg.start is not initialized
properly, when IORESOURCE_MEM "config" is represented
as cfg space resource.
solution: assign cfg_res->start to pp->cfg.start.

Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
---
 drivers/pci/host/pcie-designware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 8d1c809..e3cd54a 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -472,6 +472,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	if (cfg_res) {
 		pp->config.cfg0_size = resource_size(cfg_res)/2;
 		pp->config.cfg1_size = resource_size(cfg_res)/2;
+		pp->cfg.start = cfg_res->start;
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->config.cfg0_size;
 
-- 
1.9.1

