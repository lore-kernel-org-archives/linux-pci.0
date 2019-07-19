Return-Path: <SRS0=+Ydv=VQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9517C76188
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788782082E
	for <linux-pci@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510975;
	bh=8Qkmo7ezGTUAxtzDgCwqLOTlTxCum23/8/8T9fga8WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLLJDs2QoZvYs5NhiAtsxDfCurBA2XIKWsqrX40GzGhYxfQQQJNDdeg1RQL1x2McB
	 C09ZhMTUOzIETKMENhhVglfSYH2f3vVakMsY3BEj8iiXrwFnpBw/dGk7XU6w8yw7fo
	 K2atVsuAJl9bx4lJcFFPJUu7oHWQ53HieP8N2Pac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfGSEAj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfGSEAj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jul 2019 00:00:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69BD021873;
        Fri, 19 Jul 2019 04:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508838;
        bh=8Qkmo7ezGTUAxtzDgCwqLOTlTxCum23/8/8T9fga8WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSmLBn5wDpBKAOwZDVYsEIp3i7inlwi4eLyk8NpoTp2DNSLnvhOSamzKgJD9oCNOB
         sHSp3cQArnqGt1+PPBxsYoQLp7f65J9/c8dIcjEeMO/tPdn5Ris3g+WrwnujcVVf6T
         aCA8KF3n9YZT2P+NS8PBnu2J+HK+R3oCdvehXNmo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 118/171] PCI: mobiveil: Fix the Class Code field
Date:   Thu, 18 Jul 2019 23:55:49 -0400
Message-Id: <20190719035643.14300-118-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

[ Upstream commit 0122af0a08243f344a438f924e5c2486486555b3 ]

Fix up the Class Code field in PCI configuration space and set it to
PCI_CLASS_BRIDGE_PCI.

Move the Class Code fixup to function mobiveil_host_init() where
it belongs.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 03d697b63e2a..88e9b70081fc 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -558,6 +558,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 		}
 	}
 
+	/* fixup for PCIe class register */
+	value = csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
+	value &= 0xff;
+	value |= (PCI_CLASS_BRIDGE_PCI << 16);
+	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
+
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
 
@@ -798,9 +804,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	/* fixup for PCIe class register */
-	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
-
 	/* initialize the IRQ domains */
 	ret = mobiveil_pcie_init_irq_domain(pcie);
 	if (ret) {
-- 
2.20.1

