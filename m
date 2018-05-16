Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4149 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeEPXKW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 May 2018 19:10:22 -0400
Date: Wed, 16 May 2018 17:12:21 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Dongdong Liu <liudongdong3@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: DPC: Clear AER status bits before disabling port
 containment
Message-ID: <20180516231220.GA21659@localhost.localdomain>
References: <20180516213306.27027-1-mr.nuke.me@gmail.com>
 <605540c0-b6c5-89a2-9d50-12a3005d9f88@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <605540c0-b6c5-89a2-9d50-12a3005d9f88@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 16, 2018 at 06:44:22PM -0400, Sinan Kaya wrote:
> On 5/16/2018 5:33 PM, Alexandru Gagniuc wrote:
> > AER status bits are sticky, and they survive system resets. Downstream
> > devices are usually taken care of after re-enumerating the downstream
> > busses, as the AER bits are cleared during probe().
> > 
> > However, nothing clears the bits of the port which contained the
> > error. These sticky bits may leave some BIOSes to think that something
> > bad happened, and print ominous messages on next boot. To prevent this,
> > tidy up the AER status bits before releasing containment.
> > 
> > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > ---
> >  drivers/pci/pcie/dpc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index 8c57d607e603..bf82d6936556 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -112,6 +112,10 @@ static void dpc_work(struct work_struct *work)
> >  		dpc->rp_pio_status = 0;
> >  	}
> >  
> > +	/* DPC event made a mess of our AER status bits. Clean them up. */
> > +	pci_cleanup_aer_error_status_regs(pdev);
> > +	/* TODO: Should we also use aer_print_error to log the event? */
> > +
> >  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
> >  		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
> >  
> > 
> 
> I think Keith has a patch to fix this. It was under review at some point.

Right, I do intend to following up on this, but I've had some trouble
finding time the last few weeks. Sorry about that, things will clear up
for me shortly.
