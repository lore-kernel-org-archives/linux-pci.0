Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
To: Duc Dang <dhdang@apm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20160824213005.1a9300ef@arm.com>
 <CADaLNDm+edKaveG76h_fbMjM_b==PdranXLoATL8+JrsWRC6BQ@mail.gmail.com>
 <20160825121825.322d8450@arm.com>
 <CADaLND=MkDmYNESmL9zLEQQ5NaZp4_aGv4SnQ4=VS4LmFkFG6g@mail.gmail.com>
 <20160825195917.0e75a8db@arm.com> <20160826090813.GA1038@red-moon>
 <20160826130832.2fde2327@arm.com>
 <f747c2c3-096a-f843-908c-3f76238a6acd@codeaurora.org>
 <20160826170615.GC23885@red-moon>
 <66f94732-7ce4-e577-9bec-52f0dc8e6ddb@codeaurora.org>
 <20160830100834.GA368@red-moon>
 <CADaLND=DCFZB5KGN+yqdF0pzHhvmDhKHf9fMgZ57c+2GE0n9jQ@mail.gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Rafael Wysocki <rafael@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, patches <patches@apm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Punit Agrawal <punit.agrawal@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <16855e90-43e8-b36b-788a-cf0871261432@codeaurora.org>
Date: Tue, 30 Aug 2016 13:54:24 -0400
MIME-Version: 1.0
In-Reply-To: <CADaLND=DCFZB5KGN+yqdF0pzHhvmDhKHf9fMgZ57c+2GE0n9jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/30/2016 11:51 AM, Duc Dang wrote:
> On Tue, Aug 30, 2016 at 3:08 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> On Fri, Aug 26, 2016 at 06:53:29PM -0400, Sinan Kaya wrote:
>>>
>>>>> Let me throw option d here.
>>>>>
>>>>> I know Bjorn wants to keep ACTIVE_LOW in the code for common code but
>>>>> can't we override this in an arch specific way (arm64's pci.c) while
>>>>> creating the root bridge?
>>>>
>>>> On what basis ? You were not copied in from the beginning, but that
>>>> is not different from Duc's initial proposal, which Marc discarded
>>>> because it should not be done at arch level, it depends on the interrupt
>>>> controller.
>>>
>>> I happen to watch the linux-pci and linux-acpi mail-lists. I also saw
>>> Duc's initial proposal.
>>>
>>> I can't imagine someone building an ACPI compliant ARM64 platform
>>> without a GIC interrupt controller.
>>>
>>> The SBSA spec already mentions what kind of compatibility should be
>>> maintained with respect to GIC. You can't have an ACPI system that's
>>> SBSA compliant and not using GIC.
>>>
>>> Can't we just hard code this to ACTIVE_HIGH in arch directory if ACPI
>>> is defined.  Why do we have to reach out to the interrupt controller?
>>
>> Patch below (horrible but no solution will be shiny either).
>>
>>> https://lists.linaro.org/pipermail/linaro-acpi/2015-November/005973.html
>>
>> [...]
>>
>>> If you look at my email above, I tried getting rid of PCI Link object
>>> and I couldn't. I sticked to only thing that works.
>>
>> That's what I object to. If the ACPI bindings do not work for ARM
>> we do not work around issues, we upgrade the specs because what may work
>> for you has to work on all ARM platforms (and all FW developers have
>> to be aware of that). Granted, this is a tiny snag, but the point is
>> that no one knows what's the correct way of describing PCI legacy IRQs
>> on ARM and we need that rectified.
>>
>> This does the trick for me (I can turn it into a function/look-up
>> that returns the polarity), I am sure it will ruffle feathers but
>> we have to find a solution so here it is (that acpi_irq_model gem
>> is already used in generic code drivers/acpi/pci_link.c ;-))
>>
> 
> Good catch! This acpi_irq_model gem does help X-Gene :)
> 

+1 to this too. 

We don't need to invent some fake API or push stuff to the arch directory.

>> -- >8 --
>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
>> index 2c45dd3..c9b8c85 100644
>> --- a/drivers/acpi/pci_irq.c
>> +++ b/drivers/acpi/pci_irq.c
>> @@ -411,7 +411,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>>         int gsi;
>>         u8 pin;
>>         int triggering = ACPI_LEVEL_SENSITIVE;
>> -       int polarity = ACPI_ACTIVE_LOW;
>> +       int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
>> +                                     ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
>>         char *link = NULL;
>>         char link_desc[16];
>>         int rc;
> Regards,
> Duc Dang.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
