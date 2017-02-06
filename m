Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdBFRkq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 12:40:46 -0500
Date: Mon, 6 Feb 2017 18:40:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCHv5 2/5] pci: Add device disconnected state
Message-ID: <20170206174046.GA10441@kroah.com>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
 <1486144555-5526-3-git-send-email-keith.busch@intel.com>
 <20170203205330.GA16487@kroah.com>
 <20170206173202.GB25762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206173202.GB25762@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 09:32:02AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 03, 2017 at 09:53:30PM +0100, Greg Kroah-Hartman wrote:
> > > +/* pci_dev priv_flags */
> > > +#define PCI_DEV_DISCONNECTED 0
> > > +
> > > +static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> > > +{
> > > +	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> > 
> > Why a single bit?  Are you trying to do this without locking or
> > something?  And if you want a bit, what's wrong with a C bit type?  Or
> > just a boolean?
> 
> What's a C bit type?

Sorry, was thinking of:
	unsigned foo:2;
don't know what the "real" name for that is...

thanks,

greg k-h
