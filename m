Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8572 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687Ab1LOAQi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 14 Dec 2011 19:16:38 -0500
Date: Wed, 14 Dec 2011 16:16:36 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Vick <weasalandme@yahoo.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: xhci errors when hotplugging a NEC uPD720200 USB hub.
Message-ID: <20111215001636.GA7840@xanatos>
References: <loom.20111214T205055-477@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20111214T205055-477@post.gmane.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 14, 2011 at 08:03:57PM +0000, Vick wrote:
> Hello,
> 
> I have a Sony Vaio VPC-Z series laptop that has an external dock connected via
> the new Light Peak/Thunderbolt interface. The dock and laptop have a NEC
> uPD720200 USB hub. lspci when dock is connected:
> 
> 04:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller 
> (rev 04)
> 1b:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller 
> (rev 04)

Woah, that's cool.  I've never seen a USB 3.0 host connected behind a
Lightpeak interface before.  I thought light peak was only available in
Macs.

> If I boot the laptop with the dock connected the hub in the dock works fine.
> I can connect devices and they all work. 
> If I connect the dock while the laptop is running the USB hub in the dock does
>  not work. The other devices in the dock (cdrom and network interface) work 
> just fine after connecting. I see the following errors in dmesg:
> 
> pci 0000:1b:00.0: [1033:0194] type 0 class 0x000c03
> pci 0000:1b:00.0: reg 10: [mem 0x00000000-0x00001fff 64bit]
> pci 0000:1b:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:1b:00.0: PME# disabled
> ...
> pci 0000:1b:00.0: BAR 0: can't assign mem (size 0x2000)
> ...
> xhci_hcd 0000:1b:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> xhci_hcd 0000:1b:00.0: PCI INT A disabled
> xhci_hcd 0000:1b:00.0: init 0000:1b:00.0 fail, -16
> xhci_hcd: probe of 0000:1b:00.0 failed with error -16
> 
> related to the 1b:00 device.
> I looked at the ACPI code for the laptop and it seems that the moment the dock
> is plugged in the devices in it are enabled and ready for use and judging by 
> the working ethernet and cdrom devices I would think that is true.
> 
> I'm running a Debian Sid with 3.1.0-1-amd64 kernel.
> 
> Any ideas what's wrong? Anything I can do to help fix it?

Can you compile a custom kernel with CONFIG_USB_XHCI_HCD_DEBUGGING and
CONFIG_USB_DEBUG turned on?  We need to figure out whether it's an issue
with the xHCI driver, or PCI hotplug.  Send the full dmesg, please.

Sarah Sharp
