Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46991 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932413AbdDQHkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2017 03:40:21 -0400
Date: Mon, 17 Apr 2017 09:40:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 17/20] PCI: Use cpu_hotplug_disable() instead of
 get_online_cpus()
In-Reply-To: <20170417064619.fjpizfsfd65dtear@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.20.1704170940020.2327@nanos>
References: <20170415170107.643253702@linutronix.de> <20170415171652.675049942@linutronix.de> <20170417064619.fjpizfsfd65dtear@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 17 Apr 2017, Peter Zijlstra wrote:
> On Sat, Apr 15, 2017 at 07:01:24PM +0200, Thomas Gleixner wrote:
> > +++ b/drivers/pci/pci-driver.c
> > @@ -320,10 +320,19 @@ static long local_pci_probe(void *_ddi)
> >  	return 0;
> >  }
> >  
> > +static bool pci_physfn_is_probed(struct pci_dev *dev)
> > +{
> > +#ifdef CONFIG_ATS
> > +	return dev->physfn->is_probed;
> > +#else
> > +	return false;
> > +#endif
> > +}
> > +
> 
> Should be in the next patch perhaps?

Indeed.
