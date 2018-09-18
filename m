Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:45208 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727207AbeIRQwQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 12:52:16 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sergey Miroshnichenko' <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux@yadro.com" <linux@yadro.com>
Subject: RE: [PATCH RFC 0/4] PCI: Allow BAR movement during hotplug
Date: Tue, 18 Sep 2018 11:16:08 +0000
Message-ID: <f7c1e5d0006f4161b5e0b0370a0e25c6@AcuMS.aculab.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
In-Reply-To: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Sergey Miroshnichenko
> Sent: 14 September 2018 17:14
> 
> If the firmware or kernel has arranged memory for PCIe devices in a way that doesn't
> provide enough space for BARs of a new hotplugged device, the kernel can pause the
> drivers of the "obstructing" devices and move their BARs, so new BARs can fit into the
> created hole.
> 
> When a driver is un-paused by the kernel after the PCIe rescan, it should check if its
> BARs had changed and ioremap() them if needed.
> 
> BARs are moved not directly, but by releasing bridge resources, then sorting and
> assigning them back, similarly to the initial PCIe topology scan during system boot
> (when pci=realloc is passed).
> 
> Pausing drivers is performed via reset_prepare() and reset_done() callbacks of struct
> pci_error_handlers. Drivers should pause during rescan not only because of potential
> movement of their BARs, but also because of possible updating of the bridge windows.
...

You are restricting this to GPL drivers (unless someone has opened up the error
handling functions since I last looked).

I also suspect you need something to indicate that the driver is willing for
all this to happen.

An error return from reset_prepare() will all be too late - other drivers
might have been stopped even though it is impossible to actually perform
the reorganisation.

There will also be drivers/devices that can handle being moved by a full
remove/rescan sequence, particularly if there are no current users of the
device.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
