Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <54287AA5.3060408@amd.com>
Date: Sun, 28 Sep 2014 16:16:21 -0500
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <liviu@dudau.co.uk>
CC: Liviu Dudau <Liviu.Dudau@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	"Rob Herring" <robh+dt@kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Will Deacon" <Will.Deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Device Tree ML" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v12 10/12] PCI: Assign unassigned bus resources in pci_scan_root_bus()
References: <1411498874-9864-1-git-send-email-Liviu.Dudau@arm.com>
 <1411498874-9864-11-git-send-email-Liviu.Dudau@arm.com>
 <20140924011851.GD32643@bart.dudau.co.uk>
 <CAErSpo5DR+TPYXBWGKRj9SRPjsbJ6kjZmAH1AXT12txEjGdZGQ@mail.gmail.com>
In-Reply-To: <CAErSpo5DR+TPYXBWGKRj9SRPjsbJ6kjZmAH1AXT12txEjGdZGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/23/2014 08:41 PM, Bjorn Helgaas wrote:
> On Tue, Sep 23, 2014 at 7:18 PM, Liviu Dudau <liviu@dudau.co.uk> wrote:
>> On Tue, Sep 23, 2014 at 08:01:12PM +0100, Liviu Dudau wrote:
>>> If the firmware has not assigned all the bus resources and
>>> we are not just probing the PCIe busses, it makes sense to
>>> assign the unassigned resources in pci_scan_root_bus().
>>>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>>> ---
>>>   drivers/pci/probe.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index ef891d2..508cf61 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -1953,6 +1953,9 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
>>>        if (!found)
>>>                pci_bus_update_busn_res_end(b, max);
>>>
>>> +     if (!pci_has_flag(PCI_PROBE_ONLY))
>>> +             pci_assign_unassigned_bus_resources(b);
>>> +
>>>        pci_bus_add_devices(b);
>>>        return b;
>>>   }
>>> --
>>> 2.1.0
>>>
>>
>> Bjorn,
>>
>> If you are OK with this patch, can you let me know how do you feel about
>> making pci_scan_root_bus() set up the bus->msi pointer as well?
>
> I'm not opposed to it, but I have the same question as for setting up
> the domain: how does pci_scan_root_bus() learn what to assign to
> bus->msi?  It currently only gets a "void *sysdata" so there's no
> obvious place to put it there.  You could add a pcibios interface to
> retrieve it, I suppose, but I'm starting to get uncomfortable with
> adding more of those because we have such a mess of them already.
>
> Bjorn

[Suravee] Liviu and I had a talk during Linaro Connect, and we came up
with a new binding for the pcie controller called "msi-parent" which is
supposed to contain phandle to the corresponded msi-controller.

>
>> Side note: I don't know exactly how to do it now, but setting bus->msi is
>> needed by platforms that are based on my patches and want to use MSI,
>> otherwise they have to open code pci_scan_root_bus() to set it. I haven't
>> made any attempts to do it in this series as the GICv2m patches are not
>> ready yet, but I can see the need arriving soon.

[Suravee] I just sent out an RFC which implements the described binding 
here.

https://lkml.org/lkml/2014/9/28/149

Any feedback/comments are welcome :)

Thanks,

Suravee
