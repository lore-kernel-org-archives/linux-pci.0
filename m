Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37804 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754360AbeCGK6L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 05:58:11 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: Joao.Pinto@synopsys.com, bhelgaas@google.com, jg1.han@samsung.com,
        lorenzo.pieralisi@arm.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH 4/4] PCI: dwc: Replace division by 2 to right shift
Date: Wed,  7 Mar 2018 10:58:00 +0000
Message-Id: <50e8cd3d18d9cf1ec98f807ba3b01c6cda1a2acb.1520419084.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520419084.git.gustavo.pimentel@synopsys.com>
References: <cover.1520419084.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520419084.git.gustavo.pimentel@synopsys.com>
References: <cover.1520419084.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

rotation of 1 bit

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 7535918..ff43b0f 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -337,8 +337,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
-		pp->cfg0_size = resource_size(cfg_res) / 2;
-		pp->cfg1_size = resource_size(cfg_res) / 2;
+		pp->cfg0_size = resource_size(cfg_res) >> 1;
+		pp->cfg1_size = resource_size(cfg_res) >> 1;
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
 	} else if (!pp->va_cfg0_base) {
@@ -382,8 +382,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			break;
 		case 0:
 			pp->cfg = win->res;
-			pp->cfg0_size = resource_size(pp->cfg) / 2;
-			pp->cfg1_size = resource_size(pp->cfg) / 2;
+			pp->cfg0_size = resource_size(pp->cfg) >> 1;
+			pp->cfg1_size = resource_size(pp->cfg) >> 1;
 			pp->cfg0_base = pp->cfg->start;
 			pp->cfg1_base = pp->cfg->start + pp->cfg0_size;
 			break;
-- 
2.7.4
