Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43838 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755752Ab2K3V5K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Nov 2012 16:57:10 -0500
Date: Fri, 30 Nov 2012 16:57:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
cc: linux-usb@vger.kernel.org, <linux-pm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM/PCI D3 issue
In-Reply-To: <20121130213600.GA5056@xanatos>
Message-ID: <Pine.LNX.4.44L0.1211301650470.1362-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 30 Nov 2012, Sarah Sharp wrote:

> I've been trying to test D3 on the xHCI host controller for my Lenovo
> x230 laptop.  However, the host controller (and other PCI devices) never
> seem to go into D3.  This happens on a modified version of 3.7-rc6
> (Greg KH's usb-next branch plus a couple patches) and on 3.6.6.

Including Tianyu's stuff?

> I enable runtime PM for the PCI device:
> 
> root@xanatos:/sys/bus/pci/devices# echo auto > 0000:00:14.0/power/control
> root@xanatos:/sys/bus/pci/devices# cat 0000:00:14.0/power/control
> auto
> 
> Both the USB 2.0 and USB 3.0 bus children under the xHCI host controller
> are also set to auto runtime PM:
> 
> root@xanatos:/sys/bus/pci/devices# lsusb -t
> 3-1.6:1.0: No such file or directory
> 3-1.6:1.1: No such file or directory
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 480M
> root@xanatos:/sys/bus/pci/devices# cat /sys/bus/usb/devices/usb1/power/control
> auto
> root@xanatos:/sys/bus/pci/devices# cat /sys/bus/usb/devices/usb2/power/control
> auto
> 
> But dmesg never shows the bus or host being suspended.  The
> runtime_status remains active, and the runtime_suspended_time remains at
> zero.  There are no USB devices under the xHCI host, so I'm not sure why
> the host isn't being suspended.  Is there some new runtime PM sysfs file
> that I'm missing?

No.

The controller can't suspend until the root hub is suspended.  Did you 
check the various runtime status values for the root hub, its 
interface, and Tianyu's new port devices?

In Greg's usb-next branch, the port devices are disabled for runtime
PM.  But if you are testing Tianyu's new patches then they aren't.  
They could be preventing your root hubs from suspending.

Alan Stern

