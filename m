Return-Path: <SRS0=fO1E=IX=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=fO1E=IX=intel.com=keith.busch@kernel.org>
Date: Tue, 5 Jun 2018 16:18:26 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Alex_Gagniuc@Dellteam.com,
	Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH 4/4] PCI/AER: Lock pci topology when scanning errors
Message-ID: <20180605221825.GA17670@localhost.localdomain>
References: <20180409220444.6632-1-keith.busch@intel.com>
 <20180409220444.6632-5-keith.busch@intel.com>
 <20180605220911.GB226399@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180605220911.GB226399@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 05, 2018 at 05:09:11PM -0500, Bjorn Helgaas wrote:
> > @@ -796,10 +796,10 @@ void aer_isr(struct work_struct *work)
> >  	struct aer_rpc *rpc = container_of(work, struct aer_rpc, dpc_handler);
> >  	struct aer_err_source uninitialized_var(e_src);
> >  
> > -	mutex_lock(&rpc->rpc_mutex);
> > +	pci_lock_rescan_remove();
> >  	while (get_e_source(rpc, &e_src))
> >  		aer_isr_one_error(rpc, &e_src);
> > -	mutex_unlock(&rpc->rpc_mutex);
> > +	pci_unlock_rescan_remove();
> 
> I think this needs to be updated after Oza's patches, doesn't it?
> 
> It looks like this would deadlock if I applied it to my current "next"
> branch as-is:
> 
>   aer_isr
>     pci_lock_rescan_remove
>     aer_isr_one_error
>       aer_process_err_devices
>         handle_error_source
>           pcie_do_fatal_recovery
>             pci_lock_rescan_remove      <-- deadlock
> 
> >       aer_release(rpc);
> >  }

Yes, looks like you are right about that.

I fully intended to have this rebased on that by now, but nvme issues
took way more time than I anticipated. Things appear to have calmed down
on that front, and I should be able to rebase appropriately this week
(famous last words...).
