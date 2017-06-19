Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40014 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbdFSX75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 19:59:57 -0400
Message-Id: <20170619235444.379861978@linutronix.de>
Date: Tue, 20 Jun 2017 01:37:15 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [patch 15/55] PCI: vmd: Create named irq domain
References: <20170619233700.547167146@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the fwnode to create a named domain so diagnosis works.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/host/vmd.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -554,6 +554,7 @@ static int vmd_find_free_domain(void)
 static int vmd_enable_domain(struct vmd_dev *vmd)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
+	struct fwnode_handle *fn;
 	struct resource *res;
 	u32 upper_bits;
 	unsigned long flags;
@@ -617,8 +618,13 @@ static int vmd_enable_domain(struct vmd_
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
-	vmd->irq_domain = pci_msi_create_irq_domain(NULL, &vmd_msi_domain_info,
+	fn = irq_domain_alloc_named_id_fwnode("VMD-MSI", vmd->sysdata.domain);
+	if (!fn)
+		return -ENODEV;
+
+	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
 						    x86_vector_domain);
+	kfree(fn);
 	if (!vmd->irq_domain)
 		return -ENODEV;
 
