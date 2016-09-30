Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 30 Sep 2016 09:14:42 -0400
From: okaya@codeaurora.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        wim@djo.tudelft.nl, ravikanth.nalla@hpe.com
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
In-Reply-To: <201609300844.24325.linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609292000.56943.linux@rainbow-software.org>
 <34355440-197d-44c7-b27d-535267d1161c@codeaurora.org>
 <201609300844.24325.linux@rainbow-software.org>
Message-ID: <677698369b23f5a6bcf3a66fed78802f@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016-09-30 02:44, Ondrej Zary wrote:
> On Friday 30 September 2016, Sinan Kaya wrote:
>> On 9/29/2016 2:00 PM, Ondrej Zary wrote:
>> >> The previous two patches were in the right direction.
>> >>
>> >> > Can we also get the same output from 4.6 kernel with the attached
>> >> > patch for the same machine you sent these?
>> >
>> > Here it is.
>> >
>> >> > Something about SCI still doesn't feel right.
>> >> >
>> >> > The IRQ assignment fails if the penalty is greater than
>> >> > PIRQ_PENALTY_ISA_ALWAYS. This will happen if BIOS tells us to use an
>> >> > IRQ and same IRQ is in use by the SCI.
>> 
>> Thanks, I reverted penalize_sci function and dropped patch #1. Can you 
>> try
>> this again?
> 
> It seems to work, at least on one machine.

Ok, that comfirms my suspicion. We are  having trouble detecting sci 
interrupt  type and we end up penalizing the wrong value.

Can you try your other machines too?

I need to do some research now.
