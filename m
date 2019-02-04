Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B144C282CC
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB5D217FA
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="PCKufqSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbfBDPgZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:25 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:49298 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731323AbfBDPgY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:24 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id EF92F4196C;
        Mon,  4 Feb 2019 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1549294576; x=1551108977; bh=Y7bqz4DPDetczRyG4vWuemSZRvQz7iYuxkl
        Dbk+E/kM=; b=PCKufqSgo50tvCbks3cUJZosbl8zGShYkqUfV8zA2OExgV+8Mjg
        t5jQg1zUvqcZcWd/OpHS3niDZc7WN8PgMSMLGaOaumh7Il44Qxfji22fI+1hLYAY
        gZBSrME1hfJk3iXTnSVd4ZG9zg8wuUJ508+SDzgqXEV5Im83YWuakcLQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GWVQY8ui9u28; Mon,  4 Feb 2019 18:36:16 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 2342641931;
        Mon,  4 Feb 2019 18:36:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 4 Feb
 2019 18:36:10 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Oliver <oohall@gmail.com>, Sam Bobroff <sbobroff@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH RFC v3 06/21] PCI: Pause the devices with movable BARs during rescan
Date:   Mon, 4 Feb 2019 18:35:46 +0300
Message-ID: <20190204153601.7576-7-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204153601.7576-1-s.miroshnichenko@yadro.com>
References: <20190204153601.7576-1-s.miroshnichenko@yadro.com>
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

Drivers indicate their support of movable BARs by implementing the
new rescan_prepare() and rescan_done() hooks in the struct pci_driver.

All device's activity must be stopped during a rescan, and iounmap()
+ioremap() must be applied to every used BAR.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 51 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pci.h |  2 ++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bbc12934f041..e18d07996cf3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3172,6 +3172,38 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	return max;
 }
 
+static void pci_bus_rescan_prepare(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (child) {
+			pci_bus_rescan_prepare(child);
+		} else if (dev->driver &&
+			   dev->driver->rescan_prepare) {
+			dev->driver->rescan_prepare(dev);
+		}
+	}
+}
+
+static void pci_bus_rescan_done(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+
+		if (child) {
+			pci_bus_rescan_done(child);
+		} else if (dev->driver &&
+			   dev->driver->rescan_done) {
+			dev->driver->rescan_done(dev);
+		}
+	}
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3185,8 +3217,23 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 {
 	unsigned int max;
 
-	max = pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
+	if (pci_movable_bars_enabled()) {
+		struct pci_bus *root = bus;
+
+		while (!pci_is_root_bus(root))
+			root = root->parent;
+
+		pci_bus_rescan_prepare(root);
+
+		max = pci_scan_child_bus(root);
+		pci_assign_unassigned_root_bus_resources(root);
+
+		pci_bus_rescan_done(root);
+	} else {
+		max = pci_scan_child_bus(bus);
+		pci_assign_unassigned_bus_resources(bus);
+	}
+
 	pci_bus_add_devices(bus);
 
 	return max;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ba0b1d0ea2d2..5cd534b6631b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -777,6 +777,8 @@ struct pci_driver {
 	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
 	void (*shutdown)(struct pci_dev *dev);
 	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
+	void (*rescan_prepare)(struct pci_dev *dev);
+	void (*rescan_done)(struct pci_dev *dev);
 	const struct pci_error_handlers *err_handler;
 	const struct attribute_group **groups;
 	struct device_driver	driver;
-- 
2.20.1

