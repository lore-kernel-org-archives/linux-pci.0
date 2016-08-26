Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20160824142723.GA25843@red-moon>
 <20160824193000.GE23914@localhost> <20160824213005.1a9300ef@arm.com>
 <CADaLNDm+edKaveG76h_fbMjM_b==PdranXLoATL8+JrsWRC6BQ@mail.gmail.com>
 <20160825121825.322d8450@arm.com>
 <CADaLND=MkDmYNESmL9zLEQQ5NaZp4_aGv4SnQ4=VS4LmFkFG6g@mail.gmail.com>
 <20160825195917.0e75a8db@arm.com> <20160826090813.GA1038@red-moon>
 <20160826130832.2fde2327@arm.com>
 <f747c2c3-096a-f843-908c-3f76238a6acd@codeaurora.org>
 <20160826170615.GC23885@red-moon>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Duc Dang <dhdang@apm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Rafael Wysocki <rafael@kernel.org>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 patches <patches@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Punit Agrawal <punit.agrawal@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <66f94732-7ce4-e577-9bec-52f0dc8e6ddb@codeaurora.org>
Date: Fri, 26 Aug 2016 18:53:29 -0400
MIME-Version: 1.0
In-Reply-To: <20160826170615.GC23885@red-moon>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>


>> Let me throw option d here.
>>
>> I know Bjorn wants to keep ACTIVE_LOW in the code for common code but
>> can't we override this in an arch specific way (arm64's pci.c) while
>> creating the root bridge? 
> 
> On what basis ? You were not copied in from the beginning, but that
> is not different from Duc's initial proposal, which Marc discarded
> because it should not be done at arch level, it depends on the interrupt
> controller.

I happen to watch the linux-pci and linux-acpi mail-lists. I also saw
Duc's initial proposal. 

I can't imagine someone building an ACPI compliant ARM64 platform without 
a GIC interrupt controller. 

The SBSA spec already mentions what kind of compatibility should be maintained with
respect to GIC. You can't have an ACPI system that's SBSA compliant and not using
GIC. 

Can't we just hard code this to ACTIVE_HIGH in arch directory if ACPI is defined.
Why do we have to reach out to the interrupt controller?

I just don't want GIC code to do auto-correction on interrupt levels on behalf of
the firmware and hide firmware problems for non-PCI devices.

We are talking about an ACPI only problem for PCI devices only.

Coming back to the problem, I complained about this last year November here. It didn't 
get enough attention probably because we were trying to get the base PCI support into
the kernel.

https://lists.linaro.org/pipermail/linaro-acpi/2015-November/005973.html

I was watching this thread to see where it is going. 

> 
> Possibly a hook to be called from GIC code to override the default
> ACPI PCI IRQ polarity, I think that's _horrible_ but if we want to
> successfully boot APM's platforms that are $SUBJECT of this thread
> something has to be done (and it is not patching FW because we
> can't).
> 
>> If the ARCH override doesn't exist, ACTIVE LOW still remains the
>> default. There could be another arch that could have the same problem
>> in the future.
> 
> See above.
> 
>> This way, we don't need to touch irqchip (GIC) driver or introduce a
>> new API and/or introduce bugs for the rest of the non-PCI code.
>>
>> From what I see in the ACPI spec, both _PRT approaches are correct and
>> they need to be supported by Linux.
> 
> They are; ..but the spec says that your ACPI tables are buggy, because
> you are using a PCI interrupt link for an interrupt that is not
> configurable (frankly I still do not understand why as I explained).
> 

If you look at my email above, I tried getting rid of PCI Link object and
I couldn't. I sticked to only thing that works.

> And then there is FW that has already shipped and we can't patch
> and it is not using PCI interrupt links so we have to quirk it in
> the kernel somehow (ie I am not sure APM platforms are the only ones
> containing _PRT with static PCI legacy IRQ entries, unfortunately).
> 
> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
