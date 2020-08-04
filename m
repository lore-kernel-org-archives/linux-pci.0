Return-Path: <SRS0=QtGK=BO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF629C433E0
	for <linux-pci@archiver.kernel.org>; Tue,  4 Aug 2020 11:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18C32086A
	for <linux-pci@archiver.kernel.org>; Tue,  4 Aug 2020 11:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596542323;
	bh=CkaRHwXCd4oRoqBa/zxZnS1iAu+aHPNNEYM3Zs6/bo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dvjvdvF3QBWbeVbTiXO2gizS/faDJ5oTuMlQ/ukGtmaJ/edr4tPEZE+DF5jJvO/a8
	 O9vFrJOPq69VObzLzBaRH/dC9OSl6TP1CIgadS5uhLi5cJhvZ7/1Wq/xBqF+OwE/up
	 j800rg5zFNL7AwvTGdZXawSTWEuQj3jxKzJjLeCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgHDL6m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730440AbgHDL63 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 07:58:29 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2320D22B42;
        Tue,  4 Aug 2020 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596542289;
        bh=CkaRHwXCd4oRoqBa/zxZnS1iAu+aHPNNEYM3Zs6/bo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xjzc7MuCNWnmAM6Jsk4ZBAGTWxLAPZ8xnAeaG7S9IbCgiF2U76bjhp61JgYGJG1YV
         rHabv0E2JbAf2ZIS9T6obs7k3jtBBqo1RsfhYqPXLONHsfaR6TV9mOXtBoFD8HH+J0
         nrsH0AmTInoA2YG+012K8M+F/EHDCxKxASubUBPw=
Received: by pali.im (Postfix)
        id 718E27FD; Tue,  4 Aug 2020 13:58:07 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v2 4/5] PCI: aardvark: Implement driver 'remove' function and allow to build it as module
Date:   Tue,  4 Aug 2020 13:57:46 +0200
Message-Id: <20200804115747.7078-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200804115747.7078-1-pali@kernel.org>
References: <20200804115747.7078-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Providing driver's 'remove' function allows kernel to bind and unbind devices
from aardvark driver. It also allows to build aardvark driver as a module.

Compiling aardvark as a module simplifies development and debugging of
this driver as it can be reloaded at runtime without the need to reboot
to new kernel.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/controller/Kconfig        |  2 +-
 drivers/pci/controller/pci-aardvark.c | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index adddf21fa381..f9da5ff2c517 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -12,7 +12,7 @@ config PCI_MVEBU
 	select PCI_BRIDGE_EMUL
 
 config PCI_AARDVARK
-	bool "Aardvark PCIe controller"
+	tristate "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index d5f58684d962..f5c1d231b0e2 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/phy/phy.h>
@@ -1114,6 +1115,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
+	platform_set_drvdata(pdev, pcie);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pcie->base = devm_ioremap_resource(dev, res);
@@ -1204,18 +1206,37 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int advk_pcie_remove(struct platform_device *pdev)
+{
+	struct advk_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
+
+	advk_pcie_remove_msi_irq_domain(pcie);
+	advk_pcie_remove_irq_domain(pcie);
+
+	return 0;
+}
+
 static const struct of_device_id advk_pcie_of_match_table[] = {
 	{ .compatible = "marvell,armada-3700-pcie", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, advk_pcie_of_match_table);
 
 static struct platform_driver advk_pcie_driver = {
 	.driver = {
 		.name = "advk-pcie",
 		.of_match_table = advk_pcie_of_match_table,
-		/* Driver unloading/unbinding currently not supported */
-		.suppress_bind_attrs = true,
 	},
 	.probe = advk_pcie_probe,
+	.remove = advk_pcie_remove,
 };
-builtin_platform_driver(advk_pcie_driver);
+module_platform_driver(advk_pcie_driver);
+
+MODULE_DESCRIPTION("Aardvark PCIe controller");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

