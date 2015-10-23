Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36199 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbbJWFFq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:46 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 04/29] PCI: Remove const from the pci_dev struct passed to pci_fixup_irqs
Date: Fri, 23 Oct 2015 06:03:37 +0100
Message-Id: <1445576642-29624-5-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The pci_fixup_irqs function currently gets passed a const struct pci_dev *.
This is fine for the current implementation which never modifies the pci_dev
however the deferred IRQ assignment version may have to modify this pci_dev
on some architectures so the const is no longer correct.

Therefore we remove it, fortunately no users currently seem to rely on it
being a const so no changes to callers are needed.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/setup-irq.c | 2 +-
 include/linux/pci.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index 95c225b..c7d9f26 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -58,7 +58,7 @@ static void pdev_fixup_irq(struct pci_dev *dev,
 }
 
 void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
-		    int (*map_irq)(const struct pci_dev *, u8, u8))
+		    int (*map_irq)(struct pci_dev *, u8, u8))
 {
 	struct pci_dev *dev = NULL;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f1bae1d..1073f27 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1121,7 +1121,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
 void pdev_enable_device(struct pci_dev *);
 int pci_enable_resources(struct pci_dev *, int mask);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
-		    int (*)(const struct pci_dev *, u8, u8));
+		    int (*)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2
 int __must_check pci_request_regions(struct pci_dev *, const char *);
 int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
-- 
2.6.2

