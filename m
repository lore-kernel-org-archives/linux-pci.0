Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:49034 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757689AbdELQEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2017 12:04:54 -0400
Subject: Re: [RFC] pci: adding new interrupt api to pcie-designware
To: Marc Zyngier <marc.zyngier@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, <kishon@ti.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>
References: <5593732728f7c7f5e8c58ac49f394e688bcc192d.1494332566.git.jpinto@synopsys.com>
 <1deaad7c-ba6a-202b-4b2b-11d4fc79a0a0@arm.com>
 <c517ec9f-94ef-0f4a-6ed6-4f689f8e5de4@synopsys.com>
 <764590ed-d7ca-5142-df2e-5bf2ac714c2b@arm.com>
CC: <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <5915DD35.3080405@ti.com>
Date: Fri, 12 May 2017 12:05:09 -0400
MIME-Version: 1.0
In-Reply-To: <764590ed-d7ca-5142-df2e-5bf2ac714c2b@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/2017 06:05 AM, Marc Zyngier wrote:
> On 11/05/17 10:17, Joao Pinto wrote:
>>
>> Hello,
>>
>> Às 6:00 PM de 5/10/2017, Marc Zyngier escreveu:
>>> On 09/05/17 13:33, Joao Pinto wrote:
>>>> This is a proposal for the update of the interrupt API in pcie-designware.
>>>>
>>>> *SoC specific drivers*
>>>> All SoC specific drivers that use the common infrastructure (pci-qcom,
>>>> pci-artpec6, pci-exynos, pci-imx6) were updated to be compatible.
>>>> Other SoC specific drivers like pci-dra7, pci-armada8k, pci-hisi, pci-spear13xx
>>>> and pci-layerscape will also work fine.
>>>>
>>>> *Work still to be done - need some inputs*
>>>> The pci-keystone driver is the one that I would appreciate some opinions, since
>>>> it uses the "old" dw_pcie_msi_chip. I think we have 3 options:
>>>>
>>>> a) Keep the old API + new API in pcie-designware just for pci-keystone to use
>>>> the dw_pcie_msi_chip structure
>>>> b) Move the old API from pcie-designware to pci-keystone for it to use the
>>>> dw_pcie_msi_chip structure
>>>> c) Adapt pci-keystone to use the new API also
>>>
>>> What is the issue with moving Keystone over to this infrastructure?
>>
>> I don't hardware to test if the Keystone infrastructure porting is right or not
>> and thats my main concern. Also the Keystone SoC driver maintainer can also have
>> the option of keeping the current structure and that's why I sent the e-mail
>> asking for opinions about the subject.
> 
> I think the old infrastructure should disappear, full stop (maintaining
> two APIs is hell). It'd be great if you could convert it as well,
> leaving the testing responsibility to the TI guys who I'm sure will
> gladly help (they've done so in the past for different things).
Marc,

Sure! I can help you on the testing part. I haven't had a chance to read this
patch due to my current tasks, but will spend some time on this next week.

Murali

> 
>>>>
>>>> *Tests*
>>>> I made tests with a PCI 4.80 Core IP, using pcie-designware-plat driver.
>>>> I used an MSI-only Endpoint and a MSI/MSIX Endpoint and the APi adapted very
>>>> well to the situation.
>>>>
>>>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>>>> ---
>>>>  drivers/pci/dwc/pci-exynos.c           |  18 --
>>>>  drivers/pci/dwc/pci-imx6.c             |  18 --
>>>>  drivers/pci/dwc/pcie-artpec6.c         |  18 --
>>>>  drivers/pci/dwc/pcie-designware-host.c | 342 +++++++++++++++++----------------
>>>>  drivers/pci/dwc/pcie-designware-plat.c |  15 --
>>>>  drivers/pci/dwc/pcie-designware.h      |   6 +-
>>>>  drivers/pci/dwc/pcie-qcom.c            |  15 --
>>>>  7 files changed, 179 insertions(+), 253 deletions(-)
>>>
>>> May I suggest something for your next posting? This patch is extremely
>>> difficult to read (not your fault at all), as it deletes a lot of code
>>> and replaces it by code that is mostly unrelated. It would be a lot
>>> better if you had a series that:
>>>
>>> 1: adds the new infrastructure in parallel with the old one, with an
>>> opt-in mechanism.
>>> 2: convert each individual platform (one patch per SoC)
>>> 3: remove the old code entirely.
>>>
>>> This will result in a much more readable series, and will give us a good
>>> way to bisect, should a given platform break.
>>
>> Yep indeed! I will do the 3 patch way as you are suggesting.
> 
> Thanks,
> 
> 	M.
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
