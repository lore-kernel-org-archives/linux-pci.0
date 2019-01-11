Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DDFC43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B9920874
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="A+PPu3+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfAKPn5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:43:57 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40066 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731972AbfAKPn4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:56 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D36B4419C1
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221050; x=1549035451; bh=OgLo7/CRt0OwDQd8jzrs/7oiC/sWradzhSM
        CAbKv7SA=; b=A+PPu3+cR6D60gXDjJTdo47XtAIOARxDcahqLPpT7mmfInfjOqD
        VfFq1XxYqx6zgu/3jw5lqdrIoE0WeFCBwvVnShOAu9xV1i29tW/R1IH0i/cxlp6m
        rDMnz4/BaGtBHUikYiBHYCgbTMKB2WDE9Fz4VBjdpkIl74qjLGlIFfSQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zpZnCjw0DX7F for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id EA232419C0
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:24 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:24 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 17/21] PCI: pciehp: Add support for the movable BARs feature
Date:   Fri, 11 Jan 2019 18:37:03 +0300
Message-ID: <20190111153707.10140-18-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
References: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With movable BARs, adding a hotplugged device may affect all the PCIe
domain starting from the root, so use a pci_rescan_bus() function which
handles the rearrangement of existing BARs and bridge windows.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/hotplug/pciehp_pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index b9c1396db6fe..7c0871db5bae 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -56,12 +56,16 @@ int pciehp_configure_device(struct controller *ctrl)
 		goto out;
 	}
 
-	for_each_pci_bridge(dev, parent)
-		pci_hp_add_bridge(dev);
+	if (pci_movable_bars_enabled()) {
+		pci_rescan_bus(parent);
+	} else {
+		for_each_pci_bridge(dev, parent)
+			pci_hp_add_bridge(dev);
 
-	pci_assign_unassigned_bridge_resources(bridge);
-	pcie_bus_configure_settings(parent);
-	pci_bus_add_devices(parent);
+		pci_assign_unassigned_bridge_resources(bridge);
+		pcie_bus_configure_settings(parent);
+		pci_bus_add_devices(parent);
+	}
 
  out:
 	pci_unlock_rescan_remove();
-- 
2.20.1

