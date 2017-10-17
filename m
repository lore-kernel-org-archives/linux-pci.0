Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54927 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757464AbdJQH43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 03:56:29 -0400
Message-Id: <20171017075600.448649905@linutronix.de>
Date: Tue, 17 Oct 2017 09:54:58 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-pci@vger.kernel.org, devel@linuxdriverproject.org,
        Josh Poulson <jopoulso@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [patch 2/3] PCI/MSI: Set MSI_FLAG_MUST_REACTIVATE in core code
References: <20171017075456.694047687@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If interrupt reservation mode is enabled then the PCI/MSI interrupts must
be reactivated after early activation.

Make sure that all callers of pci_msi_create_irq_domain() have the
MSI_FLAG_MUST_REACTIVATE set when reservation mode is enabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1441,6 +1441,8 @@ struct irq_domain *pci_msi_create_irq_do
 		pci_msi_domain_update_chip_ops(info);
 
 	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION))
+		info->flags |= MSI_FLAG_MUST_REACTIVATE;
 
 	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (!domain)
