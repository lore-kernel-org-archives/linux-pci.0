Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45658C10F14
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058972082E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hOoQj4zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDKREf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:04:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11624 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfDKREf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:04:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73a50000>; Thu, 11 Apr 2019 10:04:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:04:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:04:32 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:04:32 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:04:32 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:04:29 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 02/30] PCI: tegra: Fix PCIe host power up sequence
Date:   Thu, 11 Apr 2019 22:33:27 +0530
Message-ID: <20190411170355.6882-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002277; bh=ABq9UsEXPVTkOn7iHxD1x75R+d8NlHyQqTsVdnu4vpE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hOoQj4zfWWMAYVq2lCv1ZeH1zVYoUKOkgU50P98bKp0VfgjoeogiTIYgKgZ9UwloQ
         ft5FKSfqeOBNWiYE/di8dMAK8rugczG+ven1/LWJje3pLbRdYqOg9wzFV3HPXKs2Qi
         j1V1tBLbVjp01a6R3i46tvZPLJRRbyunJfYJ4gqPAbIud68uT4/8Ezp61aS4q9P1uM
         GXvY5wEfPt47134m8TjtEeixhiKaxd46IQnHG9EwH5tRKr5inLh6D4b2ULHCh7eeRo
         AGTwoAL5L1edUCFK3j7kzEKhp4LLLaf3yNrW+O97rY2yJqCYCdodK4To79kK3gGQTW
         0kC2DVmjebdTw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe host power up sequence involves programming AFI(AXI to FPCI bridge)
registers first and then PCIe registers. Otherwise AFI register settings
may not latch to PCIe IP.

PCIe root port starts LTSSM as soon as PCIe xrst is deasserted.
So deassert PCIe xrst after programming PCIe registers.

Modify PCIe power up sequence as follows,
  - Power ungate PCIe partition
  - Enable AFI clock
  - Deassert AFI reset
  - Program AFI registers
  - Enable PCIe clock
  - Deassert PCIe reset
  - Program PCIe registers
  - Deassert PCIe xrst to start LTSSM

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 73 ++++++++++++++++++------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index f4f53d092e00..0bf270bcea34 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -966,9 +966,6 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 		}
 	}
 
-	/* take the PCIe interface module out of reset */
-	reset_control_deassert(pcie->pcie_xrst);
-
 	/* finally enable PCIe */
 	value = afi_readl(pcie, AFI_CONFIGURATION);
 	value |= AFI_CONFIGURATION_EN_FPCI;
@@ -997,8 +994,6 @@ static void tegra_pcie_disable_controller(struct tegra_pcie *pcie)
 {
 	int err;
 
-	reset_control_assert(pcie->pcie_xrst);
-
 	if (pcie->soc->program_uphy) {
 		err = tegra_pcie_phy_power_off(pcie);
 		if (err < 0)
@@ -1014,13 +1009,11 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 	int err;
 
 	reset_control_assert(pcie->afi_rst);
-	reset_control_assert(pcie->pex_rst);
 
 	clk_disable_unprepare(pcie->pll_e);
 	if (soc->has_cml_clk)
 		clk_disable_unprepare(pcie->cml_clk);
 	clk_disable_unprepare(pcie->afi_clk);
-	clk_disable_unprepare(pcie->pex_clk);
 
 	if (!dev->pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
@@ -1036,58 +1029,59 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
-	reset_control_assert(pcie->pcie_xrst);
-	reset_control_assert(pcie->afi_rst);
-	reset_control_assert(pcie->pex_rst);
-
-	if (!dev->pm_domain)
-		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
-
 	/* enable regulators */
 	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
 		dev_err(dev, "failed to enable regulators: %d\n", err);
 
-	if (dev->pm_domain) {
-		err = clk_prepare_enable(pcie->pex_clk);
+	if (!dev->pm_domain) {
+		err = tegra_powergate_power_on(TEGRA_POWERGATE_PCIE);
 		if (err) {
-			dev_err(dev, "failed to enable PEX clock: %d\n", err);
-			return err;
+			dev_err(dev, "power ungate failed: %d\n", err);
+			goto regulator_disable;
 		}
-		reset_control_deassert(pcie->pex_rst);
-	} else {
-		err = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_PCIE,
-							pcie->pex_clk,
-							pcie->pex_rst);
+		err = tegra_powergate_remove_clamping(TEGRA_POWERGATE_PCIE);
 		if (err) {
-			dev_err(dev, "powerup sequence failed: %d\n", err);
-			return err;
+			dev_err(dev, "remove clamp failed: %d\n", err);
+			goto powergate;
 		}
 	}
 
-	reset_control_deassert(pcie->afi_rst);
-
 	err = clk_prepare_enable(pcie->afi_clk);
 	if (err < 0) {
 		dev_err(dev, "failed to enable AFI clock: %d\n", err);
-		return err;
+		goto powergate;
 	}
 
 	if (soc->has_cml_clk) {
 		err = clk_prepare_enable(pcie->cml_clk);
 		if (err < 0) {
 			dev_err(dev, "failed to enable CML clock: %d\n", err);
-			return err;
+			goto afi_clk_disable;
 		}
 	}
 
 	err = clk_prepare_enable(pcie->pll_e);
 	if (err < 0) {
 		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
-		return err;
+		goto cml_clk_disable;
 	}
 
+	reset_control_deassert(pcie->afi_rst);
+
 	return 0;
+
+cml_clk_disable:
+	if (soc->has_cml_clk)
+		clk_disable_unprepare(pcie->cml_clk);
+afi_clk_disable:
+	clk_disable_unprepare(pcie->afi_clk);
+powergate:
+	if (!dev->pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
+regulator_disable:
+	regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
+	return err;
 }
 
 static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
@@ -2108,7 +2102,12 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
 			 port->index, port->lanes);
 
 		tegra_pcie_port_enable(port);
+	}
+
+	/* Start LTSSM from Tegra side */
+	reset_control_deassert(pcie->pcie_xrst);
 
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
 		if (tegra_pcie_port_check_link(port))
 			continue;
 
@@ -2123,6 +2122,8 @@ static void tegra_pcie_disable_ports(struct tegra_pcie *pcie)
 {
 	struct tegra_pcie_port *port, *tmp;
 
+	reset_control_assert(pcie->pcie_xrst);
+
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		tegra_pcie_port_disable(port);
 }
@@ -2472,6 +2473,9 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 
 	tegra_pcie_disable_ports(pcie);
 
+	reset_control_assert(pcie->pex_rst);
+	clk_disable_unprepare(pcie->pex_clk);
+
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
 
@@ -2501,10 +2505,19 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_enable_msi(pcie);
 
+	err = clk_prepare_enable(pcie->pex_clk);
+	if (err) {
+		dev_err(dev, "failed to enable PEX clock: %d\n", err);
+		goto disable_controller;
+	}
+	reset_control_deassert(pcie->pex_rst);
+
 	tegra_pcie_enable_ports(pcie);
 
 	return 0;
 
+disable_controller:
+	tegra_pcie_disable_controller(pcie);
 poweroff:
 	tegra_pcie_power_off(pcie);
 
-- 
2.17.1

