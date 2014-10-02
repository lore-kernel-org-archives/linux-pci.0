Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([69.164.217.139]:56371 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbaJBEIK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Oct 2014 00:08:10 -0400
From: matt@masarand.com
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Matthew Minter <matt@masarand.com>
Subject: [PATCH 18/18] Disabled bus scan time PCI IRQ assignment on s390
Date: Thu,  2 Oct 2014 05:07:46 +0100
Message-Id: <1412222866-21068-19-git-send-email-matt@masarand.com>
In-Reply-To: <1412222866-21068-1-git-send-email-matt@masarand.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Matthew Minter <matt@masarand.com>

Most of the architectures are switched to allocating IRQs at device_enable
time instead of boot time, however s390 does not provide an easy way of
making that transition so the new code is disabled here on s390.

Signed-off-by: Matthew Minter <matt@masarand.com>

---
 arch/s390/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2fa7b14..720592f 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -434,6 +434,13 @@ out:
 	return rc;
 }
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->swizzle_irq = NULL;
+	bridge->map_irq = NULL;
+	return 0;
+}
+
 void arch_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = get_zdev(pdev);
-- 
2.1.0

