Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:51875 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752534AbcJXKJF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2016 06:09:05 -0400
Date: Mon, 24 Oct 2016 12:09:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_state hook
Message-ID: <20161024100940.GB5144@wunner.de>
References: <cover.1477221514.git.lukas@wunner.de>
 <7c1567d4c49303a4aada94ba16275cbf56b8976b.1477221514.git.lukas@wunner.de>
 <1477226275.2932.54.camel@nexus-software.ie>
 <20161023145757.GA4909@wunner.de>
 <1477300505.6423.41.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1477300505.6423.41.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 24, 2016 at 12:15:05PM +0300, Andy Shevchenko wrote:
> On Sun, 2016-10-23 at 16:57 +0200, Lukas Wunner wrote:
> > On Sun, Oct 23, 2016 at 01:37:55PM +0100, Bryan O'Donoghue wrote:
> > > Shouldn't this serialize like this
> > > 
> > >       might_sleep();
> > > 
> > > 	reg = (id * LSS_PWS_BITS) / 32;
> > > 	bit = (id * LSS_PWS_BITS) % 32;
> > > 
> > >       mutex_lock(&pwr->lock);
> > >       power = mid_pwr_get_state(pwr, reg);
> > >       mutex_lock(&pwr->lock);
> > > 
> > > 	return (__force pci_power_t)((power >> bit) & 3);
> > > 
> > > there's a corresponding flow in mid_pwr_set_power_state() that
> > > operates
> > > in exactly that way.
> > 
> > mid_pwr_set_power_state() uses a series of steps (set the power state,
> > wait for completion) so presumably Andy thought this needs to be done
> > under a lock to prevent concurrent execution.
> > 
> > mid_pwr_get_state() on the other hand is just a register read, which
> > I assume is atomic.  The other stuff (calling
> > intel_mid_pwr_get_lss_id(),
> > calculation of reg and bit) seems to be static, it never changes
> > across
> > invocations.  Hence there doesn't seem to be a necessity to acquire
> > the mutex and call might_sleep().
> > 
> > That said I'm not really familiar with these devices and rely on
> > Andy's
> > ack for correctness.  Andy if I'm mistaken please shout, otherwise I
> > assume the patch is correct.
> 
> readl() is indeed atomic, the question is ordering of reads and writes,
> but on this platform it's just an interface to PWRMU which is slow and
> uses two sets of registers (one for read, one for write). Actual
> operation happens after doorbell is written (with regard to PM_CMD
> bits). So, there is a potential that read will return earlier state of
> the device while PWRMU is processing new one, though I believe it's
> prevented by PCI core.

The corresponding functions in pci-acpi.c don't perform any locking,
and AFAICS neither do the functions they call in drivers/acpi/.

The power state is read and written from the various pci_pm_* callbacks
and the PM core never executes those in parallel.

However there's pci_set_power_state(), this is exported and called by
various drivers, theoretically they would be able to execute that
concurrently to a pci_pm_* callback, it would be silly though.

Long story short, there's no locking needed unless you intend to call
intel_mid_pci_set_power_state() from other places.  I guess that's what
Bryan was alluding to when he wrote that the mutex might be "put in
place to future-proof the code".  I note that you're exporting
intel_mid_pci_set_power_state() even though there's currently no module
user, so perhaps you're intending to call the function from somewhere else.

Thanks,

Lukas

> > 
> > The usage of a mutex in mid_pwr_set_power_state() actually seems
> > questionable since this is called with interrupts disabled:
> > 
> > pci_pm_resume_noirq
> >   pci_pm_default_resume_early
> >     pci_power_up
> >       platform_pci_set_power_state
> >         mid_pci_set_power_state
> >           intel_mid_pci_set_power_state
> >             mid_pwr_set_power_state
> 
> Hmm... I have to look at this closer. I don't remember why I put mutex
> in the first place there. Anyway it's another story.
> 
> -- 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
