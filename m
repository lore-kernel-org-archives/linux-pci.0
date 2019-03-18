Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AFAC10F00
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64552087E
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 16:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCRQJV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:09:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36928 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfCRQJV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 12:09:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E0621650;
        Mon, 18 Mar 2019 09:09:20 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 947353F59C;
        Mon, 18 Mar 2019 09:09:19 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     bhelgaas@google.com
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Fix pci_host_bridge initialization
Date:   Mon, 18 Mar 2019 16:07:18 +0000
Message-Id: <20190318160718.10925-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Two functions allocate a host bridge, devm_pci_alloc_host_bridge() and
pci_alloc_host_bridge(). At the moment, only the unmanaged one
initializes the PCIe feature bits, which prevents from using features
such as hotplug or AER on some systems, when booting with device tree.
Make the initialization code common.

Fixes: 02bfeb484230 ("PCI/portdrv: Simplify PCIe feature permission checking")
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/pci/probe.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2ec0df04e0dc..012250a78da7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -586,16 +586,9 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	kfree(to_pci_host_bridge(dev));
 }
 
-struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
+static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 {
-	struct pci_host_bridge *bridge;
-
-	bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
-	if (!bridge)
-		return NULL;
-
 	INIT_LIST_HEAD(&bridge->windows);
-	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
 	 * We assume we can manage these PCIe features.  Some systems may
@@ -608,6 +601,18 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+}
+
+struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
+{
+	struct pci_host_bridge *bridge;
+
+	bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
+	if (!bridge)
+		return NULL;
+
+	pci_init_host_bridge(bridge);
+	bridge->dev.release = pci_release_host_bridge_dev;
 
 	return bridge;
 }
@@ -622,7 +627,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 	if (!bridge)
 		return NULL;
 
-	INIT_LIST_HEAD(&bridge->windows);
+	pci_init_host_bridge(bridge);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;
-- 
2.21.0

