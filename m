Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF9AC282CE
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DF320818
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZqgQCe18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfDKRFr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:05:47 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15291 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKRFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:05:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73d80002>; Thu, 11 Apr 2019 10:05:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:05:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:05:45 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:40 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:05:37 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 19/30] PCI: tegra: Use legacy irq for port service drivers
Date:   Thu, 11 Apr 2019 22:33:44 +0530
Message-ID: <20190411170355.6882-20-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002329; bh=EcyU1AS7Mv15UFnNqbWUSrn45tq1w3Pmn/nTs6DeimE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZqgQCe18RoYIMPmuxAryD7v1GPjpmiDjzGeFMZ/Vz7akSvJZOKUfV6uOPXgWcVLuq
         xIeLxtpr0/3ZdFQ9wogj+IymFeEUEb+PidCTZ7U7gIW+vvSZ6/OmUkuctgMwbyazUD
         56BQ41MoDT3KkZlKaXQab6E+8sxPrrhP4/FvHt2CtlxroPK0mHV8fNL+UVYscK020b
         iS8O9lXAl15AT97igEHZhv5Dgk8FXhDf0gZsPKFliD6A8DfYIGevw6Gm0WypgdWkds
         MjajGGLDFCtrf+FCse9nOnHFV19cm9kcQUYOwwquDeEN7hn741VIE+SFrllEaQ7kfT
         xQF3/KL6qSNXQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra signals PCIe services like AER, PME, etc over legacy IRQ line.
By default service drivers register interrupt routine over MSI IRQ line,
use pcie_pme_disable_msi() function to disable MSI for service drivers.

PME and AER interrupts registered to MSI without this change
cat /proc/interrupts | grep -i pci
36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif

PME and AER interrupts registered to legacy IRQ with this change
cat /proc/interrupts | grep -i pci
36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW notif
37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index dcfe97711cb5..11be88a394e3 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -41,6 +41,7 @@
 #include <soc/tegra/pmc.h>
 
 #include "../pci.h"
+#include "../pcie/portdrv.h"
 
 #define INT_PCI_MSI_NR (8 * 32)
 
@@ -2724,6 +2725,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		goto put_resources;
 	}
 
+	/* PME events are received over legacy INTR, so disable MSI for PME */
+	pcie_pme_disable_msi();
+
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err) {
-- 
2.17.1

