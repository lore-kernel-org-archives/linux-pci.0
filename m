Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2181 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeIJVLU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Sep 2018 17:11:20 -0400
Date: Mon, 10 Sep 2018 10:18:06 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 16/20] PCI/pciehp: Implement error handling callbacks
Message-ID: <20180910161806.GB7466@localhost.localdomain>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-17-keith.busch@intel.com>
 <20180910132033.ei5nk4iibt7pesd5@wunner.de>
 <20180910145641.GA7466@localhost.localdomain>
 <20180910160926.7grtfdyw3iv2xg4x@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180910160926.7grtfdyw3iv2xg4x@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 10, 2018 at 06:09:26PM +0200, Lukas Wunner wrote:
> On Mon, Sep 10, 2018 at 08:56:42AM -0600, Keith Busch wrote:
> > On Mon, Sep 10, 2018 at 06:20:33AM -0700, Lukas Wunner wrote:
> > > The __pci_walk_bus() seems superfluous because the devices are also
> > > marked disconnected when bringing down the slot as a result of the
> > > synthesized PCI_EXP_SLTSTA_PDC event.
> > 
> > Right, but we can't do that inline with the slot reset because of the
> > circular locks that creates with the pci_bus_sem. We still want to
> > fence off drivers for downstream devices from mucking with config space
> > in a topology that is reported to be different than the one we're
> > recoverying from. You can get undefined results that way.
> 
> I don't quite follow.  I meant that __pci_walk_bus() is unnecessary
> because the pciehp_request() call indirectly triggers it.  So the
> devices are marked disconnected twice.

Right, but pciehhp_request handling happens too late to fence off drivers
bound to devices downstream this hotplug port. The disconnect setting
needs to happen before pciehp's slot_reset returns.
