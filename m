Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15925 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbbLURp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
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
Subject: [PATCHv7 3/6] x86/IRQ: Export IRQ domain function for module use
Date: Mon, 21 Dec 2015 10:44:57 -0700
Message-Id: <1450719900-2824-4-git-send-email-keith.busch@intel.com>
In-Reply-To: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
References: <1450719900-2824-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 22aa961..ca05cc8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1058,6 +1058,7 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 	__irq_set_handler(virq, handler, 0, handler_name);
 	irq_set_handler_data(virq, handler_data);
 }
+EXPORT_SYMBOL(irq_domain_set_info);
 
 /**
  * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
-- 
2.6.2.307.g37023ba

