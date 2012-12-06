Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63800 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754421Ab2LFHRS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 6 Dec 2012 02:17:18 -0500
Message-ID: <1354778234.7216.9.camel@yhuang-dev>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
From: Huang Ying <ying.huang@intel.com>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Ulrich Eckhardt <usb@uli-eckhardt.de>,
	Andrew Lutomirski <luto@mit.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <ming.lei@canonical.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Thu, 06 Dec 2012 15:17:14 +0800
In-Reply-To: <20121206003344.GC5324@xanatos>
References: <20121126191002.GE6504@xanatos> <87boekave4.fsf@nemi.mork.no>
	 <20121128225406.GF8557@xanatos> <20121206003344.GC5324@xanatos>
Content-Type: multipart/mixed; boundary="=-JvUShE9OCoUdRr/59l/m"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-JvUShE9OCoUdRr/59l/m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2012-12-05 at 16:33 -0800, Sarah Sharp wrote:
> On Wed, Nov 28, 2012 at 02:54:06PM -0800, Sarah Sharp wrote:
> > On Mon, Nov 26, 2012 at 10:48:03PM +0100, Bjørn Mork wrote:
> > > Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> > > 
> > > > It looks like both Ulrich and Andrew have the same issue.  I also have a
> > > > Lenovo x220, and I confirmed that when I turn on PCI runtime suspend,
> > > > the NEC host controller does not report port status changes when a new
> > > > USB device is plugged in.
> > > >
> > > > I'm running 3.6.7, and I'm pretty sure that runtime suspend worked for
> > > > the NEC host on some older kernel.  I don't think the NEC host went into
> > > > D3cold on that kernel, though.  Is there a way to disable D3cold and
> > > > just use D3hot instead?
> > > 
> > > Yes, you have /sys/bus/pci/devices/.../d3cold_allowed
> > > See Documentation/ABI/testing/sysfs-bus-pci
> > > 
> > > If this really is a problem with the D3cold support that went into 3.6
> > > then I guess you should include Huang Ying in the discussions as well
> > > (CCed).
> > 
> > Turning off D3 cold didn't help.  Once the PCI device is suspended,
> > connect events do not generate an interrupt.
> > 
> > I'll go see if I can figure out which kernel this worked on and bisect.
> 
> Wakeup from D3 works fine on the 3.5.0 kernel, but fails on 3.6.2.  I
> haven't fully bisected yet.
> 
> In debugging, I found that if you only enable runtime suspend for the
> NEC host controller, the host successfully comes out of D3 when you plug
> in a USB device.  However, if you enable runtime PM for the parent PCIe root
> port, it stops working.  Disabling D3cold for both devices did not help.
> 
> It looks like a PCI issue, so what sort of debugging info do you need
> from me?

I do some debug with my NEC uPD720200, the patch is attached.  I found
that NEC uPD720200 can not generate PME interrupt, so it can be remote
waken up only via polling.  But if the PCIe bridge connected to NEC
uPD720200 goes into suspended, we can not poll it.  Maybe we need a way
to disable PCIe bridge suspended if the underlying device can only be
waken up via polling.

Best Regards,
Huang Ying


--=-JvUShE9OCoUdRr/59l/m
Content-Disposition: attachment; filename="dbg_poll.patch"
Content-Type: text/x-patch; name="dbg_poll.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Index: linux.git/drivers/pci/pci.c
===================================================================
--- linux.git.orig/drivers/pci/pci.c	2012-12-06 10:57:31.485231614 +0800
+++ linux.git/drivers/pci/pci.c	2012-12-06 10:57:31.541230913 +0800
@@ -1473,12 +1473,15 @@
 		dev->pme_poll = false;
 
 	if (pci_check_pme_status(dev)) {
+		if (pme_poll_reset)
+			dev_info(&dev->dev, "pme wakeup\n");
+		else
+			dev_info(&dev->dev, "poll wakeup\n");
 		pci_wakeup_event(dev);
 		pm_request_resume(&dev->dev);
 	}
 	return 0;
 }
-
 /**
  * pci_pme_wakeup_bus - Walk given bus and wake up devices on it, if necessary.
  * @bus: Top bus of the subtree to walk.
Index: linux.git/drivers/pci/pci-acpi.c
===================================================================
--- linux.git.orig/drivers/pci/pci-acpi.c	2012-12-06 10:57:31.485231614 +0800
+++ linux.git/drivers/pci/pci-acpi.c	2012-12-06 10:57:31.542230901 +0800
@@ -56,6 +56,7 @@
 
 	if (!pci_dev->pm_cap || !pci_dev->pme_support
 	     || pci_check_pme_status(pci_dev)) {
+		dev_info(&pci_dev->dev, "pme wakeup\n");
 		if (pci_dev->pme_poll)
 			pci_dev->pme_poll = false;
 
Index: linux.git/drivers/pci/pcie/pme.c
===================================================================
--- linux.git.orig/drivers/pci/pcie/pme.c	2012-12-06 10:57:31.485231614 +0800
+++ linux.git/drivers/pci/pcie/pme.c	2012-12-06 10:57:31.542230901 +0800
@@ -79,6 +79,7 @@
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Skip PCIe devices in case we started from a root port. */
 		if (!pci_is_pcie(dev) && pci_check_pme_status(dev)) {
+			dev_info(&dev->dev, "pme wakeup\n");
 			if (dev->pme_poll)
 				dev->pme_poll = false;
 
@@ -144,6 +145,7 @@
 			port->pme_poll = false;
 
 		if (pci_check_pme_status(port)) {
+			dev_info(&dev->dev, "pme wakeup\n");
 			pm_request_resume(&port->dev);
 			found = true;
 		} else {
@@ -188,6 +190,7 @@
 		/* The device is there, but we have to check its PME status. */
 		found = pci_check_pme_status(dev);
 		if (found) {
+			dev_info(&dev->dev, "pme wakeup\n");
 			if (dev->pme_poll)
 				dev->pme_poll = false;
 

--=-JvUShE9OCoUdRr/59l/m--

