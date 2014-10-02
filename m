Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56327 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbaJBD7Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 23:59:24 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Vality <matt@masarand.com>
Subject: [PATCH 17/18] Disabled bus scan time PCI IRQ assignment on parisc
Date: Thu,  2 Oct 2014 04:50:36 +0100
Message-Id: <1412221837-17452-18-git-send-email-matt@masarand.com>
In-Reply-To: <1412221837-17452-1-git-send-email-matt@masarand.com>
References: <1412221837-17452-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Vality <matt@masarand.com>

Most of the architectures are switched to allocating IRQs at device_enable
time instead of boot time, however parisc does not provide an easy way of
making that transition so the new code is disabled here on parisc.

---
 arch/parisc/kernel/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index 64f2764..9654c69 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -105,7 +105,13 @@ PCI_PORT_OUT(b,  8)
 PCI_PORT_OUT(w, 16)
 PCI_PORT_OUT(l, 32)
 
-
+/* We do not support hot-add irq assignment */
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = NULL;
+	return 0;
+}
 
 /*
  * BIOS32 replacement.
-- 
2.1.0

