Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0AEC282DD
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4897C214AE
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OLBKas4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfDWJ2p (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:28:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11396 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfDWJ2p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:28:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedab40000>; Tue, 23 Apr 2019 02:28:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:28:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:28:44 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:28:44 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:28:41 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 02/28] PCI: tegra: Handle failure cases in tegra_pcie_power_on()
Date:   Tue, 23 Apr 2019 14:57:59 +0530
Message-ID: <20190423092825.759-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011700; bh=nKU+fGz95nn6VNfBblomlVYF8K/v/VGUe50hA3PMsdw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OLBKas4aGFSiOAcDncYezPcTsqf1WE/MWZsqh6HPfnX/uTQ9vy22VGkbnsfAfWJkD
         3+EAmn82GaniWW8GZqOMOWsYMmo/9YnqWIMw4e1ahi2doJsf43d7qG2uKbs1k2O2Qa
         05CVj5bcKltFx/udicfZo2Uxy0alSUPJW99iD6oLOGWh1cmgcsrmu7rbfPNrMrbI6r
         aSE08wmocSK8oV8wmGn049H5fzGiqcux8tYzWgQf318JGkzdWOENIRfb017iURaco3
         oygVLe7RKvB4YehOBlQWAotvhfd8BnZbaNzbJ6hEI8ZddPxUfzCaDfvjl/dGKWgQLf
         iRQD3+9bnkBRA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unroll the PCIe power on sequence if any one of the steps fail in
tegra_pcie_power_on().

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: New patch to handle error cleanup in tegra_pcie_power_on().

 drivers/pci/controller/pci-tegra.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index f4f53d092e00..8235d937951b 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1052,7 +1052,7 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 		err = clk_prepare_enable(pcie->pex_clk);
 		if (err) {
 			dev_err(dev, "failed to enable PEX clock: %d\n", err);
-			return err;
+			goto regulator_disable;
 		}
 		reset_control_deassert(pcie->pex_rst);
 	} else {
@@ -1061,7 +1061,7 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 							pcie->pex_rst);
 		if (err) {
 			dev_err(dev, "powerup sequence failed: %d\n", err);
-			return err;
+			goto regulator_disable;
 		}
 	}
 
@@ -1070,24 +1070,40 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
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
+			goto disable_afi_clk;
 		}
 	}
 
 	err = clk_prepare_enable(pcie->pll_e);
 	if (err < 0) {
 		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
-		return err;
+		goto disable_cml_clk;
 	}
 
 	return 0;
+
+disable_cml_clk:
+	if (soc->has_cml_clk)
+		clk_disable_unprepare(pcie->cml_clk);
+disable_afi_clk:
+	clk_disable_unprepare(pcie->afi_clk);
+powergate:
+	reset_control_assert(pcie->afi_rst);
+	reset_control_assert(pcie->pex_rst);
+	clk_disable_unprepare(pcie->pex_clk);
+	if (!dev->pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
+regulator_disable:
+	regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
+
+	return err;
 }
 
 static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
-- 
2.17.1

