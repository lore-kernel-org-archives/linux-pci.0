Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53947 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdBFVCW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Feb 2017 16:02:22 -0500
Date: Mon, 6 Feb 2017 16:11:25 -0500
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCHv5 2/5] pci: Add device disconnected state
Message-ID: <20170206211125.GB10133@localhost.localdomain>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
 <1486144555-5526-3-git-send-email-keith.busch@intel.com>
 <20170206173300.GC25762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206173300.GC25762@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 09:33:00AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 03, 2017 at 12:55:52PM -0500, Keith Busch wrote:
> > +static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> > +{
> > +	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> > +	return 0;
> > +}
> 
> Return void here?

This is used as the callback to pci_walk_bus for setting downstream device
disconnect state in case a switch was hot removed, so I have to respect
the prototype's 'int' return and the "unused" data parameter.

I'll fix up the long lines.
