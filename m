Return-Path: <sergei.shtylyov@cogentembedded.com>
Return-Path: <sergei.shtylyov@cogentembedded.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] pcie-rcar: try setting PCIe speed to 5 GT/s at boot
To: Bjorn Helgaas <helgaas@kernel.org>
References: <6896977.DKiraAXap6@wasted.cogentembedded.com>
 <20160914205431.GC13189@localhost>
Cc: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Message-ID: <9924b888-5876-fb64-e2a6-08d8c0c767f1@cogentembedded.com>
Date: Tue, 20 Sep 2016 21:13:56 +0300
MIME-Version: 1.0
In-Reply-To: <20160914205431.GC13189@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 09/14/2016 11:54 PM, Bjorn Helgaas wrote:

>> From: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
>>
>> Initially, the PCIe link speed is set up only at 2.5 GT/s.
>> For better performance,  we're trying to increase link speed to 5 GT/s.
>>
>> [Sergei Shtylyov: indented the macro definitions with tabs, renamed the
>> SPCHG register bits for consistency, renamed the link speed field/values,
>> fixed too long lines, fixed redundancy in clearing the MACSR register bits,
>> fixed grammar/typos in  the comments/messages, removed unrelated/useless
>> changes, fixed bugs in rcar_rwm32() calls done to set the bits, removed
>> unneeded braces, removed non-informative comment, reworded the patch
>> summary/description.]
>>
>> Signed-off-by: Grigory Kletsko <grigory.kletsko@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> The patch is against the 'next' branch of Bjorn Helgaas' 'pci.git' repo.
>>
>>  drivers/pci/host/pcie-rcar.c |  103 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 103 insertions(+)
>>
>> Index: pci/drivers/pci/host/pcie-rcar.c
>> ===================================================================
>> --- pci.orig/drivers/pci/host/pcie-rcar.c
>> +++ pci/drivers/pci/host/pcie-rcar.c
[...]
>> @@ -385,6 +402,51 @@ static int rcar_pcie_setup(struct list_h
>>  	return 1;
>>  }
>>
>> +void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
>> +{
>> +	u32 macsr;
>> +
>> +	dev_info(pcie->dev, "Trying speed up to 5 GT/s\n");
>> +
>> +	if ((rcar_pci_read_reg(pcie, MACSR) & SPCHGFIN) ||
>> +	    (rcar_pci_read_reg(pcie, MACCTLR) & SPEED_CHANGE)) {
>> +		dev_err(pcie->dev, "Speed changing is in progress\n");
>
> Are these messages all really errors?

     I guess not. :-)

>> +		return;
>> +	}
>> +
>> +	if ((rcar_pci_read_reg(pcie, MACSR) & LINK_SPEED) ==
>> +	    LINK_SPEED_5_0GTS) {
>> +		dev_err(pcie->dev, "Current link speed is already 5 GT/s\n");
>> +		return;
>> +	}
>> +
>> +	if ((rcar_pci_read_reg(pcie, MACS2R) & LINK_SPEED) !=
>> +	    LINK_SPEED_5_0GTS) {
>> +		dev_err(pcie->dev,
>> +			"Current max support link speed not 5 GT/s\n");
>> +		return;
>> +	}
[...]
>> @@ -416,6 +478,9 @@ static int rcar_pcie_enable(struct rcar_
>>
>>  	pci_bus_add_devices(bus);
>>
>> +	/* Try setting 5 GT/s link speed */
>> +	rcar_pcie_force_speedup(pcie);
>
> I assume it's safe to change the link speed even while the downstream
> devices are in use?  As soon as we call pci_bus_add_devices(), drivers
> can claim the devices and start using them.

    Not sure. OK, I'm going to move this call before pci_bus_add_devices() and 
try to make it synchronous, without using interrupt.

>>  	return 0;
>>  }
>>
>> @@ -621,6 +686,44 @@ static irqreturn_t rcar_pcie_msi_irq(int
>>  	struct rcar_msi *msi = &pcie->msi;
>>  	unsigned long reg;
>>
>> +	if (rcar_pci_read_reg(pcie, PCIEINTR) & PCIEINTMAC) {
>> +		dev_dbg(pcie->dev, "MAC interrupt received\n");
>
> I guess you don't need to write PCIEINTR or any other register to
> acknowledge the interrupt?

    You need to write MACSR -- which the code below does. However, it only 
clears the SPCHGFIN interrupt (which is only ever enabled).

>> +
>> +		rcar_rmw32(pcie, MACSR, SPCHGFIN, SPCHGFIN);
>> +
>> +		/* Disable this interrupt */
>> +		rcar_rmw32(pcie, MACINTENR, SPCHGFINE, 0);
>> +		rcar_rmw32(pcie, PCIEINTER, PCIEINTMACE, 0);

>>  	reg = rcar_pci_read_reg(pcie, PCIEMSIFR);
>>
>>  	/* MSI & INTx share an interrupt - we only handle MSI here */
>
> Is this patch adding handling for INTx events?

     No.

MBR, Sergei
