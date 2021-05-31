Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F28AC47095
	for <linux-pci@archiver.kernel.org>; Mon, 31 May 2021 09:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EEC460FDA
	for <linux-pci@archiver.kernel.org>; Mon, 31 May 2021 09:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhEaJBg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 May 2021 05:01:36 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:51904 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229768AbhEaJBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 05:01:32 -0400
Received: from [77.244.183.192] (port=63376 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lndm4-0005h2-9D; Mon, 31 May 2021 10:59:52 +0200
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
Subject: [PATCH v2 3/4] PCI: dra7xx: Remove unused include
Date:   Mon, 31 May 2021 10:59:33 +0200
Message-Id: <20210531085934.2662457-4-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531085934.2662457-1-luca@lucaceresoli.net>
References: <20210531085934.2662457-1-luca@lucaceresoli.net>
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

Unused since commit e259c2926c01 ("PCI: pci-dra7xx: Prepare for deferred
probe with module_platform_driver").

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes v1 -> v2:
 - Update commit subject as suggested by Bjorn
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 9fcadd7dd943..a8daa356f7e6 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -14,7 +14,6 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-- 
2.25.1

