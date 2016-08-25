Return-Path: <prvs=0045beefe5=linux@rvanderhoff.org.uk>
Return-Path: <prvs=0045beefe5=linux@rvanderhoff.org.uk>
Subject: Re: Hotplug not working for USB 3.1 docking station on Dell XPS 13
To: Bjorn Helgaas <helgaas@kernel.org>
References: <57BDCE15.4080201@rvanderhoff.org.uk>
 <20160824201511.GF23914@localhost>
Cc: linux-pci@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
 linux-kernel@vger.kernel.org
From: Richard van der Hoff <linux@rvanderhoff.org.uk>
Message-ID: <57BEE0E7.7020300@rvanderhoff.org.uk>
Date: Thu, 25 Aug 2016 13:13:27 +0100
MIME-Version: 1.0
In-Reply-To: <20160824201511.GF23914@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 24/08/16 21:15, Bjorn Helgaas wrote:
> [+cc Andreas, linux-kernel]
>
> On Wed, Aug 24, 2016 at 05:40:53PM +0100, Richard van der Hoff wrote:
>> I'm having problems with a Plugable USB-C docking station, with my
>> laptop, a Dell XPS 13 (9350).  ...
>> My impression, and feedback from the linux-usb mailing list, is
>> therefore that this is a PCI hotplug problem.
>
> Please include a pointer to the linux-usb analysis.

For the record, here: 
http://marc.info/?l=linux-usb&m=147204147226274&w=2, however:

>  From the kernel's point of view, plugging in the dock would be a PCIe
> hotplug event on 00:1c.0 that should be handled by pciehp.  Do you
> have pciehp included in your kernel?

I did not; now I do, and it works perfectly. Thank you! A case of it 
being incredibly obvious once you know what you are looking for.

> 01:00.0 and 02:02.0 are ports of a Thunderbolt switch. Since they
> don't appear when you boot without the docking station, the dock
> connection must be between 00:1c.0 and 01:00.0.

This would strike me as surprising - the dock bills itself as a USB-C 
device, and the Thunderbolt devices look like they are part of the 
laptop chipset to me. To me it seems more likely that those PCI devices 
are part of the laptop, but are powered down until something is plugged 
into the USB-C port.

Still, this is splitting hairs; the point is that they are hotplugged 
PCI devices which need pciehp.

Thanks again for the pointer.

Best regards

Richard
