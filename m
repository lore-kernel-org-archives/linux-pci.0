Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foo.masarand.uk ([104.200.29.153]:36191 "EHLO foo.masarand.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbbJWFFo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:05:44 -0400
From: Matthew Minter <matt@masarand.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com
Cc: Matthew Minter <matt@masarand.com>
Subject: [PATCH V4 01/29] PCI: Build setup-irq.o on all arches
Date: Fri, 23 Oct 2015 06:03:34 +0100
Message-Id: <1445576642-29624-2-git-send-email-matt@masarand.com>
In-Reply-To: <1445576642-29624-1-git-send-email-matt@masarand.com>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The functions included in setup-irq.o currently apply only to a selection
of architectures which share common IRQ assignment code. However this
code needs to be generalised for all arches to allow deferred IRQ
assignment. So the first step is to build it on all architectures.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/Makefile | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index be3f631..8417f55 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,7 +4,8 @@
 
 obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
-			irq.o vpd.o setup-bus.o vc.o
+			irq.o vpd.o setup-bus.o vc.o setup-irq.o
+
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSFS) += slot.o
 
@@ -29,19 +30,6 @@ obj-$(CONFIG_PCI_ATS) += ats.o
 obj-$(CONFIG_PCI_IOV) += iov.o
 
 #
-# Some architectures use the generic PCI setup functions
-#
-obj-$(CONFIG_ALPHA) += setup-irq.o
-obj-$(CONFIG_ARM) += setup-irq.o
-obj-$(CONFIG_ARM64) += setup-irq.o
-obj-$(CONFIG_UNICORE32) += setup-irq.o
-obj-$(CONFIG_SUPERH) += setup-irq.o
-obj-$(CONFIG_MIPS) += setup-irq.o
-obj-$(CONFIG_TILE) += setup-irq.o
-obj-$(CONFIG_SPARC_LEON) += setup-irq.o
-obj-$(CONFIG_M68K) += setup-irq.o
-
-#
 # ACPI Related PCI FW Functions
 # ACPI _DSM provided firmware instance and string name
 #
-- 
2.6.2

