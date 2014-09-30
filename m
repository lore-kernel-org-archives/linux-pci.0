Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0109.outbound.protection.outlook.com ([207.46.100.109]:28351
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752047AbaI3KHK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Sep 2014 06:07:10 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, Richard Zhu <r65037@freescale.com>
Subject: [PATCH v4 05/10] PCI: designware: fix one potential assignment error of cfg start
Date: Tue, 30 Sep 2014 17:36:39 +0800
Message-ID: <1412069804-17162-6-git-send-email-r65037@freescale.com>
In-Reply-To: <1412069804-17162-1-git-send-email-r65037@freescale.com>
References: <1412069804-17162-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

if va_cfg0_base/va_cfg1_base are initialized by
designware core, the pp->cfg.start is not initialized
properly, when IORESOURCE_MEM "config" is represented
as cfg space resource.
solution: assign cfg_res->start to pp->cfg.start.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/pci/host/pcie-designware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index ae1e6c5..f1f127f 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -444,6 +444,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	if (cfg_res) {
 		pp->config.cfg0_size = resource_size(cfg_res)/2;
 		pp->config.cfg1_size = resource_size(cfg_res)/2;
+		pp->cfg.start = cfg_res->start;
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->config.cfg0_size;
 
-- 
1.9.1

