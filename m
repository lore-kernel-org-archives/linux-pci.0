Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAF5C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008B62086D
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gcveBGTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfANLR1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:17:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47014 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfANLR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:17:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBGfgq065583;
        Mon, 14 Jan 2019 05:16:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547464601;
        bh=4YRXaHedTxJwSOCNaAmkVolcFGYRNrTlux25tJuWNNM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gcveBGTey529UvNcaC9o3tW3u84kkBK4wU+/DXm2dF9gdk3xF06eCWxhlGKJ1FcEG
         dwFPRC2IO9lnYOIeXeEps8RFrbNKJJIFjgm0OXvcA0HalC2TgGyQmaklEj8VoX8JZT
         Q1iENKeugJ4Wz+NbfxFxV2B3JUen4U23hQP27fwM=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBGfiD068063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 05:16:41 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:16:41 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:16:40 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1h011560;
        Mon, 14 Jan 2019 05:16:37 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 15/15] PCI: endpoint: Remove features member in struct pci_epc
Date:   Mon, 14 Jan 2019 16:45:13 +0530
Message-ID: <20190114111513.21618-16-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since EPC features are now implemented using pci_epc_features and
all the EPC drivers are moved to using pci_epc_features, remove
features member in struct pci_epc and all the helper macros for
configuring the features.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/pci-epc.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 94e1ecff98ce..c3ffa3917f88 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -99,7 +99,6 @@ struct pci_epc {
 	struct config_group		*group;
 	/* spinlock to protect against concurrent access of EP controller */
 	spinlock_t			lock;
-	unsigned int			features;
 };
 
 /**
@@ -120,14 +119,6 @@ struct pci_epc_features {
 	u64	bar_fixed_size[BAR_5 + 1];
 };
 
-#define EPC_FEATURE_NO_LINKUP_NOTIFIER		BIT(0)
-#define EPC_FEATURE_BAR_MASK			(BIT(1) | BIT(2) | BIT(3))
-#define EPC_FEATURE_MSIX_AVAILABLE		BIT(4)
-#define EPC_FEATURE_SET_BAR(features, bar)	\
-		(features |= (EPC_FEATURE_BAR_MASK & (bar << 1)))
-#define EPC_FEATURE_GET_BAR(features)		\
-		((features & EPC_FEATURE_BAR_MASK) >> 1)
-
 #define to_pci_epc(device) container_of((device), struct pci_epc, dev)
 
 #define pci_epc_create(dev, ops)    \
-- 
2.17.1

