Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7EEC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0EA20843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="P/JJd8xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfDWJbC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:31:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8028 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfDWJbC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:31:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedb5b0001>; Tue, 23 Apr 2019 02:31:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:31:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:31:01 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:30:58 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:30:55 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 25/28] PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
Date:   Tue, 23 Apr 2019 14:58:22 +0530
Message-ID: <20190423092825.759-26-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011867; bh=Te1lfGNMFgNASafnpI0DwE4BPnWTpDFGbY245Xay0Bg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=P/JJd8xlBG09/EPsp94neFIutjPiauwxjL57XYUYPD8WuD5hS2VcinfsMXoLmJoKI
         nrxaIbbU1qXQO+isoENKmpySkze0fsozNi+G5Sq5+cOdCtweh4bR0zbVywWMkxdJ71
         CttMsNJdHHbPlFCHKK9HBTYq/os/sd9khL8QXvWnbW8b354CLrZS/KpsUN49ldySiZ
         0VvVS4L1ehDqQhkTWREJrGcf8HZbQKS021QFE728WJW7bryXNC9YJAjxXfVEgikgqs
         mHN3p9lp1s53WmmrWNIpofKkUAeX+K0nDu4L1lmcKIhPFHpfPASrZ9dL6eAOfBmfq7
         MVirKIOr8wz/Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In Tegra210 AFI design has clamp value for the BIAS pad as 0, which keeps
the bias pad in non power down mode. This is leading to power consumption
of 2 mW in BIAS pad, even if the PCIe partition is powergated. To avoid
unnecessary power consumption, put PEX CLK & BIAS pads in deep power down
mode when PCIe partition is power gated.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: Using standard pinctrl functions to apply default and idle states

 drivers/pci/controller/pci-tegra.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 05586672a221..72d344858e25 100644
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
@@ -2871,6 +2872,7 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
 
+	pinctrl_pm_select_idle_state(dev);
 	tegra_pcie_power_off(pcie);
 
 	return 0;
@@ -2886,6 +2888,13 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 		dev_err(dev, "tegra pcie power on fail: %d\n", err);
 		return err;
 	}
+
+	err = pinctrl_pm_select_default_state(dev);
+	if (err < 0) {
+		dev_err(dev, "failed to disable PCIe IO DPD: %d\n", err);
+		goto poweroff;
+	}
+
 	tegra_pcie_enable_controller(pcie);
 	tegra_pcie_setup_translations(pcie);
 
@@ -2895,7 +2904,7 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 	err = clk_prepare_enable(pcie->pex_clk);
 	if (err) {
 		dev_err(dev, "failed to enable PEX clock: %d\n", err);
-		goto poweroff;
+		goto pex_dpd_enable;
 	}
 	reset_control_deassert(pcie->pex_rst);
 
@@ -2915,6 +2924,8 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 disable_pex_clk:
 	reset_control_assert(pcie->pex_rst);
 	clk_disable_unprepare(pcie->pex_clk);
+pex_dpd_enable:
+	pinctrl_pm_select_idle_state(dev);
 poweroff:
 	tegra_pcie_power_off(pcie);
 
-- 
2.17.1

