Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34899 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970AbaKSVWc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Nov 2014 16:22:32 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so1703498igd.13
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2014 13:22:32 -0800 (PST)
Date: Wed, 19 Nov 2014 14:22:29 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Kevin Hilman <khilman@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: Regression caused by "PCI: Shrink decoding-disabled window while
 sizing BARs"
Message-ID: <20141119212229.GD23467@google.com>
References: <20141118105542.457d7863@free-electrons.com>
 <20141118105843.3c1651d5@free-electrons.com>
 <20141118123402.7318ec94@free-electrons.com>
 <CAErSpo4k57tdqbEYYcqEiviwoR0LCMUszECumpeL6w80xDeVfg@mail.gmail.com>
 <CAE9FiQX0JO40EE=D88EYGwm2uRjnrX5+McTuofW6QLbS5nLMSw@mail.gmail.com>
 <20141118220000.3ab0d2d9@free-electrons.com>
 <CAE9FiQXo3ctdFk2Z+duaq1wxSAVCA0tG5_f85-UaLk8+Dafhvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXo3ctdFk2Z+duaq1wxSAVCA0tG5_f85-UaLk8+Dafhvg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 18, 2014 at 02:36:17PM -0800, Yinghai Lu wrote:
> On Tue, Nov 18, 2014 at 1:00 PM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Is a u64 cast really the appropriate solution here? Have you seen my
> > proposed fix "[PATCH] PCI: fix probe.c warning
> > on !CONFIG_ARCH_DMA_ADDR_T_64BIT platforms" ?
> 
> Yes, that I saw your patch.
> 
> We want to make that to be consistent with __pci_read_bases()
> and avoid MACRO.
> 
> I think the warning is wrong. aka compile should omit out that branch.
> as sizeof(dma_addr_t) on !CONFIG_ARCH_DMA_ADDR_T_64BIT
> is 4 and it is smaller than 8. and those are const, so the compiler should
> not ...
> 
> add the cast just shut off the compiler wrong warning.
> 
> code segment:
> 
>                         if (sizeof(dma_addr_t) < 8) {
>                                 if (mem_base_hi || mem_limit_hi) {
>                                         dev_err(&dev->dev, "can't
> handle 64-bit address space for bridge\n");
>                                         return;
>                                 }
>                         } else  {
>                                 base |= (dma_addr_t)(((u64)mem_base_hi)<<32);
>                                 limit |= (dma_addr_t)(((u64)mem_limit_hi)<<32);
>                         }
> 
> 

I propose the following third alternative, which always computes full
64-bit base/limit, then casts them to the dma_addr_t size and compares to
see if anything got chopped off.

This is on top of pci/for-linus.  Whatever we settle on, I'll fold it into
the original patch before asking Linus to pull it.

Bjorn


diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1c5b1ca53bcd..c8ca98c2b480 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -407,6 +407,7 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 {
 	struct pci_dev *dev = child->self;
 	u16 mem_base_lo, mem_limit_lo;
+	u64 base64, limit64;
 	dma_addr_t base, limit;
 	struct pci_bus_region region;
 	struct resource *res;
@@ -414,8 +415,8 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
 	res = child->resource[2];
 	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
-	base = ((dma_addr_t) mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
-	limit = ((dma_addr_t) mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
+	base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
+	limit64 = (mem_limit_lo & PCI_PREF_RANGE_MASK) << 16;
 
 	if ((mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) == PCI_PREF_RANGE_TYPE_64) {
 		u32 mem_base_hi, mem_limit_hi;
@@ -429,17 +430,20 @@ static void pci_read_bridge_mmio_pref(struct pci_bus *child)
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
-			}
+			base64 |= (u64) mem_base_hi << 32;
+			limit64 |= (u64) mem_limit_hi << 32;
 		}
 	}
+
+	base = (dma_addr_t) base64;
+	limit = (dma_addr_t) limit64;
+
+	if (base != base64) {
+		dev_err(&dev->dev, "can't handle bridge window above 4GB (bus address %#010llx)\n",
+			(unsigned long long) base64);
+		return;
+	}
+
 	if (base <= limit) {
 		res->flags = (mem_base_lo & PCI_PREF_RANGE_TYPE_MASK) |
 					 IORESOURCE_MEM | IORESOURCE_PREFETCH;
