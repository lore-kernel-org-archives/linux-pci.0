Return-Path: <SRS0=Hio3=OO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C42FC04EB9
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 10:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AAB21527
	for <linux-pci@archiver.kernel.org>; Wed,  5 Dec 2018 10:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cuptd3Jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AAB21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeLEJib (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeLEJia (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:30 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF07820879;
        Wed,  5 Dec 2018 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002709;
        bh=hYdXHR/b2MIZbDZpwGAtpofplpyVnAHSmuDaVyFvj+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cuptd3JmTGg+er46K8KZirIpj2fO+TLUigfLVYv/UsWfXx8iwhN+fn1lLG7htDCPR
         BuG7l7oYmmHQyxbzeQaXO4r89NF82uRhtY0VEWA3CDRaxAJAw5K1JZW42vT3J5beU6
         Y32+7omnuVcI7+qY6umqmg+DkD104qG6KXnc3+Hg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Trent Piepho <tpiepho@impinj.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 045/123] PCI: imx6: Fix link training status detection in link up check
Date:   Wed,  5 Dec 2018 04:34:37 -0500
Message-Id: <20181205093555.5386-45-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Trent Piepho <tpiepho@impinj.com>

[ Upstream commit 68bc10bf992180f269816ff3d22eb30383138577 ]

This bug was introduced in the interaction for two commits on either
branch of the merge commit 562df5c8521e ("Merge branch
'pci/host-designware' into next").

Commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
imx6_pcie_wait_for_link()"), changed imx6_pcie_wait_for_link() to poll
the link status register directly, checking for link up and not
training, and made imx6_pcie_link_up() only check the link up bit (once,
not a polling loop).

While commit 886bc5ceb5cc ("PCI: designware: Add generic
dw_pcie_wait_for_link()"), replaced the loop in
imx6_pcie_wait_for_link() with a call to a new dwc core function, which
polled imx6_pcie_link_up(), which still checked both link up and not
training in a loop.

When these two commits were merged, the version of
imx6_pcie_wait_for_link() from 886bc5ceb5cc was kept, which eliminated
the link training check placed there by 4d107d3b5a68. However, the
version of imx6_pcie_link_up() from 4d107d3b5a68 was kept, which
eliminated the link training check that had been there and was moved to
imx6_pcie_wait_for_link().

The result was the link training check got lost for the imx6 driver.

Eliminate imx6_pcie_link_up() so that the default handler,
dw_pcie_link_up(), is used instead. The default handler has the correct
code, which checks for link up and also that it still is not training,
fixing the regression.

Fixes: 562df5c8521e ("Merge branch 'pci/host-designware' into next")
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
[lorenzo.pieralisi@arm.com: rewrote the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4a9a673b4777..975050a69494 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -80,8 +80,6 @@ struct imx6_pcie {
 #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -641,12 +639,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int imx6_pcie_link_up(struct dw_pcie *pci)
-{
-	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
-			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
-}
-
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
@@ -679,7 +671,7 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.link_up = imx6_pcie_link_up,
+	/* No special ops needed, but pcie-designware still expects this struct */
 };
 
 static int imx6_pcie_probe(struct platform_device *pdev)
-- 
2.17.1

