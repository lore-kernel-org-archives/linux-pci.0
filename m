Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdL1V1d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Dec 2017 16:27:33 -0500
Date: Thu, 28 Dec 2017 15:27:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: `pci_apply_final_quirks()` taking half a second
Message-ID: <20171228212723.GB211339@bhelgaas-glaptop.roam.corp.google.com>
References: <44cada166e42007d27b4c3e3aa0744d7@molgen.mpg.de>
 <20170408154128.GA16832@bhelgaas-glaptop.roam.corp.google.com>
 <c3a7c75b-c50e-1cde-7bb1-94df5dc51f08@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <c3a7c75b-c50e-1cde-7bb1-94df5dc51f08@molgen.mpg.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 26, 2017 at 04:55:20PM +0100, Paul Menzel wrote:
> Am 08.04.2017 um 17:41 schrieb Bjorn Helgaas:
> >On Fri, Apr 07, 2017 at 11:07:15PM +0200, Paul Menzel wrote:
> 
> >>Measuring where time is spent during boot with `systemd-bootchart`
> >>on an Asus A780FullHD, it turns out that half a second is spent in
> >>`pci_apply_final_quirks()`.
> >
> >I agree, that seems like a crazy amount of time.
> >
> >Can you figure out how to turn on pr_debug() (via the dynamic debug
> >mess or whatever) and boot with "initcall_debug"?  That should tell us
> >how long each quirk took.
> 
> I am sorry for taking so long to reply. I finally added `dyndbg=file
> quirks.c +p` to the command line of Linux 4.13.13. This is on
> another AMD system (Asus F285M Pro).
> 
> ```
> […]
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for
> 0000:00:00.0
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_no_pm_reset+0x0/0x20 returned after 0 usecs for 0000:00:01.0
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for
> 0000:00:18.0
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for
> 0000:00:18.1
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for
> 0000:00:18.2
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for
> 0000:00:18.3
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for
> 0000:00:18.4
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_mmio_always_on+0x0/0x10 returned after 0 usecs for
> 0000:00:18.5
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> pci_fixup_video+0x0/0x110 returned after 4 usecs for 0000:00:01.0
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_usb_early_handoff+0x0/0x6b0 returned after 197 usecs for
> 0000:00:10.0
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_usb_early_handoff+0x0/0x6b0 returned after 127 usecs for
> 0000:00:10.1
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_usb_early_handoff+0x0/0x6b0 returned after 88643 usecs for
> 0000:00:12.0
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_usb_early_handoff+0x0/0x6b0 returned after 137 usecs for
> 0000:00:12.2
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> pci_fixup_amd_ehci_pme+0x0/0x30 returned after 1 usecs for
> 0000:00:12.2
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_usb_early_handoff+0x0/0x6b0 returned after 85770 usecs for
> 0000:00:13.0
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_usb_early_handoff+0x0/0x6b0 returned after 134 usecs for
> 0000:00:13.2
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> pci_fixup_amd_ehci_pme+0x0/0x30 returned after 1 usecs for
> 0000:00:13.2
> Dez 26 16:21:46 asus-f2a85-pro kernel: pci fixup
> quirk_usb_early_handoff+0x0/0x6b0 returned after 125 usecs for
> 0000:03:00.0[…]
> ```
> 
> So it’s `pci fixup quirk_usb_early_handoff` taking around 85 ms, and
> that twice.

Wow.  That's pretty painful, but of course I don't know how to fix it.
>From looking at quirk_usb_early_handoff(), it may depend on BIOS
details.  Maybe the USB folks will have some ideas.

>From the PCI perspective, we could do something like the following to
make slow quirks more noticeable and perhaps provide a little hint
that quirk performance is important.


commit a9eec698db04ccffa1fe43634752220a2fd2108d
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Dec 28 13:23:03 2017 -0600

    PCI: Report quirks that take more than 10ms
    
    When the "initcall_debug" kernel parameter is used, we report the runtime
    of each PCI quirk.  In addition, report the runtime of any quirk that takes
    more than 10ms to execute.  The purpose is to make it easier to notice
    quirks that slow down boot.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index fd49b976973f..96008ff78a1a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3105,16 +3105,12 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
 static ktime_t fixup_debug_start(struct pci_dev *dev,
 				 void (*fn)(struct pci_dev *dev))
 {
-	ktime_t calltime = 0;
-
-	dev_dbg(&dev->dev, "calling %pF\n", fn);
 	if (initcall_debug) {
-		pr_debug("calling  %pF @ %i for %s\n",
-			 fn, task_pid_nr(current), dev_name(&dev->dev));
-		calltime = ktime_get();
+		dev_info(&dev->dev, "calling %pF @ %i\n",
+			 fn, task_pid_nr(current));
 	}
 
-	return calltime;
+	return ktime_get();
 }
 
 static void fixup_debug_report(struct pci_dev *dev, ktime_t calltime,
@@ -3123,12 +3119,11 @@ static void fixup_debug_report(struct pci_dev *dev, ktime_t calltime,
 	ktime_t delta, rettime;
 	unsigned long long duration;
 
-	if (initcall_debug) {
-		rettime = ktime_get();
-		delta = ktime_sub(rettime, calltime);
-		duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-		pr_debug("pci fixup %pF returned after %lld usecs for %s\n",
-			 fn, duration, dev_name(&dev->dev));
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	if (initcall_debug || duration > 10000) {
+		dev_info(&dev->dev, "%pF took %lld usecs\n", fn, duration);
 	}
 }
 
