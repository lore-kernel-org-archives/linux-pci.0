Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54925 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754557AbdJQH43 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 03:56:29 -0400
Message-Id: <20171017075600.369375409@linutronix.de>
Date: Tue, 17 Oct 2017 09:54:57 +0200
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
Subject: [patch 1/3] genirq: Add config option for reservation mode
References: <20171017075456.694047687@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The interrupt reservation mode requires reactivation of PCI/MSI
interrupts. Create a config option, so the PCI code can set the
corresponding flag when required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -100,6 +100,9 @@ config IRQ_TIMINGS
 config GENERIC_IRQ_MATRIX_ALLOCATOR
 	bool
 
+config GENERIC_IRQ_RESERVATION_MODE
+	bool
+
 config IRQ_DOMAIN_DEBUG
 	bool "Expose hardware/virtual IRQ mapping via debugfs"
 	depends on IRQ_DOMAIN && DEBUG_FS
