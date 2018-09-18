Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mta-01.yadro.com ([89.207.88.251]:39182 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730089AbeIRWle (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 18:41:34 -0400
Subject: Re: [PATCH RFC 0/4] PCI: Allow BAR movement during hotplug
To: David Laight <David.Laight@ACULAB.COM>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux@yadro.com" <linux@yadro.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <f7c1e5d0006f4161b5e0b0370a0e25c6@AcuMS.aculab.com>
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Message-ID: <a9863b73-c2b4-5b56-63c4-d32b4a5a4a83@yadro.com>
Date: Tue, 18 Sep 2018 20:07:56 +0300
MIME-Version: 1.0
In-Reply-To: <f7c1e5d0006f4161b5e0b0370a0e25c6@AcuMS.aculab.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 9/18/18 2:16 PM, David Laight wrote:
> From: Sergey Miroshnichenko
>> Sent: 14 September 2018 17:14
>>
>> If the firmware or kernel has arranged memory for PCIe devices in a way that doesn't
>> provide enough space for BARs of a new hotplugged device, the kernel can pause the
>> drivers of the "obstructing" devices and move their BARs, so new BARs can fit into the
>> created hole.
>>
>> When a driver is un-paused by the kernel after the PCIe rescan, it should check if its
>> BARs had changed and ioremap() them if needed.
>>
>> BARs are moved not directly, but by releasing bridge resources, then sorting and
>> assigning them back, similarly to the initial PCIe topology scan during system boot
>> (when pci=realloc is passed).
>>
>> Pausing drivers is performed via reset_prepare() and reset_done() callbacks of struct
>> pci_error_handlers. Drivers should pause during rescan not only because of potential
>> movement of their BARs, but also because of possible updating of the bridge windows.
> ...
> 
> You are restricting this to GPL drivers (unless someone has opened up the error
> handling functions since I last looked).
> 

The only GPL-related restrictions I was aware of are functions exported
with EXPORT_SYMBOL_GPL().

> I also suspect you need something to indicate that the driver is willing for
> all this to happen.
> 

I'm thinking about new callbacks in the struct pci_driver, would they
met the same restrictions?

> An error return from reset_prepare() will all be too late - other drivers
> might have been stopped even though it is impossible to actually perform
> the reorganisation.
> 
> There will also be drivers/devices that can handle being moved by a full
> remove/rescan sequence, particularly if there are no current users of the
> device.
> 

The implementation is going to be changed a bit:
 - if a device's driver doesn't have these callbacks (and so it can't
pause), its BARs are marked as immovable;
 - for every "movable" device that was working before the hotplug event,
it is guaranteed to arrange BARs;
 - if there is not enough memory or if the memory is too fragmented by
"immovable" devices, the BAR allocation for hotplugged devices can fail,
in this case the only way is to convert drivers to "movable".

The remove+rescan trick for unused "immovable" devices could be used as
a fallback, if BAR allocation has failed, but I'm not sure yet - what if
there are devices that are expected to do some job even without being
explicitly open()'ed?

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

Best regards,
Serge
