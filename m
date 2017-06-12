Return-Path: <SRS0=vY90=5R=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=vY90=5R=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170612165525.GB32131@red-moon>
References: <20170518154708.GA30182@red-moon> <CAKv+Gu-NDR1PYUfOs4z-T9WoeBrYvFTTBt3XMiMg+AU76MbYBg@mail.gmail.com>
 <20170518174612.GA31373@red-moon> <CAKv+Gu8hVhpNrXG+JUQu8XYZtQE86d0O66J8AORWDC6Ttcp3iA@mail.gmail.com>
 <20170601161511.GB19003@red-moon> <CAKv+Gu9FyLuQk3hkauoRzGME1FxHPgusWQe0v8eSJaKfaX7LMA@mail.gmail.com>
 <20170606085936.GB20085@red-moon> <CAKv+Gu-jVGvEJY7YBxSQHu+0jtnDHG7_6Gdpac8ca4PbPggw3Q@mail.gmail.com>
 <20170606100228.GA20126@red-moon> <CAKv+Gu9EffaBNW=8mM-xd+bFvWetds7LTsX1cc81Q=X1hwk39Q@mail.gmail.com>
 <20170612165525.GB32131@red-moon>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 12 Jun 2017 19:00:53 +0200
Message-ID: <CAKv+Gu-pBvUCEhF1b5-oQ=4WQ33XTdQS6SfY7yKPHXQ545K9wQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: acpi/pci: allow the firmware BAR configuration
 to be preserved
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	linux-pci <linux-pci@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Leif Lindholm <leif.lindholm@linaro.org>, Sinan Kaya <okaya@codeaurora.org>,
	Tomasz Nowicki <tn@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 12 June 2017 at 18:55, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Wed, Jun 07, 2017 at 01:45:19PM +0000, Ard Biesheuvel wrote:
>> On 6 June 2017 at 10:02, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>> > On Tue, Jun 06, 2017 at 09:14:26AM +0000, Ard Biesheuvel wrote:
>> >
>> > [...]
>> >
>> >> > Do you want me to create a branch out of these patches (inclusive of
>> >> > another patch to fix this bus reallocation policy discrepancy) for
>> >> > ARM64 folks to test ? Let me know, thanks !
>> >> >
>> >>
>> >> Hi Lorenzo,
>> >>
>> >> Bjorn has already picked up #1, which is now in -next. I will get back
>> >> to this topic today or tomorrow, so let me respin (including the bus
>> >> range fix) first, ok?
>> >
>> > Of course, I just want to help you make progress on this, I think
>> > we need help for testing them on ARM64 systems to see how to proceed.
>> >
>>
>> OK, so I am hitting another issue. While it is quite simple to do this
>>
>> """
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index c7e3e6387a49..9a529c6369ac 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -203,6 +203,9 @@
>>                 return NULL;
>>         }
>>
>> +       /* ignore bus ranges assigned by the firmware */
>> +       pci_add_flags(PCI_REASSIGN_ALL_BUS);
>> +
>>         root_ops->release_info = pci_acpi_generic_release_info;
>>         root_ops->prepare_resources = pci_acpi_root_prepare_resources;
>>         root_ops->pci_ops = &ri->cfg->ops->pci_ops;
>> """
>>
>> and get the ACPI code to behave in the same way as the DT code,
>> including the resulting quirks, i.e.
>>
>> pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus
>> 00-0f] (conflicts with (null) [bus 00-0f])
>>
>> there are two problems when we want to refine this to take _DSM #5 into account.
>>
>> 1) PCI_REASSIGN_ALL_BUS is a global flag, while _DSM is per PCI root
>> 2) setting the flag conditionally on whether _DSM #5 allows it is
>> difficult to achieve, given that the flag needs to be set before
>> acpi_pci_root_create(), at which point we cannot access the _DSM yet
>
> (2) Why ? You have the ACPI root bridge handle at that point. Anyway
> (1) makes (2) irrelevant unfortunately.
>

OK, it wasn't clear to me that the companion device has already been
created at that point. But it doesn't matter, indeed ...

>> So I can send out the above as a separate patch, but right now, I am
>> not entirely sure how to proceed with conditionally preserving the
>> firmware configuration.
>
> Yes, this definitely requires some focus because that's becoming a bit
> unwieldy to manage consistently, I will look into this.
>

OK. I would still like to fix the EFI framebuffer issue, but given
that the current code is no longer unsafe, it is no longer a priority
for me, so I will revisit it when we have a better handle on this.
