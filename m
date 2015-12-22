Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34485 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932973AbbLVVpC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2015 16:45:02 -0500
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH] PCI: aer_inject: Don't call config read/write functions with invalid ops structure.
Date: Tue, 22 Dec 2015 13:44:51 -0800
Message-Id: <1450820691-27588-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

The aer_inject module, when active, replaces the pci_ops structure of
the bus so that it can intercept config space accesses.  If the config
space access needs to be forwarded to the original pci_ops, we must
restore the bus's original ops, as the read()/write() functions may
require use of the data in the pci_ops structure.  An example of such
functions are the pci_generic_config*() functions in
drivers/pci/access.c.  A failure to call these with a valid bus->ops
results in dereferencing an invalid bus->ops->map_bus pointer and
subsequent OOPs and system crash.

So, do as suggested above.  When calling to the original
read()/write() functions, temporarily switch back to the original
pci_ops.  This is safe to do as the pci_lock must already be held, and
thus no other users of the bus->ops are possible.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/pcie/aer/aer_inject.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 182224a..2d60e0e 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -188,7 +188,9 @@ static int pci_read_aer(struct pci_bus *bus, unsigned int devfn, int where,
 	struct aer_error *err;
 	unsigned long flags;
 	struct pci_ops *ops;
+	struct pci_ops *my_ops;
 	int domain;
+	int rv;
 
 	spin_lock_irqsave(&inject_lock, flags);
 	if (size != sizeof(u32))
@@ -208,8 +210,19 @@ static int pci_read_aer(struct pci_bus *bus, unsigned int devfn, int where,
 	}
 out:
 	ops = __find_pci_bus_ops(bus);
+	/*
+	 * pci_lock must already be held, so we can directly
+	 * manipulate bus->ops.  Many config access functions,
+	 * including pci_generic_config_read() require the original
+	 * bus->ops be installed to function, so temporarily put them
+	 * back.
+	 */
+	my_ops = bus->ops;
+	bus->ops = ops;
+	rv = ops->read(bus, devfn, where, size, val);
+	bus->ops = my_ops;
 	spin_unlock_irqrestore(&inject_lock, flags);
-	return ops->read(bus, devfn, where, size, val);
+	return rv;
 }
 
 static int pci_write_aer(struct pci_bus *bus, unsigned int devfn, int where,
@@ -220,7 +233,9 @@ static int pci_write_aer(struct pci_bus *bus, unsigned int devfn, int where,
 	unsigned long flags;
 	int rw1cs;
 	struct pci_ops *ops;
+	struct pci_ops *my_ops;
 	int domain;
+	int rv;
 
 	spin_lock_irqsave(&inject_lock, flags);
 	if (size != sizeof(u32))
@@ -243,8 +258,19 @@ static int pci_write_aer(struct pci_bus *bus, unsigned int devfn, int where,
 	}
 out:
 	ops = __find_pci_bus_ops(bus);
+	/*
+	 * pci_lock must already be held, so we can directly
+	 * manipulate bus->ops.  Many config access functions,
+	 * including pci_generic_config_write() require the original
+	 * bus->ops be installed to function, so temporarily put them
+	 * back.
+	 */
+	my_ops = bus->ops;
+	bus->ops = ops;
+	rv = ops->write(bus, devfn, where, size, val);
+	bus->ops = my_ops;
 	spin_unlock_irqrestore(&inject_lock, flags);
-	return ops->write(bus, devfn, where, size, val);
+	return rv;
 }
 
 static struct pci_ops pci_ops_aer = {
-- 
1.8.3.1

