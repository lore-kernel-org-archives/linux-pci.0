Return-Path: <niklas.cassel@axis.com>
Return-Path: <niklas.cassel@axis.com>
Subject: Re: [PATCH v2 2/2] pci: host: new driver for Axis ARTPEC-6 PCIe
 controller
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1462794543-30317-1-git-send-email-niklass@axis.com>
 <20160609224125.GB19309@localhost> <575EB12D.1040206@axis.com>
 <20160613133357.GA12221@localhost>
CC: <bhelgaas@google.com>, <jespern@axis.com>, <akpm@linux-foundation.org>,
	<davem@davemloft.net>, <gregkh@linuxfoundation.org>,
	<mchehab@osg.samsung.com>, <linux@roeck-us.net>, <jslaby@suse.cz>,
	<robh@kernel.org>, <marc.zyngier@arm.com>, <rjui@broadcom.com>,
	<arnd@arndb.de>, <david.daney@cavium.com>, <geert+renesas@glider.be>,
	<lftan@altera.com>, <bharat.kumar.gogada@xilinx.com>, <hauke@hauke-m.de>,
	<thomas.petazzoni@free-electrons.com>, <simon.horman@netronome.com>,
	<phil.edworthy@renesas.com>, <svarbanov@mm-sol.com>, <dhdang@apm.com>,
	<wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@axis.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <57673F5A.7020805@axis.com>
Date: Mon, 20 Jun 2016 02:56:58 +0200
MIME-Version: 1.0
In-Reply-To: <20160613133357.GA12221@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>


On 06/13/2016 03:33 PM, Bjorn Helgaas wrote:
> On Mon, Jun 13, 2016 at 03:12:13PM +0200, Niklas Cassel wrote:
>> On 06/10/2016 12:41 AM, Bjorn Helgaas wrote:
>>> On Mon, May 09, 2016 at 01:49:03PM +0200, Niklas Cassel wrote:
>>>> From: Niklas Cassel <niklas.cassel@axis.com>
>>>>
>>>> The Axis ARTPEC-6 SoC integrates a PCIe controller from Synopsys.
>>>> This commit adds a new driver that provides the small glue
>>>> needed to use the existing Designware driver to make it work on
>>>> the Axis ARTPEC-6 SoC.
>>>>
>>>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>>> Hi Niklas,
>>>
>>> I'll review this soon.  In the meantime, can you send /proc/iomem and
>>> /proc/ioport contents?  I'm looking to avoid problems like this:
>>> http://lkml.kernel.org/r/20160606230537.20936.2892.stgit@bhelgaas-glaptop2.roam.corp.google.com
>>>
>>> It looks like this is based on DesignWare, so it probably has the
>>> problem, and will probably be fixed by these:
>>>
>>> http://lkml.kernel.org/r/20160606230452.20936.28937.stgit@bhelgaas-glaptop2.roam.corp.google.com
>>> http://lkml.kernel.org/r/20160606230501.20936.71818.stgit@bhelgaas-glaptop2.roam.corp.google.com
>>> http://lkml.kernel.org/r/20160606230508.20936.81845.stgit@bhelgaas-glaptop2.roam.corp.google.com
>>>
>>> If you wanted to apply those and then send /proc/iomem and
>>> /proc/ioports, that would be even better.
>>>
>>> Bjorn
>>>
>> Output with your patches applied:
> Great, thanks, Niklas!  Comments below:
>
>> [    2.107320] PCI host bridge /pcie@f8050000 ranges:
>> [    2.112138]   No bus range found for /pcie@f8050000, using [bus 00-ff]
> Your DT *should* provide a bus number range.  There is no way for the
> PCI core to correctly determine the range.
Ok, I will update the DT example to include bus-range.

>
>> [    2.118684]    IO 0xc0010000..0xc001ffff -> 0x00010000
>> [    2.123835]   MEM 0xc0020000..0xdfffffff -> 0xc0020000
>> [    2.245559] artpec6-pcie f8050000.pcie: link up
>> [    2.250228] artpec6-pcie f8050000.pcie: PCI host bridge to bus 0000:00
>> [    2.256773] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    2.262273] pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0x10000-0x1ffff])
> This looks questionable.  This says we're using I/O ports
> 0x10000-0x1ffff on the PCI bus.  That's legal, but unusual.
>
> The conventional PCI spec allowed the upper 16 bits of I/O BARs
> to be hard-wired to zero "for devices intended for 16-bit I/O
> systems, such as PC compatibles."
>
> I don't know whether a PCIe device with an I/O BAR with the
> upper bits hard-wired to zero exists.  The conservative approach
> would be to use ports 0x0000-0xffff on PCI.
Thank you for the detailed explanation.
We simply chose a value during testing,
there wasn't any deeper thought behind it.
Since other DesignWare drivers seem to use 0x0, lets stick to that.

I'm currently on parental leave, but I'm back on work next week.
I will try the new settings and send out a patch that updates the DT example.

Hopefully there's no hurry, since both changes are in the DT example.

>
>> [    2.271250] pci_bus 0000:00: root bus resource [mem 0xc0020000-0xdfffffff]
>> [    2.278407] PCI: bus0: Fast back to back transfers disabled
>> [    2.293358] PCI: bus1: Fast back to back transfers disabled
>> [    2.299018] pci 0000:00:00.0: BAR 0: assigned [mem 0xc0100000-0xc01fffff]
>> [    2.305825] pci 0000:00:00.0: BAR 1: assigned [mem 0xc0200000-0xc02fffff]
>> [    2.312627] pci 0000:00:00.0: BAR 8: assigned [mem 0xc0300000-0xc07fffff]
>> [    2.319430] pci 0000:01:00.0: BAR 1: assigned [mem 0xc0400000-0xc05fffff]
>> [    2.326241] pci 0000:01:00.0: BAR 2: assigned [mem 0xc0600000-0xc07fffff]
>> [    2.333052] pci 0000:01:00.0: BAR 0: assigned [mem 0xc0300000-0xc0303fff]
>> [    2.339862] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [    2.344838] pci 0000:00:00.0:   bridge window [mem 0xc0300000-0xc07fffff]
>>
>> # cat /proc/iomem
>> 00000000-0fffffff : System RAM
>>   00208000-01071b2f : Kernel code
>>   01300000-01465347 : Kernel data
>> c0020000-dfffffff : MEM
>>   c0100000-c01fffff : 0000:00:00.0
>>   c0200000-c02fffff : 0000:00:00.0
>>   c0300000-c07fffff : PCI Bus 0000:01
>>     c0300000-c0303fff : 0000:01:00.0
>>       c0301000-c0301007 : serial
>>       c0301200-c0301207 : serial
>>     c0400000-c05fffff : 0000:01:00.0
>>     c0600000-c07fffff : 0000:01:00.0
>> f8010000-f8013fff : /amba@0/ethernet@f8010000
>> f8036000-f8036fff : /amba@0/serial@f8036000
>>   f8036000-f8036fff : /amba@0/serial@f8036000
>> f8037000-f8037fff : /amba@0/serial@f8037000
>>   f8037000-f8037fff : /amba@0/serial@f8037000
>> f8038000-f8038fff : /amba@0/serial@f8038000
>>   f8038000-f8038fff : /amba@0/serial@f8038000
>> f8039000-f8039fff : /amba@0/serial@f8039000
>>   f8039000-f8039fff : /amba@0/serial@f8039000
>> f8040000-f8040fff : phy
>> f8050000-f8051fff : dbi
>>
>> # cat /proc/ioports
>> 00000000-0000ffff : I/O
>>
>>
>> Without your patches applied:
>> /proc/ioports is empty.
>> /proc/iomem is missing the node "c0020000-dfffffff : MEM"
>> and all of its child nodes.
> Good, that's exactly what I expected.  We could use better names for
> the resources, so they're connected to the PCIe controller, but at
> least we have the entries.
>
> Bjorn
