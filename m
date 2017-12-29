Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:52029 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754860AbdL2KL2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 05:11:28 -0500
Subject: Re: [PATCH v3 7/9] pci: keystone SoC driver adapted to new irq API
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
 <d814c419df5591f9170223d61388a0af746577c4.1514455857.git.gustavo.pimentel@synopsys.com>
 <10d22382-4914-da3b-a842-eb33693c7a83@ti.com>
 <000201d37ff6$dbdb6fb0$93924f10$@gmail.com>
 <f176417f-604a-16d2-aeff-d6733ffd4ae6@synopsys.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>,
        "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>,
        "tie-fei.zang@freescale.com" <tie-fei.zang@freescale.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c9b96832-5aa5-7e36-d130-c06ef7a0db1f@ti.com>
Date: Fri, 29 Dec 2017 15:40:52 +0530
MIME-Version: 1.0
In-Reply-To: <f176417f-604a-16d2-aeff-d6733ffd4ae6@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On Friday 29 December 2017 03:03 PM, Gustavo Pimentel wrote:
> Hi Jingoo and Kishon,
> 
> On 28/12/2017 16:13, Jingoo Han wrote:
>> On Thursday, December 28, 2017 7:44 AM, Kishon Vijay Abraham I wrote:
>>>
>>> Hi Gustavo,
>>>
>>> On Thursday 28 December 2017 05:26 PM, Gustavo Pimentel wrote:
>>>> This patch adapts Keystone SoC specific driver to use the new interrupt
>>> api
>>>> available in pcie-designware. A new callback was added to
>>> dw_pcie_host_ops
>>>> to handle a specific Keystone function and msi_host_init callback is
>>>> changed to simplify the access to pci data structure for keystone all
>>> SoC
>>>> drivers that use the structure.
>>>>
>>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>> ---
>>>> Change v1->v2:
>>>> - Removed hardcoded num_vectors configuration (now it is done in the
>>> core driver by default)
>>>> Change v2->v3:
>>>> -
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>  drivers/pci/dwc/pci-keystone-dw.c      | 88
>> ++---------------------------
>>> -----
>>>>  drivers/pci/dwc/pci-keystone.c         |  1 +
>>>>  drivers/pci/dwc/pci-keystone.h         |  4 +-
>>>>  drivers/pci/dwc/pci-layerscape.c       |  3 +-
>>>>  drivers/pci/dwc/pcie-designware-host.c | 19 ++++++--
>>>>  drivers/pci/dwc/pcie-designware.h      |  3 +-
>>>
>>> The designware specific patches should be part of
>>> "[1/9] pci: adding new irq api to pci-designware"
> 
> Ok, I will move your (Kishon) fixes to the 0001 patch file, no problem.
> 
>>>
>>> Also layerscap is not related to $subject.
> 
> Please note there are some initial changes on this patch (maybe they could be in
> a isolated patch) related to pci-layerscape.c, pcie-designware-host.c and
> pcie-designware.h files that changes the msi_host_init callback signature and
> this affects the Keystone, Layerscape drivers and the core at the same time,
> that's the reason why this modification touches on these three files and should
> be together.
> Was I able to pass this information clearly?

Got it. $subject or the commit message didn't have that information. However as
I've commented on your patch, it's better if we keep the signature of
msi_host_init as it is.

Thanks
Kishon
