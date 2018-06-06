Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751912AbeFFNwo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Jun 2018 09:52:44 -0400
Date: Wed, 6 Jun 2018 08:52:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Alex_Gagniuc@Dellteam.com,
        Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH 4/4] PCI/AER: Lock pci topology when scanning errors
Message-ID: <20180606135241.GB100923@bhelgaas-glaptop.roam.corp.google.com>
References: <20180409220444.6632-1-keith.busch@intel.com>
 <20180409220444.6632-5-keith.busch@intel.com>
 <20180605220911.GB226399@bhelgaas-glaptop.roam.corp.google.com>
 <20180605221825.GA17670@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180605221825.GA17670@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 05, 2018 at 04:18:26PM -0600, Keith Busch wrote:
> On Tue, Jun 05, 2018 at 05:09:11PM -0500, Bjorn Helgaas wrote:
> > > @@ -796,10 +796,10 @@ void aer_isr(struct work_struct *work)
> > >  	struct aer_rpc *rpc = container_of(work, struct aer_rpc, dpc_handler);
> > >  	struct aer_err_source uninitialized_var(e_src);
> > >  
> > > -	mutex_lock(&rpc->rpc_mutex);
> > > +	pci_lock_rescan_remove();
> > >  	while (get_e_source(rpc, &e_src))
> > >  		aer_isr_one_error(rpc, &e_src);
> > > -	mutex_unlock(&rpc->rpc_mutex);
> > > +	pci_unlock_rescan_remove();
> > 
> > I think this needs to be updated after Oza's patches, doesn't it?
> > 
> > It looks like this would deadlock if I applied it to my current "next"
> > branch as-is:
> > 
> >   aer_isr
> >     pci_lock_rescan_remove
> >     aer_isr_one_error
> >       aer_process_err_devices
> >         handle_error_source
> >           pcie_do_fatal_recovery
> >             pci_lock_rescan_remove      <-- deadlock
> > 
> > >       aer_release(rpc);
> > >  }
> 
> Yes, looks like you are right about that.
> 
> I fully intended to have this rebased on that by now, but nvme issues
> took way more time than I anticipated. Things appear to have calmed down
> on that front, and I should be able to rebase appropriately this week
> (famous last words...).

No worries, it's doubtful that I can still squeeze it into v4.18, so I
think it's better if we target this for v4.19.

I have some questions unrelated to the rebase:

  - What does the use-after-free look like to a user?  Panic,
    corruption, etc?  It's nice if we have breadcrumbs that connect a
    symptom to the fix.

  - I'm not super comfortable with the AER tree traversal in
    find_source_device().  Obviously this has always been there and is
    not your issue.  But it's dubious when a driver for device X also
    peeks at devices Y, Z, etc.  That always leads to locking issues.

  - I'm not clear on how pci_bus_sem and pci_rescan_remove_lock should
    be used.  pci_bus_sem is acquired by pci_walk_bus() and a few
    other PCI core paths.  pci_rescan_remove_lock is acquired (via
    pci_lock_rescan_remove()) by hotplug drivers and a few other
    add/remove/rescan paths.

    Most users of pci_walk_bus() do not use pci_lock_rescan_remove(),
    so it's not clear to me how to decide whether they *all* should,
    or why this AER path is different from the ones that don't need
    to.

Bjorn
