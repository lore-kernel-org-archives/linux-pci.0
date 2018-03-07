Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37659 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeCGKq5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 05:46:57 -0500
Subject: Re: [PATCH v11 0/4] PCI: dwc: Enables MSI-X driver support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>,
        "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>,
        "tie-fei.zang@freescale.com" <tie-fei.zang@freescale.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
References: <cover.1520358461.git.gustavo.pimentel@synopsys.com>
 <20180306182207.GA3208@e107981-ln.cambridge.arm.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <d4ef4765-6a66-fcbf-92e8-9e3cc6b991c2@synopsys.com>
Date: Wed, 7 Mar 2018 10:46:30 +0000
MIME-Version: 1.0
In-Reply-To: <20180306182207.GA3208@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 06/03/2018 18:22, Lorenzo Pieralisi wrote:
> On Tue, Mar 06, 2018 at 05:54:26PM +0000, Gustavo Pimentel wrote:
>> Implement a multiplexed IRQ domain hierarchy API in the pcie-designware
>> host bridge driver that funnels all MSI IRQs into a single parent
>> interrupt, moving away from the obsolete struct msi_controller based
>> API.
>>
>> Remove all existing dwc based host bridges MSI IRQs handlers, in that the
>> hierarchical API now handles MSI IRQs through the hierarchical/chained
>> MSI domain implementation.
>>
>> The Synopsys PCIe Root Complex supports up to MSI 256 IRQs distributed
>> over 8 controller registers, therefore the maximum number of MSI IRQs
>> can be changed to 256. The number of controllers can be calculated based
>> on the number of vectors used by the specific SoC driver.
>>
>> Adds Synopsys Root Complex driver support for MSI-X feature.
>>
>> The patch set was made against the Bjorn's master branch (v4.16-rc1).
>>
>> Gustavo Pimentel (4):
>>   PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API
>>   PCI: dwc: Remove old MSI IRQs API
>>   PCI: dwc: Expand maximum number of MSI IRQs from 32 to 256
>>   PCI: dwc: Code cleanup
> 
> Ok, so a couple of suggestions:
> 
> 0) Remove Gabriele from the CC list - his email must be bouncing for you too
>    right ?
Done.
> 1) Consider patches on my pci/dwc-msi branch immutable from now onwards,
>    that's important for me and other maintainers CC'ed
Ok.
> 2) Related to (1), first 3 patches must NOT be posted againI thought it was mandatory to ensure the cleanup patch would be attached to that
series, if not, it's even better :) I'll assume that you will guarantee that
then, since you are aware of it, right?
> 3) Patch (4) is a potpourri of clean-ups. It is tempting to squash
>    all clean ups in one patch but every patch has to be *logically*
>    split so that it contains one logical change. I will comment on it.
>    You will need to split patch (4) and repost it, but first trim the
>    CC list, do not copy any maintainer other than pci/dwc ones on the series
>    resulting from patch (4) rework.
I'll split the patch in several and also rebased against your pci/dwc-msi branch.
I'll waiting your and others feedback :)
> 
> If there is anything unclear please do let me know.
Ok, thank you for teaching me. The next time will be better, for sure!
> 
> Thanks,
> Lorenzo
> 
Thanks,
Gustavo
