Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 12:07:17 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] PCI: faraday: fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20171017170717.GA30633@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix inconsistent IS_ERR and PTR_ERR in faraday_pci_probe.
The proper pointer to be passed as argument is p->bus_clk.

This issue was detected with the help of Coccinelle.

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
This code was tested by compilation only.

 drivers/pci/host/pci-ftpci100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 06d9687..fae6bd1 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -463,7 +463,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	}
 	p->bus_clk = devm_clk_get(dev, "PCICLK");
 	if (IS_ERR(p->bus_clk))
-		return PTR_ERR(clk);
+		return PTR_ERR(p->bus_clk);
 	ret = clk_prepare_enable(p->bus_clk);
 	if (ret) {
 		dev_err(dev, "could not prepare PCICLK\n");
-- 
2.7.4
