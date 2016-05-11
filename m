Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43488 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbcEKTHB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 May 2016 15:07:01 -0400
Subject: [PATCH] tracing: Expose CPU physical addresses (resource values)
 for PCI devices
To: Steven Rostedt <rostedt@goodmis.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, karol herbst <karolherbst@gmail.com>,
	linux-kernel@vger.kernel.org, Pekka Paalanen <ppaalanen@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Yinghai Lu <yinghai@kernel.org>, koriakin@0x04.net
Date: Wed, 11 May 2016 14:06:57 -0500
Message-ID: <20160511190657.5898.4248.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously, mmio_print_pcidev() put "user" addresses in the trace buffer.
On most architectures, these are the same as CPU physical addresses, but on
microblaze, mips, powerpc, and sparc, they may be something else, typically
a raw BAR value (a bus address as opposed to a CPU address).

Always expose the CPU physical address to avoid this arch-dependent
behavior.

This change should have no user-visible effect because this file currently
depends on CONFIG_HAVE_MMIOTRACE_SUPPORT, which is only defined for x86,
and pci_resource_to_user() is a no-op on x86.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 kernel/trace/trace_mmiotrace.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 68f376c..cd7480d 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -68,19 +68,15 @@ static void mmio_print_pcidev(struct trace_seq *s, const struct pci_dev *dev)
 	trace_seq_printf(s, "PCIDEV %02x%02x %04x%04x %x",
 			 dev->bus->number, dev->devfn,
 			 dev->vendor, dev->device, dev->irq);
-	/*
-	 * XXX: is pci_resource_to_user() appropriate, since we are
-	 * supposed to interpret the __ioremap() phys_addr argument based on
-	 * these printed values?
-	 */
 	for (i = 0; i < 7; i++) {
-		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
+		start = dev->resource[i].start;
 		trace_seq_printf(s, " %llx",
 			(unsigned long long)(start |
 			(dev->resource[i].flags & PCI_REGION_FLAG_MASK)));
 	}
 	for (i = 0; i < 7; i++) {
-		pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
+		start = dev->resource[i].start;
+		end = dev->resource[i].end;
 		trace_seq_printf(s, " %llx",
 			dev->resource[i].start < dev->resource[i].end ?
 			(unsigned long long)(end - start) + 1 : 0);

