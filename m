Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:36058 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757661AbeD0MAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 08:00:14 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v8 8/9] PCI: dwc: Small computation improvement
Date: Fri, 27 Apr 2018 13:00:03 +0100
Message-Id: <a0bb1eb13d2f2a156c3b5a99d6140c07b6b56fe4.1524829928.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
References: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
References: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace a division by 2 operation for a right shift rotation of 1 bit.

Probably any recent and decent compiler does this kind of substitution
in order to improve code performance. Nevertheless it's a coding good
practice whenever there is a division / multiplication by multiple of 2
to replace it by the equivalent operation in this case, the shift
rotation.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
---
Change v1->v2:
 - Nothing changed, just to follow the patch set version.
Change v2->v3:
 - Nothing changed, just to follow the patch set version.
Changes v3->v4:
 - Added a small explication to the log description.
Changes v4->v5:
 - Nothing changed, just to follow the patch set version.
Changes v5->v6:
 - Nothing changed, just to follow the patch set version.
Changes v6->v7:
 - Nothing changed, just to follow the patch set version.
Changes v7->v8:
 - Patch description rework for an imperative verbal mode.

 drivers/pci/dwc/pcie-designware-host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 5a23f78..fc55fde 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -332,8 +332,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
-		pp->cfg0_size = resource_size(cfg_res) / 2;
-		pp->cfg1_size = resource_size(cfg_res) / 2;
+		pp->cfg0_size = resource_size(cfg_res) >> 1;
+		pp->cfg1_size = resource_size(cfg_res) >> 1;
 		pp->cfg0_base = cfg_res->start;
 		pp->cfg1_base = cfg_res->start + pp->cfg0_size;
 	} else if (!pp->va_cfg0_base) {
@@ -377,8 +377,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
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
