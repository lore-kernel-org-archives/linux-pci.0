Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3129 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741Ab2GZIy2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Jul 2012 04:54:28 -0400
Message-ID: <1343292851.3874.12.camel@yhuang-dev>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB
 hotplug failure
From: Huang Ying <ying.huang@intel.com>
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 26 Jul 2012 16:54:11 +0800
In-Reply-To: <874now7xi8.fsf@nemi.mork.no>
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	 <87r4s0opck.fsf@nemi.mork.no> <87pq7ko532.fsf@nemi.mork.no>
	 <1343190864.10311.26.camel@yhuang-dev> <87k3xskvqq.fsf@nemi.mork.no>
	 <CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	 <874now7xi8.fsf@nemi.mork.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2012-07-25 at 15:58 +0200, Bjørn Mork wrote:
> huang ying <huang.ying.caritas@gmail.com> writes:
> 
> > Hi, Bjorn,
> >
> > Thank you very much for your detailed information.
> >
> > On Wed, Jul 25, 2012 at 5:58 PM, Bjørn Mork <bjorn@mork.no> wrote:
> >> Huang Ying <ying.huang@intel.com> writes:
> >>> On Wed, 2012-07-25 at 06:08 +0200, Bjørn Mork wrote:
> >>>> Enabling autosuspend for USB causes hotplug failure in the current
> >>>> linux-next. Newly plugged devices are not detected at all until the
> >>>> port/controller is manually powered on by writing "on" to power/control.
> >>>> Testing is pretty simple:
> >>>>
> >>>>   1) for f in /sys/bus/usb/devices/*/power/control; do echo auto > $f; done
> >>>
> >>> Have you done:
> >>>
> >>> for f in /sys/bus/pci/devices/*/power/confol; do echo auto > $f; done
> >>>
> >>> ?
> >>>
> >>> If not, the pci device will not be suspended at all.
> >>
> >> Yes, sorry for missing that.  I had it automatically enabled.  Yes,
> >> autosuspend for the PCI device and all child devices must be enabled for
> >> the device to be suspended at all, of course.
> >>
> >>>>   2) wait for the controllers to suspend
> >>>>   3) plugin a new USB device
> >>>
> >>> After plugin the new USB device, is there anything in dmesg?
> >>
> >> No. Absolutely nothing, so the USB devices is not enumerated.  Another
> >> indication of the same:  Plugging a device like an Android phone, which
> >> normally detects being connected to a host and presents a device type
> >> menu to the user, results in the charging LED lighting up but no menu.
> >>
> >>
> >> Trying to show the sequence of events:
> >>
> >> 1)  the controllers are suspended:
> >>
> >> Jul 25 11:27:12 nemi kernel: [   38.962792] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D2
> >> Jul 25 11:27:12 nemi kernel: [   39.006718] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D2
> >> Jul 25 11:27:15 nemi kernel: [   41.808471] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D2
> >> Jul 25 11:27:15 nemi kernel: [   41.824123] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D2
> >> Jul 25 11:27:15 nemi kernel: [   41.824194] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D2
> >
> > Here uhci controller is put into D2
> >
> > [snip]
> >>
> >> Doing the same with commit 448bd857d reverted:
> >>
> >>
> >> 1)  the controllers are suspended (to state D3? instead of D2?):
> >>
> >> Jul 25 11:34:01 nemi kernel: [   37.064955] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D3
> >> Jul 25 11:34:01 nemi kernel: [   37.106586] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D3
> >> Jul 25 11:34:04 nemi kernel: [   39.808329] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D3
> >> Jul 25 11:34:04 nemi kernel: [   39.840054] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D3
> >> Jul 25 11:34:04 nemi kernel: [   39.840068] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D3
> >
> > With commit reverted, the uhci_controller is put into D3 (ACPI D3cold).
> >
> > And the uhci controller on your system may not work properly under D2
> > state, while OK in D3 state, and the commit will make uhci controller
> > choose D2 instead of D3.
> >
> > Please try following command line before testing.
> >
> > for f in /sys/bus/pci/devices/*/d3cold_allowed; do echo 1 > $f; done
> 
> That made it work.  The USB controllers ended up in D4 though:
> 
> Jul 25 15:52:33 nemi kernel: [  152.753280] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D0
> Jul 25 15:52:33 nemi kernel: [  152.753453] uhci_hcd 0000:00:1a.0: setting latency timer to 64
> Jul 25 15:52:33 nemi kernel: [  152.753619] uhci_hcd 0000:00:1a.0: power state changed by ACPI to D4
> Jul 25 15:52:33 nemi kernel: [  152.753875] uhci_hcd 0000:00:1a.1: setting latency timer to 64
> Jul 25 15:52:33 nemi kernel: [  152.754153] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D0
> Jul 25 15:52:33 nemi kernel: [  152.754279] uhci_hcd 0000:00:1a.2: setting latency timer to 64
> Jul 25 15:52:33 nemi kernel: [  152.754432] uhci_hcd 0000:00:1a.2: power state changed by ACPI to D4
> Jul 25 15:52:33 nemi kernel: [  152.754668] ehci_hcd 0000:00:1a.7: setting latency timer to 64
> Jul 25 15:52:33 nemi kernel: [  152.768089] ehci_hcd 0000:00:1a.7: power state changed by ACPI to D4
> Jul 25 15:52:33 nemi kernel: [  152.768573] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
> Jul 25 15:52:33 nemi kernel: [  152.768726] uhci_hcd 0000:00:1d.0: setting latency timer to 64
> Jul 25 15:52:33 nemi kernel: [  152.768891] uhci_hcd 0000:00:1d.0: power state changed by ACPI to D4
> Jul 25 15:52:33 nemi kernel: [  152.769144] uhci_hcd 0000:00:1d.1: setting latency timer to 64
> Jul 25 15:52:33 nemi kernel: [  152.769530] uhci_hcd 0000:00:1d.2: setting latency timer to 64
> Jul 25 15:52:33 nemi kernel: [  152.769902] ehci_hcd 0000:00:1d.7: setting latency timer to 64
> Jul 25 15:52:33 nemi kernel: [  152.784189] ehci_hcd 0000:00:1d.7: power state changed by ACPI to D4
> 
> 
> was that expected?  Anyway, waking up the controller from this state by
> plugging a USB device works, so it's a perfectly OK workaround.  Is this
> something that could/should be implemented as a system specific quirk,
> or is the problem more generic?  Even if it is a ACPI implementation
> issue I would expect it to be common to a number of Lenovo laptops of
> the same generation as mine (~2008).
> 
> > And please provide the output of the following command line.
> >
> > acpidump
> 
> Attached.  Thanks a lot for all your help debugging this issue.

Do you have time to try the below patch?

Best Regards,
Huang Ying

Subject: [BUGFIX] PCI/PM: enable D3/D3cold by default for most devices

This patch fixes the following bug:

http://marc.info/?l=linux-usb&m=134318961120825&w=2

Originally, device lower power states include D1, D2, D3.  After that,
D3 is further divided into D3hot and D3cold.  To support both scenario
safely, original D3 is mapped to D3cold.

When adding D3cold support, because worry about some device may have
broken D3cold support, D3cold is disabled by default.  This disable D3
on original platform too.  But some original platform may only have
working D3, but no working D1, D2.  The root cause of the above bug is
it too.

To deal with this, this patch enables D3/D3cold by default for most
devices.  This restores the original behavior.  For some devices that
suspected to have broken D3cold support, such as PCIe port, D3cold is
disabled by default.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/pci/pci.c              |    1 +
 drivers/pci/pcie/portdrv_pci.c |    5 +++++
 2 files changed, 6 insertions(+)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1941,6 +1941,7 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = pm;
 	dev->d3_delay = PCI_PM_D3_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
+	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
 	dev->d2_support = false;
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -200,6 +200,11 @@ static int __devinit pcie_portdrv_probe(
 		return status;
 
 	pci_save_state(dev);
+	/*
+	 * D3cold may not work properly on some PCIe port, so disable
+	 * it by default.
+	 */
+	dev->d3cold_allowed = false;
 	if (!pci_match_id(port_runtime_pm_black_list, dev))
 		pm_runtime_put_noidle(&dev->dev);
 


