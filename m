Return-Path: <SRS0=9+zz=3K=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A501C2D0CE
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jan 2020 11:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531E824125
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jan 2020 11:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PTeLFwRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAULym (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:54:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55824 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAULym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jan 2020 06:54:42 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00LBsZcK101580;
        Tue, 21 Jan 2020 05:54:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579607675;
        bh=q6qzQlnnVh5caH1AoPNGy1ZkNwMbUHyLv2CbY74wVyU=;
        h=From:To:CC:Subject:Date;
        b=PTeLFwROW/AQAmsDeW6MDlhlE4fmBO0h5zIzlQ5tm7xi2QRVeLojMT4Cl/LGTafCy
         kThp3VOftfy74XOcQZ3MZDkpUoP8Vh3dAch2ezlku68RzkubqNDyDtJhELWMrJu8E+
         BVnkfjOCB2N41WJIJfOayMkiHGoHh0/YY8RBS+Ec=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00LBsZss043131
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jan 2020 05:54:35 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 21
 Jan 2020 05:54:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 21 Jan 2020 05:54:34 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00LBsVTu001187;
        Tue, 21 Jan 2020 05:54:32 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] PCI: keystone: Fix error handling when "num-viewport" DT property is not populated
Date:   Tue, 21 Jan 2020 17:27:34 +0530
Message-ID: <20200121115734.7047-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix error handling when "num-viewport" DT property is not populated.

Fixes: 23284ad677a94 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index dbe31589eb61..2c127c321080 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1357,7 +1357,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(np, "num-viewport", &num_viewport);
 		if (ret < 0) {
 			dev_err(dev, "unable to read *num-viewport* property\n");
-			return ret;
+			goto err_get_sync;
 		}
 
 		/*
-- 
2.17.1

