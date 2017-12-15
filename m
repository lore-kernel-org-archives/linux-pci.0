Return-Path: <SRS0=O0X+=DL=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=O0X+=DL=linutronix.de=tglx@kernel.org>
Date: Fri, 15 Dec 2017 10:05:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Bjorn Helgaas <helgaas@kernel.org>, Maarten Lankhorst <dev@mblankhorst.nl>,
    Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
    Andy Lutomirski <luto@kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    the arch/x86 maintainers <x86@kernel.org>,
    Daniel Vetter <daniel.vetter@intel.com>,
    Bjorn Helgaas <bhelgaas@google.com>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
    linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Linux 4.15-rc2: Regression in resume from ACPI S3
In-Reply-To: <CA+55aFzEt3hspSXgA28emi7aka0wQc8SaC=wdVKp=DtmbptQTQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1712151000260.1702@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <20171206121452.GA6320@dhcp22.suse.cz> <db81e89d-eee6-868c-dc10-c028f4c4be84@mblankhorst.nl> <alpine.DEB.2.20.1712061344560.1724@nanos> <0f1d3d63-fa10-5cef-8014-81753dc60243@mblankhorst.nl>
 <alpine.DEB.2.20.1712061514420.1724@nanos> <57c8679e-1b88-c9ad-2299-2bea7560b28f@mblankhorst.nl> <alpine.DEB.2.20.1712081129450.1840@nanos> <alpine.DEB.2.20.1712131507160.1885@nanos> <20171213162336.GG53955@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.DEB.2.20.1712131738020.1885@nanos> <CA+55aFw-SZLey5FaQfSLSbDU1sYhoGDrWoOngswkHMFfHW3O6w@mail.gmail.com> <alpine.DEB.2.20.1712131856130.1885@nanos> <alpine.DEB.2.20.1712132149420.1885@nanos> <alpine.DEB.2.20.1712132201380.1885@nanos>
 <alpine.DEB.2.20.1712132211570.1885@nanos> <CA+55aFwQBV9J1zxbBPLC5dOK-ebd1zcN6BaoB897AaKhc_tDtA@mail.gmail.com> <alpine.DEB.2.20.1712142331030.2257@nanos> <CA+55aFzEt3hspSXgA28emi7aka0wQc8SaC=wdVKp=DtmbptQTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Dec 2017, Linus Torvalds wrote:

> On Thu, Dec 14, 2017 at 2:36 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > But, because the silly firmware comes out of suspend with all PIC lines
> > unmasked for whatever reason, the PIC can observe that IRQ being raised and
> > the CPU not handling it. So yes, I forgot about 7 being magic, but I still
> > think it's the firmware which causes it by unmasking the PIC irqs.
> 
> Yes, that sounds quite likely.

And just for the record I was able to figure out which interrupt comes in
and goes away again. It's the only level triggered interrupt, which is the
ACPI interrupt.....

Thanks,

	tglx
