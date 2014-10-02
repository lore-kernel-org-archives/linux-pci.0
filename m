Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56367 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbaJBEIJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 00:08:09 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 16/18] Disabled bus scan time PCI IRQ assignment on ia64
Date: Thu,  2 Oct 2014 05:07:44 +0100
Message-Id: <1412222866-21068-17-git-send-email-matt@masarand.com>
In-Reply-To: <1412222866-21068-1-git-send-email-matt@masarand.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

Most of the architectures are switched to allocating IRQs at device_enable
time instead of boot time, however ia64 does not provide an easy way of
making that transition so the new code is disabled here on ia64.

Signed-off-by: Matthew Minter <matt@masarand.com>

---
 arch/ia64/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 291a582..398d5d4 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -483,6 +483,9 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
 	struct pci_controller *controller = bridge->bus->sysdata;
 
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = NULL;
+
 	ACPI_COMPANION_SET(&bridge->dev, controller->companion);
 	return 0;
 }
-- 
2.1.0

