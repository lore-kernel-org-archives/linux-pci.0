Return-Path: <SRS0=h9nn=2R=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=h9nn=2R=free.fr=slash.tmp@kernel.org>
Subject: Re: Neophyte questions about PCIe
To: David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <063D6719AE5E284EB5DD2968C1650D6DCFE7A70A@AcuExch.aculab.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <b735b894-4c6c-5eb0-524e-dccee648d0f8@free.fr>
Date: Wed, 8 Mar 2017 15:17:51 +0100
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFE7A70A@AcuExch.aculab.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

Hello David,

On 08/03/2017 14:54, David Laight wrote:

> Mason wrote:
>
>> 2) On my platform, there are two revisions of the PCIe controller.
>> Rev1 muxes config and mem inside a 256 MB window, and doesn't support
>> I/O space.
>> Rev2 muxes all 3 spaces inside a 256 MB window.
> 
> Don't think config space fits.
> With the 'obvious' mapping the 'bus number' is in the top
> 8 bits of the address.

https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/host-generic-pci.txt

	cfg_offset(bus, device, function, register) =
		bus << 20 | device << 15 | function << 12 | register

8 bits for bus, 5 bits for device, 3 bits for function, 12 bits for reg offset
1 MB per bus, 256 buses max => 256 MB max

Supporting "only" 64 buses is good enough, I believe.


>> 3) What happens if a device requires more than 256 MB of
>> mem space? (Is that common? What kind of device? GPUs?)
>> Our controller supports a remapping "facility" to add an
>> offset to the bus address. Is such a feature supported
>> by Linux at all?  The problem is that this creates
>> another race condition, as setting the offset register
>> before an access may occur concurrently on two cores.
>> Perhaps 256 MB is plenty on a 32-bit embedded device?
> 
> GPUs tend to have their own paging scheme.
> So don't need humongous windows.
> I'm not sure how much space is really needed.
> 32bit x86 reserve the top 1GB of physical address for PCI(e).

I'm hoping 128 MB mem is enough. The two cards I have that are correctly
detected request 8 KB. (I have other cards that are not enumerated at all...
No idea why at the moment.)


>> 4) The HW dev is considering the following fix.
>> Instead of muxing the address spaces, provide smaller
>> exclusive spaces. For example
>> [0x5000_0000, 0x5400_0000] for config (64MB)
>> [0x5400_0000, 0x5800_0000] for I/O (64MB)
>> [0x5800_0000, 0x6000_0000] for mem (128MB)
> 
> You almost certainly don't need more than 64k of IO.

Good to know.


> Config space isn't dense, you (probably) need 25 bits to get a 2nd bus number.
> Even 256MB constrains you to 16 bus numbers.

Unless I got the math wrong, it's 20 bits (1 MB) per bus.
So 64 MB allows 64 buses.

> Is this an ARM cpu inside an altera (now intel) fpga??
> There is a nasty bug in their PCIe to avalon bridge logic (fixed in quartus 16.1).

The PCIe controller is from PLDA, and it's embedded in a SoC
where the CPU is a multi-core ARM Cortex A9 MP.

Regards.
