Return-Path: <SRS0=c4Ay=DJ=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=c4Ay=DJ=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <alpine.DEB.2.20.1712131738020.1885@nanos>
References: <168050887.sZlTFXWCmO@aspire.rjw.lan> <CA+55aFwsMuHUBQz5kDNwRf17JnasXMWjvmLq5qXGH-694yeq1w@mail.gmail.com>
 <20171206121452.GA6320@dhcp22.suse.cz> <db81e89d-eee6-868c-dc10-c028f4c4be84@mblankhorst.nl>
 <alpine.DEB.2.20.1712061344560.1724@nanos> <0f1d3d63-fa10-5cef-8014-81753dc60243@mblankhorst.nl>
 <alpine.DEB.2.20.1712061514420.1724@nanos> <57c8679e-1b88-c9ad-2299-2bea7560b28f@mblankhorst.nl>
 <alpine.DEB.2.20.1712081129450.1840@nanos> <alpine.DEB.2.20.1712131507160.1885@nanos>
 <20171213162336.GG53955@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.20.1712131738020.1885@nanos>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Dec 2017 09:45:50 -0800
Message-ID: <CA+55aFw-SZLey5FaQfSLSbDU1sYhoGDrWoOngswkHMFfHW3O6w@mail.gmail.com>
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

On Wed, Dec 13, 2017 at 8:41 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Definitely. That was fragile forever but puzzles me is that I can't figure
> out what now causes that spurious interrupt to surface out of the blue.

Perhaps just timing?

How hard would it be to change the ordering to just redirect irqs first?

                 Linus
