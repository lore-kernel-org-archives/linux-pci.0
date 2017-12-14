Return-Path: <SRS0=RDL9=DK=gmail.com=linus971@kernel.org>
Return-Path: <SRS0=RDL9=DK=gmail.com=linus971@kernel.org>
MIME-Version: 1.0
Sender: linus971@gmail.com
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
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2017 14:47:33 -0800
Message-ID: <CA+55aFzEt3hspSXgA28emi7aka0wQc8SaC=wdVKp=DtmbptQTQ@mail.gmail.com>
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

On Thu, Dec 14, 2017 at 2:36 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But, because the silly firmware comes out of suspend with all PIC lines
> unmasked for whatever reason, the PIC can observe that IRQ being raised and
> the CPU not handling it. So yes, I forgot about 7 being magic, but I still
> think it's the firmware which causes it by unmasking the PIC irqs.

Yes, that sounds quite likely.

            Linus
