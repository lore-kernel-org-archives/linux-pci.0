Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbbFBWbc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Jun 2015 18:31:32 -0400
Message-ID: <556E2EC3.2080500@redhat.com>
Date: Tue, 02 Jun 2015 18:31:31 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Linux PCI <linux-pci@vger.kernel.org>,
	Myron Stowe <mstowe@redhat.com>
Subject: Re: Initial APCI root bus discovery vs. rescan
References: <5563B21A.8080504@redhat.com> <20150526160716.GM32152@google.com> <556DEDCA.1040808@redhat.com> <20150602204433.GK3631@google.com>
In-Reply-To: <20150602204433.GK3631@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/02/2015 04:44 PM, Bjorn Helgaas wrote:
> On Tue, Jun 02, 2015 at 01:54:18PM -0400, Prarit Bhargava wrote:
>> On 05/26/2015 12:07 PM, Bjorn Helgaas wrote:
> 
>> ...
>> [    1.546925] pci_bus 0000:00: root bus resource [bus 00-3e]
>> [    1.552397] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
>> [    1.559165] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>> [    1.565934] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>> [    1.573398] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
>> [    1.580861] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
>> [    1.588322] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
>> [    1.595784] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
>> [    1.603246] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
>> [    1.610707] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
>> [    1.618170] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xfeafffff window]
> 
>> [    1.637470] pci 0000:00:16.3: [8086:1e3d] type 00 class 0x070002
>> [    1.637486] pci 0000:00:16.3: reg 0x10: [io  0x70a0-0x70a7]
>> [    1.637495] pci 0000:00:16.3: reg 0x14: [mem 0xb1580000-0xb1580fff]
> 
>> [    2.961417] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> [    2.988543] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>> [    3.016847] serial8250: ttyS2 at I/O 0x3e8 (irq = 4, base_baud = 115200) is a
>> 16550A
>> [    3.045264] 0000:00:16.3: ttyS1 at I/O 0x70a0 (irq = 19, base_baud = 115200)
>> is a 16550A
> 
>>> In this scenario, I assume the serial port device remains powered all the
>>> time, even while it is logically removed from the system, so when we
>>> re-enumerate and find the device, I would think its BARs would still
>>> contain whatever they had before, and since they are still valid, we should
>>> still use them.
>>
>> Nope.  The device should go down as ttyS1 is not active.
> 
> I'm talking about the 00:16.3 PCI device.  I doubt there's anything that
> would remove power from it when you do the "echo 1 > remove".  Of course,
> Linux will forget about it, and 00:16.3 shouldn't show up in lspci output,
> but from the device's point of view, nothing has really changed.  When we
> rescan, we should find it just as we left it (it's possible we'd clear bits
> in the PCI_COMMAND register or something, but I'm not sure we even do
> that, and I'm pretty sure we don't clear out the BARs).
> 
>>> So I think my expectation is the same as yours, and I don't know why it
>>> doesn't work that way.  I assume the device actually *works* with the new
>>> resources, so it's not really broken in that sense, but it does bother me
>>> if we're changing something when we don't need to change it.
>>
>> Yep ... I think it's broken.  Here's what I'm doing to down then rescan
>> the device.
>>
>> [root@intel-chiefriver-04 ~]# cd /sys/devices/pci0000\:00/0000\:00\:16.3
>> [root@intel-chiefriver-04 0000:00:16.3]# echo 1 > remove
>> [root@intel-chiefriver-04 0000:00:16.3]# lspci | grep 16.3
>> [root@intel-chiefriver-04 0000:00:16.3]# cd ../pci_bus/0000\:00/
>> [root@intel-chiefriver-04 0000:00]# echo 1 > rescan
> 
> The /sys/devices/pci0000:00/0000:00:16.3/ directory should disappear when
> you remove the device.  In this case you were *inside* the directory when
> you did the remove, so your shell is holding a reference to it.  But if you
> do this:
> 
>     # cd /sys/devices/pci0000:00
>     # echo 1 > 0000:00:16.3/remove
>     # ls
> 
> you should not see the 0000:00:16.3 directory any more.
> 
>> and the console contains
>>
>> [  353.212980] pci 0000:00:16.3: [8086:1e3d] type 00 class 0x070002
>> [  353.231163] pci 0000:00:16.3: BAR 1: assigned [mem 0xb1520000-0xb1520fff]
>> [  353.237937] pci 0000:00:16.3: BAR 0: assigned [io  0x1018-0x101f]
> 
> There should be some more output here.  I usually boot with
> "ignore_loglevel" to make sure I see everything.
> 
> The first line looks like it's from pci_setup_device().  The "BAR x:
> assigned" lines look like they're from pci_assign_resource().  But there
> should be "reg 0x%x: %pR\n" lines from __pci_read_base() in the middle.
> Those would show us what we actually got from the device BARs.

Hmm ... I'm booting with ignore_loglevel (that's my default FWIW) and didn't see
those printks.  I'm going to definitely debug that...

> 
> Can you check /proc/iomem and /proc/ioports before you remove it, after you
> remove it, and a third time after you do the rescan (I guess it's hung
> after the rescan, so you probably can't do that)?  I wonder if we forget to
> remove the original resources when we remove it, and then we reassign them
> after the rescan because we think they're still in use.

Yep, tried this already -- the mem and io regions are definitely released by the
serial driver.

> 
>> and the system is hung.  The addresses are clearly different here and I'll
>> debug further.  
> 
> Even if we change the 00:16.3 BARs, I wouldn't think the system would
> hang unless we actually try to *use* those new addresses.
> 
> And ... I guess the next thing we *should* see is the serial driver
> claiming this device again, and it would read some of the serial port
> registers.  I bet if you added instrumentation to pciserial_init_one(),
> you'd see output until you get into pciserial_init_ports().
> 

Yeah, was just about to do that :)  I'm going to see if we get into the serial
driver at all.

> The new addresses don't *look* like they should conflict with anything, but
> maybe they do.  I think we just need to figure out why we can't use the
> original addresses, and my first guess is that we don't release those
> resources correctly.
> 
>> The one odd thing is that the ttyS1 device is not removed from
>> /sys/ during the remove.  It's almost as if it is left around as a place holder
>> for 16.3 if it should be reinserted, and I have a feeling that may lead to the
>> system hang.
> 
> I'm not exactly sure what you're saying here.  Are you saying there's a
> /sys/.../ttyS1 that still exists after the remove?  Or do you mean that
> /sys/.../0000:00:16.3 still exists after the remove?  

/sys/...ttyS1 exists after the remove.  That has me scratching my head -- AFAICT
nothing is using ttyS1 on the system and I'm focusing in on the remove code as
you point out below.

P.

> 
> If the former, maybe there's something wrong with the remove path in the
> serial driver.  If the latter, that seems wrong unless there something like
> a shell holding a reference to the directory.
> 
> Bjorn
> 
> 

