Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:34028 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdFTQ20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2017 12:28:26 -0400
Subject: Re: [PATCH v2 0/9] add new irq api to pcie-designware
To: Murali Karicheri <m-karicheri2@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, <bhelgaas@google.com>,
        <marc.zyngier@arm.com>
CC: <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <svarbanov@mm-sol.com>,
        <linux-pci@vger.kernel.org>
References: <cover.1496677911.git.jpinto@synopsys.com>
 <593F0533.4010106@ti.com> <b479290b-7c6d-19c3-8853-416dc7d65dc6@synopsys.com>
 <5949445C.3010706@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <7e6c5468-43ff-2757-bb31-e1c7d7886198@synopsys.com>
Date: Tue, 20 Jun 2017 17:28:18 +0100
MIME-Version: 1.0
In-Reply-To: <5949445C.3010706@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Às 4:50 PM de 6/20/2017, Murali Karicheri escreveu:
> On 06/19/2017 12:31 PM, Joao Pinto wrote:
>>
>> Hi Murali,
>>
>> Às 10:18 PM de 6/12/2017, Murali Karicheri escreveu:
>>> Joao,
>>>
>>> On 06/05/2017 12:19 PM, Joao Pinto wrote:
>>>> This patch series adds the new interrupt api to pcie-designware
>>>> make it possible to use features like MSIX.
>>>>
>>>> The work consisted of adapting the pcie-designware-host and each SoC
>>>> specific driver.
>>>>
>>>> The patch set was made against the Bjorn' next branch.
>>>>
>>>> Joao Pinto (9):
>>>>   pci: adding new irq api to pci-designware
>>>>   pci: exynos SoC driver adapted to new irq API
>>>>   pci: imx6 SoC driver adapted to new irq API
>>>>   pci: artpec6 SoC driver adapted to new irq API
>>>>   pci: generic PCIe DW driver adapted to new irq API
>>>>   pci: qcom SoC driver adapted to new irq API
>>>>   pci: keystone SoC driver adapted to new irq API
>>>>   pci: removing old irq api from pcie-designware
>>>>   pci: remove limitation of the number of the available IRQs
>>>>
>>>>  drivers/pci/dwc/pci-exynos.c           |  18 --
>>>>  drivers/pci/dwc/pci-imx6.c             |  18 --
>>>>  drivers/pci/dwc/pci-keystone-dw.c      |  96 +-------
>>>>  drivers/pci/dwc/pci-keystone.c         |   1 +
>>>>  drivers/pci/dwc/pci-keystone.h         |   4 +-
>>>>  drivers/pci/dwc/pci-layerscape.c       |   4 +-
>>>>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>>>>  drivers/pci/dwc/pcie-designware-host.c | 395 +++++++++++++++++++--------------
>>>>  drivers/pci/dwc/pcie-designware-plat.c |  15 --
>>>>  drivers/pci/dwc/pcie-designware.h      |  30 ++-
>>>>  drivers/pci/dwc/pcie-qcom.c            |  15 --
>>>>  11 files changed, 255 insertions(+), 359 deletions(-)
>>>>
>>>
>>> I gave this a try today and it failed. Logs at
>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__pastebin.ubuntu.com_24843963_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=FR_WRctJN74GGjjHco1VUqNfINiGA7lGruObX4bplAY&s=8QYJU-SCW5JEmMwLUqbOEBJA5hio9vIyeNyotVRos4Q&e= 
>>>
>>> The first part of the log is with your patch series.
>>> The second part is before applying the patch. You will see
>>> that there is qc timeout log that shows the issue
>>>
>>> [   12.791852] ata2.00: qc timeout (cmd 0xec)
>>> [   12.795947] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>> [   12.802061] ata2: limiting SATA link speed to 3.0 Gbps
>>> [   13.301853] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
>>> [   23.511852] ata2.00: qc timeout (cmd 0xec)
>>> [   23.515947] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>>> [   24.021850] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
>>>
>>> Is there any DT change I need to make for this? I didn't have a
>>> chance to review your patch w.r.t Keystone. But I see you have change
>>> the MSI IRq handling.
>>>
>>
>> There is no need to change your DT. I think I will need to debug this issue
>> further. Could you please advice a board containing this SoC?
>>
> I think I may be able to work with you on this. Keystone has different 
> register set for MSI IRQ. It is in application space. Also there are
> 8 interrupts to ARM GIC that multiplexes the 32 MSI interrupts. So
> please review the original code vs the changed one w.r.t to this. I haven't
> had a chance to review the code as I am in the middle of a release.
> But will be able to spend some time after two weeks. Meanwhile please
> spend some time reviewing the code and exchange email to identify
> the issue. I can add specific debug prints for you as well and provide
> you the log for analysis.

Ok, I agree! Thanks!

> 
> Let me know.
> 
> Murali
>> Thanks.
>>
>>
>>
>>
> 
> 
