Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:12766 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755159AbdJRMMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2017 08:12:09 -0400
Subject: Re: [PATCH 1/2] PCI: dwc: dra7xx: Create functional dependency
 between PCIe and PHY
To: Roger Quadros <rogerq@ti.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20171009090338.26033-1-kishon@ti.com>
 <20171009090338.26033-2-kishon@ti.com>
 <f258c2f0-11a2-60ac-3919-dcc0badfa870@ti.com>
 <ac5b3f42-19a1-3f8d-3bb6-37d63c3574de@ti.com>
 <9dce2e30-a245-460d-a808-a733eaf7ffec@ti.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2375dfac-b68c-4a94-89ed-fb850ba5579f@ti.com>
Date: Wed, 18 Oct 2017 17:42:05 +0530
MIME-Version: 1.0
In-Reply-To: <9dce2e30-a245-460d-a808-a733eaf7ffec@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 10 October 2017 01:29 PM, Roger Quadros wrote:
> On 10/10/17 10:42, Kishon Vijay Abraham I wrote:
>> Roger,
>>
>> On Tuesday 10 October 2017 12:49 PM, Roger Quadros wrote:
>>> On 09/10/17 12:03, Kishon Vijay Abraham I wrote:
>>>> PCI core access configuration space registers in resume_noirq callbacks.
>>>> In the case of dra7xx, PIPE3 PHY connected to PCIe controller has to be
>>>> enabled before accessing configuration space registers. Since
>>>> PIPE3 PHY is enabled by only configuring control module registers, no
>>>> aborts has been observed so far (though during noirq stage, interface
>>>> clock of PIPE3 PHY is not enabled).
>>>>
>>>> With new TRM updates, PIPE3 PHY has to be initialized (PIPE3 PHY
>>>> registers has to be accessed) as well which requires the interface
>>>> clock of PIPE3 PHY to be enabled. The interface clock of PIPE3 PHY is
>>>> derived from OCP2SCP and hence PCIe PHY is modeled as a child of
>>>> OCP2SCP. Since pm_runtime is not enabled during noirq stage,
>>>> pm_runtime_get_sync done in phy_init doesn't enable
>>>> OCP2SCP clocks resulting in abort when PIPE3 PHY registers are
>>>> accessed.
>>>
>>> This could be the case not only with PCIe but even with USB and SATA?
>>
>> right, if USB/SATA driver has no_irq callbacks then the same issue might occur.
> 
> OK. Is this something that we should document in Documentation/phy.txt?

Yeah it could be but the dependency is not required for a lot of phy consumer
drivers.
Do you think it makes sense to create functional dependency between phy and
it's consumers in phy_get?

Thanks
Kishon
