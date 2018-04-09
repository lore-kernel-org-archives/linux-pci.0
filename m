Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v2 8/9] PCI: dwc: Small computation improvement
Date: Mon,  9 Apr 2018 10:41:17 +0100
Message-Id: <5181f7ffbb9d2889974c49d84e72042251adf8b6.1523266508.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replaces a simple division by 2 to a right shift rotation of 1 bit.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
- Nothing changed, just to follow the patch set version.

 drivers/pci/dwc/pcie-designware-host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 03e9b82..8e6fed4 100644
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
