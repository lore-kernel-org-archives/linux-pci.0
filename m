Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58998 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754445AbaKROuL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 09:50:11 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] PCI: fix probe.c warning on !CONFIG_ARCH_DMA_ADDR_T_64BIT platforms
Date: Tue, 18 Nov 2014 15:45:27 +0100
Message-Id: <1416321927-29120-1-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <CAErSpo4k57tdqbEYYcqEiviwoR0LCMUszECumpeL6w80xDeVfg@mail.gmail.com>
References: <CAErSpo4k57tdqbEYYcqEiviwoR0LCMUszECumpeL6w80xDeVfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 3a02517d5e2a ("PCI: Support 64-bit bridge windows if we have
64-bit dma_addr_t") modified the pci_read_bridge_mmio_pref() function
to support 64 bits bridge windows if the dma_addr_t type if 64 bits.

However, even though it accounts for platforms where dma_addr_t is 32
bits, it introduced a compile-time warning on such platforms:

drivers/pci/probe.c: In function ‘pci_read_bridge_mmio_pref’:
drivers/pci/probe.c:430:5: warning: left shift count >= width of type
     base |= ((dma_addr_t) mem_base_hi) << 32;
     ^
drivers/pci/probe.c:431:5: warning: left shift count >= width of type
     limit |= ((dma_addr_t) mem_limit_hi) << 32;

This is due to the fact that the code that gets used on platforms
where dma_addr_t is 64 bits is also compiled on platforms where
dma_addr_t is 32 bits.

To solve this, this patch switches from using the runtime
'sizeof(dma_addr_t) < 8' test to a compile time test on
CONFIG_ARCH_DMA_ADDR_T_64BIT, which is the configuration option used
by <linux/types.h> to decide whether dma_addr_t is 32 bits or 64 bits.

Note that in the case mentionned in the commit log of 3a02517d5e2a,
i.e x86 32 bits with PAE enabled, CONFIG_ARCH_DMA_ADDR_T_64BIT is
enabled, because this option is enabled when either x86-64 is used, or
x86 with HIGHMEM64G.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Fixes: 3a02517d5e2a ("PCI: Support 64-bit bridge windows if we have 64-bit dma_addr_t")
---
Applies on top of pci/for-linus

 drivers/pci/probe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1c5b1ca..9de2994 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -429,15 +429,15 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 		 * this, just assume they are not being used.
 		 */
 		if (mem_base_hi <= mem_limit_hi) {
-			if (sizeof(dma_addr_t) < 8) {
-				if (mem_base_hi || mem_limit_hi) {
-					dev_err(&dev->dev, "can't handle 64-bit address space for bridge\n");
-					return;
-				}
-			} else  {
-				base |= ((dma_addr_t) mem_base_hi) << 32;
-				limit |= ((dma_addr_t) mem_limit_hi) << 32;
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+			base |= ((dma_addr_t) mem_base_hi) << 32;
+			limit |= ((dma_addr_t) mem_limit_hi) << 32;
+#else
+			if (mem_base_hi || mem_limit_hi) {
+				dev_err(&dev->dev, "can't handle 64-bit address space for bridge\n");
+				return;
 			}
+#endif
 		}
 	}
 	if (base <= limit) {
-- 
2.1.0

