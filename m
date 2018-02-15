Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: dwc: pci-dra7xx: Improve MSI IRQ handling
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180209120415.17590-1-vigneshr@ti.com>
 <20180209120415.17590-3-vigneshr@ti.com>
 <20180212175801.GA29070@e107981-ln.cambridge.arm.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <7cfa73af-09fa-d298-aaab-3e74ee7e1dd5@ti.com>
Date: Thu, 15 Feb 2018 09:59:21 +0530
MIME-Version: 1.0
In-Reply-To: <20180212175801.GA29070@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Monday 12 February 2018 11:28 PM, Lorenzo Pieralisi wrote:
> On Fri, Feb 09, 2018 at 05:34:14PM +0530, Vignesh R wrote:
>> We need to ensure that there are no pending MSI IRQ vector set (i.e
>> PCIE_MSI_INTR0_STATUS reads 0 at least once) before exiting
>> dra7xx_pcie_msi_irq_handler(). Else, the dra7xx PCIe wrapper will not
>> register new MSI IRQs even though PCIE_MSI_INTR0_STATUS shows IRQs are
>> pending. Therefore, keep calling dra7xx_pcie_msi_irq_handler() until it
>> returns IRQ_NONE, which suggests that PCIE_MSI_INTR0_STATUS is 0.
>> 
>> This fixes a bug, where PCIe wifi cards with 4 DMA queues like Intel
>> 8260 used to throw following error and stall during ping/iperf3 tests.
>> 
>> [   97.776310] iwlwifi 0000:01:00.0: Queue 9 stuck for 2500 ms.
>> 
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/pci/dwc/pci-dra7xx.c | 21 ++++++++++++++++++---
>>  1 file changed, 18 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>> index ed8558d638e5..3420cbf7b60a 100644
>> --- a/drivers/pci/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>> @@ -254,14 +254,31 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>>        struct dra7xx_pcie *dra7xx = arg;
>>        struct dw_pcie *pci = dra7xx->pci;
>>        struct pcie_port *pp = &pci->pp;
>> +     int count = 0;
>>        unsigned long reg;
>>        u32 virq, bit;
>>  
>>        reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
>> +     dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
>>  
>>        switch (reg) {
>>        case MSI:
>> -             dw_handle_msi_irq(pp);
>> +             /*
>> +              * Need to make sure no MSI IRQs are pending before
>> +              * exiting handler, else the wrapper will not catch new
>> +              * IRQs. So loop around till dw_handle_msi_irq() returns
>> +              * IRQ_NONE
>> +              */
>> +             while (dw_handle_msi_irq(pp) != IRQ_NONE && count < 1000)
>> +                     count++;
>> +
>> +             if (count == 1000) {
>> +                     dev_err(pci->dev, "too much work in msi irq\n");
>> +                     dra7xx_pcie_writel(dra7xx,
>> +                                        PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
>> +                                        reg);
>> +                     return IRQ_HANDLED;
> 
> I am not merging any code patching this IRQ handling routine anymore
> unless you thoroughly explain to me how this CONF_IRQSTATUS_MSI register
> works (and how it is related to DW registers) and why this specific host
> controller needs handling that is not required by any other host
> controller relying on dw_handle_msi_irq().

Unlike other DW PCIe controllers, TI implementation has a wrapper on top
of DW core. This wrapper latches the DW core level MSI and legacy
interrupts and then propagates it to GIC.
PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI register is present in this TI
wrapper which aggregates all the MSI IRQs(PCIE_MSI_INTR0_STATUS) of DW
level. They are mapped on the MSI interrupt line of PCIe controller,
using a single status bit in the PCIECTRL_TI_CONF_IRQSTATUS_MSI register.

So, the irq handler, dra7xx_pcie_msi_irq_handler(), first needs to look
at PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI[4] to know that its MSI IRQ and
then call dw_handle_msi_irq() to handle individual MSI vectors.
Driver has to make sure there are no pending vectors in DW core MSI
status register before exiting handler. Otherwise next MSI IRQ will not
be latched by the wrapper.


> 
> I suspect there is a code design flaw with the way this host handles
> IRQs and we are going to find it and fix it the way it should, not with
> any plaster like this patch.
> 

I agree there has been some churn wrt this wrapper level IRQ handler.
But, that was because hardware documentation/TRM did not match
actual behavior and so it took some time to understand how the
hardware is working. I have extensively tested this series on multiple
problematic PCIe USB cards and PCIe WiFi cards over week long stress
tests. And also had some agreement with internal hardware designers.
Hardware documentations will also be updated.


> Lorenzo
> 
>> +             }
>>                break;
>>        case INTA:
>>        case INTB:
>> @@ -275,8 +292,6 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>>                break;
>>        }
>>  
>> -     dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
>> -
>>        return IRQ_HANDLED;
>>  }
>>  
>> -- 
>> 2.16.1
>> 

-- 
Regards
Vignesh
