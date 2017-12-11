Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:42199 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdLKN03 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Dec 2017 08:26:29 -0500
Subject: Re: Re-activate task to add MSI-X to pcie-designware
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <647c9bb3-94f6-a138-fbde-e946c105d517@synopsys.com>
 <20171208110225.GC26816@red-moon>
CC: Murali Karicheri <m-karicheri2@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        <Gustavo.Pimentel@synopsys.com>,
        linux-pci <linux-pci@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9ede58a6-7c0d-ae66-4e15-147234cbad6d@ti.com>
Date: Mon, 11 Dec 2017 18:53:31 +0530
MIME-Version: 1.0
In-Reply-To: <20171208110225.GC26816@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 08 December 2017 04:32 PM, Lorenzo Pieralisi wrote:
> On Thu, Dec 07, 2017 at 03:14:22PM +0000, Joao Pinto wrote:
>> Hello to all,
>>
>> I am sending this e-mail to request your opinion about the tasks needed to add
>> support for MSI-X for pcie-designware based solutions.
>>
>> A few months ago I submited a patch-set that added support for MSI-X:
>>
>> [v2,9/9] pci: remove limitation of the number of the available IRQs
>> https://patchwork.ozlabs.org/patch/771320/
>> [v2,8/9] pci: removing old irq api from pcie-designware
>> https://patchwork.ozlabs.org/patch/771360/
>> [v2,7/9] pci: keystone SoC driver adapted to new irq API
>> https://patchwork.ozlabs.org/patch/771361/
>> [v2,6/9] pci: qcom SoC driver adapted to new irq API
>> https://patchwork.ozlabs.org/patch/771362/
>> [v2,5/9] pci: generic PCIe DW driver adapted to new irq API
>> https://patchwork.ozlabs.org/patch/771365/
>> [v2,4/9] pci: artpec6 SoC driver adapted to new irq API
>> https://patchwork.ozlabs.org/patch/771364/
>> [v2,3/9] pci: imx6 SoC driver adapted to new irq API
>> https://patchwork.ozlabs.org/patch/771363/
>> [v2,2/9] pci: exynos SoC driver adapted to new irq API
>> https://patchwork.ozlabs.org/patch/771359/
>> [v2,1/9] pci: adding new irq api to pci-designware
>> https://patchwork.ozlabs.org/patch/771366/
>>
>> The patch-set was globally accepted, but it broke the MSI mechanism for
>> Keystone, due to its specificity.
> 
> Hi Joao,
> 
> would you mind pointing me at the discussion where the breakage was
> explained please ? It is to understand what are the TI specific bits
> we are talking about here.
> 
>> We are now going to resume this task and we would like to have your feedback
>> about our plan:
>>
>> Task 1: Help TI to create a keystone_msi driver to isolate its custom msi mechanism
>> Task 2: Port the existing patches to the new kernel version (except the keystone
>> one)
>>
>> If TI can do the keystone_msi implementation it would be easier. If it's not
>> possible, we volunteer to do it, but we will need testing & debug assistance.

sure, I should be able to help with at-least testing if not implementing.

Thanks
Kishon
