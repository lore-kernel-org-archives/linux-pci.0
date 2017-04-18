Return-Path: <SRS0=bo2J=32=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=bo2J=32=linutronix.de=tglx@kernel.org>
Date: Tue, 18 Apr 2017 21:51:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
    Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
    Sebastian Siewior <bigeasy@linutronix.de>,
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 17/20] PCI: Use cpu_hotplug_disable() instead of
 get_online_cpus()
In-Reply-To: <20170418194425.GH25295@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704182148210.8081@nanos>
References: <20170415170107.643253702@linutronix.de> <20170415171652.675049942@linutronix.de> <20170418194425.GH25295@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 18 Apr 2017, Bjorn Helgaas wrote:
> > +static bool pci_physfn_is_probed(struct pci_dev *dev)
> > +{
> > +#ifdef CONFIG_ATS
> 
> I think this was intended to be CONFIG_PCI_ATS, not CONFIG_ATS.

yes.

> 
> But I think CONFIG_PCI_IOV would be more appropriate.  With that, and

The physfn member is under CONFIG_PCI_ATS so I took that one, but you are
right PCI_IOV is the proper one. Will fix.

> squashing this into the next patch,

Did so

Thanks,

	tglx
