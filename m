Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9A0C6786C
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7D420672
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 13:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7D420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbeLNNLf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:11:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52409 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729792AbeLNNLf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 08:11:35 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 609CF8DC1C50C;
        Fri, 14 Dec 2018 21:11:32 +0800 (CST)
Received: from FRA1000014316.huawei.com (100.126.230.97) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 21:11:24 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Zhou Wang" <wangzhou1@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 1/2] pci/portdrv: Allow for vendor defined performance monitoring units.
Date:   Fri, 14 Dec 2018 21:10:54 +0800
Message-ID: <20181214131055.52253-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
References: <20181214131055.52253-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [100.126.230.97]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When originally introduced (and still in the docs) it was possible to have
drivers matched by HID, now it isn't so this is a bit ugly in that it will
call any registered PMU driver.

How would people prefer this was done?

* Drop the association with the port and handle as uncore.
  Whilst the driver that follows is not in config space, it is likely that
  future PMU units will use DVSEC (in PCI config space) and so this option
  won't really be available.

* Put a full subsystem style driver matching layer in here.
  Moderately simple to do do and well understood.

Right now this code is a hack to get the conversation going!

It would be nice if there was a standard PCIe PMU specification but whilst
there isn't, everyone will end up doing it differently...

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/portdrv.h      | 4 +++-
 drivers/pci/pcie/portdrv_core.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index e495f04394d0..64315713a93d 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -20,8 +20,10 @@
 #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
 #define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
+#define PCIE_PORT_SERVICE_PMU_SHIFT	4	/* Vendor defined Perf Units */
+#define PCIE_PORT_SERVICE_PMU		(1 << PCIE_PORT_SERVICE_PMU_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   4
+#define PCIE_PORT_DEVICE_MAXSERVICES   5
 
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index f458ac9cb70c..c032896a9ab1 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -250,6 +250,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
 		services |= PCIE_PORT_SERVICE_DPC;
 
+	services |= PCIE_PORT_SERVICE_PMU;
+
 	return services;
 }
 
-- 
2.19.1

