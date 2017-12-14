Return-Path: <SRS0=wdMU=DK=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=wdMU=DK=linutronix.de=tglx@kernel.org>
Date: Thu, 14 Dec 2017 14:24:22 +0100 (CET)
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
In-Reply-To: <alpine.DEB.2.20.1712132211570.1885@nanos>
Message-ID: <alpine.DEB.2.20.1712141423360.4998@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <CA+55aFwsMuHUBQz5kDNwRf17JnasXMWjvmLq5qXGH-694yeq1w@mail.gmail.com> <20171206121452.GA6320@dhcp22.suse.cz> <db81e89d-eee6-868c-dc10-c028f4c4be84@mblankhorst.nl> <alpine.DEB.2.20.1712061344560.1724@nanos>
 <0f1d3d63-fa10-5cef-8014-81753dc60243@mblankhorst.nl> <alpine.DEB.2.20.1712061514420.1724@nanos> <57c8679e-1b88-c9ad-2299-2bea7560b28f@mblankhorst.nl> <alpine.DEB.2.20.1712081129450.1840@nanos> <alpine.DEB.2.20.1712131507160.1885@nanos>
 <20171213162336.GG53955@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.20.1712131738020.1885@nanos> <CA+55aFw-SZLey5FaQfSLSbDU1sYhoGDrWoOngswkHMFfHW3O6w@mail.gmail.com> <alpine.DEB.2.20.1712131856130.1885@nanos> <alpine.DEB.2.20.1712132149420.1885@nanos>
 <alpine.DEB.2.20.1712132201380.1885@nanos> <alpine.DEB.2.20.1712132211570.1885@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Dec 2017, Thomas Gleixner wrote:
> Now, what's different vs. 4.14:
> 
> The 4.14 code accidentaly had the irq descriptor for this vector still
> populated in the old CPU due to the convoluted way the vector allocation
> worked. I have still to investigate if one of those cases is actually
> leaking the descriptor, which would be a fatal bug.

It doesn't leak. It repopulates it at the same place out of sheer luck.

Thanks,

	tglx
