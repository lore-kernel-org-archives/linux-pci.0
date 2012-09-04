Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43121 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221Ab2IDOWO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Sep 2012 10:22:14 -0400
Received: from localhost.localdomain (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.5/8.14.1) with ESMTP id q84EsuVF007358
	for <linux-pci@vger.kernel.org>; Tue, 4 Sep 2012 15:55:01 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] cpqphp_ctrl: remove unreachable path
To: linux-pci@vger.kernel.org
Date: Tue, 04 Sep 2012 15:39:57 +0100
Message-ID: <20120904143946.25201.77305.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alan Cox <alan@linux.intel.com>

register & 0x0B == 0x04 is never true, the code will always take the
(identical) 0x00 path anyway. Remove the dead code paths.

Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=44151
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/pci/hotplug/cpqphp_ctrl.c |   21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index e43908d..36112fe 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -2890,27 +2890,8 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
 						func->mem_head = mem_node;
 					} else
 						return -ENOMEM;
-				} else if ((temp_register & 0x0BL) == 0x04) {
-					/* Map memory */
-					base = temp_register & 0xFFFFFFF0;
-					base = ~base + 1;
-
-					dbg("CND:      length = 0x%x\n", base);
-					mem_node = get_resource(&(resources->mem_head), base);
-
-					/* allocate the resource to the board */
-					if (mem_node) {
-						base = mem_node->base;
-
-						mem_node->next = func->mem_head;
-						func->mem_head = mem_node;
-					} else
-						return -ENOMEM;
-				} else if ((temp_register & 0x0BL) == 0x06) {
-					/* Those bits are reserved, we can't handle this */
-					return 1;
 				} else {
-					/* Requesting space below 1M */
+					/* Reserved bits or requesting space below 1M */
 					return NOT_ENOUGH_RESOURCES;
 				}
 

