Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40117 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbaB1TDm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 28 Feb 2014 14:03:42 -0500
Message-ID: <1393614220.26901.28.camel@ul30vt.home>
Subject: Re: Fwd: Attaching drivers to identical PCI devices.
From: Alex Williamson <alex.williamson@redhat.com>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@triphase.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 28 Feb 2014 12:03:40 -0700
In-Reply-To: <CAPykPM=HhgvAebJbFW76D2umQjH5jz66FVh9egVY5khvGFNH2Q@mail.gmail.com>
References: <CAPykPMmLkQ2O5253EcUFuwNdmMKcL-Nr9KQi1EZoMH2yuHXcjQ@mail.gmail.com>
	 <CAPykPM=HhgvAebJbFW76D2umQjH5jz66FVh9egVY5khvGFNH2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-02-28 at 19:54 +0100, Jeroen Van den Keybus wrote:
> I would like to use 2 versions of a PCI driver, each for one of 2
> identical devices. The driver that gets probed first will seize both
> devices in driver_attach().
> 
> Using sysfs's bind and unbind methods, you can arrange to release the
> device for use by the other driver, but the first driver has
> nevertheless been initializing, driving and shutting down the device,
> which is unacceptable in my case.
> 
> What would be the best way to deal with this ?

It's not a very good solution, but you can use pci-stub to claim both
devices, then manually unbind each from pci-stub and bind it to the
driver you want.  Compile pci-stub statically so it gets first dibs
(CONFIG_PCI_STUB=y) and boot with pci-stub.ids=xxxx:yyyy where x/y is
vendor/device ID.  Use sysfs to unbind the device you want, load the
driver, repeat for the second device & driver.  Thanks,

Alex

