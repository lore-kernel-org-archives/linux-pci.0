Return-Path: <SRS0=w4Pv=DL=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=w4Pv=DL=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <alpine.DEB.2.20.1712142331030.2257@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <CA+55aFwsMuHUBQz5kDNwRf17JnasXMWjvmLq5qXGH-694yeq1w@mail.gmail.com>
 <20171206121452.GA6320@dhcp22.suse.cz> <db81e89d-eee6-868c-dc10-c028f4c4be84@mblankhorst.nl>
 <alpine.DEB.2.20.1712061344560.1724@nanos> <0f1d3d63-fa10-5cef-8014-81753dc60243@mblankhorst.nl>
 <alpine.DEB.2.20.1712061514420.1724@nanos> <57c8679e-1b88-c9ad-2299-2bea7560b28f@mblankhorst.nl>
 <alpine.DEB.2.20.1712081129450.1840@nanos> <alpine.DEB.2.20.1712131507160.1885@nanos>
 <20171213162336.GG53955@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.20.1712131738020.1885@nanos> <CA+55aFw-SZLey5FaQfSLSbDU1sYhoGDrWoOngswkHMFfHW3O6w@mail.gmail.com>
 <alpine.DEB.2.20.1712131856130.1885@nanos> <alpine.DEB.2.20.1712132149420.1885@nanos>
 <alpine.DEB.2.20.1712132201380.1885@nanos> <alpine.DEB.2.20.1712132211570.1885@nanos>
 <CA+55aFwQBV9J1zxbBPLC5dOK-ebd1zcN6BaoB897AaKhc_tDtA@mail.gmail.com> <alpine.DEB.2.20.1712142331030.2257@nanos>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Dec 2017 01:34:42 +0100
Message-ID: <CAJZ5v0g5+N4s_jKWcz8bYMj-OYtUF-kufcod05ruwnVvXegX+A@mail.gmail.com>
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Maarten Lankhorst <dev@mblankhorst.nl>, Michal Hocko <mhocko@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>,
	Daniel Vetter <daniel.vetter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 11:36 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 14 Dec 2017, Linus Torvalds wrote:
>> On Thu, Dec 14, 2017 at 3:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> I just wanted to pipe up about that "irq7", because judging from your
>> email it seems like you think it's a real irq:
>>
>> >        Now there is a race
>> > whether the kernel resume path manages to mask the PIC again early enough
>> > before something triggers IRQ7 or not.
>>
>> ..and that's not how the PIC works.
>>
>> In fact, "legacy irq 7" is the _normal_ and very traditional spurious
>> interrupt, and it's documented. If the PIC gets an interrupt from
>> _any_ source, but the interrupt goes away before the PIC gets an
>> acknowledge from the CPU (and by "acknowledge", I'm not talking about
>> the explicit software IRQ ACK, I'm talking about the hardware
>> protocol, between the PIC and the CPU), the PIC will then report irq 7
>> as the interrupt - regardless of what the original was.
>>
>> The reason is almost always something like
>>
>>  - CPU interrupts are disabled or masked
>>
>>  - driver does a write to the external hardware that causes an
>> interrupt to be raised
>
> Which should be a non issue because _ALL_ PIC irq lines are masked at the
> PIC itself. All interrupts are routed through IOAPIC. So unless the IOAPIC
> sports similar behaviour the PIC should not ever observe that scenario.
>
> But, because the silly firmware comes out of suspend with all PIC lines
> unmasked for whatever reason, the PIC can observe that IRQ being raised and
> the CPU not handling it. So yes, I forgot about 7 being magic, but I still
> think it's the firmware which causes it by unmasking the PIC irqs.

That's my understanding too.

Thanks,
Rafael
