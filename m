Return-Path: <rjwysocki@gmail.com>
Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20160906171401.GA7554@localhost>
References: <1473180663-20590-1-git-send-email-lorenzo.pieralisi@arm.com> <20160906171401.GA7554@localhost>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 Sep 2016 23:02:08 +0200
Message-ID: <CAJZ5v0i1VV1poabr3ZUvDdSGR9NN=tj6GoXM98rsrU6M-f_pOA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: acpi: fix GIC irq model default PCI IRQ polarity
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Punit Agrawal <punit.agrawal@arm.com>, Duc Dang <dhdang@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 6, 2016 at 7:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Sep 06, 2016 at 05:51:03PM +0100, Lorenzo Pieralisi wrote:
>> On ACPI ARM based systems the GIC interrupt controller
>> and corresponding interrupt model permit only the high
>> polarity for level interrupts.
>>
>> ACPI firmware describes PCI legacy IRQs through entries
>> in the _PRT objects. Entries in the _PRT can be of two types:
>>
>> - Static: not configurable, trigger/polarity default to level-low,
>>   _PRT entry defines the global GSI interrupt number
>> - Configurable: _PRT interrupt entry contains a reference to the
>>   corresponding PCI interrupt link device (that in turn provides the
>>   interrupt descriptor through its _CRS/_PRS methods)
>>
>> Configurable IRQ entries are not currently allowed by the ACPI
>> specification on ARM since they can only be used for interrupt pins that
>> are routable, as per ACPI specifications (version 6.1, 6.2.13):
>>
>> "[...] There are two ways that _PRT can be used. Typically, the
>> interrupt input that a given PCI interrupt is on is configurable. For
>> example, a given PCI interrupt might be configured for either IRQ 10 or
>> 11 on an 8259 interrupt controller. In this model, each interrupt is
>> represented in the ACPI namespace as a PCI Interrupt Link Device. [...]"
>
> Thanks for the reference!  I wouldn't read that as actually
> *disallowing* Interrupt Links for non-configurable interrupts.
>
> But regardless, I do understand that even if we assume Interrupt Links
> are allowed, there is firmware in the field that doesn't use them, and
> I think this patch is really targeted at *them*.

Right.  That's my understanding too.

So, generally speaking, it would be good to make interrupt links work
without _PRS, _SRS under them etc. and use link objects to address
this case in the future.

Thanks,
Rafael
