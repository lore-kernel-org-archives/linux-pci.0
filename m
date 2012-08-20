Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:38941 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab2HTNsQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Aug 2012 09:48:16 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 20 Aug 2012 09:48:13 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B208F38C805E
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:47:45 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7KDliFZ195614
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:47:45 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7KDkm7J005108
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:46:58 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	yinghai@kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 7/8] ppc/pci: override pcibios_window_alignment
Date: Mon, 20 Aug 2012 21:46:34 +0800
Message-Id: <1345470395-17295-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
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
index 2aa04f2..43fea54 100644
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

