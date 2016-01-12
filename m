Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16365 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbcALUSN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 15:18:13 -0500
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv8 2/5] x86/IRQ: Export IRQ domain function for module use
Date: Tue, 12 Jan 2016 13:18:07 -0700
Message-Id: <1452629890-17542-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8cf95de..6e655f7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1061,6 +1061,7 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 	__irq_set_handler(virq, handler, 0, handler_name);
 	irq_set_handler_data(virq, handler_data);
 }
+EXPORT_SYMBOL(irq_domain_set_info);
 
 /**
  * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
-- 
2.6.2.307.g37023ba

