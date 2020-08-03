Return-Path: <SRS0=9hNM=BN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0168AC433E1
	for <linux-pci@archiver.kernel.org>; Mon,  3 Aug 2020 12:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0955206D7
	for <linux-pci@archiver.kernel.org>; Mon,  3 Aug 2020 12:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgHCMV5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:21:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbgHCMV4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Aug 2020 08:21:56 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 38172B92AFF40E07CB31;
        Mon,  3 Aug 2020 20:21:50 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 3 Aug 2020
 20:21:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tjoseph@cadence.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] PCI: cadence: Make cdns_pci_map_bus stub helper inline
Date:   Mon, 3 Aug 2020 20:21:04 +0800
Message-ID: <20200803122104.44852-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If CONFIG_PCIE_CADENCE_HOST is n, gcc warns:

drivers/pci/controller/cadence/pcie-cadence.h:486:22:
 warning: 'cdns_pci_map_bus' defined but not used [-Wunused-function]

Make stub helper inline to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 655a6b4d4964..00e44256c3e8 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -483,8 +483,8 @@ static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	return 0;
 }
 
-static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
-				      int where)
+static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
+					     int where)
 {
 	return NULL;
 }
-- 
2.17.1


