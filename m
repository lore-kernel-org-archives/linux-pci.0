Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055ABC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53D02146E
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 15:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfBSP6G (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:58:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728642AbfBSP5j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Feb 2019 10:57:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E78BCAF5F;
        Tue, 19 Feb 2019 15:57:38 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] PCI: call add_bus method also for root bus
Date:   Tue, 19 Feb 2019 16:57:21 +0100
Message-Id: <20190219155728.19163-8-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190219155728.19163-1-tbogendoerfer@suse.de>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-xtalk controller code uses the add_bus method to set node of
the bus device, which then is used for pcibus_to_node() implementation.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/pci/probe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6f2ebb..456448d5f46d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -837,6 +837,12 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	pcibios_add_bus(bus);
 
+	if (bus->ops->add_bus) {
+		err = bus->ops->add_bus(bus);
+		if (WARN_ON(err < 0))
+			dev_err(&bus->dev, "failed to add bus: %d\n", err);
+	}
+
 	/* Create legacy_io and legacy_mem files for this bus */
 	pci_create_legacy_files(bus);
 
-- 
2.13.7

