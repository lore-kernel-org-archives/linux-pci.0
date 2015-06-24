Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 24 Jun 2015 11:49:16 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Len Brown <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [Bugfix v2] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32bit kernel
Message-ID: <20150624094916.GA5696@gmail.com>
References: <1435131817-28167-1-git-send-email-jiang.liu@linux.intel.com>
 <20150624083019.GA26672@gmail.com>
 <558A7824.3090900@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <558A7824.3090900@pr.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Boszormenyi Zoltan <zboszor@pr.hu> wrote:

> 2015-06-24 10:30 keltezéssel, Ingo Molnar írta:
> > * Jiang Liu <jiang.liu@linux.intel.com> wrote:
> >
> >> Since commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces to 
> >> simplify implementation"), x86 PCI ACPI host bridge driver validates ACPI 
> >> resources by first converting an ACPI resource to a 'struct resource' structure 
> >> and then applying checks against the converted resource structure. The 'start' 
> >> and 'end' fields in 'struct resource' are defined to be type of resource_size_t, 
> >> which may be 32 bits or 64 bits depending on CONFIG_PHYS_ADDR_T_64BIT.
> >>
> >> This may cause incorrect resource validation results with 32 bit kernels because 
> >> 64bit ACPI resource descriptors may get truncated when converting to 32bit 
> >> 'start' and 'end' fields in 'struct resource'. And eventually affects PCI 
> >> resource allocation subsystem and causes some PCI devices unusable.
> > s/causes some PCI devices unusuable.
> >   makes some PCI devices unusuable.
> >
> > Also, this description is still pretty vague. What exactly happened? Did some PCI 
> > devices not show up during bootup? Or did they hang? Or did something else happen?
> 
> There's a reference mail URL in the description, but here it is in full glory.
> 
> The machine in question started behaving like being drunk without this fix
> with 4.0.5 and 4.1.0-rc8 and 4.1.0-final. 3.18.16 was good.
> 
> There's a Realtek RTL8111/8168/8411 (PCI ID 10ec:8168, Subsystem ID 1565:230e)
> network chip on the mainboard. After the r8169 driver loaded, the IRQs in
> the machine went berserk. Keyboard keypressed arrived with considerable
> latency and duplicated, so no real work was possible. The machine responded
> to the power button but didn't actually power down. It just stuck at the powering
> down message. I had to press the power button for 4 seconds to power it down.
> 
> The computer is a POS machine with a big battery inside. Because of this,
> either ACPI or the Realtek chip kept the bad state and after rebooting, the
> network chip didn't even show up in lspci. Not even the PXE ROM announced
> itself during boot. I had to disconnect the battery to beat some sense back
> to the computer.

So my point is that this description is more valuable than all the rest of the 
changelog, and it should be quoted prominently in the first paragraph or so!

And this too should round up the changelog:

> With the fix, the behavior of the machine was restored to how 3.18.16 worked, 
> i.e. the memory range that is over 4GB is ignored again, and lspci -vvxxx shows 
> that everything is at the same memory window as they were with 3.18.16.

as it is far more informative about the practical effects of the fix than anything 
in the previous versions of the changelog.

Thanks,

	Ingo
