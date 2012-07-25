Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:45212 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450Ab2GYBu3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jul 2012 21:50:29 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Tue, 24 Jul 2012 19:50:28 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 36B983E4003C
	for <linux-pci@vger.kernel.org>; Wed, 25 Jul 2012 01:50:09 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6P1o9Fi098190
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 19:50:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6P1o7J3016470
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 19:50:09 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, linuxram@us.ibm.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 4/8] pci: weak function returns alignment
Date: Wed, 25 Jul 2012 09:49:53 +0800
Message-Id: <1343180997-9483-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch implements the weak function to return the default I/O
or memory alignment for P2P bridge. Currently, I/O window has 4KiB
alignment and memory window is 4MiB aligned by default. On the other
hand, those platforms (e.g. powernv) that have special requirements
on the alignment could override the function by themselves.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |   21 +++++++++++++++++++++
 include/linux/pci.h     |    2 ++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8fa2d4b..c0fb9da 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -690,6 +690,27 @@ static resource_size_t calculate_memsize(resource_size_t size,
 	return size;
 }
 
+resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
+						unsigned long type)
+{
+	return 1;
+}
+
+static resource_size_t window_alignment(struct pci_bus *bus,
+					unsigned long type)
+{
+	resource_size_t align = 1, arch_align;
+
+	if (type & IORESOURCE_MEM)
+		align = 1024*1024;	/* 1MiB */
+	else if (type & IORESOURCE_IO)
+		align = 4*1024;		/* 4KiB */
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
index 9acea4b..34ff2bb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -988,6 +988,8 @@ int pci_cfg_space_size_ext(struct pci_dev *dev);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
+resource_size_t pcibios_window_alignment(struct pci_bus *bus,
+					 unsigned long type);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
-- 
1.7.5.4

