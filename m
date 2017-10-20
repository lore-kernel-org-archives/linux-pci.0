Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750936AbdJTNgc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 09:36:32 -0400
Date: Fri, 20 Oct 2017 08:36:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dongdong Liu <liudongdong3@huawei.com>,
        Charles Chenxin <charles.chenxin@huawei.com>,
        linuxarm@huawei.com,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI/portdrv: Compute MSI/MSI-X IRQ vectors after
 final allocation
Message-ID: <20171020133626.GH6332@bhelgaas-glaptop.roam.corp.google.com>
References: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171019230121.17806.11826.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171020071550.GE11101@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171020071550.GE11101@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 20, 2017 at 09:15:50AM +0200, Christoph Hellwig wrote:
> > +/*
> > + * Fill in *pme, *aer, *dpc with the relevant Interrupt Message Numbers if
> > + * services are enabled in "mask".  Return the number of MSI/MSI-X vectors
> > + * required to accommodate the largest Message Number.
> > + */
> > +static int pcie_message_numbers(struct pci_dev *dev, int mask,
> > +				u32 *pme, u32 *aer, u32 *dpc)
> > +{
> 
> Can you split factoring out this helper into a separate clean up patch
> that goes before the actual change?

I did try that, but I'll try again.

> Otherwise this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Note that we should probably replace the irqs array with one storing
> the relative vector number and use pci_request_irq().  In fact in that
> case we could probably just pass said array to pcie_message_numbers()
> to further simplify it.

I like that idea.  But I don't think I have time to do it personally
right now.

Bjorn
