Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37586 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbGOQy6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2015 12:54:58 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org, Robert Richter <rrichter@cavium.com>,
	David Daney <david.daney@cavium.com>
Subject: [PATCH 3/5] arm64, pci: Allow RC drivers to supply pcibios_add_device() implementation.
Date: Wed, 15 Jul 2015 09:54:43 -0700
Message-Id: <1436979285-8177-4-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

The default is to continue doing the what we have done before, but add
a hook so that this can be overridden.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/pci.h |  3 +++
 arch/arm64/kernel/pci.c      | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b008a72..ad3fb18 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -37,6 +37,9 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 {
 	return 1;
 }
+
+void set_pcibios_add_device(int (*arg)(struct pci_dev *));
+
 #endif  /* CONFIG_PCI */
 
 #endif  /* __KERNEL__ */
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4095379..3356023 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -38,11 +38,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return res->start;
 }
 
+static int (*pcibios_add_device_impl)(struct pci_dev *);
+
+void set_pcibios_add_device(int (*arg)(struct pci_dev *))
+{
+	pcibios_add_device_impl = arg;
+}
+
 /*
  * Try to assign the IRQ number from DT when adding a new device
  */
 int pcibios_add_device(struct pci_dev *dev)
 {
+	if (pcibios_add_device_impl)
+		return pcibios_add_device_impl(dev);
+
 	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
 
 	return 0;
-- 
1.9.1

