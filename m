Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755960AbdELQLN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 May 2017 12:11:13 -0400
Subject: Re: [RFC] pci: adding new interrupt api to pcie-designware
To: Murali Karicheri <m-karicheri2@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, kishon@ti.com,
        bhelgaas@google.com, jingoohan1@gmail.com
References: <5593732728f7c7f5e8c58ac49f394e688bcc192d.1494332566.git.jpinto@synopsys.com>
 <1deaad7c-ba6a-202b-4b2b-11d4fc79a0a0@arm.com>
 <c517ec9f-94ef-0f4a-6ed6-4f689f8e5de4@synopsys.com>
 <764590ed-d7ca-5142-df2e-5bf2ac714c2b@arm.com> <5915DD35.3080405@ti.com>
Cc: linux-pci@vger.kernel.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <4045cab0-d6fc-f739-5a7d-ab2a6ff35676@arm.com>
Date: Fri, 12 May 2017 17:11:09 +0100
MIME-Version: 1.0
In-Reply-To: <5915DD35.3080405@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Murali,

On 12/05/17 17:05, Murali Karicheri wrote:
> On 05/11/2017 06:05 AM, Marc Zyngier wrote:
>> On 11/05/17 10:17, Joao Pinto wrote:
>>>
>>> Hello,
>>>
>>> Às 6:00 PM de 5/10/2017, Marc Zyngier escreveu:
>>>> On 09/05/17 13:33, Joao Pinto wrote:
>>>>> This is a proposal for the update of the interrupt API in pcie-designware.
>>>>>
>>>>> *SoC specific drivers*
>>>>> All SoC specific drivers that use the common infrastructure (pci-qcom,
>>>>> pci-artpec6, pci-exynos, pci-imx6) were updated to be compatible.
>>>>> Other SoC specific drivers like pci-dra7, pci-armada8k, pci-hisi, pci-spear13xx
>>>>> and pci-layerscape will also work fine.
>>>>>
>>>>> *Work still to be done - need some inputs*
>>>>> The pci-keystone driver is the one that I would appreciate some opinions, since
>>>>> it uses the "old" dw_pcie_msi_chip. I think we have 3 options:
>>>>>
>>>>> a) Keep the old API + new API in pcie-designware just for pci-keystone to use
>>>>> the dw_pcie_msi_chip structure
>>>>> b) Move the old API from pcie-designware to pci-keystone for it to use the
>>>>> dw_pcie_msi_chip structure
>>>>> c) Adapt pci-keystone to use the new API also
>>>>
>>>> What is the issue with moving Keystone over to this infrastructure?
>>>
>>> I don't hardware to test if the Keystone infrastructure porting is right or not
>>> and thats my main concern. Also the Keystone SoC driver maintainer can also have
>>> the option of keeping the current structure and that's why I sent the e-mail
>>> asking for opinions about the subject.
>>
>> I think the old infrastructure should disappear, full stop (maintaining
>> two APIs is hell). It'd be great if you could convert it as well,
>> leaving the testing responsibility to the TI guys who I'm sure will
>> gladly help (they've done so in the past for different things).
> Marc,
> 
> Sure! I can help you on the testing part. I haven't had a chance to read this
> patch due to my current tasks, but will spend some time on this next week.

Awesome! Please liaise with Joao in order to get this up and running!

Thanks both,

	M.
-- 
Jazz is not dead. It just smells funny...
