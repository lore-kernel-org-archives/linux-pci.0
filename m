Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43643 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbdL1Pq7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 10:46:59 -0500
Date: Thu, 28 Dec 2017 10:48:35 -0500
From: Alexandru Chirvasitu <achirvasub@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, KY Srinivasan <kys@microsoft.com>
Subject: Re: PROBLEM: 4.15.0-rc3 APIC causes lockups on Core 2 Duo laptop
Message-ID: <20171228154835.GB10658@chirva-slack.chirva-slack>
References: <20171218082011.GA24638@arch-chirva.localdomain>
 <20171218101131.GA5338@amd>
 <20171219083421.GB24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712200124440.2282@nanos>
 <ec3a298b-27a3-f3fe-ea8d-a777669104ba@cn.fujitsu.com>
 <20171220131929.GC24638@arch-chirva.localdomain>
 <alpine.DEB.2.20.1712281145510.1688@nanos>
 <20171228142117.GA10658@chirva-slack.chirva-slack>
 <alpine.DEB.2.20.1712281531120.1899@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1712281531120.1899@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 28, 2017 at 03:48:15PM +0100, Thomas Gleixner wrote:
> On Thu, 28 Dec 2017, Alexandru Chirvasitu wrote:
> > On Thu, Dec 28, 2017 at 12:00:47PM +0100, Thomas Gleixner wrote:
> > > Ok, lets take a step back. The bisect/kexec attempts led us away from the
> > > initial problem which is the machine locking up after login, right?
> > >
> > 
> > Yes; sorry about that..
> 
> Nothing to be sorry about.
> 
> >     x86/vector: Replace the raw_spin_lock() with
> > 
> > diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> > index 7504491..e5bab02 100644
> > --- a/arch/x86/kernel/apic/vector.c
> > +++ b/arch/x86/kernel/apic/vector.c
> > @@ -726,6 +726,7 @@ static int apic_set_affinity(struct irq_data *irqd,
> >                              const struct cpumask *dest, bool force)
> >  {
> >         struct apic_chip_data *apicd = apic_chip_data(irqd);
> > +       unsigned long flags;
> >         int err;
> >  
> >         /*
> > @@ -740,13 +741,13 @@ static int apic_set_affinity(struct irq_data *irqd,
> >             (apicd->is_managed || apicd->can_reserve))
> >                 return IRQ_SET_MASK_OK;
> >  
> > -       raw_spin_lock(&vector_lock);
> > +       raw_spin_lock_irqsave(&vector_lock, flags);
> >         cpumask_and(vector_searchmask, dest, cpu_online_mask);
> >         if (irqd_affinity_is_managed(irqd))
> >                 err = assign_managed_vector(irqd, vector_searchmask);
> >         else
> >                 err = assign_vector_locked(irqd, vector_searchmask);
> > -       raw_spin_unlock(&vector_lock);
> > +       raw_spin_unlock_irqrestore(&vector_lock, flags);
> >         return err ? err : IRQ_SET_MASK_OK;
> >  }
> > 
> > With this, I still get the lockup messages after login, but not the
> > freezes!
> 
> That's really interesting. There should be no code path which calls into
> that with interrupts enabled. I assume you never ran that kernel with
> CONFIG_PROVE_LOCKING=y.
>

Correct. That option is not set in .config.

> Find below a debug patch which should show us the call chain for that
> case. Please apply that on top of Dou's patch so the machine stays
> accessible. Plain output from dmesg is sufficient.
> 
> > The lockups register in the log, which I am attaching (see below for
> > attachment naming conventions).
> 
> Hmm. That's RCU lockups and that backtrace on the CPU which gets the stall
> looks very familiar. I'd like to see the above result first and then I'll
> send you another pile of patches which might cure that RCU issue.
> 
> Thanks,
> 
> 	tglx
> 
> 8<-------------------
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -729,6 +729,8 @@ static int apic_set_affinity(struct irq_
>  	unsigned long flags;
>  	int err;
>  
> +	WARN_ON_ONCE(!irqs_disabled());
> +
>  	/*
>  	 * Core code can call here for inactive interrupts. For inactive
>  	 * interrupts which use managed or reservation mode there is no
> 
> 
> 

Bit of a step back here: the kernel treated with Dou's patch no longer
logs me in reliably as before, with or without this newest patch on
top..

So now I sometimes get immediate lockups and freezes upon trying to
log in, and other times I get logged in but get a freeze seconds
later.

In no case can I roam around long nough to get a dmesg, and I no
longer get the non-freezing lockups from before. I can't imagine what
I could possibly have changed..

Here's the output of `git log --pretty=oneline -5` on the branch I'm
working in.

--------------------

f2c02af5cc1d620c039b21fab0ca5948a06daf90 2nd tglx patch
7715575170bacf3566d400b9f2210a10ce152880 x86/vector: Replace the raw_spin_lock() with raw_spin_lock_irqsave()
8d9d56caf33d78bfe6b6087767b1b84acee58458 x86-32: fix kexec with stack canary (CONFIG_CC_STACKPROTECTOR)
a197e9dea4ccb72e1a6457fac15329bd5319e719 irq/matrix: Remove the overused BUGON() in irq_matrix_assign_system()
464e1d5f23cca236b930ef068c328a64cab78fb1 Linux 4.15-rc5

--------------------

7715575170bacf3566d400b9f2210a10ce152880, which is the kernel with
Dou's patch, logged me in and allowed me to produce the dmesg from
before. I did this a couple of times back then. I no longer can, for
some reason, as it's reverted back to the no-go lockups from before.

And the next one, f2c02af5cc1d620c039b21fab0ca5948a06daf90, where I
applied the patch you just sent, behaves identically.
