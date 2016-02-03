Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] add new platform driver for PCI RC
To: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <cover.1454349430.git.jpinto@synopsys.com>
 <10b29adcdb0a31eb8f8071b271da267e44ad8a04.1454349430.git.jpinto@synopsys.com>
 <8223655.W63T0XOVm1@wuerfel> <20160203180514.GA10879@localhost>
CC: Joao Pinto <Joao.Pinto@synopsys.com>, <Vineet.Gupta1@synopsys.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B242F0.6040704@synopsys.com>
Date: Wed, 3 Feb 2016 18:12:00 +0000
MIME-Version: 1.0
In-Reply-To: <20160203180514.GA10879@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Bjorn,

Are these tasks enough?

- replace mdelay() for msleep()
- remove synopsys_pcie_irq_handler()
- replace "snps,pcie-synopsys" for "snps,pcie-synopsys-ipk"?
- rename the driver to pcie-synopsys-ipk?
- update the devicetree documentation referring that the ranges also include the
config space

Joao

On 2/3/2016 6:05 PM, Bjorn Helgaas wrote:
> Hi Joao & Arnd,
> 
> On Tue, Feb 02, 2016 at 09:25:25PM +0100, Arnd Bergmann wrote:
>> On Monday 01 February 2016 18:07:45 Joao Pinto wrote:
>>> This patch adds a new driver that will be the reference platform driver
>>> for all PCI RC IP Protoyping Kits based on ARC SDP.
>>> This patch is composed by:
>>>
>>> -MAINTAINERS file was updated to include the new driver
>>> -Documentation/devicetree/bindings/pci was updated to include the new
>>> driver documentation
>>> -New driver called pcie-synopsys
>>>
>>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>>
>> I must have completely missed all the earlier submissions and just happened
>> to see this one now that it was merged.
>>
>> I have a couple of comments, maybe you can send a follow up patch to address
>> them:
> 
> These seem pretty easy to address, so I pulled these patches out of
> for-linus temporarily while we fix them.
> 
> Joao, you can just fix the mdelay() in your driver; don't worry about 
> fixing other drivers with the same problem or consolidating them.
> 
> Bjorn
> 
>>> +----------------------------------
>>> +
>>> +This is the reference platform driver to be used in the Synopsys PCI Root
>>> +Complex IP Prototyping Kit.
>>> +
>>> +Required properties:
>>> +- compatible: set to "snps,pcie-synopsys";
>>
>> Please also include the exact version of the designware PCIe part that
>> is used in here, such as "snps,dw-pcie-1.234". I'm sure you can find
>> out the version.
>>
>> "snps,pcie-synopsys" by itself is about the worst possible compatible
>> string because it says nothing about the specific hardware. Half the
>> machines we support all have a designware PCIe host that was made
>> by synopsys. Please use the name of the SoC for the most specific
>> string.
>>
>>> +- reg: base address and length of the pcie controller registers.
>>> +- #address-cells: set to <3>
>>> +- #size-cells: set to <2>
>>> +- device_type: set to "pci"
>>> +- ranges: ranges for the PCI memory and I/O regions.
>>> +- interrupts: one interrupt source for MSI interrupts, followed by interrupt
>>> +	source for hardware related interrupts.
>>> +- #interrupt-cells: set to <1>
>>> +- num-lanes: set to <1>;
>>> +
>>> +Example configuration:
>>> +
>>> +	pcie: pcie@0xdffff000 {
>>> +		compatible = "snps,pcie-synopsys";
>>> +		reg = <0xdffff000 0x1000>;
>>> +		#address-cells = <3>;
>>> +		#size-cells = <2>;
>>> +		device_type = "pci";
>>> +		ranges = <0x00000800 0 0xd0000000 0xd0000000 0 0x00002000>,
>>
>> This line looks misplaced here and does not match the documentation. It's
>> probably a leftover from an earlier version that had the config space
>> in the ranges, so you need to remove that.
>>
>>> +/* This handler was created for future work */
>>> +static irqreturn_t synopsys_pcie_irq_handler(int irq, void *arg)
>>> +{
>>> +	return IRQ_NONE;
>>> +}
>>
>> It's not harmful, but we generally don't add code "for future work",
>> better remove it for now.
>>
>>> +static void synopsys_pcie_establish_link(struct pcie_port *pp)
>>> +{
>>> +	int retries = 0;
>>> +
>>> +	/* check if the link is up or not */
>>> +	for (retries = 0; retries < 10; retries++) {
>>> +		if (dw_pcie_link_up(pp)) {
>>> +			dev_info(pp->dev, "Link up\n");
>>> +			return;
>>> +		}
>>> +		mdelay(100);
>>> +	}
>>> +}
>>
>> That mdelay() needs to be an msleep(). You should never waste
>> a whole second worth of CPU time in a driver.
>>
>> 	Arnd
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
