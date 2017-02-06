Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbdBFRpW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Feb 2017 12:45:22 -0500
Date: Mon, 6 Feb 2017 12:54:25 -0500
From: Keith Busch <keith.busch@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCHv5 2/5] pci: Add device disconnected state
Message-ID: <20170206175425.GA10133@localhost.localdomain>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
 <1486144555-5526-3-git-send-email-keith.busch@intel.com>
 <20170203205330.GA16487@kroah.com>
 <20170206173202.GB25762@infradead.org>
 <20170206174046.GA10441@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206174046.GA10441@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 06:40:46PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 06, 2017 at 09:32:02AM -0800, Christoph Hellwig wrote:
> > On Fri, Feb 03, 2017 at 09:53:30PM +0100, Greg Kroah-Hartman wrote:
> > > > +/* pci_dev priv_flags */
> > > > +#define PCI_DEV_DISCONNECTED 0
> > > > +
> > > > +static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> > > > +{
> > > > +	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> > > 
> > > Why a single bit?  Are you trying to do this without locking or
> > > something?  And if you want a bit, what's wrong with a C bit type?  Or
> > > just a boolean?
> > 
> > What's a C bit type?
> 
> Sorry, was thinking of:
> 	unsigned foo:2;
> don't know what the "real" name for that is...

The C standard calls that a 'bit field'. I originally used that for this
flag, but Bjorn was concerned about the atomicity of getting this bit set,
conflicting with setting adjacent bits. It's unlikely that would happen
considering the pci driver's current usage, but he's correct that it's
possible without additional locking.

A bool would work just as well for the intended usage, though we may
eventually want all the currently defined bit fields to use the set/test
bit APIs, so this gets us started in that direction.
