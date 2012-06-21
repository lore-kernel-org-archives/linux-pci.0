Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:47250 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab2FUAQu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 20:16:50 -0400
Received: by qcsp5 with SMTP id p5so9731qcs.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:49 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 5D16C1E0043
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:49 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 168DC180181
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:49 -0700 (PDT)
Subject: [PATCH 3/6] PCI: fix P2P bridge I/O port window sign extension
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 20 Jun 2012 18:16:49 -0600
Message-ID: <20120621001648.4834.85647.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
References: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On P2P bridges with 32-bit I/O decoding, we incorrectly sign-extended
windows starting at 0x80000000 or above.  In "base |= (io_base_hi << 16)",
"io_base_hi" is promoted to a signed int before being extended to an
unsigned long.

This would cause a window starting at I/O address 0x80000000 to be
treated as though it started at 0xffffffff80008000 instead, which
should cause "no compatible bridge window" errors when we enumerate
devices using that I/O space.

The mmio and mmio_pref casts are not strictly necessary, but without
them, correctness depends on the types of the PCI_MEMORY_RANGE_MASK and
PCI_PREF_RANGE_MASK constants, which are not obvious from reading the
local code.

Found by Coverity (CID 138747 and CID 138748).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 658ac97..a7a504f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -281,10 +281,11 @@ static void __devinit pci_read_bridge_io(struct pci_bus *child)
 
 	if ((io_base_lo & PCI_IO_RANGE_TYPE_MASK) == PCI_IO_RANGE_TYPE_32) {
 		u16 io_base_hi, io_limit_hi;
+
 		pci_read_config_word(dev, PCI_IO_BASE_UPPER16, &io_base_hi);
 		pci_read_config_word(dev, PCI_IO_LIMIT_UPPER16, &io_limit_hi);
-		base |= (io_base_hi << 16);
-		limit |= (io_limit_hi << 16);
+		base |= ((unsigned long) io_base_hi << 16);
+		limit |= ((unsigned long) io_limit_hi << 16);
 	}
 
 	if (base && base <= limit) {
@@ -312,8 +313,8 @@ static void __devinit pci_read_bridge_mmio(struct pci_bus *child)
 	res = child->resource[1];
 	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
-	base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
-	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
+	base = ((unsigned long) mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
+	limit = ((unsigned long) mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
 	if (base && base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		region.start = base;
@@ -334,11 +335,12 @@ static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
 	res = child->resource[2];
 	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
-	base = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
-	limit = (mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
+	base = ((unsigned long) mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
+	limit = ((unsigned long) mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
 
 	if ((mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
 		u32 mem_base_hi, mem_limit_hi;
+
 		pci_read_config_dword(dev, PCI_PREF_BASE_UPPER32, &mem_base_hi);
 		pci_read_config_dword(dev, PCI_PREF_LIMIT_UPPER32, &mem_limit_hi);
 
@@ -349,8 +351,8 @@ static void __devinit pci_read_bridge_mmio_pref(struct pci_bus *child)
 		 */
 		if (mem_base_hi <= mem_limit_hi) {
 #if BITS_PER_LONG == 64
-			base |= ((long) mem_base_hi) << 32;
-			limit |= ((long) mem_limit_hi) << 32;
+			base |= ((unsigned long) mem_base_hi) << 32;
+			limit |= ((unsigned long) mem_limit_hi) << 32;
 #else
 			if (mem_base_hi || mem_limit_hi) {
 				dev_err(&dev->dev, "can't handle 64-bit "

