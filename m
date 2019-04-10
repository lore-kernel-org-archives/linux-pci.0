Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83561C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 18:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5939B2077C
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 18:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfDJSP6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:15:58 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:44861 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729811AbfDJSP6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2019 14:15:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from spencer@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Apr 2019 21:15:56 +0300
Received: from farm-1.mtbu.labs.mlnx (farm-1.mtbu.labs.mlnx [10.15.2.31])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x3AIFtPr026890;
        Wed, 10 Apr 2019 14:15:55 -0400
Received: (from spencer@localhost)
        by farm-1.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x3AIFsYn024960;
        Wed, 10 Apr 2019 14:15:54 -0400
From:   Spencer Lingard <spencer@mellanox.com>
To:     lukas@wunner.de
Cc:     linux-pci@vger.kernel.org, Spencer Lingard <spencer@mellanox.com>
Subject: [PATCH] PCI: pciehp: Fix false command timeouts on boot
Date:   Wed, 10 Apr 2019 14:07:48 -0400
Message-Id: <1554919668-24873-1-git-send-email-spencer@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During command writes, pcie_poll_cmd() is invoked if
Command Completed notifications are disabled. When polling,
if Command Completed is set, the bit is reset and success is returned,
but ctrl->cmd_busy is not set back to 0. The next command write
then attempts to wait on a command that has already been completed,
timing out after 2 seconds. This delay occurs more frequently at
boot time, since pcie_init() disables notifications when powering
down empty slots.

Clear cmd_busy upon successful command completion during
pcie_poll_cmd().

Signed-off-by: Spencer Lingard <spencer@mellanox.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6a2365c..28c70cf 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -77,6 +77,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 		if (slot_status & PCI_EXP_SLTSTA_CC) {
 			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 						   PCI_EXP_SLTSTA_CC);
+			ctrl->cmd_busy = 0;
 			return 1;
 		}
 		if (timeout < 0)
-- 
2.1.2

