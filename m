Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752564AbdLNOyp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 09:54:45 -0500
Date: Thu, 14 Dec 2017 07:54:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        liudongdong3@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Fix shared interrupt handling
Message-ID: <20171214075444.6bfbf01e@w520.home>
In-Reply-To: <20171214145030.GA25329@localhost.localdomain>
References: <20171214000051.30999.6989.stgit@gimli.home>
        <20171214145030.GA25329@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 14 Dec 2017 07:50:31 -0700
Keith Busch <keith.busch@intel.com> wrote:

> On Wed, Dec 13, 2017 at 05:01:58PM -0700, Alex Williamson wrote:
> > @@ -109,6 +109,7 @@ static void interrupt_event_handler(struct work_struct *work)
> >  	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
> >  	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
> >  	struct pci_bus *parent = pdev->subordinate;
> > +	u16 ctl;
> >  
> >  	pci_lock_rescan_remove();
> >  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
> > @@ -135,6 +136,10 @@ static void interrupt_event_handler(struct work_struct *work)
> >  
> >  	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_STATUS,
> >  		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
> > +
> > +	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
> > +	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL,
> > +			      ctl & ~PCI_EXP_DPC_CTL_INT_EN);  
> 
> Did you mean to re-enable the interrupt here rather than mask it off?

D'oh, yes.  v2 coming.  Thanks,

Alex
