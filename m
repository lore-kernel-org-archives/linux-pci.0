Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D4C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874462082E
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y/58FAK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDKRGK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:06:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11825 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKRGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:06:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf74040000>; Thu, 11 Apr 2019 10:06:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:06:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:06:07 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:06:07 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:06:03 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 25/30] PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
Date:   Thu, 11 Apr 2019 22:33:50 +0530
Message-ID: <20190411170355.6882-26-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002372; bh=Bs1HC30Y2IJy7DZ4ZDrB6mvFnE8ZMNr97OkMGJ+AYn4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Y/58FAK4UPzR1hFuIandO84OEictmRIE9Is6yLM7g0/ghS1Ri/uHQiINSqJ9Q65sV
         0botaeEmGMhbnsx5G4aSE43+qdfsSXKgkCjbeVKrUq7kB9oHiXWBKT/rFYpRfciZ9Q
         PxQ8qUWbz0eddi8jGMOdt6Of7tmZPmhcjaj6NdRLcaBpyQf59M6MgoQGurK1g5qjZZ
         DPpCP1U8w5RYySn7RztUic9pFgDgssG9pMbaI2LDW+auJ09lf63MSWV+yt2DNBjXaG
         Lcea7EWzR2A363WQPf4KrPrnw+rA1YSvVQaubjzfJBD7AqAH82OqTLsZuVJVjMluKk
         bQ7hBRGWQMaag==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In Tegra210 AFI design has clamp value for the BIAS pad as 0, which keeps
the bias pad in non power down mode. This is leading to power consumption
of 2 mW in BIAS pad, even if the PCIe partition is power gated. To avoid
unnecessary power consumption, put PEX CLK & BIAS pads in deep power down
mode when PCIe partition is power gated.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 65 +++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index c050687020f0..92c6daa0de84 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
@@ -323,6 +324,7 @@ struct tegra_pcie_soc {
 	bool program_deskew_time;
 	bool raw_violation_fixup;
 	bool update_fc_threshold;
+	bool config_pex_io_dpd;
 	struct {
 		struct {
 			u32 rp_ectl_2_r1;
@@ -385,6 +387,10 @@ struct tegra_pcie {
 
 	const struct tegra_pcie_soc *soc;
 	struct dentry *debugfs;
+
+	struct pinctrl *pex_pinctrl;
+	struct pinctrl_state *pex_dpd_enable;
+	struct pinctrl_state *pex_dpd_disable;
 };
 
 struct tegra_pcie_port {
@@ -2154,6 +2160,37 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 	return tegra_pcie_get_legacy_regulators(pcie);
 }
 
+static int tegra_pcie_parse_pinctrl(struct tegra_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int err = 0;
+
+	pcie->pex_pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(pcie->pex_pinctrl)) {
+		err = PTR_ERR(pcie->pex_pinctrl);
+		dev_err(dev, "failed to get pinctrl handle: %d\n", err);
+		return err;
+	}
+
+	pcie->pex_dpd_enable = pinctrl_lookup_state(pcie->pex_pinctrl,
+						    "pex-dpd-enable");
+	if (IS_ERR(pcie->pex_dpd_enable)) {
+		err = PTR_ERR(pcie->pex_dpd_enable);
+		dev_err(dev, "missing pex-dpd-enable state: %d\n", err);
+		return err;
+	}
+
+	pcie->pex_dpd_disable = pinctrl_lookup_state(pcie->pex_pinctrl,
+						     "pex-dpd-disable");
+	if (IS_ERR(pcie->pex_dpd_disable)) {
+		err = PTR_ERR(pcie->pex_dpd_disable);
+		dev_err(dev, "missing pex-dpd-disable state: %d\n", err);
+		return err;
+	}
+
+	return err;
+}
+
 static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -2496,6 +2533,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
 	.update_fc_threshold = false,
+	.config_pex_io_dpd = false,
 	.ectl.enable = false,
 };
 
@@ -2524,6 +2562,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
 	.update_fc_threshold = false,
+	.config_pex_io_dpd = false,
 	.ectl.enable = false,
 };
 
@@ -2547,6 +2586,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.program_deskew_time = false,
 	.raw_violation_fixup = true,
 	.update_fc_threshold = false,
+	.config_pex_io_dpd = false,
 	.ectl.enable = false,
 };
 
@@ -2570,6 +2610,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.program_deskew_time = true,
 	.raw_violation_fixup = false,
 	.update_fc_threshold = true,
+	.config_pex_io_dpd = true,
 	.ectl.regs.rp_ectl_2_r1 = 0x0000000f,
 	.ectl.regs.rp_ectl_4_r1 = 0x00000067,
 	.ectl.regs.rp_ectl_5_r1 = 0x55010000,
@@ -2607,6 +2648,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.program_deskew_time = false,
 	.raw_violation_fixup = false,
 	.update_fc_threshold = false,
+	.config_pex_io_dpd = false,
 	.ectl.enable = false,
 };
 
@@ -2753,6 +2795,12 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&pcie->ports);
 	pcie->dev = dev;
 
+	if (pcie->soc->config_pex_io_dpd) {
+		err = tegra_pcie_parse_pinctrl(pcie);
+		if (err < 0)
+			return err;
+	}
+
 	err = tegra_pcie_parse_dt(pcie);
 	if (err < 0)
 		return err;
@@ -2866,6 +2914,8 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 		tegra_pcie_disable_msi(pcie);
 
 	tegra_pcie_disable_controller(pcie);
+	if (pcie->soc->config_pex_io_dpd)
+		pinctrl_select_state(pcie->pex_pinctrl, pcie->pex_dpd_enable);
 	tegra_pcie_power_off(pcie);
 
 	return 0;
@@ -2881,10 +2931,20 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 		dev_err(dev, "tegra pcie power on fail: %d\n", err);
 		return err;
 	}
+
+	if (pcie->soc->config_pex_io_dpd) {
+		err = pinctrl_select_state(pcie->pex_pinctrl,
+					   pcie->pex_dpd_disable);
+		if (err < 0) {
+			dev_err(dev, "disabling PCIe IO DPD failed: %d\n", err);
+			goto poweroff;
+		}
+	}
+
 	err = tegra_pcie_enable_controller(pcie);
 	if (err) {
 		dev_err(dev, "tegra pcie controller enable fail: %d\n", err);
-		goto poweroff;
+		goto pex_dpd_enable;
 	}
 	tegra_pcie_setup_translations(pcie);
 
@@ -2904,6 +2964,9 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 
 disable_controller:
 	tegra_pcie_disable_controller(pcie);
+pex_dpd_enable:
+	if (pcie->soc->config_pex_io_dpd)
+		pinctrl_select_state(pcie->pex_pinctrl, pcie->pex_dpd_enable);
 poweroff:
 	tegra_pcie_power_off(pcie);
 
-- 
2.17.1

