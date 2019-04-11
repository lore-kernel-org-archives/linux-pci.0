Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185E0C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0AB2146F
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Cu7oLYUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfDKREn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:04:43 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15191 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfDKREn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:04:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73980000>; Thu, 11 Apr 2019 10:04:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:04:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 11 Apr 2019 10:04:41 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:04:40 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:04:40 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:04:36 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 04/30] PCI: tegra: Add PCIe Gen2 link speed support
Date:   Thu, 11 Apr 2019 22:33:29 +0530
Message-ID: <20190411170355.6882-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002265; bh=Kqr8uReZLMu/XSKwkh8SGFBm0mldxPJeeqppaM3RtBc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Cu7oLYUbesSHaJ4oUk3mwQ5aUJGNeFS0qBnT1j0Rija6OgVwymAMo357LS/z/jkUT
         f4OZ9YyTJxR6Ye3Nekq7nGIXATEgqKpdsi6U8whOcv8Iqf6CWYWWf2DHCjGZ8CxEPF
         9ewYw5VkpWzq6aHtoNNeUrktQECUSLZYSvZynMGHmsKtWGolSxyUItWuRfmz8aWJCA
         6WatKP6Ii1dYz8uWv0b7leDSzno6GsOPVcXprZN6N6Ncq3jRFdnFcOxS3F2XwH+piu
         xLKV0xNUpje4OqXmBnAWJXxk/sDFQ9CiIblathJysdWpwBLiRY+7xTJmg757Fetcq+
         vwwROeqvAMYqg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra124, 132, 210 and 186 support Gen2 link speed. After PCIe link is up
in Gen1, set target link speed as Gen2 and retrain link. Link switches to
Gen2 speed if Gen2 capable end point is connected, else link stays in Gen1.

Per PCIe 4.0r0.9 sec 7.6.3.7 implementation note, driver need to wait for
PCIe LTSSM to come back from recovery before retraining the link.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 61 ++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index a61ce9d475b4..6ccda82735f8 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -191,6 +191,8 @@
 #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
 #define  RP_LINK_CONTROL_STATUS_LINKSTAT_MASK	0x3fff0000
 
+#define RP_LINK_CONTROL_STATUS_2		0x000000b0
+
 #define PADS_CTL_SEL		0x0000009c
 
 #define PADS_CTL		0x000000a0
@@ -2096,6 +2098,62 @@ static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
 		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
 }
 
+#define LINK_RETRAIN_TIMEOUT 100000
+
+static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct tegra_pcie_port *port, *tmp;
+	ktime_t deadline;
+	u32 val;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		/*
+		 * Link Capabilities 2 register is hardwired to 0 in Tegra,
+		 * so no need to read it before setting target speed.
+		 */
+		val = readl(port->base + RP_LINK_CONTROL_STATUS_2);
+		val &= ~PCI_EXP_LNKSTA_CLS;
+		val |= PCI_EXP_LNKSTA_CLS_5_0GB;
+		writel(val, port->base + RP_LINK_CONTROL_STATUS_2);
+
+		/*
+		 * Poll until link comes back from recovery to avoid race
+		 * condition.
+		 */
+		deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
+		for (;;) {
+			val = readl(port->base + RP_LINK_CONTROL_STATUS);
+			if (!(val & PCI_EXP_LNKSTA_LT))
+				break;
+			if (ktime_after(ktime_get(), deadline))
+				break;
+			usleep_range(2000, 3000);
+		}
+		if (val & PCI_EXP_LNKSTA_LT)
+			dev_err(dev, "PCIe port %u link is still in recovery\n",
+				port->index);
+
+		/* Retrain the link */
+		val = readl(port->base + RP_LINK_CONTROL_STATUS);
+		val |= PCI_EXP_LNKCTL_RL;
+		writel(val, port->base + RP_LINK_CONTROL_STATUS);
+
+		deadline = ktime_add_us(ktime_get(), LINK_RETRAIN_TIMEOUT);
+		for (;;) {
+			val = readl(port->base + RP_LINK_CONTROL_STATUS);
+			if (!(val & PCI_EXP_LNKSTA_LT))
+				break;
+			if (ktime_after(ktime_get(), deadline))
+				break;
+			usleep_range(2000, 3000);
+		}
+		if (val & PCI_EXP_LNKSTA_LT)
+			dev_err(dev, "link retrain of PCIe port %u failed\n",
+				port->index);
+	}
+}
+
 static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -2122,6 +2180,9 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
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

