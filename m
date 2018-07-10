Return-Path: <SRS0=Mh2n=J2=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=Mh2n=J2=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Linux PM <linux-pm@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] driver core: Partially revert "driver core: correct device's shutdown order"
Date: Tue, 10 Jul 2018 13:35:41 +0200
Message-ID: <2927655.Y1qg3UnIrE@aspire.rjw.lan>
In-Reply-To: <8816662.k3KXbdkA2e@aspire.rjw.lan>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com> <8816662.k3KXbdkA2e@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 52cdbdd49853 (driver core: correct device's shutdown order)
introduced a regression by breaking device shutdown on some systems.

Namely, the devices_kset_move_last() call in really_probe() added by
that commit is a mistake as it may cause parents to follow children
in the devices_kset list which then causes shutdown to fail.  For
example, if a device has children before really_probe() is called
for it (which is not uncommon), that call will cause it to be
reordered after the children in the devices_kset list and the
ordering of that list will not reflect the correct device shutdown
order any more.

Also it causes the devices_kset list to be constantly reordered
until all drivers have been probed which is totally pointless
overhead in the majority of cases and it only covers an issue
with system shutdown, while system-wide suspend/resume potentially
has the same issue on the affected platforms (which is not covered).

For that reason, revert the really_probe() modifications made by
commit 52cdbdd49853 which unfortunately will expose the shutdown
issue the problematic commit attempted to fix (and which will have
to be addressed differently and correctly in the future).

The other code changes made by commit 52cdbdd49853 are useful and
they need not be reverted.

Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
Reported-by: Pingfan Liu <kernelfans@gmail.com>
Tested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a v2 of https://patchwork.kernel.org/patch/10511241/ under
a different subject.

The patch itself hasn't changed, but I rewrote the changelog (as per
the Bjorn's request) and changed the subject accordingly.

---
 drivers/base/dd.c |    8 --------
 1 file changed, 8 deletions(-)

Index: linux-pm/drivers/base/dd.c
===================================================================
--- linux-pm.orig/drivers/base/dd.c
+++ linux-pm/drivers/base/dd.c
@@ -434,14 +434,6 @@ re_probe:
 			goto probe_failed;
 	}
 
-	/*
-	 * Ensure devices are listed in devices_kset in correct order
-	 * It's important to move Dev to the end of devices_kset before
-	 * calling .probe, because it could be recursive and parent Dev
-	 * should always go first
-	 */
-	devices_kset_move_last(dev);
-
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
 		if (ret)
