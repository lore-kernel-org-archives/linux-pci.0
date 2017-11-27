Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:25847 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbdK0NC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 08:02:59 -0500
Subject: Re: [PATCH] PCI: designware-ep: Fix ->get_msi() to check MSI_EN bit
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20171122090427.12371-1-kishon@ti.com>
 <20171122113749.GA26278@red-moon>
 <1c958730-e50e-06ea-84b5-592e63ddeb87@ti.com>
 <20171122145847.GA14754@e107981-ln.cambridge.arm.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <nsekhar@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Niklas Cassel <niklas.cassel@axis.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <50149a0c-e0e7-76f8-afa5-b67cb30d328f@ti.com>
Date: Mon, 27 Nov 2017 18:31:26 +0530
MIME-Version: 1.0
In-Reply-To: <20171122145847.GA14754@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Wednesday 22 November 2017 08:28 PM, Lorenzo Pieralisi wrote:
> On Wed, Nov 22, 2017 at 05:24:21PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On Wednesday 22 November 2017 05:07 PM, Lorenzo Pieralisi wrote:
>>> On Wed, Nov 22, 2017 at 02:34:27PM +0530, Kishon Vijay Abraham I wrote:
>>>> ->get_msi() now checks MSI_EN bit in the MSI CAPABILITY register to
>>>> find whether the host supports MSI instead of using the
>>>> MSI ADDRESS in the MSI CAPABILITY register.
>>>
>>> I think that's a sensible thing to do regardless, given that I do not
>>> understand why 0x0 can't be a valid MSI address in the first place.
>>>
>>>> This fixes the issue with the following sequence
>>>>   'modprobe pci_endpoint_test' enables MSI
>>>>   'rmmod pci_endpoint_test' disables MSI but MSI address has a valid value
>>>>   'modprobe pci_endpoint_test no_msi=1' - Since MSI address has a valid
>>>> 	value (set during the previous insertion of the module), EP
>>
>> MSI address is written in the MSI capabiltiy register by the host.
>>>
>>> Where is the address set ?
>>>
>>>> 	thinks host supports MSI.
>>>
>>> Add a Fixes: tag please.
>>
>> sure.
>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/pci/dwc/pcie-designware-ep.c | 12 +++---------
>>>>  drivers/pci/dwc/pcie-designware.h    |  1 +
>>>>  2 files changed, 4 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
>>>> index d53d5f168363..7c621877a939 100644
>>>> --- a/drivers/pci/dwc/pcie-designware-ep.c
>>>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>>>> @@ -197,20 +197,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, phys_addr_t addr,
>>>>  static int dw_pcie_ep_get_msi(struct pci_epc *epc)
>>>>  {
>>>>  	int val;
>>>> -	u32 lower_addr;
>>>> -	u32 upper_addr;
>>>>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>>>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>>>  
>>>> -	val = dw_pcie_readb_dbi(pci, MSI_MESSAGE_CONTROL);
>>>> -	val = (val & MSI_CAP_MME_MASK) >> MSI_CAP_MME_SHIFT;
>>>> -
>>>> -	lower_addr = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_L32);
>>>> -	upper_addr = dw_pcie_readl_dbi(pci, MSI_MESSAGE_ADDR_U32);
>>>
>>> I can't find code that writes these registers, see above for my
>>> question.
>>
>> IIUC the host will write to these registers in __pci_write_msi_msg using the
>> configuration writes.
>>>
>>> On top of that I think that what's done the EPF test function driver in
>>> struct pci_epf.bind() should be undone in struct pci_epf.unbind() and I
>>> do not think that's happening for MSIs.
>>>
>>>> -
>>>> -	if (!(lower_addr || upper_addr))
>>>> +	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
>>>
>>> MSI_MESSAGE_CONTROL is written in dw_pcie_ep_set_msi(), I assume a write
>>> to bit[0] (ie MSI_CAP_MSI_EN_MASK) is ignored - it would be good if you
>>> can clarify that as well please.
>>
>> Do you mean dw_pcie_ep_set_msi can overwrite MSI_CAP_MSI_EN and we should avoid
>> that?
> 
> Yes, I think there are a lot of assumptions here. IIUC the sequence you
> expect this to work is:
> 
> 1) EP system (ie system where the EP is located) is brought up and EP is
>    configured (inclusive of MSI)

right. Here only the number of MSI's required by the EP is configured. The host
is responsible for enabling MSI after programming the MSI address and data.

The EP function driver should also come up here. The BAR registers and the
number of MSIs required by the EP function will be configured by the function
driver.

Once the EP function driver has been fully configured, pci_epc_start() should
be invoked which starts the link. Without this the host will not see the EP device.
> 2) host boots and enumerates PCI devices (which includes the EP)
> 3) host EP PCI driver probes and configure MSI, etc

right.
> 4) EP system runs EP function test and to understand what the host
>    system enabled on the endpoint (eg PCI EP test function driver using
>    MSIs) you rely on capabilities registers host system settings that
>    are reflected in the EP registers

Yeah. it shouldn't try to raise MSI interrupts when host has not enabled it.
The pci-epf-test driver which is there in the kernel monitors it's MEM_SPACE
registers to see if the host has issued any commands (read or write) and
performs the appropriate function.
> 
> Is my understanding correct ?
> 
> So basically the PCI EP test function works as software IP whose
> behaviour is controlled by the EP system kernel/userspace.
> 
> There are obvious syncronization assumptions here - the whole thing
> is racy by design (inclusive of the stepwise boot sequence above)

Given that two different systems can access the same physical memory, the
drivers has to be written with caution.

For instance, the EP function drivers shouldn't modify pci configuration space
registers after epc_start.
> but if my understanding above is correct I think this patch is the
> right way of handling it.
> 
> I wonder how this is going to work if the EP function BARs map a real
> device (eg USB), please let me know your thoughts on that.

The EP function driver should setup the endpoint controller to be used as a USB
by the host. At a high level, it has to perform the following 4 operations.
1) Identify itself as a USB PCI device.
2) map BAR's to USB registers
3) Forwarding interrupts
4) EP as bus master accessing host's buffer address

1st step can be achieved by using pci_epc_write_header() (vendorid and deviceid
should bind it to xhci-pci driver)

2nd step can be done by using pci_epc_set_bar() (here the USB registers base
address, size of the USB register space should be passed. These can be obtained
from the dt for instance. It has to be made sure if a particular controller is
being exposed to the PCI host, it shouldn't be used locally... move the USB dt
node from ocp bus to be the child node of endpoint dt node??)

3rd step. Even though the driver for programming the USB controller is in the
host system, the interrupts will be received in the EP system. The EP function
driver should register an interrupt handler for the USB controllers IRQ
(obtained from dt) and the handler should invoke pci_epc_raise_irq() to forward
the interrupt.
(What if the USB controller raises lot of interrupts before the first interrupt
is handled..?? this can be a separate discussion)

So far there hasn't been any modification to the standard host side driver.
But in the 4th step where the host driver might program the URB address (host
DDR address) in a register present the EPs MEM_SPACE, If the USB controller can
directly access the PCI address, then standard xhci-pci driver should suffice.

However if the USB controller cannot access PCI address space (which is the
case in dra7x SoC's) directly then using standard xhci driver won't make much
sense and a custom host side driver and a corresponding EP function driver
should be written).

This limitation will be for any controllers that can act as a master. But say
you have a MMC controller which uses host's system DMA, the programming will be
simpler. The MMC controller with ADMA2 might not be so simpler.

Thanks
Kishon
