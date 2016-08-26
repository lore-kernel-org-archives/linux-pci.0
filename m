Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 26 Aug 2016 07:04:32 -0400
From: okaya@codeaurora.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Duc Dang <dhdang@apm.com>, Bjorn
 Helgaas <helgaas@kernel.org>, Rafael Wysocki <rafael@kernel.org>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, patches
 <patches@apm.com>, Bjorn Helgaas <bhelgaas@google.com>, Punit Agrawal
 <punit.agrawal@arm.com>
Subject: Re: Defining polarity and trigger mode for static interrupts in _PRT
In-Reply-To: <20160826090813.GA1038@red-moon>
References: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
 <20160824142723.GA25843@red-moon> <20160824193000.GE23914@localhost>
 <20160824213005.1a9300ef@arm.com>
 <CADaLNDm+edKaveG76h_fbMjM_b==PdranXLoATL8+JrsWRC6BQ@mail.gmail.com>
 <20160825121825.322d8450@arm.com>
 <CADaLND=MkDmYNESmL9zLEQQ5NaZp4_aGv4SnQ4=VS4LmFkFG6g@mail.gmail.com>
 <20160825195917.0e75a8db@arm.com> <20160826090813.GA1038@red-moon>
Message-ID: <38d7a30f5acfbb96f9d1567194209216@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2016-08-26 05:08, Lorenzo Pieralisi wrote:
> [ +Sinan ]
> 
> On Thu, Aug 25, 2016 at 07:59:17PM +0100, Marc Zyngier wrote:
> 
> [...]
> 
>> > Thanks, Marc! It works, I tested on current X-Gene platforms that uses
>> > GICv2 and GICv2m.
>> >
>> > Will you commit this change? It will be a huge help as going with
>> > interrupt link will require firmware change.
>> 
>> Not for the time being. We now have an understanding of *why* things 
>> do
>> not work, but Lorenzo seems to have a good grasp on what we can do to
>> address it correctly, and we should explore this first. If (and only 
>> if)
>> there is a consensus that firmware already does all it should, then
>> I'll turn this hack into a proper series.
> 
> For the records, it is a discussion that already took place:
> 
> https://lkml.org/lkml/2016/3/14/923
> 
> As I have said there are already ARM64 systems with ACPI tables
> out there using PCI interrupt links; I doubt that Qualcomm systems
> allow to reconfigure the GIC interrupt pin allocated to legacy PCI
> IRQs through interrupt links _SRS (hey it is *empty* :)),
> therefore:
> 
> a) Some (the above is just an example from the mailing lists I am not
>    picking on anyone it is just for the sake of this discussion, I have
>    not dumped all ARM partners _PRT from their ACPI tables to check)
>    ACPI tables must be rewritten because they are not FW compliant
> 
> OR
> 
> b) We allow PCI interrupt links to be used for static interrupt
>    configurations
> 
> OR
> 
> c) We ignore the polarity flag (only for PCI legacy IRQs ? I wonder
>    how GIC code can detect from which part of the kernel the interrupt
>    request is coming, unless we implement an 
> ACPI-PCI-legacy-IRQ-special
>    gem)
> 
> Comments ?
> 
> Lorenzo

I complained about active low assumption before when reviewing the 
series from Tomasz too. The above discussion took place when refactoring 
the pci link code.

 From Acpi spec perspective, both types of declarations are valid.

It is just one syntax doesn't work on arm64. The other syntax is more 
expressive and it works. That is the reason why link objects are used in 
QCOM platforms.

I think we need to fix the code by either changing the active low 
assumption or the gic code.

Changing it at the gic level opens door for bugs that wouldn't be 
otherwise caught. I would make this change in pci code.
