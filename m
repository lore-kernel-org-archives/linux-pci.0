Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0249C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 18:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DC62083D
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 18:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSbcxYmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DC62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbeLGSVw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:21:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44282 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeLGSVw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 13:21:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so4628720otl.11;
        Fri, 07 Dec 2018 10:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Y2yo8OsiWnbY72nFqwYgUkTxSavntzX+ongNwc3v8A=;
        b=RSbcxYmFItEgVw388atFXxpObE5BfVcAHi2W655GIKuRaDAIhndbyirEjg5e0EeMYG
         gWD8i/CbkdOUcFNpDeu22RkqrbB8yQVJdih1pqVwIZlkwzRhKEOEx6V7pbGIzjvOG8/A
         rfsbvPbIUKi/gWGe5Q9cUvTsLs0EzG7hXQizD2QtmBWg21Qgq/16b+a72fxICkGxjgY0
         RD9inU1LyoivUNot86YCCSxR0M5dyos+3DyfRiVCaeS5V0v4bvz9yJztYlPbgPMTiIuR
         qxmIqQmBc6VTUxLxKemdVQnCGm9qOz4WK3lG5dTvZkBulRrsYE7Y1Cw8q7zqgAkWE6H8
         dfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Y2yo8OsiWnbY72nFqwYgUkTxSavntzX+ongNwc3v8A=;
        b=I1ewV/Zipc+YGgDcKrtSTcuEQxQyMgzKltTH7N4FoihBIGCXOaWHeLRaS36jGqnIb4
         iz2Nct6YRXmxCc/trB/VNRnSEcxzBdOKAKFsAl09FVz2PEK5oZQRgReT8TnfAB7QG0et
         hFIgOThS8XPSeFLNfnLIdR+XnEGN9tATu58um0e5FSHqWvagPB2UHUVRcxTp3gYbttvm
         LnF641nkpRyrsmOqUvnX6bDOpAvSVIGHmzKEVnb7ng/Izh+BElzq/cDwkTrjq0Rna+m1
         tL2LIaHtqnTgXkyxzuCZhKGdtQWchmuVbPhGWaasjRByPY7RzY3qmJ5wCL6uUK0+3ERT
         MjIA==
X-Gm-Message-State: AA+aEWafcW3CzliXDqZmKNbItzcZwioikoCNhfRpTX1DvftFm7AXsPAC
        8iT0YZnQZUD8DI4PyJAAKws=
X-Google-Smtp-Source: AFSGD/XrDvam8AiPx3M0rT6wq2oPa5vQoxjxDzsEakKG6nwrxiXpEn8H5W0AxMWptPHRB2zL/gMTmA==
X-Received: by 2002:a9d:628:: with SMTP id 37mr2233414otn.58.1544206911121;
        Fri, 07 Dec 2018 10:21:51 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id k207sm2348427oih.58.2018.12.07.10.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 10:21:50 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     helgaas@kernel.org
Cc:     alex_gagniuc@dellteam.com, Austin.Bolen@dell.com,
        Shyam.Iyer@dell.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: pciehp: Report degraded links via link bandwidth notification
Date:   Fri,  7 Dec 2018 12:20:00 -0600
Message-Id: <20181207182021.16344-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230454.GF178809@google.com>
References: <20181129230454.GF178809@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A warning is generated when a PCIe device is probed with a degraded
link, but there was no similar mechanism to warn when the link becomes
degraded after probing. The Link Bandwidth Notification provides this
mechanism.

Use the link bandwidth notification interrupt to detect bandwidth
changes, and rescan the bandwidth, looking for the weakest point. This
is the same logic used in probe().

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
Changes since v1:
 * Layer on top of the pcie port service drivers, instead of hotplug service.

This patch needs to be applied on top of:
	PCI: Add missing include to drivers/pci.h

Anticipated FAQ:

Q: Why is this unconditionally compiled in?
A: The symmetrical check in pci probe() is also always compiled in.

Q: Why call module_init() instead of adding a call in pcie_init_services() ?
A: A call in pcie_init_services() also requires a prototype in portdrv.h, a
non-static implementation in bw_notification.c. Using module_init() is
functionally equivalent, and takes less code.

Q: Why print only on degraded links and not when a link is back to full speed?
For symmetry with PCI probe(). Although I see a benefit in conveying that a
link is back to full speed, I expect this to be extremely rare. Secondary bus
reset is usually needed to retrain at full bandwidth.


 drivers/pci/pcie/Makefile          |   1 +
 drivers/pci/pcie/bw_notification.c | 107 +++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h         |   4 +-
 drivers/pci/pcie/portdrv_core.c    |  14 ++--
 4 files changed, 121 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pci/pcie/bw_notification.c

diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index ab514083d5d4..f1d7bc1e5efa 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -3,6 +3,7 @@
 # Makefile for PCI Express features and port driver
 
 pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
+pcieportdrv-y			+= bw_notification.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
 
diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
new file mode 100644
index 000000000000..64391ea9a172
--- /dev/null
+++ b/drivers/pci/pcie/bw_notification.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCI Express Bandwidth notification services driver
+ * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
+ *
+ * Copyright (C) 2018, Dell Inc
+ *
+ * The PCIe bandwidth notification provides a way to notify the operating system
+ * when the link width or data rate changes. This capability is required for all
+ * root ports and downstream ports supporting links wider than x1 and/or
+ * multiple link speeds.
+ *
+ * This service port driver hooks into the bandwidth notification interrupt and
+ * warns when links become degraded in operation.
+ */
+
+#include <linux/module.h>
+
+#include "../pci.h"
+#include "portdrv.h"
+
+static bool pcie_link_bandwidth_notification_supported(struct pci_dev *dev)
+{
+	int ret;
+	u32 lnk_cap;
+
+	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnk_cap);
+	return (ret == PCIBIOS_SUCCESSFUL) && (lnk_cap & PCI_EXP_LNKCAP_LBNC);
+}
+
+static void pcie_enable_link_bandwidth_notification(struct pci_dev *dev)
+{
+	u16 lnk_ctl;
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnk_ctl);
+	lnk_ctl |= PCI_EXP_LNKCTL_LBMIE;
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
+}
+
+static void pcie_disable_link_bandwidth_notification(struct pci_dev *dev)
+{
+	u16 lnk_ctl;
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnk_ctl);
+	lnk_ctl &= ~PCI_EXP_LNKCTL_LBMIE;
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
+}
+
+static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
+{
+	struct pcie_device *srv = context;
+	struct pci_dev *port = srv->port;
+	struct pci_dev *dev;
+	u16 link_status, events;
+	int ret;
+
+	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
+	events = link_status & PCI_EXP_LNKSTA_LBMS;
+
+	if (!events || ret != PCIBIOS_SUCCESSFUL)
+		return IRQ_NONE;
+
+	/* Print status from upstream link partner, not this downstream port. */
+	list_for_each_entry(dev, &port->subordinate->devices, bus_list)
+		__pcie_print_link_status(dev, false);
+
+	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
+	return IRQ_HANDLED;
+}
+
+static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
+{
+	int ret;
+
+	/* Single-width or single-speed ports do not have to support this. */
+	if (!pcie_link_bandwidth_notification_supported(srv->port))
+		return -ENODEV;
+
+	ret = devm_request_irq(&srv->device, srv->irq, pcie_bw_notification_irq,
+			       IRQF_SHARED, "PCIe BW notif", srv);
+	if (ret)
+		return ret;
+
+	pcie_enable_link_bandwidth_notification(srv->port);
+
+	return 0;
+}
+
+static void pcie_bandwidth_notification_remove(struct pcie_device *srv)
+{
+	pcie_disable_link_bandwidth_notification(srv->port);
+}
+
+static struct pcie_port_service_driver pcie_bandwidth_notification_driver = {
+	.name		= "pcie_bw_notification",
+	.port_type	= PCI_EXP_TYPE_DOWNSTREAM,
+	.service	= PCIE_PORT_SERVICE_BwNOTIF,
+	.probe		= pcie_bandwidth_notification_probe,
+	.remove		= pcie_bandwidth_notification_remove,
+};
+
+static int __init pcie_bandwidth_notification_service_init(void)
+{
+	return pcie_port_service_register(&pcie_bandwidth_notification_driver);
+}
+
+module_init(pcie_bandwidth_notification_service_init);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index e495f04394d0..46652469ffaa 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -20,8 +20,10 @@
 #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
 #define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
+#define PCIE_PORT_SERVICE_BWNOTIF_SHIFT	4	/* Bandwidth notification */
+#define PCIE_PORT_SERVICE_BwNOTIF	(1 << PCIE_PORT_SERVICE_BWNOTIF_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   4
+#define PCIE_PORT_DEVICE_MAXSERVICES   5
 
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index f458ac9cb70c..86455ff7ced9 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -99,7 +99,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
  */
 static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 {
-	int nr_entries, nvec;
+	int nr_entries, nvec, pcie_irq;
 	u32 pme = 0, aer = 0, dpc = 0;
 
 	/* Allocate the maximum possible number of MSI/MSI-X vectors */
@@ -136,9 +136,12 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 	}
 
 	/* PME and hotplug share an MSI/MSI-X vector */
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
-		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
-		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
+		    PCIE_PORT_SERVICE_BwNOTIF)) {
+		pcie_irq = pci_irq_vector(dev, pme);
+		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
+		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
+		irqs[PCIE_PORT_SERVICE_BWNOTIF_SHIFT] = pcie_irq;
 	}
 
 	if (mask & PCIE_PORT_SERVICE_AER)
@@ -250,6 +253,9 @@ static int get_port_device_capability(struct pci_dev *dev)
 	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
 		services |= PCIE_PORT_SERVICE_DPC;
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
+		services |= PCIE_PORT_SERVICE_BwNOTIF;
+
 	return services;
 }
 
-- 
2.17.1

