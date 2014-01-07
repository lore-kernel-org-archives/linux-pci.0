Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37575 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884AbaAGA4d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2014 19:56:33 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so19545500iec.41
        for <linux-pci@vger.kernel.org>; Mon, 06 Jan 2014 16:56:32 -0800 (PST)
Subject: [PATCH v7 11/15] agp/intel: Use CPU physical address,
 not bus address, for ioremap()
To: linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Airlie <airlied@linux.ie>, Yinghai Lu <yinghai@kernel.org>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Date: Mon, 06 Jan 2014 17:56:31 -0700
Message-ID: <20140107005630.10786.35580.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140107005003.10786.85164.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In i810_setup(), i830_setup(), and i9xx_setup(), we use the result of
pci_bus_address() as an argument to ioremap() and to compute gtt_phys_addr.
These should use pci_resource_start() instead because we want the CPU
physical address, not the bus address.

If there were an AGP device behind a host bridge that translated addresses,
e.g., a PNP0A08 device with _TRA != 0, this would fix a bug.  I'm not aware
of any of those, but they are possible.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/char/agp/intel-gtt.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index dd8b66a617dc..ad5da1ffcbe9 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -172,7 +172,7 @@ static void i8xx_destroy_pages(struct page *page)
 #define I810_GTT_ORDER 4
 static int i810_setup(void)
 {
-	u32 reg_addr;
+	phys_addr_t reg_addr;
 	char *gtt_table;
 
 	/* i81x does not preallocate the gtt. It's always 64kb in size. */
@@ -181,7 +181,7 @@ static int i810_setup(void)
 		return -ENOMEM;
 	intel_private.i81x_gtt_table = gtt_table;
 
-	reg_addr = pci_bus_address(intel_private.pcidev, I810_MMADR_BAR);
+	reg_addr = pci_resource_start(intel_private.pcidev, I810_MMADR_BAR);
 
 	intel_private.registers = ioremap(reg_addr, KB(64));
 	if (!intel_private.registers)
@@ -782,9 +782,9 @@ EXPORT_SYMBOL(intel_enable_gtt);
 
 static int i830_setup(void)
 {
-	u32 reg_addr;
+	phys_addr_t reg_addr;
 
-	reg_addr = pci_bus_address(intel_private.pcidev, I810_MMADR_BAR);
+	reg_addr = pci_resource_start(intel_private.pcidev, I810_MMADR_BAR);
 
 	intel_private.registers = ioremap(reg_addr, KB(64));
 	if (!intel_private.registers)
@@ -1102,10 +1102,10 @@ static void i965_write_entry(dma_addr_t addr,
 
 static int i9xx_setup(void)
 {
-	u32 reg_addr;
+	phys_addr_t reg_addr;
 	int size = KB(512);
 
-	reg_addr = pci_bus_address(intel_private.pcidev, I915_MMADR_BAR);
+	reg_addr = pci_resource_start(intel_private.pcidev, I915_MMADR_BAR);
 
 	intel_private.registers = ioremap(reg_addr, size);
 	if (!intel_private.registers)
@@ -1114,7 +1114,7 @@ static int i9xx_setup(void)
 	switch (INTEL_GTT_GEN) {
 	case 3:
 		intel_private.gtt_phys_addr =
-			pci_bus_address(intel_private.pcidev, I915_PTE_BAR);
+			pci_resource_start(intel_private.pcidev, I915_PTE_BAR);
 		break;
 	case 5:
 		intel_private.gtt_phys_addr = reg_addr + MB(2);

