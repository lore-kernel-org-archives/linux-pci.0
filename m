Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 14/20] PCI: hisi: update PCI config space remap function
Date: Thu, 2 Mar 2017 10:56:16 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1FA96A69@lhreml507-mbx>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-15-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170227151436.18698-15-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo

Many thanks for putting all of this together.

> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: 27 February 2017 15:14
> To: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org; linux-arch@vger.kernel.org; Lorenzo
> Pieralisi; Bjorn Helgaas; Gabriele Paoloni; Wangzhou (B)
> Subject: [PATCH 14/20] PCI: hisi: update PCI config space remap
> function
> 
> PCI configuration space should be mapped with a memory region type that
> generates on the CPU host bus non-posted write transations. Update the
> driver to use the devm_pci_remap_cfg* interface to make sure the
> correct
> memory mappings for PCI configuration space are used.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/pci/dwc/pcie-hisi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index e3e4fed..8042780 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -294,10 +294,9 @@ static int hisi_pcie_probe(struct platform_device
> *pdev)
>  	}
> 
>  	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "rc_dbi");
> -	pci->dbi_base = devm_ioremap_resource(dev, reg);
> +	pci->dbi_base = devm_pci_remap_cfg_resource(dev, reg);
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
> -
>  	platform_set_drvdata(pdev, hisi_pcie);
> 
>  	ret = hisi_add_pcie_port(hisi_pcie, pdev);
> --
> 2.10.0

I think you missed a couple of places where cfg space is ioremapped.
I have added these and merged with your changes in the patch below:

Thanks again
Gab

---------------------------------
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Tue, 21 Feb 2017 15:24:34 +0000
Subject: [PATCH 09/15] PCI: hisi: update PCI config space remap function

PCI configuration space should be mapped with a memory region type that
generates on the CPU host bus non-posted write transations. Update the
driver to use the devm_pci_remap_cfg* interface to make sure the correct
memory mappings for PCI configuration space are used.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/dwc/pcie-hisi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index e3e4fed..a5b542c 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -99,7 +99,7 @@ static int hisi_pcie_init(struct pci_config_window *cfg)
 		return -ENOMEM;
 	}
 
-	reg_base = devm_ioremap(dev, res->start, resource_size(res));
+	reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
 	if (!reg_base)
 		return -ENOMEM;
 
@@ -294,10 +294,9 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	}
 
 	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
-	pci->dbi_base = devm_ioremap_resource(dev, reg);
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, reg);
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
-
 	platform_set_drvdata(pdev, hisi_pcie);
 
 	ret = hisi_add_pcie_port(hisi_pcie, pdev);
@@ -358,7 +357,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
 		return -EINVAL;
 	}
 
-	reg_base = devm_ioremap(dev, res->start, resource_size(res));
+	reg_base = devm_pci_remap_cfgspace(dev, res->start, resource_size(res));
 	if (!reg_base)
 		return -ENOMEM;
 
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
