Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.sysgo.com ([176.9.12.79]:58654 "EHLO mail.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbcELG5B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 May 2016 02:57:01 -0400
From: David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] PCI: Fix __pci_bus_size_bridges when bridge is not available
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Message-ID: <5734293A.6040702@sysgo.com>
Date: Thu, 12 May 2016 08:56:58 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010505070306040704090109"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010505070306040704090109
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

A virtual PCI controller may not have a bridge device, thus when 
__pci_bus_size_bridges is called, it will generate a NULL pointer 
exception when accessing bus->self->class. The attached patch adds a 
check to verify if a bridge has been set. Without a bridge device, the 
function returns.

Signed-off-by: David Engraf <david.engraf <at> sysgo.com>


--------------010505070306040704090109
Content-Type: text/x-diff;
 name="setup-pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setup-pci.patch"

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 55641a3..ddb3381 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1245,6 +1245,10 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	if (pci_is_root_bus(bus))
 		return;
 
+	/* bridge device available? */
+	if (!bus->self)
+		return;
+
 	switch (bus->self->class >> 8) {
 	case PCI_CLASS_BRIDGE_CARDBUS:
 		/* don't size cardbuses yet. */

--------------010505070306040704090109--
