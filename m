Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E42C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F1220843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AqSUJ6+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfDWJ3J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:29:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7884 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDWJ3I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:29:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedae80000>; Tue, 23 Apr 2019 02:29:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:29:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Apr 2019 02:29:06 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:01 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:01 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:28:58 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 06/28] PCI: tegra: Add PCIe Gen2 link speed support
Date:   Tue, 23 Apr 2019 14:58:03 +0530
Message-ID: <20190423092825.759-7-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011752; bh=GX0wb/MG8hEbiGmXz2Wd/Rwi79FPLBNJFQQVeJodHQY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=AqSUJ6+WUBvuxuvNSR+X7YVMDHjBsl2Nj8sUNPlK7UJQQ8n5un7ohQQW0OEUg9VAr
         8VRhludddkuhXdsxFlkW9IxqQ59GdGxJFhE1UI8RSWmxBMe2M8znSTSq/VXUjwLEVL
         h/2IdhdnsWbE8byA1WKe7bjHW5lg14W1Dur2D33JSyJbEI8P9BToYkjKejaKbnnnwi
         HwK1UyX7YlD9XFF07Q20tVPq+YIJgE4WVNu4eO03OuxSdOdvJqjG09un/3BIOWC7bx
         Yfz/D9QtpnCtupZeSjLwSLcYDozuhCx9JNWeQTOWlr0spHq+MWAFoYJKVc7HtLjIKR
         MgNuACrhInvPA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra124, Tegra132, Tegra210 and Tegra186 support Gen2 link speed. After
PCIe link is up in Gen1, set target link speed as Gen2 and retrain link.
Link switches to Gen2 speed if Gen2 capable end point is connected, else
link stays in Gen1.

Per PCIe 4.0r0.9 sec 7.6.3.7 implementation note, driver need to wait for
PCIe LTSSM to come back from recovery before retraining the link.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Changed "for loop" to "while", to make it compact and handled coding
style comments.

 drivers/pci/controller/pci-tegra.c | 62 ++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index ed0cfd355b28..0ae8ebe92bb9 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -191,6 +191,8 @@
 #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
 #define  RP_LINK_CONTROL_STATUS_LINKSTAT_MASK	0x3fff0000
 
+#define RP_LINK_CONTROL_STATUS_2		0x000000b0
+
 #define PADS_CTL_SEL		0x0000009c
 
 #define PADS_CTL		0x000000a0
@@ -226,6 +228,7 @@
 #define PADS_REFCLK_CFG_DRVI_SHIFT		12 /* 15:12 */
 
 #define PME_ACK_TIMEOUT 10000
+#define LINK_RETRAIN_TIMEOUT 100000 /* in usec */
 
 struct tegra_msi {
 	struct msi_controller chip;
@@ -2092,6 +2095,62 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
 	return false;
 }
 
+static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct tegra_pcie_port *port, *tmp;
+	ktime_t deadline;
+	u32 value;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		/*
+		 * "Supported Link Speeds Vector" in "Link Capabilities 2"
+		 * is not supported by Tegra. tegra_pcie_change_link_speed()
+		 * is called only for Tegra chips which support Gen2.
+		 * So there no harm if supported link speed is not verified.
+		 */
+		value = readl(port->base + RP_LINK_CONTROL_STATUS_2);
+		value &= ~PCI_EXP_LNKSTA_CLS;
+		value |= PCI_EXP_LNKSTA_CLS_5_0GB;
+		writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
+
+		/*
+		 * Poll until link comes back from recovery to avoid race
+		 * condition.
+		 */
+		deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
+
+		while (ktime_before(ktime_get(), deadline)) {
+			value = readl(port->base + RP_LINK_CONTROL_STATUS);
+			if ((value & PCI_EXP_LNKSTA_LT) == 0)
+				break;
+
+			usleep_range(2000, 3000);
+		}
+		if (value & PCI_EXP_LNKSTA_LT)
+			dev_warn(dev, "PCIe port %u link is in recovery\n",
+				 port->index);
+
+		/* Retrain the link */
+		value = readl(port->base + RP_LINK_CONTROL_STATUS);
+		value |= PCI_EXP_LNKCTL_RL;
+		writel(value, port->base + RP_LINK_CONTROL_STATUS);
+
+		deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
+
+		while (ktime_before(ktime_get(), deadline)) {
+			value = readl(port->base + RP_LINK_CONTROL_STATUS);
+			if ((value & PCI_EXP_LNKSTA_LT) == 0)
+				break;
+
+			usleep_range(2000, 3000);
+		}
+		if (value & PCI_EXP_LNKSTA_LT)
+			dev_err(dev, "failed to retrain link of port %u\n",
+				port->index);
+	}
+}
+
 static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -2116,6 +2175,9 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 		tegra_pcie_port_disable(port);
 		tegra_pcie_port_free(port);
 	}
+
+	if (pcie->soc->has_gen2)
+		tegra_pcie_change_link_speed(pcie);
 }
 
 static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
-- 
2.17.1

