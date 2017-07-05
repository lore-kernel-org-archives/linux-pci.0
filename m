Return-Path: <SRS0=lBym=6I=synopsys.com=Joao.Pinto@kernel.org>
Return-Path: <SRS0=lBym=6I=synopsys.com=Joao.Pinto@kernel.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jisheng Zhang
	<jszhang@marvell.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>,
	Mason <slash.tmp@free.fr>, Marc Zyngier <marc.zyngier@arm.com>, linux-pci
	<linux-pci@vger.kernel.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Gonzalez
	<marc_gonzalez@sigmadesigns.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu_zAXTNYoWt+nMj_8tdDA8bcs86vepPJL1=zHfed2n-DA@mail.gmail.com>
 <20170703132704.GF13824@bhelgaas-glaptop.roam.corp.google.com>
 <20170704145840.69e53f58@xhacker>
 <CAKv+Gu9gi1W2Ex1hchMdob9PqkQ94uYspQW31W2+RG_sgsEV4Q@mail.gmail.com>
 <20170704161913.4935b16a@xhacker>
 <CAKv+Gu9ASLzBpJNN2eddw4K=g6+be8amH_7ZdZ0Qj+s_p+EuRw@mail.gmail.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <e758781e-65d0-d891-1c7b-a3f04fbe6c79@synopsys.com>
Date: Wed, 5 Jul 2017 14:53:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9ASLzBpJNN2eddw4K=g6+be8amH_7ZdZ0Qj+s_p+EuRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

Hi to all,

Às 10:38 AM de 7/4/2017, Ard Biesheuvel escreveu:
> On 4 July 2017 at 09:19, Jisheng Zhang <jszhang@marvell.com> wrote:
>> On Tue, 4 Jul 2017 09:02:06 +0100 Ard Biesheuvel wrote:
>>
>>> On 4 July 2017 at 07:58, Jisheng Zhang <jszhang@marvell.com> wrote:
>>>> On Mon, 3 Jul 2017 08:27:04 -0500 wrote:
>>>>
>>>>> [+cc Jingoo, Joao]
>>>>>
>>>>> On Mon, Jul 03, 2017 at 10:35:50AM +0100, Ard Biesheuvel wrote:
>>>>>> On 3 July 2017 at 00:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>> On Tue, Jun 20, 2017 at 10:17:40AM +0200, Marc Gonzalez wrote:
>>>>>>>> This driver is required to work around several hardware bugs
>>>>>>>> in the PCIe controller.
>>>>>>>>
>>>>>>>> NB: Revision 1 does not support legacy interrupts, or IO space.
>>>>>>>
>>>>>>> I had to apply these manually because of conflicts in Kconfig and
>>>>>>> Makefile.  What are these based on?  Easiest for me is if you base
>>>>>>> them on the current -rc1 tag.
>>>>>>>
>>>>>>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>>>>>>> ---
>>>>>>>>  drivers/pci/host/Kconfig      |   8 +++
>>>>>>>>  drivers/pci/host/Makefile     |   1 +
>>>>>>>>  drivers/pci/host/pcie-tango.c | 164 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>  include/linux/pci_ids.h       |   2 +
>>>>>>>>  4 files changed, 175 insertions(+)
>>>>>>>>  create mode 100644 drivers/pci/host/pcie-tango.c
>>>>>>>>
>>>>>> [..]
>>>>>>>> +     /*
>>>>>>>> +      * QUIRK #2
>>>>>>>> +      * Unfortunately, config and mem spaces are muxed.
>>>>>>>> +      * Linux does not support such a setting, since drivers are free
>>>>>>>> +      * to access mem space directly, at any time.
>>>>>>>> +      * Therefore, we can only PRAY that config and mem space accesses
>>>>>>>> +      * NEVER occur concurrently.
>>>>>>>> +      */
>>>>>>>> +     writel_relaxed(1, pcie->mux);
>>>>>>>> +     ret = pci_generic_config_read(bus, devfn, where, size, val);
>>>>>>>> +     writel_relaxed(0, pcie->mux);
>>>>>>>
>>>>>>> I'm very hesitant about this.  When people stress this, we're going to
>>>>>>> get reports of data corruption.  Even with the disclaimer below, I
>>>>>>> don't feel good about this.  Adding the driver is an implicit claim
>>>>>>> that we support the device, but we know it can't be made reliable.
>>>>>>
>>>>>> I noticed that the Synopsys driver suffers from a similar issue: in
>>>>>> dw_pcie_rd_other_conf(), it happily reprograms the outbound I/O window
>>>>>> to perform a config space access, and switches it back to I/O space
>>>>>> afterwards (unless it has more than 2 viewports, in which case it uses
>>>>>> dedicated windows for I/O space and config space)
>>>>>
>>>>> That doesn't sound good.  Jingoo, Joao?  I remember some discussion
>>>>> about this, but not the details.
>>>>>
>>>>> I/O accesses use wrappers (inb(), etc), so there's at least the
>>>>> possibility of a mutex to serialize them with respect to config
>>>>> accesses.
>>>>>
>>>>
>>>> IIRC, for 2 viewports, we don't need to worry about the config space
>>>> access, because config space access is serialized by pci_lock; We
>>>> do have race between config space and io space. But the accessing config
>>>> space and io space at the same time is rare.
>>>
>>> Being 'rare' is not sufficient, unfortunately. In the current
>>> situation, I/O space accesses may occur when the outbound window is
>>> directed to the config space of a potentially completely unrelated
>>> device. This is bad.
>>
>> Yep, I agree with you.
>>
>>>
>>>> And the PCIe EPs which
>>>> has io space are rare too, supporting these EPs are not the potential
>>>> target of those platforms with 2 viewports.
>>>>
>>>
>>> I am not sure EP mode is relevant here. What I do know is that boards
>>
>> I mean those PCIe EP cards which have IO space, but that doesn't matter.
>>
> 
> Ah, ok. But if such EP cards are so rare, why expose I/O space at all
> if we cannot do it safely?
> 
>>> like the Marvell 8040 based MacchiatoBin uses this IP in RC mode, and
>>> exposes config, MMIO and IO space windows using only 2 viewports. Note
>>> that this is essentially a bug in the DT description, given that its
>>> version of the IP supports 8 viewports. But the driver needs to be
>>> fixed as well.
>>
>> To fix for 2 viewports situation, we need to serialize access of the io
>> and config space. In internal repo, we can achieve it by modifying the
>> io access helper functions such as inl/outl, but this won't be accepted
>> by the mainline IMHO. Except fixing the HW, any elegant solution?
>>
>> Suggestions are appreciated.
>>
> 
> I think the safe and upstreamable approach is to disable the I/O
> window completely if num-viewports <= 2.
> 

I think that the critical case is when we are using a single ATU region, and
that has to managed by software. The hardware is not capable of managing racing
conditions, like programming the ATU while still transfering data, so problems
can ocurre for sure. In this case we should be able to add to the driver a
simple lock to signal that the ATU is being used. If the ATU was being used we
could make a spinlock for example. Would this acceptable in your opinion? The
problem is when we are transfering data. Are we able to know that data is being
processed?

When using a single region, when we access the config mem, we have to stop all
data transfers, reprogram the ATU to handle the config access, do the config
read/write, put the region "back" and restart the data transfer.

When using 2 or more regions, we can separate the scopes and the data transfers
does not need to be stopped. The race problem is harder to ocurre.

Thanks,
Joao
