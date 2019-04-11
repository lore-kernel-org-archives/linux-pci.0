Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DF6C10F14
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F8B2173C
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bpdtyN/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDKRGY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:06:24 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7253 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKRGY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:06:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf740d0000>; Thu, 11 Apr 2019 10:06:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:06:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:06:23 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:06:23 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:06:20 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 29/30] PCI: tegra: Add support for GPIO based PCIe reset
Date:   Thu, 11 Apr 2019 22:33:54 +0530
Message-ID: <20190411170355.6882-30-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002381; bh=b3e7OhRFH9QAd19m73yUJDf0ooZ9e5e17Yw9VY4k1tM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=bpdtyN/uFffXZFtSajm9GZtD2OLUTWuRoIjqpnoAxLjW9LBXuRhHA/cxQ28ifI7eK
         S5C2ZEn29JeQcQCeQGuYgMJ7kBC/EGyB6d5psunC7gL1l0jqoUo2Ux8ahVggWt3/NK
         H0wjs9hJM7CRf9dwOnWx5WL4uX7AKhre41ZAkvZ2NB5qh8M3NUkLzF1RPkxtG7strp
         +dZeofL+wp8PZEFwRSXlEcpl3eE1Te6n1qd9qt/aSfjuaaldrbrWrgxT9k72tIx6Hg
         PqBwWWvjGrIdv5agKszqvY2D0qZy6b632CbDAhz+zFchUIC/TlCXRm1Ba5BkPdpC3T
         17HVjkQf7ukoQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for GPIO based PERST# instead of SFIO mode controller by AFI.
GPIO number comes from per port PCIe device tree node.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 37 +++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 4a91c9fb3a9d..75873e6627f9 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
@@ -26,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
@@ -406,6 +408,7 @@ struct tegra_pcie_port {
 
 	int n_gpios;
 	int *gpios;
+	int rst_gpio;
 };
 
 struct tegra_pcie_bus {
@@ -589,15 +592,23 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
 	unsigned long value;
 
 	/* pulse reset signal */
-	value = afi_readl(port->pcie, ctrl);
-	value &= ~AFI_PEX_CTRL_RST;
-	afi_writel(port->pcie, value, ctrl);
+	if (gpio_is_valid(port->rst_gpio)) {
+		gpio_set_value(port->rst_gpio, 0);
+	} else {
+		value = afi_readl(port->pcie, ctrl);
+		value &= ~AFI_PEX_CTRL_RST;
+		afi_writel(port->pcie, value, ctrl);
+	}
 
 	usleep_range(1000, 2000);
 
-	value = afi_readl(port->pcie, ctrl);
-	value |= AFI_PEX_CTRL_RST;
-	afi_writel(port->pcie, value, ctrl);
+	if (gpio_is_valid(port->rst_gpio)) {
+		gpio_set_value(port->rst_gpio, 1);
+	} else {
+		value = afi_readl(port->pcie, ctrl);
+		value |= AFI_PEX_CTRL_RST;
+		afi_writel(port->pcie, value, ctrl);
+	}
 }
 
 static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
@@ -2241,6 +2252,20 @@ static int tegra_pcie_parse_plat_dt(struct tegra_pcie_port *port,
 		}
 	}
 
+	port->rst_gpio = of_get_named_gpio(np, "nvidia,rst-gpio", 0);
+	if (gpio_is_valid(port->rst_gpio)) {
+		err = devm_gpio_request(dev, port->rst_gpio, "pex_rst_gpio");
+		if (err < 0) {
+			dev_err(dev, "rst_gpio request failed: %d\n", err);
+			return err;
+		}
+		err = gpio_direction_output(port->rst_gpio, 0);
+		if (err < 0) {
+			dev_err(dev, "rst_gpio set o/p failed: %d\n", err);
+			return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.17.1

