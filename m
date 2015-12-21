Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:47144 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbbLURp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 21 Dec 2015 12:45:27 -0500
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv7 2/6] PCI/MSI: Export msi functions for module use
Date: Mon, 21 Dec 2015 10:44:56 -0700
Message-Id: <1450719900-2824-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
References: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7eaa4c8..fb7506f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1126,6 +1126,7 @@ struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
 }
+EXPORT_SYMBOL_GPL(msi_desc_to_pci_dev);
 
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 {
@@ -1285,6 +1286,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	domain->bus_token = DOMAIN_BUS_PCI_MSI;
 	return domain;
 }
+EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
 
 /**
  * pci_msi_domain_alloc_irqs - Allocate interrupts for @dev in @domain
-- 
2.6.2.307.g37023ba

