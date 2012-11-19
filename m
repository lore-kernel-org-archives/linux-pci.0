Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41697 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab2KSSiF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2012 13:38:05 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 016/493] PCI: always build setup-bus when PCI is enabled
Date: Mon, 19 Nov 2012 13:19:25 -0500
Message-Id: <1353349642-3677-16-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CONFIG_HOTPLUG is being removed so setup-bus always needs to be built
as part of PCI.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-pci@vger.kernel.org 
---
 drivers/pci/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 36f119d..0c3efcf 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,7 +4,7 @@
 
 obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
-			irq.o vpd.o
+			irq.o vpd.o setup-bus.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSFS) += slot.o
 
@@ -58,9 +58,6 @@ obj-$(CONFIG_ACPI)    += pci-acpi.o
 # SMBIOS provided firmware instance and labels
 obj-$(CONFIG_PCI_LABEL) += pci-label.o
 
-# Cardbus & CompactPCI use setup-bus
-obj-$(CONFIG_HOTPLUG) += setup-bus.o
-
 obj-$(CONFIG_PCI_SYSCALL) += syscall.o
 
 obj-$(CONFIG_PCI_STUB) += pci-stub.o
-- 
1.8.0

