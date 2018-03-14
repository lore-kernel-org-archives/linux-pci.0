Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeCNNag (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 09:30:36 -0400
Subject: [PATCH v2 1/2] PCI: Report quirk timings with pci_info() instead of
 pr_debug()
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>,
        Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Andreas Noever <andreas.noever@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Mar 2018 08:30:34 -0500
Message-ID: <152103423397.167541.13308871352418597826.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152103417018.167541.3290752859388672112.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152103417018.167541.3290752859388672112.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

With "initcall_debug", we report how long every PCI quirk took.  Previously
we used pr_debug(), which means you have to figure out how to enable debug
output.

Log these timings using pci_info() instead so it doesn't depend on DEBUG,
CONFIG_DYNAMIC_DEBUG, etc.

Also, don't log anything at all unless "initcall_debug" is specified.  This
matches what we do in do_one_initcall_debug().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ec280f2223b3..97c74e386bcc 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3004,10 +3004,8 @@ static ktime_t fixup_debug_start(struct pci_dev *dev,
 {
 	ktime_t calltime = 0;
 
-	pci_dbg(dev, "calling %pF\n", fn);
 	if (initcall_debug) {
-		pr_debug("calling  %pF @ %i for %s\n",
-			 fn, task_pid_nr(current), dev_name(&dev->dev));
+		pci_info(dev, "calling  %pF @ %i\n", fn, task_pid_nr(current));
 		calltime = ktime_get();
 	}
 
@@ -3024,8 +3022,7 @@ static void fixup_debug_report(struct pci_dev *dev, ktime_t calltime,
 		rettime = ktime_get();
 		delta = ktime_sub(rettime, calltime);
 		duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-		pr_debug("pci fixup %pF returned after %lld usecs for %s\n",
-			 fn, duration, dev_name(&dev->dev));
+		pci_info(dev, "%pF took %lld usecs\n", fn, duration);
 	}
 }
 
