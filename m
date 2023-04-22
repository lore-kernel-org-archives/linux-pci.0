Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA00C7618E
	for <linux-pci@archiver.kernel.org>; Sat, 22 Apr 2023 02:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjDVCWb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Apr 2023 22:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDVCWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 22:22:30 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087730EA;
        Fri, 21 Apr 2023 19:22:03 -0700 (PDT)
Received: from ubuntu.localdomain ([10.21.36.114])
        (user=u202212057@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33M2KMxt012137-33M2KMxu012137
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 22 Apr 2023 10:20:40 +0800
From:   Huang Yuhao <u202212057@hust.edu.cn>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Huang Yuhao <u202212057@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dra7xx: Fix missing unwind goto in 'dra7xx_pcie_probe'
Date:   Fri, 21 Apr 2023 19:20:19 -0700
Message-Id: <20230422022019.7332-1-u202212057@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: u202212057@hust.edu.cn
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In dra7xx_pcie_probe, if dra7xx_pcie_enable_phy fails, it will directly
return without freeing the resources.

Fix this by changing the return statement to a goto statement.

Fixes: 1f6c4501c667 ("PCI: dra7xx: Group PHY API invocations")
Signed-off-by: Huang Yuhao <u202212057@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
This issue is found by static analyzer.

 drivers/pci/controller/dwc/pci-dra7xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4ae807e7cf79..cc3cce0c5552 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -777,7 +777,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	ret = dra7xx_pcie_enable_phy(dra7xx);
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
-		return ret;
+		goto err_enable_phy;
 	}
 
 	platform_set_drvdata(pdev, dra7xx);
@@ -854,7 +854,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	dra7xx_pcie_disable_phy(dra7xx);
-
+err_enable_phy:
 err_link:
 	while (--i >= 0)
 		device_link_del(link[i]);
-- 
2.25.1

