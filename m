Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC86BC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC7A20818
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kB6iyAKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDKRGR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:06:17 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11836 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKRGR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:06:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf740c0000>; Thu, 11 Apr 2019 10:06:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:06:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:06:16 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:06:15 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:06:12 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 27/30] PCI: tegra: Add support to configure platform GPIOs
Date:   Thu, 11 Apr 2019 22:33:52 +0530
Message-ID: <20190411170355.6882-28-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002380; bh=TRwT6uJRrYeFirfFUPjMTRYXSppFeOoz/cV88XhtMhY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kB6iyAKr9LjQ0+EuKMElB55SYp3ZiGYe4WQIUR09ObewItDRT4q8OkzuhgADTr2rM
         zLRM8LfSXheN+AcCABZbESvKDOsS2t8YhbQi7w7BaykF2Pt6zhphmql7DNfNLQet5o
         rm9cnov41YjKc+AAPe06DasS52mG6EYObKfTRT2huTpfTb2gmDHGOTmEX5eLxj+fct
         NU4OX3rdegzYMEDyjmxPdBPXXnJ3AF+l7mP4+oZhgFfPkqlKzPeBGi0OEIm3TLFk6W
         IQSmYYbianw9g+tBCLNuDs6C3mxQHAYHEw1hRgTdYFK5mO5694Fg9bfC7yTtQYdNaF
         yM8aBAKWSwOgQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Few endpoints provides gpio control to its internal regulators or PCIe
interface. For example, few Wi-Fi chips provide gpio control to turn ON
or OFF internal regulators and RTL8111 NIC card provides a gpio control
to stop sampling PCIe Rx lane & driving Tx lane.

Add generic support to configure platform specific GPIOs of both
active high and low types before going for PCIe link up.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 92c6daa0de84..4a91c9fb3a9d 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -403,6 +403,9 @@ struct tegra_pcie_port {
 	unsigned int lanes;
 
 	struct phy **phys;
+
+	int n_gpios;
+	int *gpios;
 };
 
 struct tegra_pcie_bus {
@@ -1359,6 +1362,17 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	return err;
 }
 
+static void tegra_pcie_config_plat(struct tegra_pcie *pcie, bool set)
+{
+	struct tegra_pcie_port *port;
+	int count;
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		for (count = 0; count < port->n_gpios; ++count)
+			gpiod_set_value(gpio_to_desc(port->gpios[count]), set);
+	}
+}
+
 static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -2191,6 +2205,45 @@ static int tegra_pcie_parse_pinctrl(struct tegra_pcie *pcie)
 	return err;
 }
 
+static int tegra_pcie_parse_plat_dt(struct tegra_pcie_port *port,
+				    struct device_node *np)
+{
+	struct device *dev = port->pcie->dev;
+	int count, gpio, err;
+	enum of_gpio_flags flags;
+	unsigned long f;
+
+	port->n_gpios = of_gpio_named_count(np, "nvidia,plat-gpios");
+	if (port->n_gpios > 0) {
+		port->gpios = devm_kzalloc(dev, port->n_gpios * sizeof(int),
+					   GFP_KERNEL);
+		if (!port->gpios)
+			return -ENOMEM;
+
+		for (count = 0; count < port->n_gpios; ++count) {
+			gpio = of_get_named_gpio_flags(np, "nvidia,plat-gpios",
+						       count, &flags);
+			if (!gpio_is_valid(gpio)) {
+				dev_err(dev, "invalid gpio: %d\n", gpio);
+				return gpio;
+			}
+
+			f = (flags & OF_GPIO_ACTIVE_LOW) ?
+			    (GPIOF_OUT_INIT_LOW | GPIOF_ACTIVE_LOW) :
+			    GPIOF_OUT_INIT_HIGH;
+
+			err = devm_gpio_request_one(dev, gpio, f, NULL);
+			if (err < 0) {
+				dev_err(dev, "gpio %d request failed\n", gpio);
+				return err;
+			}
+			port->gpios[count] = gpio;
+		}
+	}
+
+	return 0;
+}
+
 static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -2332,6 +2385,10 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		if (IS_ERR(rp->base))
 			return PTR_ERR(rp->base);
 
+		err = tegra_pcie_parse_plat_dt(rp, port);
+		if (err < 0)
+			return err;
+
 		list_add_tail(&rp->list, &pcie->ports);
 	}
 
@@ -2917,6 +2974,7 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 	if (pcie->soc->config_pex_io_dpd)
 		pinctrl_select_state(pcie->pex_pinctrl, pcie->pex_dpd_enable);
 	tegra_pcie_power_off(pcie);
+	tegra_pcie_config_plat(pcie, 0);
 
 	return 0;
 }
@@ -2926,6 +2984,7 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 	struct tegra_pcie *pcie = dev_get_drvdata(dev);
 	int err;
 
+	tegra_pcie_config_plat(pcie, 1);
 	err = tegra_pcie_power_on(pcie);
 	if (err) {
 		dev_err(dev, "tegra pcie power on fail: %d\n", err);
-- 
2.17.1

