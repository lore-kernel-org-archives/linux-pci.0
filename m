Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <8520D5D51A55D047800579B094147198258BC2BB@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160722151546.GA20646@localhost> <20160722155133.GB20646@localhost>
 <8520D5D51A55D047800579B094147198258BC23C@XAP-PVEXMBX01.xlnx.xilinx.com> <8520D5D51A55D047800579B094147198258BC2BB@XAP-PVEXMBX01.xlnx.xilinx.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 26 Jul 2016 12:25:35 -0700
Message-ID: <CAE9FiQWaFAD0+biMmnKqSQ2K4AdRJJmeEZ=ASSsvEgiDsKAP6Q@mail.gmail.com>
Subject: Re: Why does BIOS assign memory to 16 byte BAR
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Bharat Kumar Gogada <bharatku@xilinx.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>, nofooter <nofooter@xilinx.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 26, 2016 at 8:43 AM, Bharat Kumar Gogada
<bharat.kumar.gogada@xilinx.com> wrote:
>> > > We have only one End point connected to our root port.
>> > >
>> > > Here is the log:
>> > > [    2.319289] nwl-pcie fd0e0000.pcie: Link is UP
>> > > [    2.319332] PCI host bridge /amba/pcie@fd0e0000 ranges:
>> > > [    2.319349]   No bus range found for /amba/pcie@fd0e0000, using [bus
>> > 00-
>> > > ff]
>> > > [    2.319374]    IO 0xe0000000..0xe000ffff -> 0x00000000
>> > > [    2.319415]   MEM 0xe0100000..0xefffffff -> 0xe0100000
>> > > [    2.319431]   MEM 0x600000000..0x7ffffffff -> 0x600000000
>> > > [    2.319539] nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00
>> > > [    2.319557] pci_bus 0000:00: root bus resource [bus 00-ff]
>> > > [    2.319573] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> > > [    2.319589] pci_bus 0000:00: root bus resource [mem 0xe0100000-
>> > 0xefffffff]
>> > > [    2.319606] pci_bus 0000:00: root bus resource [mem 0x600000000-
>> > > 0x7ffffffff pref]
>> > > [    2.319845] pci 0000:00:00.0: cannot attach to SMMU, is it on the same
>> > bus?
>> > > [    2.319861] iommu: Adding device 0000:00:00.0 to group 1
>> > > [    2.320243] pci 0000:01:00.0: cannot attach to SMMU, is it on the same
>> > bus?
>> > > [    2.320258] iommu: Adding device 0000:01:00.0 to group 1
>> > > [    2.320313] pci 0000:00:00.0: BAR 8: no space for [mem size 0x60000000]
>> > > [    2.320331] pci 0000:00:00.0: BAR 8: failed to assign [mem size
>> 0x60000000]
>> > > [    2.320349] pci 0000:00:00.0: BAR 6: assigned [mem 0xe0100000-
>> > 0xe01007ff
>> > > pref]
>> > > [    2.320374] pci 0000:01:00.0: BAR 0: no space for [mem size 0x40000000]
>> > > [    2.320390] pci 0000:01:00.0: BAR 0: failed to assign [mem size
>> 0x40000000]
>> > > [    2.320407] pci 0000:01:00.0: BAR 4: no space for [mem size 0x00100000
>> > > 64bit]
>> > > [    2.320423] pci 0000:01:00.0: BAR 4: failed to assign [mem size
>> 0x00100000
>> > > 64bit]
>> > > [    2.320446] pci 0000:01:00.0: BAR 2: no space for [mem size 0x00000010]
>> > > [    2.320461] pci 0000:01:00.0: BAR 2: failed to assign [mem size
>> 0x00000010]
>> > > [    2.320477] pci 0000:01:00.0: BAR 3: no space for [mem size 0x00000010]
>> > > [    2.320493] pci 0000:01:00.0: BAR 3: failed to assign [mem size
>> 0x00000010]
>> > > [    2.320509] pci 0000:00:00.0: PCI bridge to [bus 01-0c]
>> > >
>> >
>> > What if the End Point has multiple function and say first function BAR
>> > assignment failed, will the kernel assign BAR's to second function on
>> > same bus and device ?

Your system host bridge: has resource
pci_bus 0000:00: root bus resource [mem 0xe0100000-0xefffffff]
pci_bus 0000:00: root bus resource [mem 0x600000000-0x7ffffffff pref]
then one pci bridge:
pci 0000:00:00.0
then 0000:01:00.0 have four bars:
pci 0000:01:00.0: BAR 0:  [mem size 0x40000000]
pci 0000:01:00.0: BAR 4:  [mem size 0x00100000 64bit]
pci 0000:01:00.0: BAR 2:  [mem size 0x00000010]
pci 0000:01:00.0: BAR 3:  [mem size 0x00000010]


kernel need to get allocation for pci 0000:00:00.0 at first

but can not find big enough space.

pci 0000:00:00.0: BAR 8: no space for [mem size 0x60000000]
as it should come from [mem 0xe0100000-0xefffffff], and that is
less 1.5G.

so all children resource from pci 0000:01:00.0 all fail.


please check if you modify your FPGA code to make pci 0000:01:00.0

BAR 0, and BAR 4 to use 64bit pref instead non-pref mmio.

or you can check if can increase root bus mmio range

 MEM 0xe0100000..0xefffffff -> 0xe0100000
nwl-pcie fd0e0000.pcie: PCI host bridge to bus 0000:00

to have more than 1.5G.

Thanks

Yinghai
