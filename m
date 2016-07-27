Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Wed, 27 Jul 2016 10:34:22 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	nofooter <nofooter@xilinx.com>
Subject: Re: Why does BIOS assign memory to 16 byte BAR
Message-ID: <20160727093422.GA8334@red-moon>
References: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160722151546.GA20646@localhost>
 <20160722155133.GB20646@localhost>
 <8520D5D51A55D047800579B094147198258BC23C@XAP-PVEXMBX01.xlnx.xilinx.com>
 <8520D5D51A55D047800579B094147198258BC2BB@XAP-PVEXMBX01.xlnx.xilinx.com>
 <CAE9FiQWaFAD0+biMmnKqSQ2K4AdRJJmeEZ=ASSsvEgiDsKAP6Q@mail.gmail.com>
 <8520D5D51A55D047800579B094147198258BC5E3@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8520D5D51A55D047800579B094147198258BC5E3@XAP-PVEXMBX01.xlnx.xilinx.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 27, 2016 at 06:33:29AM +0000, Bharat Kumar Gogada wrote:
> > Your system host bridge: has resource
> > pci_bus 0000:00: root bus resource [mem 0xe0100000-0xefffffff] pci_bus
> > 0000:00: root bus resource [mem 0x600000000-0x7ffffffff pref] then one pci
> > bridge:
> > pci 0000:00:00.0
> > then 0000:01:00.0 have four bars:
> > pci 0000:01:00.0: BAR 0:  [mem size 0x40000000] pci 0000:01:00.0: BAR 4:
> > [mem size 0x00100000 64bit] pci 0000:01:00.0: BAR 2:  [mem size 0x00000010]
> > pci 0000:01:00.0: BAR 3:  [mem size 0x00000010]
> > 
> > 
> > kernel need to get allocation for pci 0000:00:00.0 at first
> > 
> > but can not find big enough space.
> > 
> > pci 0000:00:00.0: BAR 8: no space for [mem size 0x60000000] as it should
> > come from [mem 0xe0100000-0xefffffff], and that is less 1.5G.
> > 
> > so all children resource from pci 0000:01:00.0 all fail.
> > 
> > 
> > please check if you modify your FPGA code to make pci 0000:01:00.0
> > 
> > BAR 0, and BAR 4 to use 64bit pref instead non-pref mmio.
> > 
> > or you can check if can increase root bus mmio range
> > 
> >  MEM 0xe0100000..0xefffffff -> 0xe0100000 nwl-pcie fd0e0000.pcie: PCI host
> > bridge to bus 0000:00
> > 
> > to have more than 1.5G.
> > 
> Thanks Yinghai Lu.
> We see that similar test is passing in x86 machine, where function one
> requesting 1GB BAR's is failing, but function two requesting BAR's
> with 16byte is getting assigned BAR's.
> 
> To my knowledge on x86 BIOS assigns resources, or will kernel assign
> reosurces on x86 ?  If kernel does is there any difference between x86
> and arm64 resource assignment logic ?

We can't answer your question if you do not provide a full log
of x86 and ARM PCI configurations you are testing I am afraid.

It is also unclear to me what "a similar test is passing in x86
machine" means, in particular in relation to the HW configuration
you are testing on x86.

Yes, there are differences between x86 and ARM resources assignments,
x86 tries to claim PCI resources as set-up by BIOS and assign them
iff the claiming fails whereas on ARM (and that's done in the host
bridge driver) FW configuration is always discarded and the kernel
reassigns the whole PCI resource hierarchy entirely, but to help we
need more data as I said above.

I suspect the issue you are facing has to do as Yinghai mentioned
with the prefetchable memory window set-up, saying that "it works"
on x86 does not really help unless you provide data to debug it.

Thanks,
Lorenzo
