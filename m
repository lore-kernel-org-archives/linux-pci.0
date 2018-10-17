Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE94ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A0C2152B
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W1MU7Zra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A0C2152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJQPhF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:37:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52606 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeJQPhE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:37:04 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9H7gNit052378;
        Wed, 17 Oct 2018 02:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539762143;
        bh=qLooC43o3Xah6sg19dYuQxiI+kMXmBiRqnnUEenMqWs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=W1MU7ZraCdhLviemlrJ0vTn8XTzWVcToIOGEjddvO53L2OAfW6TYI97t0igrcMIsc
         Glgi6qIRFcEKdkikpuN4VKUVDzDUexNp+BG0viuwYVd+cxefSzyeWA1XQ5SHhlWuf0
         8Uk7t9y6rYirnXhLn78gBdt769AN0n7B2EkIhb9E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7gNFD009303;
        Wed, 17 Oct 2018 02:42:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 17
 Oct 2018 02:42:23 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 17 Oct 2018 02:42:23 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9H7fgSW009413;
        Wed, 17 Oct 2018 02:42:20 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 11/21] PCI: keystone: Cleanup PHY handling
Date:   Wed, 17 Oct 2018 13:11:04 +0530
Message-ID: <20181017074114.28239-12-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cleanup PHY handling by using devm_phy_optional_get to get PHYs if
the PHYs are optional, creating a device link between the PHY device
and the controller device and disable PHY on error cases here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 122 +++++++++++++++++++---
 1 file changed, 106 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e22328f89c84..5ae73c185c99 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -105,6 +105,9 @@ struct keystone_pcie {
 
 	int			num_msi_host_irqs;
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
+	int			num_lanes;
+	struct phy		**phy;
+	struct device_link	**link;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*legacy_irq_domain;
 	struct device_node	*np;
@@ -880,22 +883,57 @@ static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
 	.link_up = ks_pcie_link_up,
 };
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static void ks_pcie_disable_phy(struct keystone_pcie *ks_pcie)
 {
-	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
+	int num_lanes = ks_pcie->num_lanes;
 
-	clk_disable_unprepare(ks_pcie->clk);
+	while (num_lanes--) {
+		phy_power_off(ks_pcie->phy[num_lanes]);
+		phy_exit(ks_pcie->phy[num_lanes]);
+	}
+}
+
+static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
+{
+	int i;
+	int ret;
+	int num_lanes = ks_pcie->num_lanes;
+
+	for (i = 0; i < num_lanes; i++) {
+		ret = phy_init(ks_pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
+		ret = phy_power_on(ks_pcie->phy[i]);
+		if (ret < 0) {
+			phy_exit(ks_pcie->phy[i]);
+			goto err_phy;
+		}
+	}
 
 	return 0;
+
+err_phy:
+	while (--i >= 0) {
+		phy_power_off(ks_pcie->phy[i]);
+		phy_exit(ks_pcie->phy[i]);
+	}
+
+	return ret;
 }
 
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct phy *phy;
+	struct device_link **link;
+	struct phy **phy;
+	u32 num_lanes;
+	char name[10];
 	int ret;
+	int i;
 
 	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
 	if (!ks_pcie)
@@ -908,29 +946,59 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
 
-	ks_pcie->pci = pci;
+	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
+	if (ret)
+		num_lanes = 1;
 
-	/* initialize SerDes Phy if present */
-	phy = devm_phy_get(dev, "pcie-phy");
-	if (PTR_ERR_OR_ZERO(phy) == -EPROBE_DEFER)
-		return PTR_ERR(phy);
+	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
 
-	if (!IS_ERR_OR_NULL(phy)) {
-		ret = phy_init(phy);
-		if (ret < 0)
-			return ret;
+	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	for (i = 0; i < num_lanes; i++) {
+		snprintf(name, sizeof(name), "pcie-phy%d", i);
+		phy[i] = devm_phy_optional_get(dev, name);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_link;
+		}
+
+		if (!phy[i])
+			continue;
+
+		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
+		if (!link[i]) {
+			ret = -EINVAL;
+			goto err_link;
+		}
+	}
+
+	ks_pcie->np = np;
+	ks_pcie->pci = pci;
+	ks_pcie->link = link;
+	ks_pcie->num_lanes = num_lanes;
+	ks_pcie->phy = phy;
+
+	ret = ks_pcie_enable_phy(ks_pcie);
+	if (ret) {
+		dev_err(dev, "failed to enable phy\n");
+		goto err_link;
 	}
 
-	ks_pcie->np = dev->of_node;
 	platform_set_drvdata(pdev, ks_pcie);
 	ks_pcie->clk = devm_clk_get(dev, "pcie");
 	if (IS_ERR(ks_pcie->clk)) {
 		dev_err(dev, "Failed to get pcie rc clock\n");
-		return PTR_ERR(ks_pcie->clk);
+		ret = PTR_ERR(ks_pcie->clk);
+		goto err_phy;
 	}
+
 	ret = clk_prepare_enable(ks_pcie->clk);
 	if (ret)
-		return ret;
+		goto err_phy;
 
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
@@ -940,9 +1008,31 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(ks_pcie->clk);
 
+err_phy:
+	ks_pcie_disable_phy(ks_pcie);
+
+err_link:
+	while (--i >= 0 && link[i])
+		device_link_del(link[i]);
+
 	return ret;
 }
 
+static int __exit ks_pcie_remove(struct platform_device *pdev)
+{
+	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
+	struct device_link **link = ks_pcie->link;
+	int num_lanes = ks_pcie->num_lanes;
+
+	clk_disable_unprepare(ks_pcie->clk);
+	ks_pcie_disable_phy(ks_pcie);
+
+	while (num_lanes--)
+		device_link_del(link[num_lanes]);
+
+	return 0;
+}
+
 static struct platform_driver ks_pcie_driver __refdata = {
 	.probe  = ks_pcie_probe,
 	.remove = __exit_p(ks_pcie_remove),
-- 
2.17.1

