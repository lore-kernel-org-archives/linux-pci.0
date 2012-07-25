Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35460 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab2GYBud (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jul 2012 21:50:33 -0400
Received: from /spool/local
	by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Tue, 24 Jul 2012 21:50:12 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B6564C9001B
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 21:50:09 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6P1o929395556
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 21:50:09 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6P7L1gX019795
	for <linux-pci@vger.kernel.org>; Wed, 25 Jul 2012 03:21:02 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, linuxram@us.ibm.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 7/8] ppc/pci: override pcibios_window_alignment
Date: Wed, 25 Jul 2012 09:49:56 +0800
Message-Id: <1343180997-9483-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function pcibios_window_alignment() has been implemented as "weak"
in PCI core to return the default alignment of I/O and memory windows
for the associated p2p bridge. The patch adds same function to
override the weak one so that the default alignment could be changed
for those platforms (e.g. powernv).

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h |    3 +++
 arch/powerpc/kernel/pci-common.c   |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 42ce570..f7706d7 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -214,6 +214,9 @@ struct machdep_calls {
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
 
+	/* Called during PCI resource reassignment */
+	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
+
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 8e78e93..776df07 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -99,6 +99,26 @@ void pcibios_free_controller(struct pci_controller *phb)
 		kfree(phb);
 }
 
+/*
+ * The function is used to return the minimal alignment
+ * for memory or I/O windows of the associated P2P bridge.
+ * By default, 4KiB alignment for I/O windows and 1MiB for
+ * memory windows.
+ */
+resource_size_t pcibios_window_alignment(struct pci_bus *bus,
+					 unsigned long type)
+{
+	if (ppc_md.pcibios_window_alignment)
+		return ppc_md.pcibios_window_alignment(bus, type);
+
+	/*
+	 * PCI core will figure out the default
+	 * alignment: 4KiB for I/O and 1MiB for
+	 * memory window.
+	 */
+	return 1;
+}
+
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
-- 
1.7.5.4

