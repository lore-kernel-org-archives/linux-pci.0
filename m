Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A7C433B4
	for <linux-pci@archiver.kernel.org>; Mon, 10 May 2021 14:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFE161421
	for <linux-pci@archiver.kernel.org>; Mon, 10 May 2021 14:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhEJO4F (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 May 2021 10:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbhEJOzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 10:55:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D262C04684F
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 07:15:15 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lg6gg-0000Fk-L1; Mon, 10 May 2021 16:15:10 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH 2/7] PCI: imx6: Initialize ATU unroll offset
Date:   Mon, 10 May 2021 16:15:04 +0200
Message-Id: <20210510141509.929120-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510141509.929120-1-l.stach@pengutronix.de>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This gets rid of a warning printed when the common code tries to get
this address via non-existent DT reg region, before falling back to
the default offset.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 46b5f070939e..922c14361cd3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1063,6 +1063,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
 
+		pci->atu_base =  pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
+
 		fallthrough;
 	case IMX7D:
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
-- 
2.29.2

