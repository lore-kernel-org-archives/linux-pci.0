Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8470 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932913AbdJQMGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 08:06:55 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Brian Norris <briannorris@chromium.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH -next] PCI: faraday: Fix wrong pointer passed to PTR_ERR()
Date: Tue, 17 Oct 2017 12:11:03 +0000
Message-ID: <1508242263-73684-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PTR_ERR should access the value just tested by IS_ERR, otherwise
the wrong error code will be returned.

Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
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
