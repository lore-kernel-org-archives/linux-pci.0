Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:16008 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeIDTAK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 15:00:10 -0400
Date: Tue, 4 Sep 2018 08:36:13 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>
Subject: Re: [PATCH 11/16] PCI/portdrv: Restore pci state on slot reset
Message-ID: <20180904143612.GA18241@localhost.localdomain>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-12-keith.busch@intel.com>
 <20180902093402.rgeb5ioig7h5hoxf@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180902093402.rgeb5ioig7h5hoxf@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 02, 2018 at 02:34:02AM -0700, Lukas Wunner wrote:
> On Fri, Aug 31, 2018 at 03:26:34PM -0600, Keith Busch wrote:
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -174,7 +174,9 @@ static int slot_reset_iter(struct device *device, void *data)
> >  
> >  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
> >  {
> > +	pci_restore_state(dev);
> >  	device_for_each_child(&dev->dev, dev, slot_reset_iter);
> > +	pci_save_state(dev);
> >  	return PCI_ERS_RESULT_RECOVERED;
> >  }
> 
> Shouldn't this be the other way round, i.e. save, reset, restore?

No, this is the correct order. The state is originally saved in
pcie_portdrv_probe, and we need to restore to that state in the slot
reset callback. Once the slot has been restored through all the child
drivers, then we need to save the state again for any future error
handling.
 
> Also, the function pcie_portdrv_slot_reset() was introduced in the prior
> patch, so it seems this is a fix for that other patch and the two should
> be squashed together.

I guess they could be squashed, but the problems they're addressing seemed
different enough to warrant separate change logs. The previous patch
just set up the infrastructure for port error callbacks and chaining to
child drivers. This patch is fixing a specific problem to restore the
slot to a usable state.
