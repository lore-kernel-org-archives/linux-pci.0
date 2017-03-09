Return-Path: <SRS0=J5Gl=2S=arm.com=james.morse@kernel.org>
Return-Path: <SRS0=J5Gl=2S=arm.com=james.morse@kernel.org>
Message-ID: <58C135B4.2000809@arm.com>
Date: Thu, 09 Mar 2017 11:00:04 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
To: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Rajat Jain <rajatxjain@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Keith Busch <keith.busch@intel.com>,
 Andreas Ziegler <andreas.ziegler@fau.de>,
 Jonathan Yong <jonathan.yong@intel.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 David Daney <david.daney@cavium.com>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 Ram Amrani <Ram.Amrani@cavium.com>, Doug Ledford <dledford@redhat.com>,
 Wang Sheng-Hui <shhuiw@foxmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brian Norris <briannorris@google.com>
Subject: Re: [PATCH 5/6] PCI/ASPM: Actually configure the L1 substate settings
 to the device
References: <1483425255-101923-1-git-send-email-rajatja@google.com> <1483425255-101923-6-git-send-email-rajatja@google.com> <58C05114.5030202@arm.com> <20170308223938.GA28050@bhelgaas-glaptop.roam.corp.google.com> <CACK8Z6H7V=dM71LuUh7653qnLXJmGCNVcm3cG4_s4hwQKe58aA@mail.gmail.com>
In-Reply-To: <CACK8Z6H7V=dM71LuUh7653qnLXJmGCNVcm3cG4_s4hwQKe58aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

On 08/03/17 23:08, Rajat Jain wrote:
> On Wed, Mar 8, 2017 at 2:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Wed, Mar 08, 2017 at 06:44:36PM +0000, James Morse wrote:
>>> On 03/01/17 06:34, Rajat Jain wrote:
>>>> Add code to actually configure the L1 substate settigns on the
>>>> upstream and downstream device, while taking care of the rules
>>>> dictated by the PCIe spec.
>>>
>>> While testing hibernate on an arm64 juno with v4.11-rc1, I get a NULL
>> pointer
>>> dereference from pcie_config_aspm_link():
>>>
>>>
>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>> index a70afdf..6735f38 100644
>>>> --- a/drivers/pci/pcie/aspm.c
>>>> +++ b/drivers/pci/pcie/aspm.c
>>>> @@ -597,11 +683,23 @@ static void pcie_config_aspm_dev(struct pci_dev
>> *pdev, u32 val)
>>>>  static void pcie_config_aspm_link(struct pcie_link_state *link, u32
>> state)
>>>>  {
>>>>     u32 upstream = 0, dwstream = 0;
>>>> -   struct pci_dev *child, *parent = link->pdev;
>>>> +   struct pci_dev *child = link->downstream, *parent = link->pdev;
>>>
>>>
>>> Here link->downstream is NULL,
>>
>> Sorry about the breakage.  Can you try also cherry-picking this
>> commit:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.
>> git/commit/?h=for-linus&id=3bd7db63a841e8c5297bb18ad801df67d5e38ad2
>>
>> Yinghai tripped over a similar problem in a different way, but I
>> suspect his fix might also fix the problem you're seeing.
>>
> 
> Yes, I think that should fix it.

Yes, this fixes the problem. Thanks!

I should have dug through the list a little more to see if there was an existing
fix...


Thanks,

James
