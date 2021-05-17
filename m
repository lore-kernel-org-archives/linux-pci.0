Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE90BC433B4
	for <linux-pci@archiver.kernel.org>; Mon, 17 May 2021 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A412D611CA
	for <linux-pci@archiver.kernel.org>; Mon, 17 May 2021 15:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244586AbhEQPrP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 May 2021 11:47:15 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:57525 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344186AbhEQPmz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 11:42:55 -0400
Received: from [77.244.183.192] (port=64722 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lifNB-000Exi-8s; Mon, 17 May 2021 17:41:37 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pci@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 2/5] PCI: dwc: pci-dra7xx: make it a kernel module
Date:   Mon, 17 May 2021 17:41:19 +0200
Message-Id: <20210517154122.430544-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517154122.430544-1-luca@lucaceresoli.net>
References: <20210517154122.430544-1-luca@lucaceresoli.net>
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

This allows to build the driver as a loadable kernel module.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 6457695df00c..fe11b96fe9a5 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
@@ -949,4 +950,8 @@ static struct platform_driver dra7xx_pcie_driver = {
 	},
 	.shutdown = dra7xx_pcie_shutdown,
 };
-builtin_platform_driver(dra7xx_pcie_driver);
+module_platform_driver(dra7xx_pcie_driver);
+
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_DESCRIPTION("PCIe controller driver for TI DRA7xx SoCs");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

