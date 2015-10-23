Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36197 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbbJWFFp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:45 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 03/29] PCI: Add IRQ mapping function pointers to pci_host_bridge struct
Date: Fri, 23 Oct 2015 06:03:36 +0100
Message-Id: <1445576642-29624-4-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to defer IRQ assignment arches must be able to register functions
to map and swizzle interrupts. These registered functions are stored in
the pci_host_bridge struct.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22..f1bae1d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -409,6 +409,8 @@ struct pci_host_bridge {
 	struct device dev;
 	struct pci_bus *bus;		/* root bus */
 	struct list_head windows;	/* resource_entry */
+	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* platform irq swizzler */
+	int (*map_irq)(struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
-- 
2.6.2

