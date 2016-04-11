Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35076 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbcDKX3i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 19:29:38 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Daney <david.daney@cavium.com>
Subject: [PATCH] pci, pci-thunder-pem: Don't clobber read-only bits in bridge config registers.
Date: Mon, 11 Apr 2016 16:29:32 -0700
Message-Id: <1460417372-13147-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

The 32-bit addressing modes in the I/O and Prefetchable Memory
registers are required to be read-only.  Since the underlying access
method allows them to be set, we must emulate their read-only nature
and always set them.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/host/pci-thunder-pem.c | 42 ++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index cabb92a..196adf6 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -153,11 +153,11 @@ static int thunder_pem_config_read(struct pci_bus *bus, unsigned int devfn,
  * reserved bits, this makes the code simpler and is OK as the bits
  * are not affected by writing zeros to them.
  */
-static u32 thunder_pem_bridge_w1c_bits(int where)
+static u32 thunder_pem_bridge_w1c_bits(u64 where_aligned)
 {
 	u32 w1c_bits = 0;
 
-	switch (where & ~3) {
+	switch (where_aligned) {
 	case 0x04: /* Command/Status */
 	case 0x1c: /* Base and I/O Limit/Secondary Status */
 		w1c_bits = 0xff000000;
@@ -184,12 +184,34 @@ static u32 thunder_pem_bridge_w1c_bits(int where)
 	return w1c_bits;
 }
 
+/* Some bits must be written to one so they appear to be read-only. */
+static u32 thunder_pem_bridge_w1_bits(u64 where_aligned)
+{
+	u32 w1_bits;
+
+	switch (where_aligned) {
+	case 0x1c: /* I/O Base / I/O Limit, Secondary Status*/
+		/* Force 32-bit I/O addressing. */
+		w1_bits = 0x0101;
+		break;
+	case 0x24: /* Prefetchable Memory Base / Prefetchable Memory Limit */
+		/* Force 64-bit addressing */
+		w1_bits = 0x00010001;
+		break;
+	default:
+		w1_bits = 0;
+		break;
+	}
+	return w1_bits;
+}
+
 static int thunder_pem_bridge_write(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 val)
 {
 	struct gen_pci *pci = bus->sysdata;
 	struct thunder_pem_pci *pem_pci;
 	u64 write_val, read_val;
+	u64 where_aligned = where & ~3ull;
 	u32 mask = 0;
 
 	pem_pci = container_of(pci, struct thunder_pem_pci, gen_pci);
@@ -205,8 +227,7 @@ static int thunder_pem_bridge_write(struct pci_bus *bus, unsigned int devfn,
 	 */
 	switch (size) {
 	case 1:
-		read_val = where & ~3ull;
-		writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
+		writeq(where_aligned, pem_pci->pem_reg_base + PEM_CFG_RD);
 		read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
 		read_val >>= 32;
 		mask = ~(0xff << (8 * (where & 3)));
@@ -215,8 +236,7 @@ static int thunder_pem_bridge_write(struct pci_bus *bus, unsigned int devfn,
 		val |= (u32)read_val;
 		break;
 	case 2:
-		read_val = where & ~3ull;
-		writeq(read_val, pem_pci->pem_reg_base + PEM_CFG_RD);
+		writeq(where_aligned, pem_pci->pem_reg_base + PEM_CFG_RD);
 		read_val = readq(pem_pci->pem_reg_base + PEM_CFG_RD);
 		read_val >>= 32;
 		mask = ~(0xffff << (8 * (where & 3)));
@@ -244,11 +264,17 @@ static int thunder_pem_bridge_write(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	/*
+	 * Some bits must be read-only with value of one.  Since the
+	 * access method allows these to be cleared if a zero is
+	 * written, force them to one before writing.
+	 */
+	val |= thunder_pem_bridge_w1_bits(where_aligned);
+
+	/*
 	 * Low order bits are the config address, the high order 32
 	 * bits are the data to be written.
 	 */
-	write_val = where & ~3ull;
-	write_val |= (((u64)val) << 32);
+	write_val = (((u64)val) << 32) | where_aligned;
 	writeq(write_val, pem_pci->pem_reg_base + PEM_CFG_WR);
 	return PCIBIOS_SUCCESSFUL;
 }
-- 
1.8.3.1

