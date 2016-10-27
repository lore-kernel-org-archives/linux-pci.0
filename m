Return-Path: <mingo.kernel.org@gmail.com>
Return-Path: <mingo.kernel.org@gmail.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 27 Oct 2016 08:23:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: quirks: hide maybe-uninitialized warning
Message-ID: <20161027062328.GA2564@gmail.com>
References: <20161024153325.2752428-1-arnd@arndb.de>
 <20161026195653.GE17507@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161026195653.GE17507@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>


* Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Oct 24, 2016 at 05:33:18PM +0200, Arnd Bergmann wrote:
> > gcc -Wmaybe-uninitialized detects that quirk_intel_brickland_xeon_ras_cap
> > uses uninitialized data when CONFIG_PCI is not set:
> > 
> > arch/x86/kernel/quirks.c: In function ‘quirk_intel_brickland_xeon_ras_cap’:
> > arch/x86/kernel/quirks.c:641:13: error: ‘capid0’ is used uninitialized in this function [-Werror=uninitialized]
> > 
> > However, the function is also not called in this configuration, so we
> > can avoid the warning by moving the existing #ifdef to cover it as well.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> This fixes 3637efb00864 ("x86/mce: Add PCI quirks to identify Xeons with
> machine check recovery"), which appeared in v4.9-rc1.  I assume it will be
> merged for v4.9 via the x86 tree, as 3637efb00864 was.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Yeah, that's the plan - thanks!

	Ingo
