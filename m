Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta23.ai270.net ([94.126.44.34]:39401 "EHLO
	out-mta22.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752872AbcBAUG5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2016 15:06:57 -0500
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5698191B.1070904@keynet-technology.com>
 <20160115172640.GC28453@localhost> <569CFB5B.7050903@keynet-technology.com>
 <20160119033839.GA3339@localhost> <56A8DA21.7060607@keynet-technology.com>
 <20160127215522.GA4875@localhost> <56A9EC07.8080509@keynet-technology.com>
 <20160129162400.GB12965@localhost> <56ACF8D4.8010607@keynet-technology.com>
 <20160201190611.GA4861@localhost>
Cc: linux-pci@vger.kernel.org
From: Richard F <lists@keynet-technology.com>
Message-ID: <56AFBADB.3060108@keynet-technology.com>
Date: Mon, 1 Feb 2016 20:06:51 +0000
MIME-Version: 1.0
In-Reply-To: <20160201190611.GA4861@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

Thanks so much for your investigation.

Yes, MOBO has 2 PCI slots fed off the IT8893E.
This guy -
http://linux.derkeiler.com/Mailing-Lists/Debian/2005-08/3243.html  had a
similar problem 10yrs ago(!), fixed by disabling ACPI, I tried that
without any success.   I did extract the BIOS tables and
disassemble/reassemble them to see if there was anything obvious broken
there, and not much shows, a few warnings, AML is pretty indecipherable
stuff... I also tried fooling it with some Windows acpi_os_name's
matching those in the AML, without luck.

For kicks I spun up an old Win XP image today, and it recognised the PCI
bridge but may not have been able to see the BT878's behind, but then I
didn't have a reliable source for drivers for it.

Is there's something needing configuring in that Hint HB6/PCI6140
bridge?  When working, it loads the shpchp module, and it does advertise
itself as "non transparent" mode. The other difference is a latency of
64 in the working scenario, 32 when not. Not configurable on the AMI
BIOS unfortunately.

Thanks again
Richard


On 1/02/2016 19:06, Bjorn Helgaas wrote:
> On Sat, Jan 30, 2016 at 05:54:28PM +0000, Richard F wrote:
>> On 29/01/2016 16:24, Bjorn Helgaas wrote:
>>> On Thu, Jan 28, 2016 at 10:23:03AM +0000, Richard F wrote:
>>> Your topology looks a little strange:
>>>
>>>   00:1c.0 PCIe root port to [bus 01]    slot 0
>>>   00:1c.1 PCIe root port to [bus 02]    slot 1
>>>   00:1c.2 PCIe root port to [bus 03-05] slot 2
>>>   03:00.0 PCI bridge to [bus 04-05] (Integrated Technology Express)
>>>   04:01.0 PCI bridge to [bus 05] (Hint Corp)
>>>
>>> 00:1c.2 is a normal PCIe Root Port, so the device it's connected to
>>> *should* be a PCIe device, but 03:00.0 doesn't have a PCIe capability.
>>> Is this an adapter card of some kind?
>>
>> It's a motherboard bridge to get from PCIe to legacy PCI slots, quite a
>> few motherboards use it I think. It's not an adapter I plugged in.
> 
> That makes sense.  It sounds like there are two conventional PCI
> slots?  I think it's also a minor platform bug that the 00:1c.2 root
> port advertises a slot.  1c.2 is connected to a system-integrated
> device, i.e., 03:00.0, not a slot.  This might cause pciehp to claim
> 1c.2 when it shouldn't.  But that's unrelated to the current issue, of
> course.
> 
>> I posted the output of DMESG with your patch (in 4.4.0) to the bugzilla
>> https://bugzilla.kernel.org/show_bug.cgi?id=110851
>>
>> It produced a fair bit of output but doesn't look like the card was
>> recognised. At least modprobe'ing bttv with the right parameters didn't
>> yield the right response.
> 
> I only added printks, so I didn't expect it to change the behavior.  I
> just wanted to confirm that we are scanning the bus and device numbers
> where we expect the bttv devices to be, and we are.  I think your bttv
> card includes these devices:
> 
>   04:01.0 PCI-PCI bridge (Hint Corp)
>   05:0c.0 bt878
>   05:0c.1 bt878
>   05:0d.0 bt878
>   ...
>   05:0f.1 bt878
> 
> For conventional PCI, I think the device number is determined by the
> slot wiring.  That affects the device number of the Hint Corp bridge,
> so if you move it between slots, it should change from device 01 to
> something else.
> 
> The device and function numbers of the bt878 devices are determined by
> wiring on the card, so those should be the same between machine A and
> B.  These are 5- and 3-bit fields, respectively, so 0c.0 means we have
> 01100 000 encoded into an 8-bit devfn as 0110 0000 or 0x60.  When we
> tried to read the vendor & device ID from 0c.0, we got no response
> from the device:
> 
>   pci_bus 0000:05: pci_scan_slot 60
>   pci_bus 0000:05: pci_scan_single_device 60
>   pci_bus 0000:05: pci_scan_device 60
>   pci_bus 0000:05: pci_bus_read_dev_vendor_id 60 0xffffffff
> 
> I'm out of ideas.  Other cards work in this slot; it's only the bttv
> card that doesn't work.  So it seems like it must be something about
> that card that's different.
> 
> Maybe somebody on the list will have more ideas?
> 
> Bjorn
> 

