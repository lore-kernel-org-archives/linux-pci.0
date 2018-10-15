Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E388C28CF8
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0912086A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 08:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0912086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeJOPxc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:53:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24511 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726904AbeJOPxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Oct 2018 11:53:32 -0400
X-UUID: ff532e0b2b4146eca5935e4496261383-20181015
X-UUID: ff532e0b2b4146eca5935e4496261383-20181015
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1795508987; Mon, 15 Oct 2018 16:09:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Oct 2018 16:09:13 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Oct 2018 16:09:11 +0800
From:   <honghui.zhang@mediatek.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ryder.lee@mediatek.com>
CC:     <ulf.hansson@linaro.org>, <marc.zyngier@arm.com>,
        <matthias.bgg@gmail.com>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <honghui.zhang@mediatek.com>, <youlin.pei@mediatek.com>,
        <yt.shen@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>
Subject: [PATCH v8 9/9] PCI: mediatek: Add loadable kernel module support
Date:   Mon, 15 Oct 2018 16:09:00 +0800
Message-ID: <1539590940-13355-10-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6B585DFADFB3E1A7AEE626DC53208B2C60F4F3DE9597F5C5BFF1E8259F655E122000:8
X-MTK:  N
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Implement remove callback function for Mediatek PCIe driver to add
loadable kernel module support.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/Kconfig         |  2 +-
 drivers/pci/controller/pcie-mediatek.c | 51 +++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 028b287..465790f 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -231,7 +231,7 @@ config PCIE_ROCKCHIP_EP
 	  available to support GEN2 with 4 slots.
 
 config PCIE_MEDIATEK
-	bool "MediaTek PCIe controller"
+	tristate "MediaTek PCIe controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index daba78f..5048adb 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
@@ -532,6 +533,27 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
+static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+{
+	struct mtk_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+
+		if (port->irq_domain)
+			irq_domain_remove(port->irq_domain);
+
+		if (IS_ENABLED(CONFIG_PCI_MSI)) {
+			if (port->msi_domain)
+				irq_domain_remove(port->msi_domain);
+			if (port->inner_domain)
+				irq_domain_remove(port->inner_domain);
+		}
+
+		irq_dispose_mapping(port->irq);
+	}
+}
+
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
@@ -1171,6 +1193,31 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+
+static void mtk_pcie_free_resources(struct mtk_pcie *pcie)
+{
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+	struct list_head *windows = &host->windows;
+
+	pci_free_resource_list(windows);
+}
+
+static int mtk_pcie_remove(struct platform_device *pdev)
+{
+	struct mtk_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
+
+	pci_stop_root_bus(host->bus);
+	pci_remove_root_bus(host->bus);
+	mtk_pcie_free_resources(pcie);
+
+	mtk_pcie_irq_teardown(pcie);
+
+	mtk_pcie_put_resources(pcie);
+
+	return 0;
+}
+
 static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
@@ -1248,6 +1295,7 @@ static const struct of_device_id mtk_pcie_ids[] = {
 
 static struct platform_driver mtk_pcie_driver = {
 	.probe = mtk_pcie_probe,
+	.remove = mtk_pcie_remove,
 	.driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_ids,
@@ -1255,4 +1303,5 @@ static struct platform_driver mtk_pcie_driver = {
 		.pm = &mtk_pcie_pm_ops,
 	},
 };
-builtin_platform_driver(mtk_pcie_driver);
+module_platform_driver(mtk_pcie_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.6.4

