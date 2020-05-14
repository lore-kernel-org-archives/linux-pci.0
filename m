Return-Path: <SRS0=uJIJ=64=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A25C433E0
	for <linux-pci@archiver.kernel.org>; Thu, 14 May 2020 15:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7725205CB
	for <linux-pci@archiver.kernel.org>; Thu, 14 May 2020 15:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yUS70p4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgENPAh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 May 2020 11:00:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42190 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgENPAf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 11:00:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04EF0BBj029167;
        Thu, 14 May 2020 10:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589468411;
        bh=hFv2iOUC9MFGbvA/KZkyn+UkE86d8RSkbhbbEwZ8rmI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yUS70p4Ved7qpx5ntRAwginbYDjg3v9OI1PXLTi1XyU7QMO9Zbhw9ODxHqmZh/P6w
         z2UCoz11W1QPSULfMZE7Xw3m0EQ/PaMQf7sbvjii0TAB4pwKOA0Om/J+Ucv2WGdaEI
         TiLv27mjLMfFK+zH50ozkj4b0GkqGMx2SrrTXmmE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04EF0BNg103053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 10:00:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 10:00:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 10:00:10 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EExgAn019279;
        Thu, 14 May 2020 10:00:06 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 05/19] PCI: endpoint: Add "pci-epf-bus" driver
Date:   Thu, 14 May 2020 20:29:13 +0530
Message-ID: <20200514145927.17555-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add "pci-epf-bus" driver that helps to create EPF device from
device tree. This is added in order to define an endpoint function
device completely from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/Makefile      |  3 +-
 drivers/pci/endpoint/pci-epf-bus.c | 54 ++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/endpoint/pci-epf-bus.c

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b0..36cf33cf975c 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-epf-bus.o \
+					   functions/
diff --git a/drivers/pci/endpoint/pci-epf-bus.c b/drivers/pci/endpoint/pci-epf-bus.c
new file mode 100644
index 000000000000..b6ab1479b79e
--- /dev/null
+++ b/drivers/pci/endpoint/pci-epf-bus.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * PCI Endpoint *Function* Bus Driver
+ *
+ * Copyright (C) 2020 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci-epf.h>
+#include <linux/platform_device.h>
+
+static int pci_epf_bus_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = of_node_get(dev->of_node);
+	struct device_node *child;
+	struct pci_epf *epf;
+
+	for_each_child_of_node(node, child) {
+		epf = devm_pci_epf_of_create(dev, child);
+		if (IS_ERR(epf)) {
+			dev_err(dev, "Failed to create PCI EPF device %s\n",
+				node->full_name);
+			of_node_put(child);
+			break;
+		}
+	}
+	of_node_put(node);
+
+	return 0;
+}
+
+static const struct of_device_id pci_epf_bus_id_table[] = {
+	{ .compatible = "pci-epf-bus" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pci_epf_bus_id_table);
+
+static struct platform_driver pci_epf_bus_driver = {
+	.probe		= pci_epf_bus_probe,
+	.driver		= {
+		.name	= "pci-epf-bus",
+		.of_match_table = of_match_ptr(pci_epf_bus_id_table),
+	},
+};
+
+module_platform_driver(pci_epf_bus_driver);
+
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_DESCRIPTION("PCI EPF Bus Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

