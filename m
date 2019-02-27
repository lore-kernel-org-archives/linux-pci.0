Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A12C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 20:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC44C21850
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 20:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmfCEUdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfB0U6v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:58:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41431 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfB0U6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 15:58:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id e7so14664061oia.8;
        Wed, 27 Feb 2019 12:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjMG6anEv+h0YuOc4leNaCP4l/Y2HNkPU2jPr+Y8efg=;
        b=cmfCEUdlf2tRALC9D44jxw2kSIMYkJYkG6EU9wmhwZ5LTNl04T55OSxzUfrH2ulSZP
         dRx85t9H+BBHjJzt+hYLVRR0g+N5v3cphFvWW4wsx6GxSvKJwzbBz90ulRddOSc/0gfq
         k0MNMDZWC7GdjB3IXXy1SCoATLHUSd3qXNke4HLFP0awo0Yi5x+3fkECSDiXycWjb8xa
         CqZmzfPOq8QnR+xkkt/OPDPiB1kXjqeGyFQX2LuS7OKZEDIvGu+zPe9WAZAB9PCNqrHn
         x6qRHuKjUT2dNzvqRFVQcII8RZtJY8b0CLnKe+1u95o5lkY3bwjWeOiV79gZc7feJDWx
         sukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjMG6anEv+h0YuOc4leNaCP4l/Y2HNkPU2jPr+Y8efg=;
        b=stciujmxOJPMZfI7rdARjdttt66bK9M5SKyNLqMOph1J85hUaosV3TX+AgCYovdrTF
         qlC8f4E5ScDrCy7JlkAqE9Kl7tbRnQVvYfSOrDQ33q+JuNxOcJ/ChCr8uHHtoCdgT78r
         A/FbPXcqMQpgACnTQEmMv3tzd0K34nw/kY22+YR7pa0bfSnx5n+d+va7k7wMMEHj5UAu
         NdH63jEpPC+27/qaf24ZcZ5lJ1qaymUUGr6fR1zNHj+4RFdHiQdBU5OBVJN2W3agesMK
         YEYUQOpSQfRTXAtjBuVqOIr7gSA3I72Fcy3qxi1YeGZY3JkOUaNermQOULmQqkNlyQMW
         Nk1Q==
X-Gm-Message-State: APjAAAXO5dIkTEUrqj841PC6zsjcjTR7BHI18ORVbwMGOlhP33wXEPgy
        uDng3LituCRw/oODUNGWtR4=
X-Google-Smtp-Source: AHgI3IZUrRp/Lq0+7DHYCAHnAfyVUo/0XKXBcD5XJ3VeHQ7mPnLAjFxwVwP8/xy8wrY3ClLh8royjA==
X-Received: by 2002:aca:cd:: with SMTP id 196mr816749oia.42.1551301128484;
        Wed, 27 Feb 2019 12:58:48 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id d67sm7790279oig.36.2019.02.27.12.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 12:58:48 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Young <youngcdev@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI: portdrv: Report degraded links via link bandwidth notification
Date:   Wed, 27 Feb 2019 14:58:17 -0600
Message-Id: <20190227205840.26898-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/pci/pcie/Makefile          |   1 +
 drivers/pci/pcie/bw_notification.c | 109 +++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h         |   6 +-
 drivers/pci/pcie/portdrv_core.c    |  17 +++--
 drivers/pci/pcie/portdrv_pci.c     |   1 +
 5 files changed, 128 insertions(+), 6 deletions(-)
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
index 000000000000..05bbef38dbbd
--- /dev/null
+++ b/drivers/pci/pcie/bw_notification.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCI Express Bandwidth notification services driver
+ * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
+ *
+ * Copyright (C) 2019, Dell Inc
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
+static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
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
+	down_read(&pci_bus_sem);
+	/* Print status from upstream link partner, not this downstream port. */
+	list_for_each_entry(dev, &port->subordinate->devices, bus_list)
+		__pcie_print_link_status(dev, false);
+	up_read(&pci_bus_sem);
+
+	pcie_update_link_speed(port->subordinate, link_status);
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
+	ret = request_threaded_irq(srv->irq, NULL, pcie_bw_notification_handler,
+				   IRQF_SHARED, "PCIe BW notif", srv);
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
+	free_irq(srv->irq, srv);
+}
+
+static struct pcie_port_service_driver pcie_bandwidth_notification_driver = {
+	.name		= "pcie_bw_notification",
+	.port_type	= PCIE_ANY_PORT,
+	.service	= PCIE_PORT_SERVICE_BWNOTIF,
+	.probe		= pcie_bandwidth_notification_probe,
+	.remove		= pcie_bandwidth_notification_remove,
+};
+
+int __init pcie_bandwidth_notification_init(void)
+{
+	return pcie_port_service_register(&pcie_bandwidth_notification_driver);
+}
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index fbbf00b0992e..1d50dc58ac40 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -20,8 +20,10 @@
 #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
 #define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
+#define PCIE_PORT_SERVICE_BWNOTIF_SHIFT	4	/* Bandwidth notification */
+#define PCIE_PORT_SERVICE_BWNOTIF	(1 << PCIE_PORT_SERVICE_BWNOTIF_SHIFT)
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   4
+#define PCIE_PORT_DEVICE_MAXSERVICES   5
 
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
@@ -47,6 +49,8 @@ int pcie_dpc_init(void);
 static inline int pcie_dpc_init(void) { return 0; }
 #endif
 
+int pcie_bandwidth_notification_init(void);
+
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index f458ac9cb70c..7d04f9d087a6 100644
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
@@ -135,10 +135,13 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
 			return nr_entries;
 	}
 
-	/* PME and hotplug share an MSI/MSI-X vector */
-	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
-		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
-		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
+	/* PME, hotplug and bandwidth notification share an MSI/MSI-X vector */
+	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
+		    PCIE_PORT_SERVICE_BWNOTIF)) {
+		pcie_irq = pci_irq_vector(dev, pme);
+		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
+		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
+		irqs[PCIE_PORT_SERVICE_BWNOTIF_SHIFT] = pcie_irq;
 	}
 
 	if (mask & PCIE_PORT_SERVICE_AER)
@@ -250,6 +253,10 @@ static int get_port_device_capability(struct pci_dev *dev)
 	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
 		services |= PCIE_PORT_SERVICE_DPC;
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+		services |= PCIE_PORT_SERVICE_BWNOTIF;
+
 	return services;
 }
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0acca3596807..a9dac4a8b017 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -238,6 +238,7 @@ static void __init pcie_init_services(void)
 	pcie_pme_init();
 	pcie_dpc_init();
 	pcie_hp_init();
+	pcie_bandwidth_notification_init();
 }
 
 static int __init pcie_portdrv_init(void)
-- 
2.19.2

