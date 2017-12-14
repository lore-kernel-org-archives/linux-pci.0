Return-Path: <SRS0=RDL9=DK=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=RDL9=DK=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <alpine.DEB.2.20.1712132211570.1885@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <CA+55aFwsMuHUBQz5kDNwRf17JnasXMWjvmLq5qXGH-694yeq1w@mail.gmail.com>
 <20171206121452.GA6320@dhcp22.suse.cz> <db81e89d-eee6-868c-dc10-c028f4c4be84@mblankhorst.nl>
 <alpine.DEB.2.20.1712061344560.1724@nanos> <0f1d3d63-fa10-5cef-8014-81753dc60243@mblankhorst.nl>
 <alpine.DEB.2.20.1712061514420.1724@nanos> <57c8679e-1b88-c9ad-2299-2bea7560b28f@mblankhorst.nl>
 <alpine.DEB.2.20.1712081129450.1840@nanos> <alpine.DEB.2.20.1712131507160.1885@nanos>
 <20171213162336.GG53955@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.20.1712131738020.1885@nanos> <CA+55aFw-SZLey5FaQfSLSbDU1sYhoGDrWoOngswkHMFfHW3O6w@mail.gmail.com>
 <alpine.DEB.2.20.1712131856130.1885@nanos> <alpine.DEB.2.20.1712132149420.1885@nanos>
 <alpine.DEB.2.20.1712132201380.1885@nanos> <alpine.DEB.2.20.1712132211570.1885@nanos>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2017 11:03:27 -0800
Message-ID: <CA+55aFwQBV9J1zxbBPLC5dOK-ebd1zcN6BaoB897AaKhc_tDtA@mail.gmail.com>
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Maarten Lankhorst <dev@mblankhorst.nl>,
	Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>,
	Daniel Vetter <daniel.vetter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 3:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> So the old scheme silently consumed the spurious vector. I added debug code
> to that effect to 4.14 and on that machine IRQ7 is triggered at the same
> point post resume and the core code drops it silently because the interrupt
> is marked masked and no action assigned.
>
> So the only difference to today is that the new code complains, while the
> old one does an extra mask of the already masked IOAPIC pin and silently
> returns.

Great debugging, and it looks like Rafael has a patch that already got
positive testing.

I just wanted to pipe up about that "irq7", because judging from your
email it seems like you think it's a real irq:

>        Now there is a race
> whether the kernel resume path manages to mask the PIC again early enough
> before something triggers IRQ7 or not.

..and that's not how the PIC works.

In fact, "legacy irq 7" is the _normal_ and very traditional spurious
interrupt, and it's documented. If the PIC gets an interrupt from
_any_ source, but the interrupt goes away before the PIC gets an
acknowledge from the CPU (and by "acknowledge", I'm not talking about
the explicit software IRQ ACK, I'm talking about the hardware
protocol, between the PIC and the CPU), the PIC will then report irq 7
as the interrupt - regardless of what the original was.

The reason is almost always something like

 - CPU interrupts are disabled or masked

 - driver does a write to the external hardware that causes an
interrupt to be raised

 - CPU doesn't react to the irq due to the disabled/masked nature

 - but the driver then does something that masks the interrupt again

 - interrupts are enabled/unmasked on the CPU

 - CPU now acks the interrupt, but the PIC no longer sees any
interrupt source, so the PIC (that has to reply with *something*)
replies with that documented spurious irq7.

To confuse things further, irq7 is not _exclusively_ the spurious
interrupt, You can definitely put real hardware and connect it to pin7
of the PIC, and get real irq7 reports.

And to confuse things even *more*, this "irq7" thing is per-PIC, and
the PC model obviously has the whole "nested PIC" thing where the
second PIC is connected to irq2 of the first PIC. So there are *two*
different "spurious interrupt" reports, one for each PIC.

Anyway, to avoid this issue, drivers should strive to

 (a) actually take the interrupt when doing things that can cause
them, and have the interrupt handler do whatever it is that causes the
interrupt to go away (ie: "normal operation")

 (b) if you play games with clearing the source of the interrupt
_without_ taking the interrupt, you should strive to basically mask
the interrupt first.

So to do (b) you can do something like

      mask_device_interrupt(dev);
      read_from_device_to_synchronize(dev);

instead of (or perhaps _before_) disabling interrupts at a CPU level.
Suspend/resume obviously does tend to play games with these kinds of
things where you are no longer in "normal operation" and you do setup
without having interrupts actually enabled.

Or you can just decide that spurious interrupts are ok, and ignore the
issue. But they *can* be very confusing, and obviously in this case
that confusion then seems to have caused actual problems.

            Linus
