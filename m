Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:37223 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab2FUAQz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 20:16:55 -0400
Received: by mail-fa0-f74.google.com with SMTP id 25so2361fat.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:55 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id D190B5C0050
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:54 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 3D51A180181
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:54 -0700 (PDT)
Subject: [PATCH 4/6] PCI: shpchp: remove dead code
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 20 Jun 2012 18:16:54 -0600
Message-ID: <20120621001654.4834.59821.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
References: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"slots_not_empty" is initialized to zero and can't be set again before
reaching this point, so this return statement is dead.  Remove it.

Found by Coverity (CID 114324).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/shpchp_ctrl.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index b00b09b..f9b5a52 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -262,9 +262,6 @@ static int board_added(struct slot *p_slot)
 	}
 
 	if ((ctrl->pci_dev->vendor == 0x8086) && (ctrl->pci_dev->device == 0x0332)) {
-		if (slots_not_empty)
-			return WRONG_BUS_FREQUENCY;
-
 		if ((rc = p_slot->hpc_ops->set_bus_speed_mode(p_slot, PCI_SPEED_33MHz))) {
 			ctrl_err(ctrl, "%s: Issue of set bus speed mode command"
 				 " failed\n", __func__);

