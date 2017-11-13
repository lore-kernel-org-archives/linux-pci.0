Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v1 1/3] PCI: xgene: Rename xgene_pcie_probe_bridge() to
 xgene_pcie_probe()
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Date: Mon, 13 Nov 2017 16:40:43 -0600
Message-ID: <20171113224043.29024.73152.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@xilinx.com>, rfi@lists.rocketboards.org,
 =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 Ley Foon Tan <lftan@altera.com>, linux-arm-kernel@lists.infradead.org,
 Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Rename xgene_pcie_probe_bridge() to xgene_pcie_probe() to follow the
convention of other drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 087645116ecb..9f53612f6594 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -628,7 +628,7 @@ static struct pci_ops xgene_pcie_ops = {
 	.write = pci_generic_config_write32,
 };
 
-static int xgene_pcie_probe_bridge(struct platform_device *pdev)
+static int xgene_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
@@ -709,7 +709,7 @@ static struct platform_driver xgene_pcie_driver = {
 		.of_match_table = of_match_ptr(xgene_pcie_match_table),
 		.suppress_bind_attrs = true,
 	},
-	.probe = xgene_pcie_probe_bridge,
+	.probe = xgene_pcie_probe,
 };
 builtin_platform_driver(xgene_pcie_driver);
 #endif


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
