Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB9BC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387C820870
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 09:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oFHlQN+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfCYJng (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:43:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45066 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfCYJnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 05:43:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P9hEch068172;
        Mon, 25 Mar 2019 04:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553506994;
        bh=dFVQ4pidiC5cYCJgE2pe5Ra71CSY84AMLd39Zm5xel0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oFHlQN+Zv+DIffg/ycZ53VEn1IUGxVmlUKoeiP8RnPqGdybNpVAGllBlBFJE9vh2Z
         s0nuMAs52kkB9fcgUF4M24KU3LAuBMhgayQZznmirlbGSwsCTX7YXayqWQ5x/2L+ma
         +Vd54kIfzbMRBn5JicZL6XdH2ntnKe5yyAB9MLJ4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P9hEjs015765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 04:43:14 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 04:43:13 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 04:43:13 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P9feaV028077;
        Mon, 25 Mar 2019 04:43:08 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 16/26] PCI: OF: Allow of_pci_get_max_link_speed() to be used by PCI Endpoint drivers
Date:   Mon, 25 Mar 2019 15:09:37 +0530
Message-ID: <20190325093947.32633-17-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_pci_get_max_link_speed() is built only if CONFIG_PCI is enabled.
Make of_pci_get_max_link_speed() to be also used by PCI Endpoint
controllers with just CONFIG_PCI_ENDPOINT enabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pci/Makefile |  2 +-
 drivers/pci/of.c     | 44 +++++++++++++++++++++++---------------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 657d642fcc67..28cdd8c0213a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -10,10 +10,10 @@ obj-$(CONFIG_PCI)		+= access.o bus.o probe.o host-bridge.o \
 ifdef CONFIG_PCI
 obj-$(CONFIG_PROC_FS)		+= proc.o
 obj-$(CONFIG_SYSFS)		+= slot.o
-obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
 endif
 
+obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
 obj-$(CONFIG_PCIEPORTBUS)	+= pcie/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3d32da15c215..8095933f8452 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -15,6 +15,7 @@
 #include <linux/of_pci.h>
 #include "pci.h"
 
+#ifdef CONFIG_PCI
 void pci_set_of_node(struct pci_dev *dev)
 {
 	if (!dev->bus->dev.of_node)
@@ -196,27 +197,6 @@ int of_get_pci_domain_nr(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
 
-/**
- * This function will try to find the limitation of link speed by finding
- * a property called "max-link-speed" of the given device node.
- *
- * @node: device tree node with the max link speed information
- *
- * Returns the associated max link speed from DT, or a negative value if the
- * required property is not found or is invalid.
- */
-int of_pci_get_max_link_speed(struct device_node *node)
-{
-	u32 max_link_speed;
-
-	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed > 4)
-		return -EINVAL;
-
-	return max_link_speed;
-}
-EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
-
 /**
  * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
  *                           is present and valid
@@ -537,3 +517,25 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 	return err;
 }
 
+#endif /* CONFIG_PCI */
+
+/**
+ * This function will try to find the limitation of link speed by finding
+ * a property called "max-link-speed" of the given device node.
+ *
+ * @node: device tree node with the max link speed information
+ *
+ * Returns the associated max link speed from DT, or a negative value if the
+ * required property is not found or is invalid.
+ */
+int of_pci_get_max_link_speed(struct device_node *node)
+{
+	u32 max_link_speed;
+
+	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
+	    max_link_speed > 4)
+		return -EINVAL;
+
+	return max_link_speed;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_max_link_speed);
-- 
2.17.1

