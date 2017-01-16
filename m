Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:53349 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbdAPNkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2017 08:40:17 -0500
Subject: Re: [PATCH] pcie: ti: Provide patch to force GEN1 PCIe operation
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Lukasz Majewski <lukma@denx.de>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>
References: <1484486354-4585-1-git-send-email-lukma@denx.de>
 <587C6A40.8070608@ti.com> <20170116074927.086418f4@jawa>
 <587C8088.80905@ti.com> <20170116103136.21c899ac@jawa>
 <587C9CE6.8040001@ti.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <2adac46e-b7b3-d41a-b3c4-1edec48dcf83@synopsys.com>
Date: Mon, 16 Jan 2017 13:40:10 +0000
MIME-Version: 1.0
In-Reply-To: <587C9CE6.8040001@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi,

Às 10:13 AM de 1/16/2017, Kishon Vijay Abraham I escreveu:
> + Joao, Jingoo
> 
> Hi,
> 
> On Monday 16 January 2017 03:01 PM, Lukasz Majewski wrote:
>> Hi Kishon,
>>
>>> Hi Łukasz,
>>>
>>> On Monday 16 January 2017 12:19 PM, Lukasz Majewski wrote:
>>>> Hi Kishon,
>>>>
>>>>> Hi,
>>>>>
>>>>> On Sunday 15 January 2017 06:49 PM, Lukasz Majewski wrote:
>>>>>> Some devices (due to e.g. bad PCIe signal integrity) require to
>>>>>> run with forced GEN1 speed on PCIe bus.
>>>>>>
>>>>>> This patch changes the speed explicitly on dra7 based devices when
>>>>>> proper device tree attribute is defined for the PCIe controller.
>>>>>>
>>>>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>>>>
>>>>> Bjorn has already queued a patch to do the same thing
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_cgit_linux_kernel_git_helgaas_pci.git_log_-3Fh-3Dpci_host-2Ddra7xx&d=DwIDaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=zD82T5n4WcL7Ga-NSY2NI7KE75xQ99hN-mW2yX46wQk&s=E8zk1CbKxGH-f3fw_WpXxFU-A8BLkgA8NusCaxk1SvA&e= 
>>>>
>>>> It seems like Bjorn only modifies CAP registers.
>>>
>>> The patch also modifies the LNKCTL2 register.
>>>>
>>>> He also needs to change register with 0x080C offset to actually
>>>> ( PCIECTRL_PL_WIDTH_SPEED_CTL )
>>>
>>> This bit is used to initiate speed change (after the link is
>>> initialized in GEN1). Resetting the bit (like what you have done
>>> here) prevents speed change.
>>
>> This is strange, but e2e advised me to do things as I did in the patch
>> to _force_ GEN1 operation on PCIe2 port [1] (AM5728)
>>
>> Link:
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__e2e.ti.com_support_arm_sitara-5Farm_f_791_t_566421&d=DwIDaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=zD82T5n4WcL7Ga-NSY2NI7KE75xQ99hN-mW2yX46wQk&s=uXLwglyRYqKpwp1JSxkOWmKpQ2wjfhgofpm8DCfquNw&e= 
>>
>> Both patches modify 0x5180 007C register to set GEN1 capability
>> (PCI_EXP_LNKCAP_SLS_2_5GB)
>>
>> The problem is with second register (in your patch):
>>
>> From SPRUHZ6G TRM:
>>
>> PCIECTRL_EP_DBICS_LNK_CAS_2 (0x5180 00A0)
>> - TRGT_LINK_SPEED (Reset 0x1) - "Target Link Speed" - no more
>>   description in TRM
>>
>> It is set to PCI_EXP_LNKCAP_SLS_2_5GB = 0x1, which is the same as
>> default /reset value.
> 
> The default value is 0x2 (or else none of the cards would have enumerated in GEN2)
>>
>>
>> Could you clarify which way to _force_ PCIe GEN1 operation is correct?
>> Mine shows differences in lspci output (as posted in [1]).
> 
> You'll see the difference even with the patch in Bjorn's tree ;-)
> 
> I think these are 2 different approaches to keep the link at GEN1. Joao or
> Jingoo, do you have any suggestion here?

I am going to check this and come back soon with a fundamented opinion.

Thanks.

> 
>>
>>>
>>> IMO the better way is to set the LNKCTL2 to GEN1 instead of hacking
>>> the IP register.
>>
>> From the original patch description:
>>
>> "Add support to force Root Complex to work in GEN1 mode if so desired,
>> but don't force GEN1 mode on any board just yet."
>>
>> Are there any (floating around) patches allowing forcing GEN1 operation
>> on any board (I would like to reuse/port them to my current solution)?
> 
> For setting to GEN1 mode, "max-link-speed" should be set to 1 in dt with the
> patch in Bjorn's tree.
> 
> Thanks
> Kishon
> 

