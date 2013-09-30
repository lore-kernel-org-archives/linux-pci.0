Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33699 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab3I3CE6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Sep 2013 22:04:58 -0400
Date: Sun, 29 Sep 2013 19:05:00 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatjain.linux@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org
Subject: Re: pciehp & other hot-plug drivers (shpc etc..)
Message-ID: <20130930020500.GB28774@kroah.com>
References: <CADTPrLTuzvj3iSMdNVs2BjDFHsWqjRPM4qDkkpmv+P11LMP0JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADTPrLTuzvj3iSMdNVs2BjDFHsWqjRPM4qDkkpmv+P11LMP0JQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 29, 2013 at 11:27:23AM -0700, Rajat Jain wrote:
> Hello List,
> 
> Today all the PCI Hot-plug drivers (shpc, acpihp, cpqhp, ibmhp etc
> except pciedhp) directly claim the downstream port bridge device.
> Where as in case of pciehp, the PCIe port bus driver claims the bridge
> device, and service drivers (aer, pm, pciehp) simply register for the
> service with it.
> 
> 1) Does that mean that in a system where I am using a driver other
> than pciehp for hot-plug (eg. shpc), I cannot use service drivers like
> AER or PM on the same port (since the device would be claimed by
> shpc, it would not be available to port bus driver)?

It depends on your system, and you BIOS, which sets up all of this
stuff.  It's up to the kernel to bind to the proper things it exposes.

> 2) In the same system, can I use SHPC on one port, and pciehp on
> another port? I believe not?

Yes you can, but such a system seems really strange, do you know of any
that require it?

> Please note that it may not be a realistic scenarios, my intent of
> asking is to just understand how things are intended to behave.

Again, it depends on your BIOS / hardware.  They are the ones that
determine which driver handles this type of thing.

Hope this helps,

greg k-h
