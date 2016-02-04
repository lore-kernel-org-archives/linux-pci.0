Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49796 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755128AbcBDU1T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 15:27:19 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 165B620398
	for <linux-pci@vger.kernel.org>; Thu,  4 Feb 2016 20:27:18 +0000 (UTC)
Received: from localhost (unknown [69.71.1.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 437AE20397
	for <linux-pci@vger.kernel.org>; Thu,  4 Feb 2016 20:27:17 +0000 (UTC)
Subject: [PATCH] PCI/AER: Rename pci_ops_aer to aer_inj_pci_ops
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 04 Feb 2016 14:27:16 -0600
Message-ID: <20160204202716.10091.376.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename

  pci_ops_aer     to aer_inj_pci_ops
  pci_read_aer()  to aer_inj_read_config()
  pci_write_aer() to aer_inj_write_config()

This is more conventional and more informative.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 20db790..148a301 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -181,8 +181,8 @@ static u32 *find_pci_config_dword(struct aer_error *err, int where,
 	return target;
 }
 
-static int pci_read_aer(struct pci_bus *bus, unsigned int devfn, int where,
-			int size, u32 *val)
+static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *val)
 {
 	u32 *sim;
 	struct aer_error *err;
@@ -212,8 +212,8 @@ out:
 	return ops->read(bus, devfn, where, size, val);
 }
 
-static int pci_write_aer(struct pci_bus *bus, unsigned int devfn, int where,
-			 int size, u32 val)
+static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 val)
 {
 	u32 *sim;
 	struct aer_error *err;
@@ -247,9 +247,9 @@ out:
 	return ops->write(bus, devfn, where, size, val);
 }
 
-static struct pci_ops pci_ops_aer = {
-	.read = pci_read_aer,
-	.write = pci_write_aer,
+static struct pci_ops aer_inj_pci_ops = {
+	.read = aer_inj_read_config,
+	.write = aer_inj_write_config,
 };
 
 static void pci_bus_ops_init(struct pci_bus_ops *bus_ops,
@@ -270,9 +270,9 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	bus_ops = kmalloc(sizeof(*bus_ops), GFP_KERNEL);
 	if (!bus_ops)
 		return -ENOMEM;
-	ops = pci_bus_set_ops(bus, &pci_ops_aer);
+	ops = pci_bus_set_ops(bus, &aer_inj_pci_ops);
 	spin_lock_irqsave(&inject_lock, flags);
-	if (ops == &pci_ops_aer)
+	if (ops == &aer_inj_pci_ops)
 		goto out;
 	pci_bus_ops_init(bus_ops, bus, ops);
 	list_add(&bus_ops->list, &pci_bus_ops_list);

