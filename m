Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37706 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbcJZN7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2016 09:59:43 -0400
Received: by mail-wm0-f54.google.com with SMTP id 140so20693142wmv.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Oct 2016 06:59:42 -0700 (PDT)
Message-ID: <1477490807.25812.20.camel@nexus-software.ie>
Subject: Re: [PATCH v3 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_state hook
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
To: Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Oct 2016 15:06:47 +0100
In-Reply-To: <20161025061934.GB5630@wunner.de>
References: <cover.1477221514.git.lukas@wunner.de>
         <7c1567d4c49303a4aada94ba16275cbf56b8976b.1477221514.git.lukas@wunner.de>
         <1477226275.2932.54.camel@nexus-software.ie>
         <20161023145757.GA4909@wunner.de>
         <1477300505.6423.41.camel@linux.intel.com>
         <20161024100940.GB5144@wunner.de>
         <1477307145.6423.48.camel@linux.intel.com>
         <20161025061934.GB5630@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-10-25 at 08:19 +0200, Lukas Wunner wrote:
> On Mon, Oct 24, 2016 at 02:05:45PM +0300, Andy Shevchenko wrote:
> > 
> > On Mon, 2016-10-24 at 12:09 +0200, Lukas Wunner wrote:
> > > 
> > > I note that you're exporting intel_mid_pci_set_power_state() even
> > > though there's currently no module user, so perhaps you're
> > > intending
> > > to call the function from somewhere else.
> > The export there is purely dictated by leaving abstract stuff under
> > drivers/pci when platform code is kept under arch/x86/platform.
> > Other
> > than that there is no plans to call this outside of pci-mid.c.
> The PCI core, including pci-mid.o, is linked into vmlinux, not a
> module,
> and exporting is only needed for module users.  A commit to unexport
> the
> symbol has been sitting on my development branch for 2 weeks, I
> delayed
> it because I wanted to wait for the regression to be fixed first.
> Sending out now since the topic has come up.
> 
> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > The usage of a mutex in mid_pwr_set_power_state() actually
> > > > > seems
> > > > > questionable since this is called with interrupts disabled:
> > > > > 
> > > > > pci_pm_resume_noirq
> > > > >   pci_pm_default_resume_early
> > > > >     pci_power_up
> > > > >       platform_pci_set_power_state
> > > > >         mid_pci_set_power_state
> > > > >           intel_mid_pci_set_power_state
> > > > >             mid_pwr_set_power_state
> > > > Hmm... I have to look at this closer. I don't remember why I
> > > > put
> > > > mutex
> > > > in the first place there. Anyway it's another story.
> > There are two code paths
> > pci_power_up()
> > pci_platform_power_transition()
> > 
> > Second one can be called in non-atomic context for sure (consider
> > standard ->resume() callback).
> > 
> > First one runs when IRQ disabled on CPU side.
> > 
> > In any case we probably need to serialize access in our code to
> > protect
> > against several PCI devices being powered up simultaneously.
> Right, good point, the PM core will indeed parallelize suspend/resume
> of the devices, so if __update_power_state() cannot be safely called
> concurrently for different devices (I don't know if that's the case)
> then indeed you need locking (with spinlocks).  It might be worth
> pondering if the locking should happen further down in the call stack
> because I assume the critical section would really just be in
> __update_power_state().
> 
> Best regards,
> 
> Lukas

So the conclusion is to apply this patch now and go and look further @
locking in a separate series right ? There's not much point in leaving
Edison not booting as is the case with tip-of-tree right now.

---
bod
