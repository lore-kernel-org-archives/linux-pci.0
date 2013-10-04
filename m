Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:33756 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab3JDBIQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Oct 2013 21:08:16 -0400
MIME-Version: 1.0
In-Reply-To: <20130930020500.GB28774@kroah.com>
References: <CADTPrLTuzvj3iSMdNVs2BjDFHsWqjRPM4qDkkpmv+P11LMP0JQ@mail.gmail.com>
	<20130930020500.GB28774@kroah.com>
Date: Thu, 3 Oct 2013 18:08:15 -0700
Message-ID: <CADTPrLSpfnY6Z1MgpR=C4SRH7yXJ2BKi3w5ChLpTuWL3zZWx_Q@mail.gmail.com>
Subject: Re: pciehp & other hot-plug drivers (shpc etc..)
From: Rajat Jain <rajatjain.linux@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org,
	tom.l.nguyen@intel.com, yanmin.zhang@intel.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Hello,

On Sun, Sep 29, 2013 at 7:05 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sun, Sep 29, 2013 at 11:27:23AM -0700, Rajat Jain wrote:
>> Hello List,
>>
>> Today all the PCI Hot-plug drivers (shpc, acpihp, cpqhp, ibmhp etc
>> except pciedhp) directly claim the downstream port bridge device.
>> Where as in case of pciehp, the PCIe port bus driver claims the bridge
>> device, and service drivers (aer, pm, pciehp) simply register for the
>> service with it.
>>
>> 1) Does that mean that in a system where I am using a driver other
>> than pciehp for hot-plug (eg. shpc), I cannot use service drivers like
>> AER or PM on the same port (since the device would be claimed by
>> shpc, it would not be available to port bus driver)?
>
> It depends on your system, and you BIOS, which sets up all of this
> stuff.  It's up to the kernel to bind to the proper things it exposes.

Actually, I just wanted to understand that on a machine where
shpchp.ko is to be used for hot-plug, can I still use the AER port bus
service driver? My understanding is NO, because shpc will claim the
downstream port bridge, and hence port bus driver will not be able to
claim it?

>
>> 2) In the same system, can I use SHPC on one port, and pciehp on
>> another port? I believe not?
>
> Yes you can, but such a system seems really strange, do you know of any
> that require it?
>
>> Please note that it may not be a realistic scenarios, my intent of
>> asking is to just understand how things are intended to behave.
>
> Again, it depends on your BIOS / hardware.  They are the ones that
> determine which driver handles this type of thing.
>
> Hope this helps,
>
> greg k-h
