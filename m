Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5514C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 11:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A2521850
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 11:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfCTLON (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:14:13 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:57735 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfCTLOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2019 07:14:12 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 4E9B7100AFB99;
        Wed, 20 Mar 2019 12:14:11 +0100 (CET)
Received: from localhost (p5491779F.dip0.t-ipconnect.de [84.145.119.159])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id DA0606233615;
        Wed, 20 Mar 2019 12:14:10 +0100 (CET)
X-Mailbox-Line: From 87006d1f5b6868c0a6bb2fbb2765ee4dde550f28 Mon Sep 17 00:00:00 2001
Message-Id: <87006d1f5b6868c0a6bb2fbb2765ee4dde550f28.1553078908.git.lukas@wunner.de>
In-Reply-To: <cover.1553078908.git.lukas@wunner.de>
References: <cover.1553078908.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 20 Mar 2019 12:05:30 +0100
Subject: [PATCH 1/2] PCI/LINK: bw_notification: Clear interrupt before
 enabling it
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

When booting a MacBookPro9,1, duplicate link downtraining messages are
logged for the devices directly attached to the two CPU-internal Root
Ports of the Core i7 3615QM:  Once on device enumeration and once on
enablement of the bandwidth notification interrupt on the Root Ports.

Duplicate messages do not occur with Root Ports on the PCH and Downstream
Ports on the Thunderbolt controller:  Only a single message is logged for
these, namely on device enumeration.

The reason for the duplicate messages is a stale interrupt in the Link
Status register of the 3615QM's internal Root Ports.  Avoid by clearing
the interrupt before enabling it.

An alternative approach would be to clear the interrupt already on device
enumeration or to report link downtraining only if the speed has changed.
That way, link downtraining occurring between device enumeration and
enablement of the bandwidth notification interrupt could be catched.
However clearing stale interrupts before enabling them is a standard
operating procedure for any driver and keeping the two steps in one place
makes the code easier to follow.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/bw_notification.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index 001d6253ad48..69e6ba2558bf 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -30,6 +30,8 @@ static void pcie_enable_link_bandwidth_notification(struct pci_dev *dev)
 {
 	u16 lnk_ctl;
 
+	pcie_capability_write_word(dev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
+
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnk_ctl);
 	lnk_ctl |= PCI_EXP_LNKCTL_LBMIE;
 	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
-- 
2.20.1

