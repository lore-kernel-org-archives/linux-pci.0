Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DDEC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CFB21738
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 09:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nBCmYHdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDWJ3w (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:29:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11480 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDWJ3w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 05:29:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbedaf70001>; Tue, 23 Apr 2019 02:29:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 02:29:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 02:29:51 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Apr
 2019 09:29:51 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 23 Apr 2019 09:29:48 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V2 19/28] PCI: tegra: Change PRSNT_SENSE irq log to debug
Date:   Tue, 23 Apr 2019 14:58:16 +0530
Message-ID: <20190423092825.759-20-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423092825.759-1-mmaddireddy@nvidia.com>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556011767; bh=d2lveZat3yBVhqxgS4fFb89E4wpA2kc2pXBmlAAD7as=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=nBCmYHdyq71b3chRnrdkiZHQQShQTyOP7NxGxXuu75/gi+uDNsF0H67otetqDWBFd
         /qInjBWUiAl1B29XdtwHTZTJvur+nTW/5v92JwlnECK9dXG88cqD2KzSqpP0+Hp8+E
         8SF+yxLvqJ+u5YAGu+0fNUPUsWK/oot2RLUxJYtFeSCA2UmjBDmcXAWxtuwGt9vS53
         fjnuidkrsxYqpV3fqi4poOzUgC9WBluEpuJOWk+vaHwnjh+V31vurx17lTqhT/D1kN
         ZIlCoCCmZxp9fCrKkMYAPikLgwlfRxO4ff84sWRPPGuV5HSiNP7U8v+x9vyoYiP1+E
         EaKbAbMU7p5wQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PRSNT_MAP bit field is programmed to update the slot present status.
PRSNT_SENSE irq is triggered when this bit field is programmed, which is
not an error. Add a new if condition to trap RSNT_SENSE code and print it
with debug log level.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V2: If-else to switch-case conversion patch is dropped, this patch is
rebased to stay with if-else statements

 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9b841b0392ac..72634ce6d3da 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -864,7 +864,7 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 	 * do not pollute kernel log with master abort reports since they
 	 * happen a lot during enumeration
 	 */
-	if (code == AFI_INTR_MASTER_ABORT)
+	if (code == AFI_INTR_MASTER_ABORT || code == AFI_INTR_PE_PRSNT_SENSE)
 		dev_dbg(dev, "%s, signature: %08x\n", err_msg[code], signature);
 	else
 		dev_err(dev, "%s, signature: %08x\n", err_msg[code], signature);
-- 
2.17.1

