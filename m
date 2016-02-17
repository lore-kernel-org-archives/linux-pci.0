Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:46535 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965175AbcBQDqB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 22:46:01 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 13:45:59 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 31/45] powerpc/pci: Don't scan empty slot
Date: Wed, 17 Feb 2016 14:44:14 +1100
Message-Id: <1455680668-23298-32-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In hotplug case, function pci_add_pci_devices() is called to rescan
the specified PCI bus, which might not have any child devices. Access
to the PCI bus's child device node will cause kernel crash without
exception.

This adds one more check to skip scanning PCI bus that doesn't have
any subordinate devices from device-tree, in order to avoid kernel
crash.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 7929a1c..3628c38 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -120,7 +120,8 @@ void pci_add_pci_devices(struct pci_bus *bus)
 	if (mode == PCI_PROBE_DEVTREE) {
 		/* use ofdt-based probe */
 		of_rescan_bus(dn, bus);
-	} else if (mode == PCI_PROBE_NORMAL) {
+	} else if (mode == PCI_PROBE_NORMAL &&
+		   dn->child && PCI_DN(dn->child)) {
 		/*
 		 * Use legacy probe. In the partial hotplug case, we
 		 * probably have grandchildren devices unplugged. So
-- 
2.1.0

