Return-Path: <SRS0=Q0Wt=UX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C58C43613
	for <linux-pci@archiver.kernel.org>; Mon, 24 Jun 2019 04:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DA6208CA
	for <linux-pci@archiver.kernel.org>; Mon, 24 Jun 2019 04:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfFXEcW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:32:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:39070 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfFXEcW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 00:32:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5O4WJIr012950
        for <linux-pci@vger.kernel.org>; Sun, 23 Jun 2019 23:32:20 -0500
Message-ID: <02ca29627597445442bb14c069678e549429dace.camel@kernel.crashing.org>
Subject: [RFC/PATCH] PCI: Protect pci_reassign_bridge_resources() against
 concurrent addition/removal
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Mon, 24 Jun 2019 14:32:19 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_reassign_bridge_resources() can be called by pci_resize_resource()
at runtime.

It will walk the PCI tree up and down, and isn't currently protected
against any changes or hotplug operation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2104,6 +2104,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 	unsigned int i;
 	int ret;
 
+	down_read(&pci_bus_sem);
+
 	/* Walk to the root hub, releasing bridge BARs when possible */
 	next = bridge;
 	do {
@@ -2160,6 +2162,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 	}
 
 	free_list(&saved);
+	up_read(&pci_bus_sem);
 	return 0;
 
 cleanup:
@@ -2188,6 +2191,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		pci_setup_bridge(bridge->subordinate);
 	}
 	free_list(&saved);
+	up_read(&pci_bus_sem);
 
 	return ret;
 }

