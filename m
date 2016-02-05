Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56B3ECAD.4050605@caviumnetworks.com>
Date: Thu, 4 Feb 2016 16:28:29 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: David Daney <ddaney.cavm@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 2/2] pci, pci-thunder-pem: Add PCIe host driver for
 ThunderX processors.
References: <1453844781-24380-1-git-send-email-ddaney.cavm@gmail.com> <1453844781-24380-3-git-send-email-ddaney.cavm@gmail.com> <20160205000452.GI7031@localhost>
In-Reply-To: <20160205000452.GI7031@localhost>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/04/2016 04:04 PM, Bjorn Helgaas wrote:
> Hi David,
>
> Looks good, a few trival questions below.
>
> On Tue, Jan 26, 2016 at 01:46:21PM -0800, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Some Cavium ThunderX processors require quirky access methods for the
>> config space of the PCIe bridge.  Add a driver to provide these config
>> space accessor functions.  The pci-host-common code is used to
>> configure the PCI machinery.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 ++++
>>   MAINTAINERS                                        |   8 +
>>   drivers/pci/host/Kconfig                           |   7 +
>>   drivers/pci/host/Makefile                          |   1 +
>>   drivers/pci/host/pci-thunder-pem.c                 | 283 +++++++++++++++++++++
>
> What's the significance of the "pem" part of the name?  I'm wondering
> if we can shorten the filenames and function names by dropping it and
> referring to this simply as "thunder" or "thunderx".

PEM == PCI Express MAC, Essentially the circuitry related to off-chip 
PCI devices.  This differentiates it from the internal on-chip devices 
which are connected to internal buses we refer to as "ECAMs"

See also the follow on patch, from me, that adds the pci-thunder-ecam.c 
driver.

Since PEM and ECAM are terminology used in the hardware manuals that 
have specific meanings relative to the Thunder SoC family, I think it is 
not too inconvenient to carry them over into the file names.

>
>>   5 files changed, 342 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
>>   create mode 100644 drivers/pci/host/pci-thunder-pem.c
>>

>> +
>> +static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
>> +				    int where, int size, u32 val)
>> +{
>> +	struct gen_pci *pci = bus->sysdata;
>> +	struct thunder_pem_pci *pem_pci;
>> +
>> +	pem_pci = container_of(pci, struct thunder_pem_pci, gen_pci);
>> +
>> +	/*
>> +	 * The first device on the bus in the PEM PCIe bridge.
>> +	 * Special case its config access.
>> +	 */
>> +	if (bus->number == pci->cfg.bus_range->start) {
>> +		u64 write_val, read_val;
>> +
>> +		if (devfn != 0 || where >= 2048)
>> +			return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>> +		/*
>> +		 * 32-bit accesses only.  If the write is for a size
>> +		 * smaller than 32-bits, we must first read the 32-bit
>> +		 * value and merge in the desired bits and then write
>> +		 * the whole 32-bits back out.
>> +		 */
>
> Ugh.  Another device that only supports 32-bit writes.  I guess this
> only affects this single device, and maybe you "know" that it has no
> registers where RW1C bits may be corrupted.  Although I suppose this
> device has the standard status registers (Status at 0x06, Secondary
> Status at 0x1e, Device Status in PCIe capability, etc.), which do
> contain RW1C bits.

This device is exactly the specific PCIe host bridge implementation, 
present on these SoCs.  The only sane way to access its config space is 
via 32-bit operations.  We know that it presents the appropriate Class 
and other registers to be recognized as, and operate as, a standard PCIe 
bridge.

>
> We need to print a warning at probe-time so we know to consider the
> possibility of corruption when debugging.

If you really want it, I suppose I can add that, but I am somewhat hesitant.

>
[...]
>> +
>> +static struct gen_pci_cfg_bus_ops thunder_pem_bus_ops = {
>> +	.bus_shift	= 24,
>> +	.ops		= {
>> +		.map_bus	= map_cfg_bus_thunder_pem,
>
> How about "thunder_pem_map_bus"?

That would be better.  Actually, I wonder how I came up with that crappy 
name in the first place...

>
>> +		.read		= thunder_pem_config_read,
>> +		.write		= thunder_pem_config_write,
>> +	}
>> +};
>> +

I will wait a day to see if you have any response, and then send a new 
version of the patch set.

Thanks,
David Daney
