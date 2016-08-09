Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
To: helgaas@kernel.org
Cc: jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jszhang@marvell.com,
	Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH v4 3/3] pcie-designware: fix typo
Date: Tue,  9 Aug 2016 17:35:34 +0100
Message-Id: <bba00c66a124b80c2bc259b3d2f78e561c3df27a.1470758382.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470758382.git.jpinto@synopsys.com>
References: <cover.1470758382.git.jpinto@synopsys.com>
In-Reply-To: <cover.1470758382.git.jpinto@synopsys.com>
References: <cover.1470758382.git.jpinto@synopsys.com>
List-ID: <linux-pci.vger.kernel.org>

Simple fix typo.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
---
changes v1->v4:
- Nothing changed. Just to keep up patch set version.

 drivers/pci/host/pcie-designware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 3fb9036..7731eda 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -36,7 +36,7 @@
 #define LINK_WAIT_IATU_MIN		9000
 #define LINK_WAIT_IATU_MAX		10000
 
-/* Synopsis specific PCIE configuration registers */
+/* Synopsys specific PCIE configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_MODE_MASK		(0x3f << 16)
 #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
@@ -253,7 +253,7 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 		}
 
 		if (val == PCIE_ATU_ENABLE)
-			break;
+			return;
 
 		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
 	}
@@ -646,11 +646,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		}
 	}
 
+	pp->iatu_unroll_status = dw_pcie_get_atu_mode(pp);
+
 	if (pp->ops->host_init)
 		pp->ops->host_init(pp);
 
-	pp->iatu_unroll_status = dw_pcie_get_atu_mode(pp);
-
 	pp->root_bus_nr = pp->busn->start;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
-- 
1.8.1.5
