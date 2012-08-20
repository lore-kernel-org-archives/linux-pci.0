Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50058 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808Ab2HTNrG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Aug 2012 09:47:06 -0400
Received: from /spool/local
	by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 20 Aug 2012 09:47:05 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2A1C96E8039
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:46:53 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7KDkqOs146038
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:46:52 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7KDkoTd016727
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:46:51 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	yinghai@kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 4/8] pci: weak function returns alignment
Date: Mon, 20 Aug 2012 21:46:31 +0800
Message-Id: <1345470395-17295-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch implements the weak function to return the default I/O
or memory alignment for P2P bridge. Currently, I/O window has 4KiB
alignment and memory window is 4MiB aligned by default. On the other
hand, those platforms (e.g. powernv) that have special requirements
on the alignment could override the function by themselves.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   24 ++++++++++++++++++++++++
 include/linux/pci.h     |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index fb50613..826a4f3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -697,6 +697,30 @@ static resource_size_t calculate_memsize(resource_size_t size,
 	return size;
 }
 
+resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
+						unsigned long type)
+{
+	return 1;
+}
+
+#define PCI_P2P_DEFAULT_MEM_ALIGN	0x100000	/* 1MiB */
+#define PCI_P2P_DEFAULT_IO_ALIGN	0x1000		/* 4KiB */
+
+static resource_size_t window_alignment(struct pci_bus *bus,
+					unsigned long type)
+{
+	resource_size_t align = 1, arch_align;
+
+	if (type & IORESOURCE_MEM)
+		align = PCI_P2P_DEFAULT_MEM_ALIGN;
+	else if (type & IORESOURCE_IO)
+		align = PCI_P2P_DEFAULT_IO_ALIGN;
+
+	arch_align = pcibios_window_alignment(bus, type);
+
+	return max(align, arch_align);
+}
+
 /**
  * pbus_size_io() - size the io window of a given bus
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a47a4d3..739be31 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1034,6 +1034,8 @@ int pci_cfg_space_size_ext(struct pci_dev *dev);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
+resource_size_t pcibios_window_alignment(struct pci_bus *bus,
+					 unsigned long type);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
-- 
1.7.5.4

