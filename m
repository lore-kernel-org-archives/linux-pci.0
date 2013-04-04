Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55372 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764511Ab3DDTTd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Apr 2013 15:19:33 -0400
Date: Thu, 4 Apr 2013 12:19:33 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Huang Ying <ying.huang@intel.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup
 notifications
Message-ID: <20130404191933.GC15489@xanatos>
References: <51548C9E.9090703@fold.natur.cuni.cz>
 <2990024.LMTIBUbM3d@vostro.rjw.lan>
 <51564804.9000700@fold.natur.cuni.cz>
 <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com>
 <515AF312.1010507@fold.natur.cuni.cz>
 <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com>
 <515B17D9.6030805@fold.natur.cuni.cz>
 <515B45A6.1020404@fold.natur.cuni.cz>
 <515C1DB8.5020905@fold.natur.cuni.cz>
 <1365075019.8901.9.camel@yhuang-mobile.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365075019.8901.9.camel@yhuang-mobile.sh.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 04, 2013 at 07:30:19PM +0800, Huang Ying wrote:
> Hi, Martin,
> 
> On Wed, 2013-04-03 at 14:16 +0200, Martin Mokrejs wrote:
> > >> 2) xHCI dead due to to its suspend - 3.8 series and above
> > > 
> > > Not fixed by port_dbg.patch applied over 3.8.5. Interestingly, a NEC-based
> > > XHCI card *in an express card slot* does not suffer this suspend issue.
> > > Although it is being put into suspend if a device is unplugged.
> > 
> > 20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_xHCI_test_TI-based
> > 20130402/3.8.5-ying_port-dbg__with_laptop-mode-tools_xHCI_test_NEC-based
> > 
> > Same thing but yet without the port_dbg.patch:
> > 20130402/3.9-rc5__with_2368081__with-latop-mode-tools_xhci_testing/
> 
> It appears that TI xHCI dead port issue will present even if the PCIe
> port will never go suspended.  So I think this bug is not related to
> PCIe port runtime PM but related to USB xHCI.
> 
> Do you agree Sarah?

No.  The symptoms he described (in another email) were that the port
only becomes "dead" after a USB 2.0 device is removed, and the host was
suspended.  The issue was that the TI host is simply not reporting the
USB device connect, even if it is manually resumed.  The port status
registers do not show a device connect at all.

Martin, can you confirm this by trying this, and sending me dmesg of the
test with CONFIG_USB_DEBUG and CONFIG_USB_XHCI_HCD_DEBUGGING turned on:

1. Remove the laptop mode tools
2. Reboot with no USB devices attached to the TI host
3. Make sure the xHCI PCI device's power/control file is set to 'on'
   You will find that file in /sys/bus/pci/devices/.  Use lspci to
   figure out which directory is the xHCI PCI device.
4. Plug in a USB 2.0 device and make sure it works (e.g. wiggle a
   mouse)
5. Unplug the device, replug it, and check to see if it works.

If you have problems, stop here.  Otherwise try:

6. Unplug all USB devices
7. echo 'auto' to the xHCI PCI device's power/control file in
8. echo 'auto' to both xHCI roothubs in /sys/bus/usb/devices/
   (i.e. all usbN directories)
9. Wait a few seconds or so until the xHCI PCI host suspends, meaning the
   power/runtime_status file reads as 'suspended'
10. Plug in the same USB 2.0 device, and check if it works.
11. Unplug the device, and wait until the PCI host is suspended.
12. Replug the device, and check to see if it works.

Sarah Sharp
