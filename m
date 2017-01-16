Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Message-ID: <76d18446-78c9-87f2-22ad-f7ea38771285@synopsys.com>
Date: Mon, 16 Jan 2017 17:01:54 +0000
MIME-Version: 1.0
In-Reply-To: <587C9CE6.8040001@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
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

I studied the Databook, and both approaches seem to be right, dependently of the
Core configuration and setup.

The standard manual speed change sequence is:
a) Write to PCIE_CAP_TARGET_LINK_SPEED (indicating desired speed)
b) Clear "Directed Speed Change"
c) Set "Directed Speed Change"

If "Directed Speed Change" is set (DEFAULT_GEN2_SPEED_CHANGE is the default
value), it will execute LTSSM to initiate speed change to Gen2 or Gen3, after
link is started in Gen1, and then the bit is automatically cleared.

Lukasz is reseting this bit, in order to avoid the LTSSM to be executed, which
is correct. There is another way to prevent this automatic speed change, which
is to set GEN1 speed before link up which might be difficult in some setups, so
Kishon's also right.

In my opinion Lukasz approach would be the one that might be more universal and
more "secure".

Joao


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
