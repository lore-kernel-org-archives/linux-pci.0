Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42762 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdLUOIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Dec 2017 09:08:44 -0500
Subject: Re: Re-activate task to add MSI-X to pcie-designware
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>,
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
        linux-pci <linux-pci@vger.kernel.org>
References: <647c9bb3-94f6-a138-fbde-e946c105d517@synopsys.com>
 <20171208110225.GC26816@red-moon>
 <9ede58a6-7c0d-ae66-4e15-147234cbad6d@ti.com>
 <69f78abd-f83e-b3a6-0daf-638f89d07f99@synopsys.com>
 <8771860f-babd-afcb-ed07-2642d2a4d6a8@ti.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <0531c3e9-57e7-d531-1bee-a5a5bbff2a8c@synopsys.com>
Date: Thu, 21 Dec 2017 14:08:38 +0000
MIME-Version: 1.0
In-Reply-To: <8771860f-babd-afcb-ed07-2642d2a4d6a8@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/12/2017 13:03, Kishon Vijay Abraham I wrote:This is our most recent
version of the patches that are running on our equipment, please check with yours
> Hi,
> 
> On Monday 18 December 2017 09:31 PM, Gustavo Pimentel wrote:
>> Hi Kishon,
>>
>> I would like to collaborate with you on this subject, I have on my side João's
>> patches updated to the Bjorn's latest kernel version.
> 
> cool, do you have a branch so that I can check what breaks in keystone and debug?
> 
Unfortunately not, however I'll mailed you the patches immediately.
Once again, thanks.

Gustavo

> Thanks
> Kishon
>>
>> Regards,
>>
>> Gustavo
>>
>>
>> On 11/12/2017 13:23, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Friday 08 December 2017 04:32 PM, Lorenzo Pieralisi wrote:
>>>> On Thu, Dec 07, 2017 at 03:14:22PM +0000, Joao Pinto wrote:
>>>>> Hello to all,
>>>>>
>>>>> I am sending this e-mail to request your opinion about the tasks needed to add
>>>>> support for MSI-X for pcie-designware based solutions.
>>>>>
>>>>> A few months ago I submited a patch-set that added support for MSI-X:
>>>>>
>>>>> [v2,9/9] pci: remove limitation of the number of the available IRQs
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_771320_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=fBQ8uqCEYYa2ogSRPy8cR1jhWPLboPICkxUdpcYB6Yw&s=p3N21H26OSEMkCxG6P0d-nO2j8dsNTPY3vyU1QDWjT0&e=
>>>>> [v2,8/9] pci: removing old irq api from pcie-designware
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_771360_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=fBQ8uqCEYYa2ogSRPy8cR1jhWPLboPICkxUdpcYB6Yw&s=qQWZngqGOJ1ILhY65f3YL6xrgp_5UXRR0NrDlSaHSTQ&e=
>>>>> [v2,7/9] pci: keystone SoC driver adapted to new irq API
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_771361_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=fBQ8uqCEYYa2ogSRPy8cR1jhWPLboPICkxUdpcYB6Yw&s=4J5yDyNZ0Hp9AD75kGoIjfyT-dr7gWoj5B3XO4cx7Q0&e=
>>>>> [v2,6/9] pci: qcom SoC driver adapted to new irq API
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_771362_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=fBQ8uqCEYYa2ogSRPy8cR1jhWPLboPICkxUdpcYB6Yw&s=KpC3k1Y_c4guyLRzb-w5H_Kglt6KWYb8Xk7iWsZqkzY&e=
>>>>> [v2,5/9] pci: generic PCIe DW driver adapted to new irq API
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_771365_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=fBQ8uqCEYYa2ogSRPy8cR1jhWPLboPICkxUdpcYB6Yw&s=TNoIYF7RaBl7jXnmFrFSIJD1a_vNJL2IKTYPbaJEpww&e=
>>>>> [v2,4/9] pci: artpec6 SoC driver adapted to new irq API
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_771364_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=fBQ8uqCEYYa2ogSRPy8cR1jhWPLboPICkxUdpcYB6Yw&s=p9aOuvgKv8e74QNe5XxXiI7gfvkPeCeanhs6i3FBwnc&e=
>>>>> [v2,3/9] pci: imx6 SoC driver adapted to new irq API
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_771363_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=fBQ8uqCEYYa2ogSRPy8cR1jhWPLboPICkxUdpcYB6Yw&s=ibzCdKoVbLHn-0vo9tzAlnirwgZZsDpILRkTEowHwWs&e=
>>>>> [v2,2/9] pci: exynos SoC driver adapted to new irq API
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_771359_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=fBQ8uqCEYYa2ogSRPy8cR1jhWPLboPICkxUdpcYB6Yw&s=D0dvpjeXB-BTo69WreBpia6vlml1pBysJU6ta-9cLOM&e=
>>>>> [v2,1/9] pci: adding new irq api to pci-designware
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_771366_&d=DwIC-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=fBQ8uqCEYYa2ogSRPy8cR1jhWPLboPICkxUdpcYB6Yw&s=Wu_iKSHepvoDa3X5gU02AMMa9yzAgrT2jIfiu6jHgPs&e=
>>>>>
>>>>> The patch-set was globally accepted, but it broke the MSI mechanism for
>>>>> Keystone, due to its specificity.
>>>> Hi Joao,
>>>>
>>>> would you mind pointing me at the discussion where the breakage was
>>>> explained please ? It is to understand what are the TI specific bits
>>>> we are talking about here.
>>>>
>>>>> We are now going to resume this task and we would like to have your feedback
>>>>> about our plan:
>>>>>
>>>>> Task 1: Help TI to create a keystone_msi driver to isolate its custom msi mechanism
>>>>> Task 2: Port the existing patches to the new kernel version (except the keystone
>>>>> one)
>>>>>
>>>>> If TI can do the keystone_msi implementation it would be easier. If it's not
>>>>> possible, we volunteer to do it, but we will need testing & debug assistance.
>>> sure, I should be able to help with at-least testing if not implementing.
>>>
>>> Thanks
>>> Kishon
>>
>>
