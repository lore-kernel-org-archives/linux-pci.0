Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F52C25B08
	for <linux-pci@archiver.kernel.org>; Wed, 17 Aug 2022 08:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiHQIgk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Aug 2022 04:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHQIgj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 04:36:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157FA7AC0D;
        Wed, 17 Aug 2022 01:36:38 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M71Y36NvvzGpX6;
        Wed, 17 Aug 2022 16:35:03 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:36:36 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 16:36:35 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>
Subject: [PATCH -next 2/2] PCI: switch to use dev_err_probe()
Date:   Wed, 17 Aug 2022 16:44:44 +0800
Message-ID: <20220817084444.2876059-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817084444.2876059-1-yangyingliang@huawei.com>
References: <20220817084444.2876059-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use dev_err_probe() to simplify code and print error code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/probe.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0e947f24153e..f2430da8a30b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3054,10 +3054,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	int ret;
 
 	ret = pci_scan_root_bus_bridge(bridge);
-	if (ret < 0) {
-		dev_err(bridge->dev.parent, "Scanning root bridge failed");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(bridge->dev.parent, ret,
+				     "Scanning root bridge failed");
 
 	bus = bridge->bus;
 
-- 
2.25.1

