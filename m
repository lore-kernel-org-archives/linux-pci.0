Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:40938 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751245AbeACH1y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jan 2018 02:27:54 -0500
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-arm-kernel@axis.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH -next] PCI: dwc: artpec6: Fix return value check in artpec6_add_pcie_ep()
Date: Wed, 3 Jan 2018 07:33:35 +0000
Message-ID: <1514964815-93190-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In case of error, the function devm_ioremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: b5074ef6fe7d ("PCI: dwc: artpec6: Add support for endpoint mode")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/dwc/pcie-artpec6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 312f21b..b1e9820 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -485,8 +485,8 @@ static int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
 	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
-	if (IS_ERR(pci->dbi_base2))
-		return PTR_ERR(pci->dbi_base2);
+	if (!pci->dbi_base2)
+		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
