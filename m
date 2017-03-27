Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v2 15/22] PCI: hisi: update PCI config space remap function
Date: Mon, 27 Mar 2017 10:49:43 +0100
Message-Id: <20170327094954.7162-16-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-kernel@vger.kernel.org,
 Zhou Wang <wangzhou1@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_ioremap_nopost* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/dwc/pcie-hisi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index fd66a31..66a91b2 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -99,7 +99,7 @@ static int hisi_pcie_init(struct pci_config_window *cfg)
 		return -ENOMEM;
 	}
 
-	reg_base = devm_ioremap(dev, res->start, resource_size(res));
+	reg_base = devm_ioremap_nopost(dev, res->start, resource_size(res));
 	if (!reg_base)
 		return -ENOMEM;
 
@@ -296,10 +296,9 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	}
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	pci->dbi_base = devm_ioremap_resource(dev, reg);
+	pci->dbi_base = devm_ioremap_nopost_resource(dev, reg);
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
-
 	platform_set_drvdata(pdev, hisi_pcie);
 
 	ret = hisi_add_pcie_port(hisi_pcie, pdev);
@@ -360,7 +359,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 		return -EINVAL;
 	}
 
-	reg_base = devm_ioremap(dev, res->start, resource_size(res));
+	reg_base = devm_ioremap_nopost(dev, res->start, resource_size(res));
 	if (!reg_base)
 		return -ENOMEM;
 
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
