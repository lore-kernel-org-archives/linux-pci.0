Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56DF2258.8020004@codeaurora.org>
References: <20160301194340.GA19783@localhost>
	<56D7317F.7090500@codeaurora.org>
	<56D7ABFB.3070302@codeaurora.org>
	<56D84EA9.3080900@codeaurora.org>
	<20160303151048.GA3290@localhost>
	<56D8546B.5040908@codeaurora.org>
	<56D8745D.70509@codeaurora.org>
	<20160304180959.GA4794@localhost>
	<56DDB28F.1040300@codeaurora.org>
	<20160308002558.GC26149@localhost>
	<20160308002909.GA13250@localhost>
	<56DF2258.8020004@codeaurora.org>
Date: Tue, 8 Mar 2016 21:59:47 +0100
Message-ID: <CAJZ5v0iWk_rBBDtApSdQwZry73VpZcG4-rXWJgNigjp83+5FZA@mail.gmail.com>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Timur Tabi <timur@codeaurora.org>,
	Christopher Covington <cov@codeaurora.org>,
	Linux PCI <linux-pci@vger.kernel.org>, ravikanth.nalla@hpe.com,
	Len Brown <lenb@kernel.org>, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 8, 2016 at 8:04 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>
>>>>> I think there are two issues here that should be teased apart a bit
>>>>> more:
>>>>>
>>>>>   1) Trigger settings: If the IRQ is configured as anything other than
>>>>>   level-triggered, active-low, we can't use it at all for a PCI
>>>>>   interrupt, and we should return an "infinite" penalty.  We currently
>>>>>   increase the penalty for the SCI IRQ if it's not level/low, but
>>>>>   doesn't it apply to *all* IRQs, not just the SCI IRQ?
>>>>
>>>> It makes sense for SCI as it is Intel specific.
>>>>
>>>> Unfortunately, this cannot be done in an arch independent way. Of course,
>>>> ARM had to implement its own thing. While level-triggered, active-low is
>>>> good for intel world, it is not for the ARM world. ARM uses active-high
>>>> level triggered.
>>>
>>> I'm confused.  I don't think SCI is Intel-specific.  Per PCI Spec
>>> r3.0, sec 2.2.6, PCI interrupts are level-sensitive, asserted low.
>>> Per ACPI Spec v3.0, sec 2.1, the SCI is an "active, low, shareable,
>>> level interrupt".

That's correct.

The SCI isn't Intel-specific or even x86-specific for that matter.
However, it is not available on hardware-reduced ACPI platforms which
are all ARM using ACPI.

>>> Are you saying SCI is active-high on ARM?  If so, I don't think that's
>>> necessarily a huge problem, although we'd have to audit the ACPI code
>>> to make sure we handle it correctly.
>
> We don't have an SCI interrupt on ARM. That's why, I assumed it is an Intel specific
> interrupt. However, all legacy interrupts are active-high level sensitive. This is a
> limitation of the ARM GIC Interrupt Controller.
>
> Here is what a PCI Link object looks like.
>
> Device(LN0D){
>         Name(_HID, EISAID("PNP0C0F")) // PCI interrupt link
>         Name(_UID, 4)
>         Name(_PRS, ResourceTemplate(){
>                 Interrupt(ResourceProducer, Level, ActiveHigh, Exclusive, , ,) {123}
>         })
>         Method(_DIS) {}
>         Method(_CRS) { Return (_PRS) }
>         Method(_SRS, 1) {}
> }
>
>>>
>>> The point here is that a PCI Interrupt Link can only use an IRQ that
>>> is level-triggered, active low.  If an IRQ is already set to any other
>>> state, whether for an ISA device or for an active-high SCI, we can't
>>> use it for a PCI Interrupt Link.
>
> Unfortunately, this still doesn't hold.

I think that the original active-low requirement is related to the
fact that those IRQ can be shared.  If they aren't shared, I guess the
point is slightly moot.

Thanks,
Rafael
