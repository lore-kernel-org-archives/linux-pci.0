Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <94aee80e-f7c3-5732-ef1e-08e3ecb19e5e@codeaurora.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609300844.24325.linux@rainbow-software.org> <677698369b23f5a6bcf3a66fed78802f@codeaurora.org>
 <201609301756.25894.linux@rainbow-software.org> <94aee80e-f7c3-5732-ef1e-08e3ecb19e5e@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Sep 2016 21:39:07 +0200
Message-ID: <CAJZ5v0jr=KEfjo3HH6M2WhPCPCB9w1DYGB_VHhXDJXwjh76Pmg@mail.gmail.com>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Ondrej Zary <linux@rainbow-software.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 30, 2016 at 9:30 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Rafael, Bjorn;
>
> On 9/30/2016 11:56 AM, Ondrej Zary wrote:
>>>> It seems to work, at least on one machine.
>>> >
>>> > Ok, that comfirms my suspicion. We are  having trouble detecting sci
>>> > interrupt  type and we end up penalizing the wrong value.
>>> >
>>> > Can you try your other machines too?
>> Works on the 2nd one too.
>>
>>> > I need to do some research now.
>
> Thanks for the confirmation. I need to gather some opinion from Rafael and Bjorn.
>
> The patch provided only handles SCI in the ISA IRQ range (<16)
>
> I looked at the ACPI spec. SCI interrupt is a two byte field:
>
> "SCI_INT byte 2 offset 46
>
> System vector the SCI interrupt is wired to in 8259 mode. On
> systems that do not contain the 8259, this field contains the
> Global System interrupt number of the SCI interrupt. OSPM is
> required to treat the ACPI SCI interrupt as a sharable, level,
> active low interrupt."
>
> Since we have a race condition between the time the IRQ is registered
> via the ISA API and the time it gets to the interrupt driver
> since irq_get_type function is not matching what SCI API indicated.
>
> how do we feel about increasing the ISA IRQ range to 256 so that
> we are safe for all SCI interrupts?

I'm not sure how this is related to the problem at hand.  Care to elaborate?

And why exactly was that race condition not present before your changes?

Thanks,
Rafael
