Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:35141 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeBYCH3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Feb 2018 21:07:29 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: cpqphp: Fix possible NULL pointer dereference
Date: Sun, 25 Feb 2018 10:01:42 +0800
Message-Id: <1519524102-121438-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

io_node is used before verify whether it's null pointer,
so move the check of null pointer immediately after.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/hotplug/cpqphp_ctrl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index b1b6e45..616df44 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -2812,18 +2812,16 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
 
 					dbg("CND:      length = 0x%x\n", base);
 					io_node = get_io_resource(&(resources->io_head), base);
+					if (!io_node)
+						return -ENOMEM;
 					dbg("Got io_node start = %8.8x, length = %8.8x next (%p)\n",
 					    io_node->base, io_node->length, io_node->next);
 					dbg("func (%p) io_head (%p)\n", func, func->io_head);
 
 					/* allocate the resource to the board */
-					if (io_node) {
-						base = io_node->base;
-
-						io_node->next = func->io_head;
-						func->io_head = io_node;
-					} else
-						return -ENOMEM;
+					base = io_node->base;
+					io_node->next = func->io_head;
+					func->io_head = io_node;
 				} else if ((temp_register & 0x0BL) == 0x08) {
 					/* Map prefetchable memory */
 					base = temp_register & 0xFFFFFFF0;
-- 
1.9.1
