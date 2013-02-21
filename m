Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53178 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022Ab3BUVlq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 Feb 2013 16:41:46 -0500
Date: Thu, 21 Feb 2013 13:41:45 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: PCI D3 wakeup failure on Lynx Point xHCI
Message-ID: <20130221214145.GA25639@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

I'm running into some issues with PCI D3 wakeup on the latest version of
the Lynx Point chipset.  I can give you the stepping and BIOS version
privately if you need it.

Basically, I think PMEs are being lost somewhere in the ACPI or PCI
stack.  I'm not sure how to further debug this issue, so I'm hoping you have
some pointers.

This is reproduced on the 3.7.1, 3.7.7, and 3.8.0 kernels.

First, I go into powertop and basically change all the 'Bad' entries to
'Good', which turns on runtime PM for all PCI devices, bridges, and
rootports.  I have no USB devices plugged into the xHCI host, and I wait
until the host is suspended, and the PCI device is in D3.

Then I run:

watch -n 1 'sudo lspci -vvv -s 00:14.0'

When I plug in a USB 2.0 device to a USB 2.0 port, the hotplug event is
lost.  I can see from the lspci output that the Status line under the PM
capabilities changes when I plug in the device.  The PME- changes to
PME+, which I assume means a PME happened.  But the USB core's PCI
resume functions are never called.

Wakeup from D3 works fine on the previous generation chipset (Panther
Point) on my Lenovo x230 laptop, so this makes me suspicious that it's a
hardware or BIOS issue.  I'll try updating my BIOS and seeing if that
helps.

Sarah Sharp
