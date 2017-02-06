Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdBFRcD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 12:32:03 -0500
Date: Mon, 6 Feb 2017 09:32:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv5 2/5] pci: Add device disconnected state
Message-ID: <20170206173202.GB25762@infradead.org>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
 <1486144555-5526-3-git-send-email-keith.busch@intel.com>
 <20170203205330.GA16487@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170203205330.GA16487@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2017 at 09:53:30PM +0100, Greg Kroah-Hartman wrote:
> > +/* pci_dev priv_flags */
> > +#define PCI_DEV_DISCONNECTED 0
> > +
> > +static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> > +{
> > +	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> 
> Why a single bit?  Are you trying to do this without locking or
> something?  And if you want a bit, what's wrong with a C bit type?  Or
> just a boolean?

What's a C bit type?  set_bit and friends defintively are the standard
for being able to set individual bits without worrying for RMW races.
So while a bool would work fine here for now, this seems much easier
to extent for any flag in the future if we need one.
