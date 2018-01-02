Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46585 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeABSoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jan 2018 13:44:32 -0500
Received: by mail-qk0-f193.google.com with SMTP id b132so32466205qkc.13
        for <linux-pci@vger.kernel.org>; Tue, 02 Jan 2018 10:44:32 -0800 (PST)
Subject: Re: Regression: NULL pointer dereference caused by
 iproc_pcie_map_dma_ranges
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Oza Oza <oza.oza@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
References: <CACna6rxOBUfVhqrMZ2=-6NLrey7193Dtgf-DniSw8Y+qCD6kKA@mail.gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <6707e532-7a5e-261c-4d5b-950d0ccc8f66@broadcom.com>
Date: Tue, 2 Jan 2018 10:44:27 -0800
MIME-Version: 1.0
In-Reply-To: <CACna6rxOBUfVhqrMZ2=-6NLrey7193Dtgf-DniSw8Y+qCD6kKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafal,

Can you please give the following patch a try to see if that fixes the 
issue? Thanks.

 From f91de124bc8fb5645d7dbbfd68a9a68617955749 Mon Sep 17 00:00:00 2001
From: Ray Jui <ray.jui@broadcom.com>
Date: Tue, 2 Jan 2018 10:36:03 -0800
Subject: [PATCH] PCI: iproc: Fix NULL pointer dereference for BCMA

With the inbound DMA mapping supported added, the iProc PCIe driver
parses DT property "dma-ranges" through call to
"of_pci_dma_range_parser_init". In the case of BCMA, this results in a
NULL pointer deference due to a missing of_node.

Fix this by adding a guard in pcie-iproc-platform.c to only enable the
inbound DMA mapping logic when DT property "dma-ranges" is present

fixes: dd9d4e7498de3 ("PCI: iproc: Add inbound DMA mapping support")
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
  drivers/pci/host/pcie-iproc-platform.c | 3 +++
  drivers/pci/host/pcie-iproc.c          | 8 +++++---
  drivers/pci/host/pcie-iproc.h          | 2 ++
  3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-platform.c 
b/drivers/pci/host/pcie-iproc-platform.c
index a5073a9..235c545 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -92,6 +92,9 @@ static int iproc_pcie_pltfm_probe(struct 
platform_device *pdev)
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
@@ -1378,9 +1378,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, 
struct list_head *res)
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


On 12/29/2017 2:34 PM, Rafał Miłecki wrote:
> Hi, I just updated from kernel 4.9 to 4.14 and found a NULL pointer
> dereference caused by the iproc driver.
> 
> 1) For bcma case pcie->dev->of_node can be NULL
> 2) iproc_pcie_map_dma_ranges calls pci_dma_range_parser_init
> 3) pci_dma_range_parser_init calls of_n_addr_cells(node) (node is NULL)
> 
> This is caused by a commit dd9d4e7498de3 ("PCI: iproc: Add inbound DMA
> mapping support").
> 
> I believe that new DMA mapping code should be optional.
> 
> Would you find a moment to fix that, please?
> 
