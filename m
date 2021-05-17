Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B1FC433ED
	for <linux-pci@archiver.kernel.org>; Mon, 17 May 2021 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BF76124C
	for <linux-pci@archiver.kernel.org>; Mon, 17 May 2021 15:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243503AbhEQPkt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 May 2021 11:40:49 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:60079 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245089AbhEQPh1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 11:37:27 -0400
Received: from [77.244.183.192] (port=64716 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lifHt-000CDv-67; Mon, 17 May 2021 17:36:09 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pci@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: dwc: pci-dra7xx: fix reset behaviour
Date:   Mon, 17 May 2021 17:35:57 +0200
Message-Id: <20210517153557.429623-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe PERSTn reset pin is active low and should be asserted, then
deasserted.

The current implementation only drives the pin once in "HIGH" position,
thus presumably it was intended to deassert the pin. This has two problems:

  1) it assumes the pin was asserted by other means before loading the
     driver
  2) it has the wrong polarity, since "HIGH" means "active", and the pin is
     presumably configured as active low coherently with the PCIe
     convention, thus it is driven physically to 0, keeping the device
     under reset unless the pin is configured as active high.

Fix both problems by:

  1) keeping devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH) as is, but
     assuming the pin is correctly configured as "active low" this now
     becomes a reset assertion
  2) adding gpiod_set_value(reset, 0) after a delay to deassert reset

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index dacd6da70c35..8dd20b394d0c 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -800,6 +800,8 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
 		goto err_gpio;
 	}
+	usleep_range(1000, 2000);
+	gpiod_set_value(reset, 0);
 
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
 	reg &= ~LTSSM_EN;
-- 
2.25.1

