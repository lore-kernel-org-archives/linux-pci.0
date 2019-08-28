Return-Path: <SRS0=6piv=WY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47419C3A5A1
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 13:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC432070B
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 13:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VLHvjUhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfH1NPl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:15:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2023 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1NPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 09:15:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d667e7c0001>; Wed, 28 Aug 2019 06:15:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 06:15:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 28 Aug 2019 06:15:40 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 13:15:39 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 28 Aug 2019 13:15:39 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d667e770002>; Wed, 28 Aug 2019 06:15:39 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 3/6] PCI: tegra: Add support to configure sideband pins
Date:   Wed, 28 Aug 2019 18:45:02 +0530
Message-ID: <20190828131505.28475-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828131505.28475-1-vidyas@nvidia.com>
References: <20190828131505.28475-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566998140; bh=sqZxuTo6wQZPVbRv2gWjrrG8x7BYtnQNodewva3kbkY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=VLHvjUhveJbMuCjKHCJDaDQ3Bl8kw8UPLtF9Ft4p1+aDuiXiaNu60di5FoCLlT24z
         UVmdWsYCd0bHMFKrrh5lhHK2FgXELzuSHGishbHqIE/SFZIPuNm120+fZQKCnQmfwC
         DSd3ZqkFF+4g1MAHGxktkKT/ogPp3UHxc6wCEgMNvjoxyKxlpgaECLLD9elPKwNMZo
         NtTLeBZo76gIv2016rk1z9Avf10j0O+L8Q4GLmJhIUAnqb4IX560kPvSmAaTOVuewT
         rwnRFKe0n1AtSDlRTNN8vhr/ee/BZxwWRqHSU/yMVmokESMcnJeuzxvFiOWAB6MUGD
         7zupSklbWdCng==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to configure sideband signal pins when information is present
in respective controller's device-tree node.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed review comment from Andrew Murray
* Handled failure case of pinctrl_pm_select_default_state() cleanly

 drivers/pci/controller/dwc/pcie-tegra194.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fc0dbeb31d78..057ba4f9fbcd 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1304,8 +1304,13 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 	if (ret < 0) {
 		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
 			ret);
-		pm_runtime_disable(dev);
-		return ret;
+		goto fail_pm_get_sync;
+	}
+
+	ret = pinctrl_pm_select_default_state(pcie->dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
+		goto fail_pinctrl;
 	}
 
 	tegra_pcie_init_controller(pcie);
@@ -1332,7 +1337,9 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 
 fail_host_init:
 	tegra_pcie_deinit_controller(pcie);
+fail_pinctrl:
 	pm_runtime_put_sync(dev);
+fail_pm_get_sync:
 	pm_runtime_disable(dev);
 	return ret;
 }
-- 
2.17.1

