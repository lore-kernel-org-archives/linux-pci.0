Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAA0C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881FB21547
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 10:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gbvuMQDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881FB21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbeIUQMj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54608 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbeIUQMi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 12:12:38 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8LAO3qH032966;
        Fri, 21 Sep 2018 05:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537525443;
        bh=K31ChqNjRu5l1S0E4b+jKiReLdWou1lCpsnq9Pl7H2I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gbvuMQDfJGS9EWAjQQ6DD0kSzkHrnqRwOFC1htINNpsqtHl8RI3z5J6BfM1kTWCZS
         LcAZL8qVRWZSe7Gd3xBi+832cNYTTeEx6xfmD230tutvhSrJpcckCqpTwwe+bvQPFQ
         rfikHPGK8jbQzp7OtYcGpsYj0DfGW07rGlqIIpQA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAO2qP019252;
        Fri, 21 Sep 2018 05:24:02 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 21
 Sep 2018 05:24:02 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 21 Sep 2018 05:24:02 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8LAMEtQ032280;
        Fri, 21 Sep 2018 05:23:58 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <Gustavo.Pimentel@synopsys.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 22/40] PCI: keystone: Reorder header file in alphabetical order
Date:   Fri, 21 Sep 2018 15:51:37 +0530
Message-ID: <20180921102155.22839-23-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No functional change. Reorder header file in alphabetical order.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index a3dec74da70c..b1dfaea29530 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -9,19 +9,19 @@
  * Implementation based on pci-exynos.c and pcie-designware.c
  */
 
-#include <linux/irqchip/chained_irq.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/init.h>
 #include <linux/mfd/syscon.h>
 #include <linux/msi.h>
-#include <linux/of_irq.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_pci.h>
-#include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
-- 
2.17.1

