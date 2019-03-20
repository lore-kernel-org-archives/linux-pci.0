Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8D0C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A142184E
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 11:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCTLPg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:15:36 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:48631 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfCTLPf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2019 07:15:35 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 48C71101E68AA;
        Wed, 20 Mar 2019 12:15:34 +0100 (CET)
Received: from localhost (p5491779F.dip0.t-ipconnect.de [84.145.119.159])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C8E7F6233615;
        Wed, 20 Mar 2019 12:15:33 +0100 (CET)
X-Mailbox-Line: From 70cb1754e3f0da3b84712460b1017ac707cd2616 Mon Sep 17 00:00:00 2001
Message-Id: <70cb1754e3f0da3b84712460b1017ac707cd2616.1553078908.git.lukas@wunner.de>
In-Reply-To: <cover.1553078908.git.lukas@wunner.de>
References: <cover.1553078908.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 20 Mar 2019 12:05:30 +0100
Subject: [PATCH 2/2] PCI/LINK: bw_notification: Deduplicate reports for
 multi-function devices
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-pci@vger.kernel.org, Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@Dell.com>, Sinan Kaya <okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If a multi-function device's bandwidth is already limited when it is
enumerated, a message is logged only for function 0.  By contrast, when
downtraining occurs after enumeration, a message is logged for all
functions.  That's because the former uses pcie_report_downtraining(),
whereas the latter uses __pcie_print_link_status() (which doesn't filter
functions != 0).  I am seeing this happen on a MacBookPro9,1 with a GPU
(function 0) and an integrated HDA controller (function 1).

Avoid this incongruence by calling pcie_report_downtraining() in both
cases.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.h                  | 1 +
 drivers/pci/pcie/bw_notification.c | 2 +-
 drivers/pci/probe.c                | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 224d88634115..d994839a3e24 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -273,6 +273,7 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 			   enum pcie_link_width *width);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
+void pcie_report_downtraining(struct pci_dev *dev);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index 69e6ba2558bf..c26045f2a890 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -76,7 +76,7 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
 	 */
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &port->subordinate->devices, bus_list)
-		__pcie_print_link_status(dev, false);
+		pcie_report_downtraining(dev);
 	up_read(&pci_bus_sem);
 
 	pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2ec0df04e0dc..7e12d0163863 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2388,7 +2388,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
-static void pcie_report_downtraining(struct pci_dev *dev)
+void pcie_report_downtraining(struct pci_dev *dev)
 {
 	if (!pci_is_pcie(dev))
 		return;
-- 
2.20.1

