Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E0EC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EAF2146F
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 17:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="c0MKbT3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDKRF4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:05:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7207 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKRFz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 13:05:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf73f00000>; Thu, 11 Apr 2019 10:05:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 10:05:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 10:05:55 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:51 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 17:05:51 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 17:05:48 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 21/30] PCI: tegra: Add "pci" type check before parsing child device tree node
Date:   Thu, 11 Apr 2019 22:33:46 +0530
Message-ID: <20190411170355.6882-22-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411170355.6882-1-mmaddireddy@nvidia.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555002352; bh=OsVLg+L6QvHByP/Bu8nnT003id+Pm2cQ7hXdV6MtcD8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=c0MKbT3VrlG6AgWbgPcp+DvV2zsTR2gxwdGhvEzWesVboq9b9DFxw+yEz1VtPlZV7
         qeWQWVd6+2olISAGIDlbRNzETyrNOIekyrmq24WK+hgOUFUgiohXkgOVroCjTRjXU6
         xWMXl+Gc3yhvOc4r45USkSekJ4wKcsgNQcK2wsC89b6FqO6ZzoxF1PjhT81LVHVEmb
         RgZ186fsKO80LFMS6+EcYOUc18r38n6gaTsGbvQmRDhXw7zJLSKS9gzA9XoqgDbY5s
         R+vBBQbI0NaTNGUgYjsAyUgY53P2/juEDXJC+4ksXFF3T0koCWnAzHwfN9TrP4luq3
         sGLEC9voaw2+g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Each root port is added as a child device tree node of PCIe controller
node. These child nodes are parsed using open firmware PCI bus accessor
functions. If the child node is not of "pci" type then device tree
parsing fails. Add "pci" type check before parsing child device tree node.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8fdc7934d4c9..d08a63132c77 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2197,6 +2197,9 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		unsigned int index;
 		u32 value;
 
+		if (!of_node_is_type(port, "pci"))
+			continue;
+
 		err = of_pci_get_devfn(port);
 		if (err < 0) {
 			dev_err(dev, "failed to parse address: %d\n", err);
-- 
2.17.1

