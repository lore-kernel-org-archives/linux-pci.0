Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54018 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab2LLCcI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 11 Dec 2012 21:32:08 -0500
Message-ID: <1355279525.7216.154.camel@yhuang-dev>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
From: Huang Ying <ying.huang@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Andrew Lutomirski <luto@mit.edu>,
	Ulrich Eckhardt <usb@uli-eckhardt.de>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ming Lei <ming.lei@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Wed, 12 Dec 2012 10:32:05 +0800
In-Reply-To: <7766249.mqYLvmhmrJ@vostro.rjw.lan>
References: <20121126191002.GE6504@xanatos>
	 <1962497.aG1sFtYjJG@vostro.rjw.lan> <20121207002808.GG5324@xanatos>
	 <7766249.mqYLvmhmrJ@vostro.rjw.lan>
Content-Type: multipart/mixed; boundary="=-Mwt41YOrjNgzioppXz4P"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--=-Mwt41YOrjNgzioppXz4P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-12-07 at 22:00 +0100, Rafael J. Wysocki wrote:
> On Thursday, December 06, 2012 04:28:08 PM Sarah Sharp wrote:
> > On Thu, Dec 06, 2012 at 01:43:32AM +0100, Rafael J. Wysocki wrote:
> > > On Wednesday, December 05, 2012 04:33:44 PM Sarah Sharp wrote:
> > > > Wakeup from D3 works fine on the 3.5.0 kernel, but fails on 3.6.2.  I
> > > > haven't fully bisected yet.
> > > > 
> > > > In debugging, I found that if you only enable runtime suspend for the
> > > > NEC host controller, the host successfully comes out of D3 when you plug
> > > > in a USB device.  However, if you enable runtime PM for the parent PCIe root
> > > > port, it stops working.  Disabling D3cold for both devices did not help.
> > > > 
> > > > It looks like a PCI issue, so what sort of debugging info do you need
> > > > from me?
> > > 
> > > It looks like this is related to one of the following commits:
> > 
> > > Generally, please try to bisect changes in drivers/pci between v3.5 and v3.6.
> > 
> > Ok, I ran git bisect with only the drivers/pci directory as a target.
> > 
> > > ee85f54 ACPI/PM: specify lowest allowed state for device sleep state
> > 
> > git bisect ended up identifying this as the bad patch, although
> > reverting just that patch after the bisect finished didn't seem to help.
> > However, it does make sense that this would be the culprit patch, if
> > Huang Ying's theory about the PME polling is correct.
> 
> Well, we surely don't handle this particular case correctly, and it shouldn't
> be very difficult to fix, so let's hope that this is the culprit. :-)
> 

Please try the patch attached.  With it, USB host controller can be
waken up with USB card reader plugging in on my test machine.

Best Regards,
Huang Ying


--=-Mwt41YOrjNgzioppXz4P
Content-Disposition: attachment; filename="port_suspend_no_poll.patch"
Content-Type: text/x-patch; name="port_suspend_no_poll.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Subject: [BUGFIX] PCIe/PM: Do not suspend port if any subordinate device need PME polling

In

Ulrich reported that his USB3 cardreader does not work reliably when
connected to the USB3 port.  It turns out that USB3 controller failed
to be waken up when plugging in the USB3 cardreader.  Further
experiment found that the USB3 host controller can only be waken up
via polling, while not via PME interrupt.  But if the PCIe port the
USB3 host controller connected is suspended, we can not poll the USB3
host controller because its config space is not accessible if the PCIe
port is put into low power state.

To solve the issue, the PCIe port will not be suspended if any
subordinate device need PME polling.

Reported-by: Ulrich Eckhardt <usb@uli-eckhardt.de>
Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -134,10 +134,26 @@ static int pcie_port_runtime_resume(stru
 	return 0;
 }
 
+static int pci_dev_pme_poll(struct pci_dev *pdev, void *data)
+{
+	int *pme_poll = data;
+	*pme_poll = *pme_poll || pdev->pme_poll;
+	return 0;
+}
+
 static int pcie_port_runtime_idle(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int pme_poll = false;
+
+	/*
+	 * If any subordinate device needs pme poll, we should keep
+	 * the port in D0, because we need port in D0 to poll it.
+	 */
+	pci_walk_bus(pdev->subordinate, pci_dev_pme_poll, &pme_poll);
 	/* Delay for a short while to prevent too frequent suspend/resume */
-	pm_schedule_suspend(dev, 10);
+	if (!pme_poll)
+		pm_schedule_suspend(dev, 10);
 	return -EBUSY;
 }
 #else

--=-Mwt41YOrjNgzioppXz4P--

