Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A632C56201
	for <linux-pci@archiver.kernel.org>; Wed, 25 Nov 2020 19:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECA12075A
	for <linux-pci@archiver.kernel.org>; Wed, 25 Nov 2020 19:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BiPFh2BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgKYTWr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 25 Nov 2020 14:22:47 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4121 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgKYTWr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 14:22:47 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbeaf060000>; Wed, 25 Nov 2020 11:22:46 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Nov
 2020 19:22:45 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 25 Nov 2020 19:22:41 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <jingoohan1@gmail.com>, <kw@linux.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH] PCI: tegra: Move "dbi" accesses to post common DWC initialization
Date:   Thu, 26 Nov 2020 00:52:34 +0530
Message-ID: <20201125192234.2270-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606332166; bh=qhn+7M1gOz4JIgwvQxocnYwYlqiPE1tJKqV+lUO0Fdo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=BiPFh2BUh4Hm2eGT6PQ60R3brNRko5HBVgeQDVx/BTXNCgjHlyEXdIGBCkE9hLO0z
         Hm8sZLxYzyVEv8UV3yhOHrLVewkjBSL6EL7kOEkEO2jEaB6Vsv2l6x1ZjSG/ZKpkwE
         wX7jIeWj8lk7+G7t0QCO73QzJex9Aq/gVNBg9DVYTz6bxX2TnhPv0qWj+efbriTXl+
         U+XnC6JIdyYNMwTAzYyNbczHoTYP/bTwh1MSVwzigz5q/292KrQA8N5m1yfSqAwvbF
         6vfSwCmxqftGjp75Uk53Sw3dqsM48HxnFwR5yJHz/4jkAOjCUydp997TLF7tiSclUs
         Q2UqaNXKPlK/Q==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space"
resource setup into common code") moved the code that sets up dbi_base
to DWC common code thereby creating a requirement to not access the "dbi"
region before calling common DWC initialization code. But, Tegra194
already had some code that programs some of the "dbi" registers resulting
in system crash. This patch addresses that issue by refactoring the code
to have accesses to the "dbi" region only after common DWC initialization.

Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ac2225175087..648e731bccfa 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -859,6 +859,16 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
 
+	if (!pcie->pcie_cap_base)
+		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
+							      PCI_CAP_ID_EXP);
+
+	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
+	if (!pcie->supports_clkreq) {
+		disable_aspm_l11(pcie);
+		disable_aspm_l12(pcie);
+	}
+
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
 	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
@@ -1389,15 +1399,6 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 
 	reset_control_deassert(pcie->core_rst);
 
-	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
-						      PCI_CAP_ID_EXP);
-
-	/* Disable ASPM-L1SS advertisement as there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	return ret;
 
 fail_phy:
-- 
2.17.1

