Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32977 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbcFNP3Q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2016 11:29:16 -0400
Date: Tue, 14 Jun 2016 17:29:11 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	David Cohen <david.a.cohen@linux.intel.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v1 1/1] x86/platform/intel-mid: Add Power Management Unit
 driver
Message-ID: <20160614152911.GB28601@gmail.com>
References: <1465849087-54528-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20160614104355.GC13439@gmail.com>
 <1465912766.30123.55.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1465912766.30123.55.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, 2016-06-14 at 12:43 +0200, Ingo Molnar wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > Add Power Management Unit driver to handle power states of South
> > > Complex
> > > devices on Intel Tangier. In the future it might be expanded to
> > > cover North
> > > Complex devices as well.
> > > 
> > > With this driver the power state of the host controllers such as
> > > SPI, I2C,
> > > UART, eMMC, and DMA would be managed.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  arch/x86/include/asm/intel-mid.h     |   8 +
> > >  arch/x86/pci/intel_mid_pci.c         |  35 +++-
> > >  arch/x86/platform/intel-mid/Makefile |   2 +-
> > >  arch/x86/platform/intel-mid/pmu.c    | 392
> > > +++++++++++++++++++++++++++++++++++
> > >  drivers/pci/Makefile                 |   3 +
> > >  drivers/pci/pci-mid.c                |  77 +++++++
> > >  6 files changed, 515 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/x86/platform/intel-mid/pmu.c
> > >  create mode 100644 drivers/pci/pci-mid.c
> > 
> > So this collides with perf's 'PMU' naming massively. Can we pick
> > another name 
> > before hillarious kernel-wide confusion spreads?
> > 
> > how about intel/mid/pm.c plus renaming all the pmu* internal names to
> > pm*?
> > 
> > We could call it 'power management interface', and in a single line
> > mention that 
> > this is also a 'Power Management Unit' in Intel-speak?
> 
> In the TRM it's called Power Management Unit, though once or twice in some 
> documents as Power Management Controller. I actually woudn't like to use PMC 
> abbreviation to not be confused with pmc_atom.c and many other variation of 
> existing PMC drivers of other Intel platforms.
> 
> PM* as a prefix might be too short to conflict with Power Management framework 
> in the kernel. P-Unit (punit*) is existing part in SoC which will have its own 
> driver in the future, so, can't use it either.
> 
> pwr*, pwrmu*, scpmu* (as of South Complex Power Management Unit) — one of them?

'pwr' certainly sounds good to me! PWMU perhaps?

Thanks,

	Ingo
