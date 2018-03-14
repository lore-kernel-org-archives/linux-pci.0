Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeCNNan (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 09:30:43 -0400
Subject: [PATCH v2 2/2] PCI: Report quirks that take more than 10ms
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>,
        Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Andreas Noever <andreas.noever@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 08:30:40 -0500
Message-ID: <152103424057.167541.9559805983145916469.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152103417018.167541.3290752859388672112.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152103417018.167541.3290752859388672112.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

With "initcall_debug", we report how long every PCI quirk took.

Even without "initcall_debug", report the runtime of any quirk that takes
longer than 10ms.  This is to make it easier to notice quirks that slow
down boot.

This was motivated by a report from Paul Menzel that PCI final quirks took
half a second at boot.

Link: https://lkml.kernel.org/r/44cada166e42007d27b4c3e3aa0744d7@molgen.mpg.de
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 97c74e386bcc..1466ee729e0a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3002,14 +3002,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
 static ktime_t fixup_debug_start(struct pci_dev *dev,
 				 void (*fn)(struct pci_dev *dev))
 {
-	ktime_t calltime = 0;
-
-	if (initcall_debug) {
+	if (initcall_debug)
 		pci_info(dev, "calling  %pF @ %i\n", fn, task_pid_nr(current));
-		calltime = ktime_get();
-	}
 
-	return calltime;
+	return ktime_get();
 }
 
 static void fixup_debug_report(struct pci_dev *dev, ktime_t calltime,
@@ -3018,12 +3014,11 @@ static void fixup_debug_report(struct pci_dev *dev, ktime_t calltime,
 	ktime_t delta, rettime;
 	unsigned long long duration;
 
-	if (initcall_debug) {
-		rettime = ktime_get();
-		delta = ktime_sub(rettime, calltime);
-		duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	if (initcall_debug || duration > 10000)
 		pci_info(dev, "%pF took %lld usecs\n", fn, duration);
-	}
 }
 
 /*
