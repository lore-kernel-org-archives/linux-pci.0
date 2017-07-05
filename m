Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbdGEP0p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jul 2017 11:26:45 -0400
Subject: Re: [PATCH v2 0/9] add new irq api to pcie-designware
To: Joao Pinto <Joao.Pinto@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>, bhelgaas@google.com
References: <cover.1496677911.git.jpinto@synopsys.com>
 <593F0533.4010106@ti.com> <b479290b-7c6d-19c3-8853-416dc7d65dc6@synopsys.com>
 <5949445C.3010706@ti.com> <7e6c5468-43ff-2757-bb31-e1c7d7886198@synopsys.com>
 <594955BC.3010703@ti.com> <45e93a6e-122a-398f-d547-dd3ebf88aeae@synopsys.com>
Cc: thomas.petazzoni@free-electrons.com, minghuan.Lian@freescale.com,
        mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        niklas.cassel@axis.com, jesper.nilsson@axis.com,
        wangzhou1@hisilicon.com, gabriele.paoloni@huawei.com,
        svarbanov@mm-sol.com, linux-pci@vger.kernel.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <a6380712-214b-990b-69e3-e3889835879b@arm.com>
Date: Wed, 5 Jul 2017 16:26:36 +0100
MIME-Version: 1.0
In-Reply-To: <45e93a6e-122a-398f-d547-dd3ebf88aeae@synopsys.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/07/17 11:57, Joao Pinto wrote:
> Às 6:05 PM de 6/20/2017, Murali Karicheri escreveu:
>> On 06/20/2017 12:28 PM, Joao Pinto wrote:
>>> Às 4:50 PM de 6/20/2017, Murali Karicheri escreveu:
>>>> On 06/19/2017 12:31 PM, Joao Pinto wrote:
>>>>>
>>>>> Hi Murali,
>>>>>
>>>>> Às 10:18 PM de 6/12/2017, Murali Karicheri escreveu:
>>>>>> Joao,
>>>>>>
>>>>>> On 06/05/2017 12:19 PM, Joao Pinto wrote:
>>>>>>> This patch series adds the new interrupt api to pcie-designware
>>>>>>> make it possible to use features like MSIX.
>>>>>>>
>>>>>>> The work consisted of adapting the pcie-designware-host and each SoC
>>>>>>> specific driver.
>>>>>>>
>>>>>>> The patch set was made against the Bjorn' next branch.
>>>>>>>
>>>>>>> Joao Pinto (9):
>>>>>>>   pci: adding new irq api to pci-designware
>>>>>>>   pci: exynos SoC driver adapted to new irq API
>>>>>>>   pci: imx6 SoC driver adapted to new irq API
>>>>>>>   pci: artpec6 SoC driver adapted to new irq API
>>>>>>>   pci: generic PCIe DW driver adapted to new irq API
>>>>>>>   pci: qcom SoC driver adapted to new irq API
>>>>>>>   pci: keystone SoC driver adapted to new irq API
>>>>>>>   pci: removing old irq api from pcie-designware
>>>>>>>   pci: remove limitation of the number of the available IRQs
>>>>>>>
>>>>>>>  drivers/pci/dwc/pci-exynos.c           |  18 --
>>>>>>>  drivers/pci/dwc/pci-imx6.c             |  18 --
>>>>>>>  drivers/pci/dwc/pci-keystone-dw.c      |  96 +-------
>>>>>>>  drivers/pci/dwc/pci-keystone.c         |   1 +
>>>>>>>  drivers/pci/dwc/pci-keystone.h         |   4 +-
>>>>>>>  drivers/pci/dwc/pci-layerscape.c       |   4 +-
>>>>>>>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>>>>>>>  drivers/pci/dwc/pcie-designware-host.c | 395 +++++++++++++++++++--------------
>>>>>>>  drivers/pci/dwc/pcie-designware-plat.c |  15 --
>>>>>>>  drivers/pci/dwc/pcie-designware.h      |  30 ++-
>>>>>>>  drivers/pci/dwc/pcie-qcom.c            |  15 --
>>>>>>>  11 files changed, 255 insertions(+), 359 deletions(-)
>>>>>>>
>>>>>>
>>>>>> I gave this a try today and it failed. Logs at
>>>>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__pastebin.ubuntu.com_24843963_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=FR_WRctJN74GGjjHco1VUqNfINiGA7lGruObX4bplAY&s=8QYJU-SCW5JEmMwLUqbOEBJA5hio9vIyeNyotVRos4Q&e= 
>>>>>>
>>>>>> The first part of the log is with your patch series.
>>>>>> The second part is before applying the patch. You will see
>>>>>> that there is qc timeout log that shows the issue
>>>>>>
>>>>>> [   12.791852] ata2.00: qc timeout (cmd 0xec)
>>>>>> [   12.795947] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>>>>> [   12.802061] ata2: limiting SATA link speed to 3.0 Gbps
>>>>>> [   13.301853] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
>>>>>> [   23.511852] ata2.00: qc timeout (cmd 0xec)
>>>>>> [   23.515947] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>>>>> [   24.021850] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
>>>>>>
>>>>>> Is there any DT change I need to make for this? I didn't have a
>>>>>> chance to review your patch w.r.t Keystone. But I see you have change
>>>>>> the MSI IRq handling.
>>>>>>
>>>>>
>>>>> There is no need to change your DT. I think I will need to debug this issue
>>>>> further. Could you please advice a board containing this SoC?
>>>>>
>>>> I think I may be able to work with you on this. Keystone has different 
>>>> register set for MSI IRQ. It is in application space. Also there are
>>>> 8 interrupts to ARM GIC that multiplexes the 32 MSI interrupts. So
>>>> please review the original code vs the changed one w.r.t to this. I haven't
>>>> had a chance to review the code as I am in the middle of a release.
>>>> But will be able to spend some time after two weeks. Meanwhile please
>>>> spend some time reviewing the code and exchange email to identify
>>>> the issue. I can add specific debug prints for you as well and provide
>>>> you the log for analysis.
>>>
>>> Ok, I agree! Thanks!
>>>
>>>>
>> Look at this logic in the patch where a potential issue exists for Keystone.
>>
>> +static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
>> +{
>> +       struct dw_pcie *pci = irq_data_get_irq_chip_data(data);
>> +       struct pcie_port *pp = &pci->pp;
>> +       u64 msi_target;
>> +
>> +       if (pp->ops->get_msi_addr)
>> +               msi_target = pp->ops->get_msi_addr(pp);
>> +       else
>> +               msi_target = virt_to_phys((void *)pp->msi_data);
>> +
>> +       msg->address_lo = lower_32_bits(msi_target);
>> +       msg->address_hi = upper_32_bits(msi_target);
>> +
>> +       if (pp->ops->get_msi_data)
>> +               msg->data = pp->ops->get_msi_data(pp, data->hwirq);
>> +       else
>> +               msg->data = data->hwirq;
>> +
>> +       dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
>> +               (int)data->hwirq, msg->address_hi, msg->address_lo);
>> +}
>>
>> Keystone has 8 hw irqs, 4 multiplexed over each since the register
>> set is different than other DWC cores. So will not work for Keystone,
>> right?
> 
> Well, that can be challenging, since it is a very particular operation.
> Maybe we should implement a _pci_setup_msi_msg in the keystone driver and
> overide this one if necessary. What do you think?

At that rate, and given that keystone seems to override almost all
operations in this driver, wouldn't it make sense for this to be
implemented as a *separate* driver?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
