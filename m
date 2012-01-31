Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45752 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab2AaEuc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2012 23:50:32 -0500
Date: Mon, 30 Jan 2012 20:52:07 -0800
From: Arjan van de Ven <arjan@infradead.org>
To: linux-pci@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, arjanvandeven@gmail.com
Subject: pci: Annotate PCI quirks in initcall_debug style
Message-ID: <20120130205207.41636a23@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From 77fcc610189853f9c8cf35f77bb8bcfc68833202 Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Mon, 30 Jan 2012 20:30:03 -0800
Subject: [PATCH] pci: Annotate PCI quirks in initcall_debug style

While diagnosing some boot time issues on a platform, all that I
could see in the bootgraph/dmesg was that the system was spending
a lot of time in applying one or more PCI quirks... which
was virtually undebuggable.

This patch adds printk's in "initcall_debug" style to the dmesg,
which are added when the user asks for the initcall_debug
(the nr one tool to use when debugging boot hangs or boot time issues)
kernel command line option.

CC: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: linux-pci@vger.kernel.org

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/pci/quirks.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6476547..b3afa1c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2906,6 +2906,22 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f8, quirk_intel_mc_errata);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f9, quirk_intel_mc_errata);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65fa, quirk_intel_mc_errata);
 
+
+static void do_one_fixup_debug(void (*fn)(struct pci_dev *dev), struct pci_dev *dev)
+{
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+
+	printk(KERN_DEBUG "calling  %pF @ %i\n", fn, task_pid_nr(current));
+	calltime = ktime_get();
+	fn(dev);
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	printk(KERN_DEBUG "pci fixup %pF returned after %lld usecs\n", fn,
+		duration);
+}
+
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 			  struct pci_fixup *end)
 {
@@ -2913,7 +2929,10 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 		if ((f->vendor == dev->vendor || f->vendor == (u16) PCI_ANY_ID) &&
 		    (f->device == dev->device || f->device == (u16) PCI_ANY_ID)) {
 			dev_dbg(&dev->dev, "calling %pF\n", f->hook);
-			f->hook(dev);
+			if (initcall_debug)
+				do_one_fixup_debug(f->hook, dev);
+			else
+				f->hook(dev);
 		}
 		f++;
 	}
-- 
1.7.6.4



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
