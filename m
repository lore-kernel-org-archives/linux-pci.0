Return-Path: <SRS0=97kd=EE=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=97kd=EE=broadcom.com=ray.jui@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Rafal Milecki <rafal@milecki.pl>,
	Ray Jui <ray.jui@broadcom.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] PCI: iproc: Fix NULL pointer dereference for BCMA
Date: Tue,  9 Jan 2018 11:45:40 -0800
Message-Id: <1515527140-24964-1-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

With the inbound DMA mapping supported added, the iProc PCIe driver
parses DT property "dma-ranges" through call to
"of_pci_dma_range_parser_init". In the case of BCMA, this results in a
NULL pointer deference due to a missing of_node.

Fix this by adding a guard in pcie-iproc-platform.c to only enable the
inbound DMA mapping logic when DT property "dma-ranges" is present

fixes: dd9d4e7498de3 ("PCI: iproc: Add inbound DMA mapping support")
Reported-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Tested-by: Rafał Miłecki <rafal@milecki.pl>
Cc: <stable@vger.kernel.org> # 4.10+
---
 drivers/pci/host/pcie-iproc-platform.c | 3 +++
 drivers/pci/host/pcie-iproc.c          | 8 +++++---
 drivers/pci/host/pcie-iproc.h          | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index a5073a9..235c545 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -92,6 +92,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		pcie->need_ob_cfg = true;
 	}
 
+	if (of_property_read_bool(np, "dma-ranges"))
+		pcie->need_ib_cfg = true;
+
 	/* PHY use is optional */
 	pcie->phy = devm_phy_get(dev, "pcie-phy");
 	if (IS_ERR(pcie->phy)) {
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 935909b..7583606 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1378,9 +1378,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		}
 	}
 
-	ret = iproc_pcie_map_dma_ranges(pcie);
-	if (ret && ret != -ENOENT)
-		goto err_power_off_phy;
+	if (pcie->need_ib_cfg) {
+		ret = iproc_pcie_map_dma_ranges(pcie);
+		if (ret && ret != -ENOENT)
+			goto err_power_off_phy;
+	}
 
 #ifdef CONFIG_ARM
 	pcie->sysdata.private_data = pcie;
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index a6b55ce..4ac6282 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -74,6 +74,7 @@ struct iproc_msi;
  * @ob: outbound mapping related parameters
  * @ob_map: outbound mapping related parameters specific to the controller
  *
+ * @need_ib_cfg: indicates SW needs to configure the inbound mapping window
  * @ib: inbound mapping related parameters
  * @ib_map: outbound mapping region related parameters
  *
@@ -101,6 +102,7 @@ struct iproc_pcie {
 	struct iproc_pcie_ob ob;
 	const struct iproc_pcie_ob_map *ob_map;
 
+	bool need_ib_cfg;
 	struct iproc_pcie_ib ib;
 	const struct iproc_pcie_ib_map *ib_map;
 
-- 
2.1.4
